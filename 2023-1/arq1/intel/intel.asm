;======================================================================================================================
;   8086_genome_reader
;======================================================================================================================
;
;   Autor:			Bruno Samuel A. Gonçalves
;   Data:			08/2023
;   Descrição:		Um leitor de sequências de DNA em linguagem de montagem para a arquitetura Intel 8086.
;
;   Utilização:
;		main.exe -f <input_file> -o <output_file> -n <base_group_size> -<actg+>
;
;======================================================================================================================

.model small
.stack

;======================================================================================================================
;	Macros
;======================================================================================================================

int_terminate	macro	return_code 					; INT 21,4C - Terminate Process With Return Code

				mov		al, return_code
				mov		ah, 4Ch
				int		21h
endm

line_feed		macro									; Imprimir caractere LF

				push	dx
				mov		dl, LF
				call	putchar
				pop		dx
endm

backspace		macro									; Remover último caractere impresso

				push	dx
				mov		dl, BS
				call	putchar
				mov		dl, SPACE
				call	putchar
				mov		dl, BS
				call	putchar
				pop		dx
endm

line_feed_f		macro									; Escrever caractere LF no arquivo de saída

				mov		bx, write_handle
				mov		cx, 1
				lea		dx,	write_buffer
				mov		write_buffer, LF
				call	fwrite
endm

backspace_f		macro	handle							; Descolar ponteiro do arquivo 1 byte para trás

				push	cx
				push	dx
				mov		al, SEEK_CUR
				mov		bx, handle
				mov		cx, -1
				mov		dx,	-1
				call	fseek
				pop		dx
				pop		cx
endm

;======================================================================================================================
;	Constantes
;======================================================================================================================

; Geral
ERROR						equ		-1
FALSE						equ		0
READ_ONLY					equ		0
TRUE						equ		1
SEEK_CUR					equ		1
STR_SIZE					equ		128
MAX_BASE_COUNT				equ		10000

; Caracteres
NUL							equ		0
BS							equ		8
TAB							equ		9
LF							equ		10
CR							equ		13
SPACE						equ		32
DBQ							equ		34
CSV_DELIM					equ		59

; Códigos de retorno
SUCCESS						equ		0
ERROR_INVALID_N				equ		1
ERROR_INVALID_OPTION		equ		2
ERROR_MISSING_F				equ		3
ERROR_MISSING_N				equ		4
ERROR_MISSING_ACTG			equ		5
ERROR_DUPLICATE_F			equ		6
ERROR_DUPLICATE_O			equ		7
ERROR_DUPLICATE_N			equ		8
ERROR_FILE_NOT_EXIST		equ		9
ERROR_INVALID_BASE			equ		10
ERROR_NOT_ENOUGH_BASES		equ		11
ERROR_TOO_MANY_BASES		equ		12

;======================================================================================================================
;	Segmento de dados
;======================================================================================================================
.data

; Geral
return_code					db		SUCCESS
leading_zero				db		TRUE

; Processamento da linha de comando
argv 						db		STR_SIZE dup(0)
argv_cursor					dw		argv
token						dw		?
option_buffer				dw		?

; Controle de parâmetros
input_file					db		STR_SIZE dup(0)
output_file					db		"a.out", (STR_SIZE - 5) dup(0)
group_size					dw		?
include_a					db		FALSE
include_t					db		FALSE
include_c					db		FALSE
include_g					db		FALSE
include_plus				db		FALSE
f_provided					db		FALSE
o_provided					db		FALSE
n_provided					db		FALSE

; Leitura do arquivo de entrada
read_handle					dw		?
read_buffer					db		?, NUL
base_buffer					db		10000 dup(0), NUL
base_count					dw		0
group_count					dw		0
line_count					dw		1
base_line_count				dw		0
new_line					db		TRUE
nul_terminated_char			db		?, NUL

; Escrita do arquivo de saída
write_handle				dw		?
current_handle				dw		?
write_buffer				db		?
a_count						dw		0
t_count						dw		0
c_count						dw		0
g_count						dw		0
header_a					db		"A;", NUL
header_t					db		"T;", NUL
header_c					db		"C;", NUL
header_g					db		"G;", NUL
header_plus					db		"A+T;C+G;", NUL

; Mensagens de erro
msg_invalid_n				db		"ERRO: parametro ", DBQ, "%s", DBQ, " e invalido para -n. Informe um numero maior ou igual a 1.", NUL
msg_invalid_option			db		"ERRO: opcao ", DBQ, "%s", DBQ, " e invalida.", NUL
msg_missing_f				db		"ERRO: opcao -f nao encontrada. Informe o arquivo de entrada.", NUL
msg_missing_n				db		"ERRO: opcao -n nao encontrada. Informe o tamanho dos grupos de bases.", NUL
msg_missing_atcg			db		"ERRO: opcao -<atcg+> nao encontrada. Informe as bases a serem processadas.", NUL
msg_duplicate_f				db		"ERRO: opcao -f foi fornecida mais de uma vez. Informe apenas um arquivo de entrada.", NUL
msg_duplicate_o				db		"ERRO: opcao -o foi fornecida mais de uma vez. Informe apenas um arquivo de saida.", NUL
msg_duplicate_n				db		"ERRO: opcao -n foi fornecida mais de uma vez. Informe apenas um tamanho dos grupos de bases.", NUL
msg_file_not_exist			db		"ERRO: arquivo ", DBQ, "%s", DBQ, " nao existe.", NUL
msg_invalid_base			db		"ERRO: base '%s' na linha %d e invalida. Apenas A, T, C e G sao aceitas.", NUL
msg_not_enough_bases		db		"ERRO: numero de bases insuficiente. Forneca pelo menos %d bases no arquivo de entrada.", NUL
msg_too_many_bases			db		"ERRO: arquivo muito grande. Sao aceitas no maximo 10.000 bases nitrogenadas.", NUL

; Resumo
summary_header				db		72 dup('-'), LF, 27 dup(' '), "8086_genome_reader", LF, 23 dup(' '), "Relatorio de Processamento", LF, 72 dup('-'), LF, NUL
summary_title_options		db		"Opcoes Utilizadas:", LF, NUL
summary_input_file			db		TAB, "- Arquivo de entrada:", 3 dup(TAB), "%s", LF, NUL
summary_output_file			db		TAB, "- Arquivo de saida:", 3 dup(TAB), "%s", LF, NUL
summary_group_size			db		TAB, "- Tamanho dos grupos de bases:", 2 dup(TAB), "%d", LF, NUL
summary_included_bases		db		TAB, "- Bases do arquivo de saida:", 2 dup(TAB), NUL
summary_title_input_file	db		"Informacoes do Arquivo de Entrada:", LF, NUL
summary_base_count			db		TAB, "- Total de bases:", 3 dup(TAB), "%d", LF, NUL
summary_group_count			db		TAB, "- Total de grupos:", 3 dup(TAB), "%d", LF, NUL
summary_base_line_count		db		TAB, "- Total de linhas com bases:", 2 dup(TAB), "%d", LF, NUL
summary_end_separator		db		72 dup('-'), LF, NUL
list_a						db		"A, ", NUL
list_t						db		"T, ", NUL
list_c						db		"C, ", NUL
list_g						db		"G, ", NUL
list_plus					db		"A+T;C+G, ", NUL

;======================================================================================================================
;	Segmento de código
;======================================================================================================================

.code
.startup
				call	get_argv						; Obter string da linha de comando
				call	join_segments					; Unir segmentos DS e ES
				call	parse_options					; Extrair opções da string da linha de commando
				call	validate_input_file				; Validar arquivo de entrada
				call	print_summary					; Exibir resumo das informações de processamento
				call	write_output_file				; Escrever arquivo de saída

				int_terminate	return_code				; Terminar programa com código de sucesso

.exit

;----------------------------------------------------------------------------------------------------------------------
;	get_argv
;----------------------------------------------------------------------------------------------------------------------
;	Função para obter a string de argumentos da linha de comando e armazenar na variável 'argv'.
;----------------------------------------------------------------------------------------------------------------------
get_argv		proc	near

				push	ds								; Salvar registradores de segmentos
				push	es

				mov		ax, ds							; Trocar DS <-> ES para uso do MOVSB
				mov		bx, es
				mov		ds, bx
				mov		es, ax

				mov		si, 80h							; Carregar tamanho da string
				mov		ch, 0
				mov		cl, [si]

				mov		si, 81h							; Carregar endereço de origem
				lea		di, argv						; Carregar endereço de destino

				rep 	movsb							; Mover string

				pop 	es								; Retornar registradores de segmentos
				pop 	ds

				ret

get_argv		endp

;----------------------------------------------------------------------------------------------------------------------
;	parse_options
;----------------------------------------------------------------------------------------------------------------------
;	Função para extrair as opções de uma string de argumentos e as armazenar nas variáveis correspondentes.
;----------------------------------------------------------------------------------------------------------------------
parse_options	proc	near

				call	argv_tok						; Obter primeiro token

check_token:
				mov		bx, token						; Carregar endereço do token em BX

				cmp		bx, NUL							; Verificar token nulo
				je		check_missing_f

check_option:
				cmp		byte ptr [bx], '-'				; Verificar início de opção ('-')
				jne		next_token
				mov		option_buffer, bx
				inc		bx								; Pular caractere '-'

token_char:
				cmp		byte ptr [bx], NUL				; Verificar fim do token
				je		next_token

				cmp		byte ptr [bx], 'f'				; Switch case para caractere atual
				je		case_f
				cmp		byte ptr [bx], 'o'
				je		case_o
				cmp		byte ptr [bx], 'n'
				je		case_n
				cmp		byte ptr [bx], 'a'
				je		case_a
				cmp		byte ptr [bx], 't'
				je		case_t
				cmp		byte ptr [bx], 'c'
				je		case_c
				cmp		byte ptr [bx], 'g'
				je		case_g
				cmp		byte ptr [bx], '+'
				je		case_plus
				jmp		case_default

case_f:
				cmp		f_provided, TRUE				; Verificar opção -f duplicada
				je		handle_duplicate_f
				mov		f_provided, TRUE				; Ativar flag da opção -f
				call	argv_tok						; Obter parâmetro
				mov		si, token
				lea		di, input_file
				call	strlen							; Obter comprimento do parâmetro
				rep		movsb							; Mover parâmetro para input_file
				jmp		next_char

case_o:
				cmp		o_provided, TRUE				; Verificar opção -o duplicada
				je		handle_duplicate_o
				mov		o_provided, TRUE				; Ativar flag da opção -o
				call	argv_tok						; Obter parâmetro
				mov		si, token
				lea		di, output_file
				call	strlen							; Obter comprimento do parâmetro
				rep		movsb							; Mover parâmetro para output_file
				jmp		next_char

case_n:
				cmp		n_provided, TRUE				; Verificar opção -n duplicada
				je		handle_duplicate_n
				mov		n_provided, TRUE				; Ativar flag da opção -n
				call	argv_tok						; Obter parâmetro
				mov		si, token
				call	atoi							; Converter parâmetro para decimal
				cmp		ax, 1							; Verificar valor >= 1
				jge		valid_n
				mov		dl, ERROR_INVALID_N				; Tratar erro: parâmetro de -n inválido
				mov		ax, token
				call	handle_error
				jmp		next_char
valid_n:
				mov		group_size, ax					; Salvar valor do parâmetro em group_size
				jmp		next_char

case_a:
				mov		include_a, TRUE					; Ativar flag da opção -a
				jmp		next_char

case_t:
				mov		include_t, TRUE					; Ativar flag da opção -t
				jmp		next_char

case_c:
				mov		include_c, TRUE					; Ativar flag da opção -c
				jmp		next_char

case_g:
				mov		include_g, TRUE					; Ativar flag da opção -g
				jmp		next_char

case_plus:
				mov		include_plus, TRUE				; Ativar flag da opção -+
				jmp		next_char

case_default:
				mov		dl, ERROR_INVALID_OPTION		; Tratar erro: opção inválida
				mov		ax, option_buffer
				call	handle_error
				jmp		next_token

next_char:
				inc		bx								; Próximo caractere
				jmp		token_char

next_token:
				call	argv_tok						; Obter próximo token
				jmp		check_token

check_missing_f:
				cmp		f_provided, FALSE				; Verificar opção -f faltante
				je		handle_missing_f

check_missing_n:
				cmp		n_provided, FALSE				; Verificar opção -n faltante
				je		handle_missing_n

check_missing_atcg:
				cmp		include_a, TRUE					; Verificar opção -<atcg+> faltante
				je		parse_options_end
				cmp		include_t, TRUE
				je		parse_options_end
				cmp		include_c, TRUE
				je		parse_options_end
				cmp		include_g, TRUE
				je		parse_options_end
				cmp		include_plus, TRUE
				je		parse_options_end
				jmp		handle_missing_atcg

handle_missing_f:
				mov		dl, ERROR_MISSING_F				; Tratar erro: opção -f faltante
				call	handle_error
				jmp		check_missing_n

handle_missing_n:
				mov		dl, ERROR_MISSING_N				; Tratar erro: opção -n faltante
				call	handle_error
				jmp		check_missing_atcg

handle_missing_atcg:
				mov		dl, ERROR_MISSING_ACTG			; Tratar erro: opção -<atcg+> faltante
				call	handle_error
				jmp		parse_options_end

handle_duplicate_f:
				mov		dl, ERROR_DUPLICATE_F			; Tratar erro: opção -f duplicada
				call	handle_error
				jmp		next_char

handle_duplicate_o:
				mov		dl, ERROR_DUPLICATE_O			; Tratar erro: opção -o duplicada
				call	handle_error
				jmp		next_char

handle_duplicate_n:
				mov		dl, ERROR_DUPLICATE_N			; Tratar erro: opção -n duplicada
				call	handle_error
				jmp		next_char

parse_options_end:
				cmp		return_code, SUCCESS			; Verificar se houve erros
				je		parse_options_ret

				int_terminate	return_code				; Terminar programa com código de erro

parse_options_ret:
				ret

parse_options				endp

;----------------------------------------------------------------------------------------------------------------------
;	validate_input_file
;----------------------------------------------------------------------------------------------------------------------
;	Função para ler e validar a existência, tamanho e conteúdo do arquivo de entrada.
;----------------------------------------------------------------------------------------------------------------------
validate_input_file		proc	near

				mov		al, READ_ONLY					; Definir leitura como modo de acesso
				lea		dx, input_file					; Carregar endereço do nome do arquivo
				call	fopen							; Abrir arquivo
				mov		read_handle, ax					; Salvar handle do arquivo

validate_input_file_loop:
				cmp		base_count, MAX_BASE_COUNT		; Verificar máximo de bases
				jge		handle_too_many_bases

				mov		bx, read_handle					; Ler caractere
				mov		cx, 1
				lea		dx, read_buffer
				call	fread

				cmp		ax, 0							; Verificar fim do arquivo
				je		check_min_bases

				call	is_base							; Verificar base
				cmp		ax, TRUE
				je		count_base
				cmp		read_buffer, LF					; Verificar quebra de linha
				je		count_line
				cmp		read_buffer, CR
				je		validate_input_file_loop
				jmp		handle_invalid_base

count_base:
				lea		si, base_buffer					; Adicionar base ao buffer de bases
				add		si, base_count
				mov		al, read_buffer
				mov		[si], al
				inc		base_count						; Contar base
				cmp		new_line, TRUE					; Verificar nova linha
				jne		validate_input_file_loop
				inc		base_line_count					; Contar linha com base
				mov		new_line, FALSE					; Desativar flag de nova linha
				jmp		validate_input_file_loop

count_line:
				inc		line_count						; Contar linha
				mov		new_line, TRUE					; Ativar flag de nova linha
				jmp		validate_input_file_loop

handle_invalid_base:
				mov		dl,	ERROR_INVALID_BASE			; Tratar erro: base inválida
				lea		ax, read_buffer
				mov		bx,	line_count
				call	handle_error
				jmp		validate_input_file_end

handle_too_many_bases:
				mov		dl, ERROR_TOO_MANY_BASES		; Tratar erro: arquivo muito grande
				call	handle_error
				jmp		validate_input_file_end

check_min_bases:
				mov		bx, group_size					; Verificar mínimo de bases
				cmp		base_count, bx
				jnl		validate_input_file_end
				mov		dl, ERROR_NOT_ENOUGH_BASES
				call	handle_error

validate_input_file_end:
				mov		ax, base_count					; Calcular número de grupos
				sub		ax, group_size
				inc		ax
				mov		group_count, ax

				mov		bx, read_handle					; Fechar arquivo
				call	fclose
				cmp		return_code, SUCCESS			; Verificar se houve erros
				je		validate_input_file_ret
				int_terminate	return_code				; Terminar programa com código de erro

validate_input_file_ret:
				ret

validate_input_file		endp

;----------------------------------------------------------------------------------------------------------------------
;	print_summary
;----------------------------------------------------------------------------------------------------------------------
;	Função para exibir detalhes sobre as opções utilizadas no processamento e informações sobre
;	o arquivo de entrada.
;----------------------------------------------------------------------------------------------------------------------
print_summary	proc	near

				lea		si, summary_header				; Imprimir cabeçalho
				call	printf

				lea		si, summary_title_options		; Imprimir título "Opções Utilizadas"
				call	printf
				lea		si, summary_input_file			; Imprimir arquivo de entrada
				lea		ax, input_file
				call	printf
				lea		si, summary_output_file			; Imprimir arquivo de saída
				lea		ax, output_file
				call	printf
				lea		si, summary_group_size			; Imprimir tamanho do grupos de base
				mov		dx, group_size
				call	printf
				lea		si, summary_included_bases		; Imprimir bases do arquivo de saída
				call	printf
				call	print_included_bases
				line_feed

				lea		si, summary_title_input_file	; Imprimir título "Informações do arquivo de entrada"
				call	printf
				lea		si, summary_base_count			; Imprimir total de bases
				mov		dx, base_count
				call	printf
				lea		si, summary_group_count			; Imprimir total de grupos
				mov		dx, group_count
				call	printf
				lea		si, summary_base_line_count		; Imprimir total de linhas com bases
				mov		dx, base_line_count
				call	printf

				lea		si, summary_end_separator		; Imprimir separador final
				call	printf

				ret

print_summary	endp

;----------------------------------------------------------------------------------------------------------------------
;	write_output_file
;----------------------------------------------------------------------------------------------------------------------
;	Função para criar um arquivo de saída e registrar a contagem de bases para cada grupo.
;----------------------------------------------------------------------------------------------------------------------
write_output_file	proc	near

				lea		dx, output_file					; Criar e abrir arquivo de saída
				call	fcreate
				mov		write_handle, ax

				call	write_output_header				; Escrever cabeçalho da saída

				lea		si, base_buffer					; Carregar buffer de bases
				mov		cx, group_size					; Inicializar contador do primeiro grupo

first_group_loop:
				mov		al, [si]						; Escrever primeiro grupo
				call	inc_count
				inc		si
				loop	first_group_loop
				call	write_group

write_output_file_loop:
				cmp		[si], NUL						; Verificar fim das bases
				je		write_output_file_end
				mov		al, [si]						; Incrementar contador do caractere atual
				call	inc_count
				sub		si, group_size					; Deslocar para início do grupo atual
				mov		al, [si]
				call	dec_count						; Decrementar contador do caractere
				add		si, group_size					; Deslocar para início do próximo grupo
				inc		si
				call	write_group						; Escrever grupo
				jmp		write_output_file_loop

write_output_file_end:
				mov		bx, write_handle				; Fechar arquivo de saída
				call	fclose
				ret

write_output_file	endp

;----------------------------------------------------------------------------------------------------------------------
;	argv_tok
;----------------------------------------------------------------------------------------------------------------------
;	Função para realizar a segmentação de uma string de argumentos em tokens individuais, efetuando
;	o tratamento de espaços e delimitadores.
;----------------------------------------------------------------------------------------------------------------------
argv_tok		proc	near

				push	bx								; Salvar registradores
				mov		bx, argv_cursor					; Carregar cursor do argv em BX

check_space_start:
				mov		dl, [bx]						; Verificar SPACE no início da string
				cmp		dl, SPACE
				jne		check_nul_start
				inc		bx								; Pular caractere
				jmp		check_space_start

check_nul_start:
				cmp		dl, NUL							; Verificar NUL no início da string
				jne		get_token
				mov		token, NUL						; Salvar token nulo
				jmp		argv_tok_end

get_token:
				mov		token, bx						; Salvar endereço de início do token

check_space_end:
				mov		dl, [bx]						; Verificar SPACE
				cmp		dl, SPACE
				jne		check_nul_end
				mov 	byte ptr [bx], NUL				; Substituir SPACE por NUL para indicar fim do token
				inc		bx								; Pular caractere para próximo token
				jmp		argv_tok_end

check_nul_end:
				cmp		dl, NUL							; Vericiar NUL
				je		argv_tok_end

				inc		bx								; Próximo caractere
				jmp		check_space_end

argv_tok_end:
				mov		argv_cursor, bx					; Salvar posição atual do cursor
				pop		bx								; Retornar registradores
				ret

argv_tok		endp

;----------------------------------------------------------------------------------------------------------------------
;	handle_error
;----------------------------------------------------------------------------------------------------------------------
;	Função para lidar com erros com base em seus códigos, exibindo uma mensagem correspondente e atualizando
;	o código de retorno.
;
;	Entrada:
;		- DL (int):		código de erro
;		- AX (char *):	endereço da string a ser inserida como parâmetro na mensagem de erro
;		- BX (int):		número inteiro a ser inserido como parâmetro na mensagem de erro
;----------------------------------------------------------------------------------------------------------------------
handle_error	proc	near

				cmp		dl, ERROR_INVALID_N				; Switch case para código de erro
				je		load_invalid_n
				cmp		dl, ERROR_INVALID_OPTION
				je		load_invalid_option
				cmp		dl, ERROR_MISSING_F
				je		load_missing_f
				cmp		dl, ERROR_MISSING_N
				je		load_missing_n
				cmp		dl, ERROR_MISSING_ACTG
				je		load_missing_atcg
				cmp		dl, ERROR_DUPLICATE_F
				je		load_duplicate_f
				cmp		dl, ERROR_DUPLICATE_O
				je		load_duplicate_o
				cmp		dl, ERROR_DUPLICATE_N
				je		load_duplicate_n
				cmp		dl, ERROR_FILE_NOT_EXIST
				je		load_file_not_exist
				cmp		dl, ERROR_INVALID_BASE
				je		load_invalid_base
				cmp		dl, ERROR_TOO_MANY_BASES
				je		load_too_many_bases
				cmp		dl, ERROR_NOT_ENOUGH_BASES
				je		load_not_enough_bases

load_invalid_n:
				lea		si, msg_invalid_n				; Carregar mensagem de "INVALID_N"
				jmp		print_msg

load_invalid_option:
				lea		si, msg_invalid_option			; Carregar mensagem de "INVALID_OPTION"
				jmp		print_msg

load_missing_f:
				lea		si, msg_missing_f				; Carregar mensagem de "MISSING_F"
				jmp		print_msg

load_missing_n:
				lea		si, msg_missing_n				; Carregar mensagem de "MISSING_N"
				jmp		print_msg

load_missing_atcg:
				lea		si, msg_missing_atcg			; Carregar mensagem de "MISSING_ACTG"
				jmp		print_msg

load_duplicate_f:
				lea		si, msg_duplicate_f				; Carregar mensagem de "DUPLICATE_F"
				jmp		print_msg

load_duplicate_o:
				lea		si, msg_duplicate_o				; Carregar mensagem de "DUPLICATE_O"
				jmp		print_msg

load_duplicate_n:
				lea		si, msg_duplicate_n				; Carregar mensagem de "DUPLICATE_N"
				jmp		print_msg

load_file_not_exist:
				lea		si, msg_file_not_exist			; Carregar mensagem de "FILE_NOT_EXIST"
				jmp		print_msg

load_invalid_base:
				lea		si, msg_invalid_base			; Carregar mensagem de "INVALID_BASE"
				mov		dx,	bx
				jmp		print_msg

load_too_many_bases:
				lea		si, msg_too_many_bases			; Carregar mensagem de "TOO_MANY_BASES"
				jmp		print_msg

load_not_enough_bases:
				lea		si, msg_not_enough_bases		; Carregar mensagem de "NOT_ENOUGH_BASES"
				mov		dx,	bx
				jmp		print_msg

print_msg:
				call	printf							; Imprimir mensagem
				line_feed
				mov		return_code, dl					; Atualizar código de retorno
				ret

handle_error	endp

;----------------------------------------------------------------------------------------------------------------------
;	write_group
;----------------------------------------------------------------------------------------------------------------------
;	Função para imprimir a contagem de bases para cada grupo no arquivo de saída.
;----------------------------------------------------------------------------------------------------------------------
write_group		proc	near

write_group_a:
				cmp		include_a, TRUE					; Verificar inclusão da base A
				jne		write_group_t
				mov		bx, a_count						; Escrever contagem de A
				call	fwrite_d
				mov		dl, CSV_DELIM					; Escrever delimitador
				call	putchar_f

write_group_t:
				cmp		include_t, TRUE					; Verificar inclusão da base T
				jne		write_group_c
				mov		bx, t_count						; Escrever contagem de T
				call	fwrite_d
				mov		dl, CSV_DELIM					; Escrever delimitador
				call	putchar_f

write_group_c:
				cmp		include_c, TRUE					; Verificar inclusão da base C
				jne		write_group_g
				mov		bx, c_count						; Escrever contagem de C
				call	fwrite_d
				mov		dl, CSV_DELIM					; Escrever delimitador
				call	putchar_f

write_group_g:
				cmp		include_g, TRUE					; Verificar inclusão da base G
				jne		write_group_plus
				mov		bx, g_count						; Escrever contagem de G
				call	fwrite_d
				mov		dl, CSV_DELIM					; Escrever delimitador
				call	putchar_f

write_group_plus:
				cmp		include_plus, TRUE				; Verificar inclusão das bases A+T;C+G
				jne		write_group_end
				mov		bx, a_count						; Escrever contagem de A+T
				add		bx, t_count
				call	fwrite_d
				mov		dl, CSV_DELIM					; Escrever delimitador
				call	putchar_f
				mov		bx, c_count						; Escrever contagem de C+G
				add		bx, g_count
				call	fwrite_d
				mov		dl, CSV_DELIM					; Escrever delimitador
				call	putchar_f

write_group_end:
				backspace_f		write_handle			; Apagar último delimitador
				line_feed_f								; Quebrar linha
				ret

write_group		endp

;----------------------------------------------------------------------------------------------------------------------
;	print_included_bases
;----------------------------------------------------------------------------------------------------------------------
;	Função para imprimir a lista de bases que devem incluídas no arquivo de saída.
;----------------------------------------------------------------------------------------------------------------------
print_included_bases	proc	near

print_a:
				cmp		include_a, TRUE					; Verificar inclusão da base A
				jne		print_t
				lea		si, list_a						; Listar base A
				call	printf

print_t:
				cmp		include_t, TRUE					; Verificar inclusão da base T
				jne		print_c
				lea		si, list_t						; Listar base C
				call	printf

print_c:
				cmp		include_c, TRUE					; Verificar inclusão da base C
				jne		print_g
				lea		si, list_c						; Listar base C
				call	printf

print_g:
				cmp		include_g, TRUE					; Verificar inclusão da base G
				jne		print_plus
				lea		si, list_g						; Listar base G
				call	printf

print_plus:
				cmp		include_plus, TRUE				; Verificar inclusão das bases A+T;C+G
				jne		print_included_bases_end
				lea		si, list_plus					; Listar base A+T;C+G
				call	printf

print_included_bases_end:
				backspace								; Remover última vírgula e espaço
				backspace
				line_feed								; Quebrar linha
				ret

print_included_bases	endp

;----------------------------------------------------------------------------------------------------------------------
;	write_output_header
;----------------------------------------------------------------------------------------------------------------------
;	Função para escrever o cabeçalho do arquivo de saída, incluindo as bases selecionadas.
;----------------------------------------------------------------------------------------------------------------------
write_output_header		proc	near

				mov		bx, write_handle				; Carregar handle do arquivo de saída
				mov		cx, 2							; Definir escrita de 2 bytes

write_a:
				cmp		include_a, TRUE					; Verificar inclusão da base A
				jne		write_t
				lea		dx, header_a					; Escrever base A
				call	fwrite

write_t:
				cmp		include_t, TRUE					; Verificar inclusão da base T
				jne		write_c
				lea		dx, header_t					; Escrever base C
				call	fwrite

write_c:
				cmp		include_c, TRUE					; Verificar inclusão da base C
				jne		write_g
				lea		dx, header_c					; Escrever base C
				call	fwrite

write_g:
				cmp		include_g, TRUE					; Verificar inclusão da base G
				jne		write_plus
				lea		dx, header_g					; Escrever base G
				call	fwrite

write_plus:
				cmp		include_plus, TRUE				; Verificar inclusão das bases A+T;C+G
				jne		write_output_header_end
				mov		cx, 8							; Definir escrita de 8 bytes
				lea		dx, header_plus					; Escrever base A+T;C+G
				call	fwrite

write_output_header_end:
				backspace_f 	write_handle			; Remover último ';'
				line_feed_f								; Quebrar linha
				ret

write_output_header		endp

;----------------------------------------------------------------------------------------------------------------------
;	fcreate
;----------------------------------------------------------------------------------------------------------------------
;	Função para criar e abrir um arquivo.
;
;	Entrada:
;		- DX (char *):	endereço do nome do arquivo
;
;	Saída:
;		- AX (char *):	handle do arquivo criado
;----------------------------------------------------------------------------------------------------------------------
fcreate			proc	near

				mov		cx, 0							; Zerar atributos do arquivo

				mov		ah, 3Ch							; INT 21,3C - Create File Using Handle
				int		21h
				ret

fcreate			endp

;----------------------------------------------------------------------------------------------------------------------
;	fopen
;----------------------------------------------------------------------------------------------------------------------
;	Função para abrir um arquivo no modo especificado e retornar um handle.
;
;	Entrada:
;		- AL (int):		modo de acesso
;		- DX (char *):	endereço do nome do arquivo
;
;	Saída:
;		- AX (char *):	handle do arquivo aberto
;----------------------------------------------------------------------------------------------------------------------
fopen			proc	near

				mov		ah, 3Dh							; INT 21,3D - Open File Using Handle
				int		21h

				jnc		fopen_end						; Verificar existência do arquivo

				mov		dl, ERROR_FILE_NOT_EXIST		; Tratar erro: arquivo não existe
				lea		ax, input_file
				call	handle_error

				int_terminate	return_code				; Terminar programa com código de erro

fopen_end:
				ret

fopen			endp

;----------------------------------------------------------------------------------------------------------------------
;	fclose
;----------------------------------------------------------------------------------------------------------------------
;	Função para fechar um arquivo a partir de um handle
;
;	Entrada:
;		- BX (char *):	handle do arquivo a ser fechado
;----------------------------------------------------------------------------------------------------------------------
fclose			proc	near

				mov		ah, 3Eh							; INT 21,3E - Close File Using Handle
				int		21h

				ret

fclose			endp

;----------------------------------------------------------------------------------------------------------------------
;	fread
;----------------------------------------------------------------------------------------------------------------------
;	Função para ler um arquivo e armazenar seu conteúdo em um buffer.
;
;	Entrada:
;		- BX (char *):	handle do arquivo
;		- DX (char *):	endereço do buffer
;		- CX (int):		número de bytes a serem lidos
;
;	Saída:
;		- AX (int):		número de bytes lidos
;----------------------------------------------------------------------------------------------------------------------
fread			proc	near

				mov		ah, 3Fh							; INT 21,3F - Read From File or Device Using Handle
				int		21h

				ret

fread			endp

;----------------------------------------------------------------------------------------------------------------------
;	fwrite
;----------------------------------------------------------------------------------------------------------------------
;	Função para escrever o conteúdo de um buffer em um arquivo.
;
;	Entrada:
;		- BX (char *):	handle do arquivo
;		- DX (char *):	endereço do buffer
;		- CX (int):		número de bytes a serem escritos
;
;	Saída:
;		- AX (int):		número de bytes escritos
;----------------------------------------------------------------------------------------------------------------------
fwrite			proc	near

				mov		ah, 40h							; INT 21,40 - Write To File or Device Using Handle
				int		21h

				ret

fwrite			endp

;----------------------------------------------------------------------------------------------------------------------
;	fseek
;----------------------------------------------------------------------------------------------------------------------
;	Função para descolar o ponteiro de um arquivo.
;
;	Entrada:
;		- AL (int):		origem do deslocamento
;		- BX (char *):	handle do arquivo
;		- CX (int):		número de bytes a descolar (high)
;		- DX (int):		número de bytes a descolar (low)
;
;	Saída:
;		- AX (int):		nova localização do ponteiro
;----------------------------------------------------------------------------------------------------------------------
fseek			proc	near

				mov		ah, 42h							; INT 21,42 - Move File Pointer Using Handle
				int		21h

				ret

fseek			endp

;----------------------------------------------------------------------------------------------------------------------
;	printf
;----------------------------------------------------------------------------------------------------------------------
;	Função para imprimir uma string, permitindo a inclusão opcional de uma string, indicada
;	por "%s", e de um inteiro, indicada por "%d".
;
;	Entrada:
;		- SI (char *):	endereço da string a ser impressa
;		- AX (char *):	endereço da string a ser inserida como parâmetro
;		- DX (int):		número inteiro a ser inserido como parâmetro
;----------------------------------------------------------------------------------------------------------------------
printf			proc	near

				push	ax								; Salvar registradores
				push	bx
				push	dx

				mov		bx, dx							; Salvar decimal e liberar DX

printf_loop:
				cmp		byte ptr [si], NUL				; Verificar fim da string
				je		printf_end
				cmp		byte ptr [si], '%'				; Verificar placeholder de parâmetro
				je		printf_param

				mov		dl, byte ptr [si]				; Imprimir caractere
				call	putchar

printf_next:
				inc		si								; Próximo caractere
				jmp		printf_loop

printf_param:
				inc		si								; Verificar parâmetro string ou decimal
				cmp		byte ptr [si], 's'
				je		printf_param_str
				cmp		byte ptr [si], 'd'
				je		printf_param_int

				dec		si								; Imprimir '%' normalmente
				call	putchar
				jmp		printf_loop

printf_param_str:
				push	si								; Imprimir string parâmetro
				mov		si, ax
				call	printf
				pop		si
				jmp		printf_next

printf_param_int:
				call	printf_d						; Imprimir decimal parâmetro
				jmp		printf_next

printf_end:
							; Retornar registradores
				pop		dx
				pop		bx
				pop		ax
				ret

printf			endp

;----------------------------------------------------------------------------------------------------------------------
;	printf_d
;----------------------------------------------------------------------------------------------------------------------
;	Função para imprimir um número inteiro.
;
;	Entrada:
;		- BX (int):		número a ser impresso
;----------------------------------------------------------------------------------------------------------------------
printf_d		proc	near

				mov		cx, 10000						; Inicializar contador
				mov		leading_zero, TRUE				; Ativar flag de zero à esquerda

printf_d_loop:
				cmp		cx, 1							; while (CX > 1)
				jng		printf_d_end

				mov		dx, 0							; DX <- 0
				mov		ax, bx							; AX <- n
				div		cx								; DX <- (DX:AX) % CX
				mov		ax, dx							; AX <- DX
				call	divide_by_ten					; CX <- CX / 10
				mov		dx, 0							; DX <- 0
				div		cx								; AX <- (DX:AX) / CX

				cmp		ax, 0							; Verificar se valor é 0
				jne		printf_d_put
				cmp		cx, 1							; Verificar se é o último dígito
				je		printf_d_put
				cmp		leading_zero, TRUE				; Verificar se é zero a esquerda
				je		printf_d_loop

printf_d_put:
				mov		leading_zero, FALSE				; Desativar flag de zero à esquerda
				mov		dl, al							; DL <- AL
				add		dl, '0'							; Converter dígito para caractere
				call	putchar							; Imprimir dígito
				jmp		printf_d_loop

printf_d_end:
				ret

printf_d		endp

;----------------------------------------------------------------------------------------------------------------------
;	fwrite_d
;----------------------------------------------------------------------------------------------------------------------
;	Função para escrever um número inteiro no arquivo.
;
;	Entrada:
;		- BX (int):		número a ser impresso
;----------------------------------------------------------------------------------------------------------------------
fwrite_d		proc	near

				mov		cx, 10000						; Inicializar contador
				mov		leading_zero, TRUE				; Ativar flag de zero à esquerda

fwrite_d_loop:
				cmp		cx, 1							; while (CX > 1)
				jng		fwrite_d_end

				mov		dx, 0							; DX <- 0
				mov		ax, bx							; AX <- n
				div		cx								; DX <- (DX:AX) % CX
				mov		ax, dx							; AX <- DX
				call	divide_by_ten					; CX <- CX / 10
				mov		dx, 0							; DX <- 0
				div		cx								; AX <- (DX:AX) / CX

				cmp		ax, 0							; Verificar se valor é 0
				jne		fwrite_d_put
				cmp		cx, 1							; Verificar se é o último dígito
				je		fwrite_d_put
				cmp		leading_zero, TRUE				; Verificar se é zero a esquerda
				je		fwrite_d_loop

fwrite_d_put:
				mov		leading_zero, FALSE				; Desativar flag de zero à esquerda
				mov		dl, al							; DL <- AL
				add		dl, '0'							; Converter dígito para caractere
				call	putchar_f						; Escrever caractere no arquivo
				jmp		fwrite_d_loop

fwrite_d_end:
				ret

fwrite_d		endp

;----------------------------------------------------------------------------------------------------------------------
;	putchar_f
;----------------------------------------------------------------------------------------------------------------------
;	Função para escrever um caractere no arquivo.
;
;	Entrada:
;		- DL (char):	caractere a ser impresso
;----------------------------------------------------------------------------------------------------------------------
putchar_f		proc	near

				push	bx								; Salvar registradores
				push	cx
				push	dx

				mov		write_buffer, dl				; Carregar buffer de escrita
				mov		bx, write_handle
				mov		cx, 1
				lea		dx, write_buffer

				call	fwrite							; Escrever caractere

				pop		dx								; Retornar registradores
				pop		cx
				pop		bx
				ret

putchar_f		endp

;----------------------------------------------------------------------------------------------------------------------
;	putchar
;----------------------------------------------------------------------------------------------------------------------
;	Função para imprimir um caractere.
;
;	Entrada:
;		- DL (char):	caractere a ser impresso
;----------------------------------------------------------------------------------------------------------------------
putchar			proc	near

				push	ax								; Salvar registradores

				mov		ah, 2							; INT 21,2 - Display Output
				int		21h

				pop		ax								; Retornar registradores
				ret

putchar			endp

;----------------------------------------------------------------------------------------------------------------------
;	strlen
;----------------------------------------------------------------------------------------------------------------------
;	Função para calcular o comprimento de uma string terminada em '\0'.
;
;	Entrada:
;		- SI (char *):	endereço da string
;
;	Saída:
;		- CX (int):		comprimento da string
;----------------------------------------------------------------------------------------------------------------------
strlen			proc	near

				push	si								; Salvar registradores
				mov		cx, 0							; Zerar contador

count_char:
				cmp		byte ptr [si], NUL				; Verificar fim da string
				je		strlen_end
				inc		cx								; Incrementar contador
				inc		si								; Próximo caractere
				jmp		count_char

strlen_end:
				pop		si								; Retornar registradores
				ret

strlen			endp

;----------------------------------------------------------------------------------------------------------------------
;	atoi
;----------------------------------------------------------------------------------------------------------------------
;	Função para converter uma string de caracteres numéricos em um número inteiro.
;
;	Entrada:
;		- SI (char *):	endereço da string
;
;	Saída:
;		- AX (int):		número inteiro
;----------------------------------------------------------------------------------------------------------------------
atoi			proc	near

				push	bx								; Salvar registradores
				mov		ax, 0							; Zerar acumulador
				mov		bl, 10							; Definir 10 como parâmetro para MUL

check_nul:
				cmp		byte ptr [si], NUL				; Verificar fim da string
				je		atoi_end

				cmp		byte ptr [si], '0'				; Verificar caractere não numérico
				jl		atoi_error
				cmp		byte ptr [si], '9'
				jg		atoi_error

				mul		bl								; AX <- AL * 10
				add		ax, [si]						; AX <- AX + caractere
				sub		ax, '0'							; AX <- AX - '0'

				inc		si								; Próximo caractere
				jmp		check_nul

atoi_error:
				mov		ax, ERROR

atoi_end:
				pop		bx								; Retornar registradores
				ret

atoi			endp

;----------------------------------------------------------------------------------------------------------------------
;	inc_count
;----------------------------------------------------------------------------------------------------------------------
;	Função para incrementar contador da base informada
;
;	Entrada:
;		- AL (char):	base
;----------------------------------------------------------------------------------------------------------------------
inc_count		proc	near

				cmp		al, 'A'							; Identificar base
				je		inc_a
				cmp		al, 'T'
				je		inc_t
				cmp		al, 'C'
				je		inc_c
				cmp		al, 'G'
				je		inc_g
				jmp		inc_count_end

inc_a:													; Incrementar contador correspondente
				inc		a_count
				jmp		inc_count_end
inc_t:
				inc		t_count
				jmp		inc_count_end
inc_c:
				inc		c_count
				jmp		inc_count_end
inc_g:
				inc		g_count
				jmp		inc_count_end

inc_count_end:
				ret

inc_count		endp

;----------------------------------------------------------------------------------------------------------------------
;	dec_count
;----------------------------------------------------------------------------------------------------------------------
;	Função para decrementar contador da base informada
;
;	Entrada:
;		- AL (char):	base
;----------------------------------------------------------------------------------------------------------------------
dec_count		proc	near

				cmp		al, 'A'							; Identificar base
				je		dec_a
				cmp		al, 'T'
				je		dec_t
				cmp		al, 'C'
				je		dec_c
				cmp		al, 'G'
				je		dec_g
				jmp		dec_count_end

dec_a:													; Decrementar contador correspondente
				dec		a_count
				jmp		dec_count_end
dec_t:
				dec		t_count
				jmp		dec_count_end
dec_c:
				dec		c_count
				jmp		dec_count_end
dec_g:
				dec		g_count
				jmp		dec_count_end

dec_count_end:
				ret

dec_count		endp

;----------------------------------------------------------------------------------------------------------------------
;	is_base
;----------------------------------------------------------------------------------------------------------------------
;	Função para verificar se caractere no buffer de leitura é uma base.
;
;	Saída:
;		- AX (int):		TRUE caso afirmativo, FALSE caso negativo.
;----------------------------------------------------------------------------------------------------------------------
is_base			proc	near

				cmp		read_buffer, 'A'
				je		is_base_true
				cmp		read_buffer, 'T'
				je		is_base_true
				cmp		read_buffer, 'C'
				je		is_base_true
				cmp		read_buffer, 'G'
				je		is_base_true

is_base_false:
				mov		ax, FALSE
				ret

is_base_true:
				mov		ax, TRUE
				ret

is_base			endp

;----------------------------------------------------------------------------------------------------------------------
;	divide_by_ten
;----------------------------------------------------------------------------------------------------------------------
;	Função para dividir um número por 10.
;
;	Entrada:
;		- CX (int):		número a ser dividido
;
;	Saída:
;		- CX (int):		número dividido por 10
;----------------------------------------------------------------------------------------------------------------------
divide_by_ten	proc	near

				push	ax								; Salvar registradores
				push	bx
				push	dx

				mov		ax, cx							; CX <- CX / 10
				mov		dx, 0
				mov		bx, 10
				div		bx
				mov		cx, ax

				pop		dx								; Retornar registradores
				pop		bx
				pop		ax

				ret

divide_by_ten	endp

;----------------------------------------------------------------------------------------------------------------------
;	join_segments
;----------------------------------------------------------------------------------------------------------------------
;	Função para unir segmentos DS e ES.
;----------------------------------------------------------------------------------------------------------------------
join_segments	proc	near

				mov		ax, ds
				mov		es, ax

				ret

join_segments	endp

;----------------------------------------------------------------------------------------------------------------------
	end
;----------------------------------------------------------------------------------------------------------------------
