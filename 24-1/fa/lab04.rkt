#lang racket

(require rackunit)
(require 2htdp/image)

;#####################################################################################################
;;
;; LISTA AVALIADA 3
;;
;#####################################################################################################
;; IDENTIFICAÇÃO DO GRUPO
;; Escreva abaixo, em ordem alfabética, o nome e número de matrícula de todos os membros do grupo:
;;    Nome Sobrenome Matrícula
;; 1.
;; 2.
;; 3.
;; 4.
;#####################################################################################################

;; ============================================
;; DEFINIÇÕES DE TIPOS DE DADOS (não modificar)
;; ============================================

;; ------------------
;; TIPO GENERO:
;; ------------------
;; Um Genero é
;; 1. a string "feminino", ou
;; 2. a string "masculino", ou
;; 3. a srting "outros"

;; ------------------
;; TIPO FUNCIONARIO:
;; ------------------
(define-struct funcionario (nome genero anos-empresa destaque?))
;; Um elemento do conjunto Funcionario tem o formato
;;     (make-funcionario n g a d) onde
;;      n: String, é o nome do funcionário,
;;      g: Genero, é o genero do funcionário,
;;      a: Número, representa os anos de serviço na empresa do funcionário,
;;      d: Boolean, representa se funcionário foi o destaque o mês.

;; ------------------
;; TIPO SETOR:
;; ------------------
(define-struct setor (nome membros))
;; Um elemento do conjunto Setor tem o formato
;;     (make-setor nome lmemb) onde
;;     nome: String, é o nome do setor e
;;     lmemb: Lista-membros, é uma lista de membros deste setor.

;; ------------------
;; TIPO LISTA-MEMBROS:
;; ------------------
;; Uma Lista-membros é
;; 1. empty (vazia), ou
;; 2. (cons f lm), onde f : Funcionario, e lm : Lista-membros, ou
;; 3. (cons s lm), onde s : Setor, e  lm : Lista-membros.

;=====================================================================================================
;	QUESTÃO 1
;=====================================================================================================
;
;	Defina pelo menos 10 constantes do tipo Funcionario e 4 constante do tipo Setor, sendo que ao
;	menos um setor deve ter no mínimo mais 2 níveis de subsetores (sem contar o setor raiz da
;	árvore), um mesmo funcionário não pode estar em mais de um setor, e não existam setores sem
;	funcionários.
;
;=====================================================================================================

(define FUNCIONARIO1 (make-funcionario "João" "masculino" 0 #f))
(define FUNCIONARIO2 (make-funcionario "Maria" "feminino" 1 #f))
(define FUNCIONARIO3 (make-funcionario "Fernando" "outros" 2 #f))
(define FUNCIONARIO4 (make-funcionario "José" "masculino" 3 #f))
(define FUNCIONARIO5 (make-funcionario "Rafaela" "feminino" 4 #f))
(define FUNCIONARIO6 (make-funcionario "Ana" "outros" 5 #f))
(define FUNCIONARIO7 (make-funcionario "Miguel" "masculino" 6 #f))
(define FUNCIONARIO8 (make-funcionario "Carol" "feminino" 7 #f))
(define FUNCIONARIO9 (make-funcionario "Pedro" "outros" 8 #f))
(define FUNCIONARIO10 (make-funcionario "Bruno" "masculino" 9 #t))

(define SETOR4 (make-setor "RH" (list FUNCIONARIO8 FUNCIONARIO9 FUNCIONARIO10)))
(define SETOR3 (make-setor "APIs" (list FUNCIONARIO6 FUNCIONARIO7)))
(define SETOR2 (make-setor "Back-end" (list SETOR3 FUNCIONARIO4 FUNCIONARIO5)))
(define SETOR1 (make-setor "Software" (list SETOR2 FUNCIONARIO1 FUNCIONARIO2 FUNCIONARIO3)))

;=====================================================================================================
;	QUESTÃO 2
;=====================================================================================================
;
;	Para fazer uma análise de seus funcionários, a empresa quer saber quantos funcionários há do
;	gênero feminino, gênero masculino ou outro. Construa a função quantidade-por-genero que, dados
;	um setor e um gênero (use as definições de dados do template para esses tipos), devolve o
;	número de funcionários deste gênero neste setor da empresa.
;
;=====================================================================================================

;-----------------------------------------------------------------------------------------------------
;	FUNÇÃO quantidade-por-genero-lista : Lista-membros Genero -> Número
;-----------------------------------------------------------------------------------------------------
;	Dada uma lista de membros e um gênero, devolve o número de funcionários deste gênero na lista.
;
;	Exemplos:
;		(quantidade-por-genero-lista (setor-membeos SETOR1) "masculino") = 3
;		(quantidade-por-genero-lista (setor-membeos SETOR4) "feminino") = 1
;-----------------------------------------------------------------------------------------------------
(define (quantidade-por-genero-lista lista genero)
  (cond
    [(empty? lista) 0]
    [else
     (+ (quantidade-por-genero-lista (rest lista) genero)
        (cond
          [(setor? (first lista)) (quantidade-por-genero-lista (setor-membros (first lista)) genero)]
          [(string=? (funcionario-genero (first lista)) genero) 1]
          [else 0]))]))

; Testes
(check-equal? (quantidade-por-genero-lista (setor-membros SETOR1) "masculino") 3)
(check-equal? (quantidade-por-genero-lista (setor-membros SETOR4) "feminino") 1)

;-----------------------------------------------------------------------------------------------------
;	FUNÇÃO quantidade-por-genero : Setor Genero -> Número
;-----------------------------------------------------------------------------------------------------
;	Dado um setor e um gênero, devolve o número de funcionários deste gênero neste setor da
;	empresa.
;
;	Exemplos:
;		(quantidade-por-genero SETOR1 "masculino") = 3
;		(quantidade-por-genero SETOR4 "feminino") = 1
;-----------------------------------------------------------------------------------------------------
(define (quantidade-por-genero setor genero)
  (quantidade-por-genero-lista (setor-membros setor) genero))

; Testes
(check-equal? (quantidade-por-genero SETOR1 "masculino") 3)
(check-equal? (quantidade-por-genero SETOR4 "feminino") 1)

;=====================================================================================================
;	QUESTÃO 3
;=====================================================================================================
;
;	Construa a função maximo, dada uma lista de números naturais, devolve o número máximo desta
;	lista. Se a lista estiver vazia, a função devolve zero.
;
;=====================================================================================================

;-----------------------------------------------------------------------------------------------------
;	TIPO ListaDeNúmeros = empty | (cons Número ListaDeNúmeros)
;-----------------------------------------------------------------------------------------------------

;-----------------------------------------------------------------------------------------------------
;	FUNÇÃO maximo : ListaDeNúmeros -> Número
;-----------------------------------------------------------------------------------------------------
;	Dada uma lista de números naturais, devolve o número máximo desta lista. Se a lista estiver
;	vazia, a função devolve zero.
;
;	Exemplos:
;		(maximo (list 8 5 11 0 6)) = 11
;		(maximo empty) = 0
;-----------------------------------------------------------------------------------------------------

(define (maximo lista)
  (cond
    [(empty? lista) 0]
    [(> (first lista) (maximo (rest lista))) (first lista)]
    [else (maximo (rest lista))]))

; Testes
(check-equal? (maximo (list 8 5 11 0 6)) 11)
(check-equal? (maximo empty) 0)

;=====================================================================================================
;	QUESTÃO 4
;=====================================================================================================
;
;	Para analisar sua estrutura organizacional, a empresa gostaria de saber o número máximo de
;	subsetores que existe em algum setor e o tamanho da maior cadeia de subsetores da empresa.
;	Essas informações podem ser obtidas calculando-se o grau e a altura da árvore de setores da
;	empresa, respectivamente.
;
;	Construa as funções correspondentes, que devem se chamar grau e altura, respectivamente. O grau
;	de uma árvore é o maior grau entre os graus de seus nós. O grau de um nó da árvore é o número
;	de subárvores não vazias deste nó (ou seja, conta-se as folhas e galhos).
;
;	A altura de uma árvore é a maior distância entre a raiz e uma das folhas da árvore. Um setor
;	sem funcionários tem altura zero. Um setor que tem funcionários mas não possui subsetores tem
;	altura 1.
;
;=====================================================================================================

(define (conta-filhos)
  )

;-----------------------------------------------------------------------------------------------------
;	TIPO ListaDeSetores = empty | (cons Setor ListaDeSetores)
;-----------------------------------------------------------------------------------------------------

(define (conta-setores membros)
  (cond
    [(empty? membros) 0]
    [else
     (+ (conta-setores (rest membros))
        (cond
          [(setor? (first membros)) 1]
          [else 0]))]))

(define (filtra-setores membros)
  (cond
    [(empty? membros) empty]
    [(setor? (first membros)) (cons (first membros) (filtra-setores (rest membros)))]
    [else (filtra-setores (rest membros))]))

(define (lista-graus membros)
  (cond
    [(empty? membros) empty]
    [(setor? (first membros)) (cons (grau (first membros)) (lista-graus (rest membros)))]
    [else (lista-graus (rest membros))]))

(define (grau-setor setor)
  (cond
    [(empty? (setor-membros setor)) 0]
    [(maximo)]))

;-----------------------------------------------------------------------------------------------------
;	FUNÇÃO grau : Setor -> Número
;-----------------------------------------------------------------------------------------------------
;	Dado um setor raiz, calcula o grau da árvore de subsetores originada desse setor, ou seja, o
;	número máximo de subsetores que existe em algum setor.
;
;	Exemplos:
;		(grau SETOR1) = 1
;		(grau SETOR4) = 0
;-----------------------------------------------------------------------------------------------------
(define (grau raiz)
  (cond
    [(empty? (filtra-setores (setor-membros setor))) 0]
    [else (maximo (cons (conta-setores (setor-membros setor))) (lista-graus (setor-membros setor)))]))

;=====================================================================================================
;	QUESTÃO 5
;=====================================================================================================
;
;	Construa a função chamada gera-imagem-setor, dado um setor, que mostra a árvore que este setor
;	representa. A visualização (uma imagem) deve satisfazer os seguintes requisitos:
;		(a) setores e funcionários devem ter visualizações diferentes (cor ou forma ou outra
;			característica) para que seja fácil diferencia-los na imagem;
;		(b) para cada funcionário, deve ser mostrado seu nome e o número de anos na empresa;
;		(c) para cada setor, deve ser mostrado o número de funcionários diretos do setor (ou seja,
;			sem considerar funcionários de subsetores);
;		(d) deve haver uma visualização diferente para cada gênero;
;		(e) funcionários-destaque devem ser ressaltados de alguma forma.
;
;=====================================================================================================

;=====================================================================================================
;	QUESTÃO 6
;=====================================================================================================
;
;	Construa a função chamada insere-funcionario que, dados um funcionário, o nome de um setor e a
;	árvore de setores de uma empresa, inclui este funcionário no setor indicado. Se não existir
;	este setor, devolve a mensagem "Setor não existente".
;
;=====================================================================================================
