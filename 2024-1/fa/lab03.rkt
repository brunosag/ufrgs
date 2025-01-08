;#####################################################################################################
;;
;; LISTA AVALIADA 2
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

;; ========================================================================================
;;                              DEFINIÇÕES DE DADOS
;; ========================================================================================
;; -----------------
;; TIPO TipoDeForma:
;; -----------------
;; Um TipoDeForma pode ser
;; 1. "retângulo", ou
;; 2. "triângulo", ou
;; 3. "círculo", ou
;; 4. "estrela"

;; -----------------
;; TIPO CorDeForma:
;; -----------------
;; Uma CorDeForma pode ser
;; 1. "red", ou
;; 2. "blue", ou
;; 3. "green", ou
;; 4. "yellow", ou
;; 5. "orange", ou
;; 6. "brown"

;; -------------------
;; TIPO ListaDeNumeros:
;; -------------------
;; Uma ListaDeNumeros é
;; 1. empty (lista vazia), ou
;; 2. (cons n ln), onde n: Número e ln: ListaDeNumeros

;; -----------
;; TIPO Forma:
;; -----------
(define-struct forma (nome tipo cor args))
;; Um elemento do conjunto Forma tem o formato
;;    (make-forma n t c a), onde
;;    n : String, é o nome da forma
;;    t : TipoDeForma, é o tipo da forma
;;    c : CorDeForma, é a cor da forma
;;    a : ListaDeNumeros, é a lista de argumentos da forma, confore seu tipo:
;;                        - retângulos possumes 2 argumentos, largura e altura;
;;                        - triângulos possumes 1 argumento, o lado;
;;                        - círculos possumes 1 argumento, o raio;
;;                        - estrelas possumes 3 argumentos, o número de pontas, o
;;                          raio interno e o raio externo.

;; -------------------
;; TIPO ListaDeFormas:
;; -------------------
;; Uma ListaDeFormas é
;; 1. vazia (empty), ou
;; 2. (cons f lf), onde
;;     f : Forma
;;     lf: ListaFormas

;; -----------
;; TIPO Aluno:
;; -----------

(define-struct aluno (nome desenho conceito))
;; Um elemento do conjunto Aluno tem o formato
;;    (make-aluno n d c), onde
;;    n : String, é o nome do aluno
;;    d : ListaDeFormas, é o desenho do aluno
;;    c : String, é o conceito do aluno

;; ========================================================================================
;;                                    FUNÇÕES ÚTEIS
;; ========================================================================================

;; ----------------------------------------------
;; FUNÇÃO length: (funcão pré-definida no Racket)
;; ----------------------------------------------
;; length : Lista -> Número
;; Dada uma lista (de qualquer tipo), devolve o número de elementos da lista
;; Exemplos:
;;        (length empty) = 0
;;        (length (cons 1 (con 3 (cons -10 empty)))) = 3

;; -----------------------
;; FUNÇÃO desenha-com-nome:
;; -----------------------
;; desenha : Forma -> Imagem
;; Dada uma forma, desenha esta forma com o  seu nome dentro
;; Exemplos:
;;     (desenha-com-nome (make-forma "C2" "circulo" "blue"  (cons 30 empty))) = .
;;     (desenha-com-nome (make-forma "E1" "estrela" "red"     (cons 40 (cons 20 (cons 40 empty))))) = .

(define (desenha-com-nome @F) ;; Dada uma forma @F
  (overlay ;; sobrepõe
   ;; o nome da forma @F, e
   (text (forma-nome @F) 20 "black")
   ;; o desenho da forma @F
   (cond
     ;; se @F for um retângulo, desenha este retângulo
     [(string=? "retângulo" (forma-tipo @F))
      (rectangle (first (forma-args @F)) (second (forma-args @F)) "solid" (forma-cor @F))]
     ;; se @F for um triângulo, desenha este triângulo
     [(string=? "triângulo" (forma-tipo @F))
      (triangle (first (forma-args @F)) "solid" (forma-cor @F))]
     ;; se @F for um círculo, desenha este circulo
     [(string=? "círculo" (forma-tipo @F)) (circle (first (forma-args @F)) "solid" (forma-cor @F))]
     ;; se @F for uma estrela, desenha esta estrela
     [(string=? "estrela" (forma-tipo @F))
      (radial-star (first (forma-args @F))
                   (second (forma-args @F))
                   (third (forma-args @F))
                   "solid"
                   (forma-cor @F))])))

;; ---------------------------
;; FUNÇÃO desenha-lista-formas:
;; ---------------------------
;; desenha-lista-formas: ListaDeFormas -> Imagem
;; Dada uma lista de formas, desenha as formas da lista lado a lado, com os nomes dentro das formas.
;; Exemplo:
;;    (desenha-lista-formas (cons (make-forma "C2" "circulo" "blue"  (cons 30 empty))
;;                            (cons  (make-forma "E1" "estrela" "red"     (cons 40 (cons 20 (cons 40 empty)))) empty))) = .

(define (desenha-lista-formas @LF) ;; Dada uma lista de formas @LF
  (cond
    ;; se a lista @LF estiver vazia, devolve a imagem vazia
    [(empty? @LF) empty-image]
    ;; senão coloca lado a lado
    ;; o desenho do primeiro elemento de @LF, e
    [else
     (beside (desenha-com-nome (first @LF))
             ;; o desenho do resto dos elementos da lista @LF
             (desenha-lista-formas (rest @LF)))]))

;; -------------------------
;; FUNÇÃO conta-formas-cor:
;; -------------------------
;; conta-formas-cor: ListaDeFormas CorDeForma -> Numero
;; Dada uma lista de formas e uma cor, diz quantas formas desta cor há na lista.
;; Exemplos:
;;    (conta-formas-cor empty "red") = 0
;;    (conta-formas-cor (cons (make-forma "C2" "circulo" "blue"  (cons 30 empty))
;;                            (cons  (make-forma "E1" "estrela" "red"     (cons 40 (cons 20 (cons 40 empty)))) empty)) "red"))) =   1

(define (conta-formas-cor @LF @COR)
  (cond
    ;; se a lista estiver vazia, devolve zero
    [(empty? @LF) 0]
    ;; senão, soma
    [else
     ;; 1, se o primeiro elemento da lista @LF for da cor @COR, ou zero, caso contrário
     (+ (cond
          [(string=? (forma-cor (first @LF)) @COR) 1]
          [else 0])
        ;; ao número de formas da cor @COR do resto da lista @LF
        (conta-formas-cor (rest @LF) @COR))]))

;=====================================================================================================
;                                            EXERCÍCIOS
;=====================================================================================================

;=====================================================================================================
;   1.
;=====================================================================================================
;
;   Defina um tipo de dados chamado ListaDeAlunos armazenar os dados de uma turma. Defina pelo
;   menos 10 constantes do tipo Aluno e 4 constantes do tipo ListaDeAlunos, sendo que ao menos uma
;   lista de alunos deve ter no mínimo 5 elementos.
;
;=====================================================================================================

(define R1 (make-forma "R1" "retângulo" "red" (cons 48 (cons 72 empty))))
(define R2 (make-forma "R2" "retângulo" "blue" (cons 48 (cons 72 empty))))
(define T1 (make-forma "T1" "triângulo" "red" (cons 83 empty)))
(define T2 (make-forma "T2" "triângulo" "yellow" (cons 83 empty)))
(define C1 (make-forma "C1" "círculo" "green" (cons 36 empty)))
(define C2 (make-forma "C2" "círculo" "blue" (cons 36 empty)))
(define E1 (make-forma "E1" "estrela" "red" (cons 10 (cons 28 (cons 36 empty)))))
(define E2 (make-forma "E2" "estrela" "yellow" (cons 10 (cons 28 (cons 36 empty)))))

(define ALUNO1 (make-aluno "Maria" (cons C1 (cons C2 (cons C2 (cons E2 (cons T1 empty))))) ""))
(define ALUNO2
  (make-aluno "João" (cons T1 (cons T2 (cons T1 (cons E1 (cons R1 (cons E2 empty)))))) ""))
(define ALUNO3
  (make-aluno "Adão" (cons C2 (cons E2 (cons T1 (cons T2 (cons R1 (cons R2 empty)))))) ""))
(define ALUNO4 (make-aluno "Eva" (cons C1 empty) ""))
(define ALUNO5 (make-aluno "José" empty ""))
(define ALUNO6 (make-aluno "Ana" (cons R1 (cons R2 (cons E1 (cons E2 (cons T1 empty))))) ""))
(define ALUNO7
  (make-aluno "Pedro" (cons T1 (cons T2 (cons T1 (cons E1 (cons R1 (cons E2 empty)))))) ""))
(define ALUNO8
  (make-aluno "Paula" (cons C2 (cons E2 (cons T1 (cons T2 (cons R1 (cons R2 empty)))))) ""))
(define ALUNO9 (make-aluno "Joaquim" (cons C1 empty) ""))
(define ALUNO10 (make-aluno "Marta" empty ""))

;-----------------------------------------------------------------------------------------------------
;   TIPO ListaDeAlunos = empty | (cons Aluno ListaDeAlunos)
;-----------------------------------------------------------------------------------------------------

(define LISTA-ALUNOS1 (cons ALUNO1 (cons ALUNO2 (cons ALUNO3 (cons ALUNO4 (cons ALUNO5 empty))))))
(define LISTA-ALUNOS2 (cons ALUNO6 (cons ALUNO7 (cons ALUNO8 (cons ALUNO9 (cons ALUNO10 empty))))))
(define LISTA-ALUNOS3 (cons ALUNO2 (cons ALUNO4 (cons ALUNO6 (cons ALUNO8 empty)))))
(define LISTA-ALUNOS4
  (cons ALUNO1
        (cons ALUNO2
              (cons ALUNO3
                    (cons ALUNO4
                          (cons ALUNO5
                                (cons ALUNO6
                                      (cons ALUNO7
                                            (cons ALUNO8 (cons ALUNO9 (cons ALUNO10 empty)))))))))))

;=====================================================================================================
;   2.
;=====================================================================================================
;
;   Desenvolva a função existe-forma-na-lista? que, dada uma lista de formas e um tipo de forma,
;   nesta ordem, verifica se há alguma forma deste tipo na lista.
;
;=====================================================================================================

;-----------------------------------------------------------------------------------------------------
;	FUNÇÃO existe-forma-na-lista? : ListaDeFormas TipoDeForma -> Booleano
;-----------------------------------------------------------------------------------------------------
;	Dada uma lista de formas e um tipo de forma, verifica se há alguma forma deste tipo na lista.
;
;	Exemplos:
;		(existe-forma-na-lista? (cons C1 (cons E1 (cons R1 (cons T1 empty)))) "retângulo") = true
;		(existe-forma-na-lista? (cons T1 (cons R2 (cons T2 (cons E2 empty)))) "círculo") = false
;-----------------------------------------------------------------------------------------------------
(define (existe-forma-na-lista? lista tipo)
  (cond
    ; Se a lista estiver vazia, devolver falso
    [(empty? lista) false]
    ; Se o primeira forma da lista for do tipo procurado, devolver verdadeiro
    [(string=? (forma-tipo (first lista)) tipo) true]
    ; Senão, procurar a forma no resto da lista
    [else (existe-forma-na-lista? (rest lista) tipo)]))

; Testes
(check-expect (existe-forma-na-lista? empty "triângulo") false)
(check-expect (existe-forma-na-lista? (cons C1 (cons E1 (cons R1 (cons T1 empty)))) "retângulo") true)
(check-expect (existe-forma-na-lista? (cons T1 (cons R2 (cons T2 (cons E2 empty)))) "círculo") false)

;=====================================================================================================
;   3.
;=====================================================================================================
;
;   Construa a função remove-formas-mesma-cor que, dada uma lista de formas, remove formas da mesma
;   cor da lista, deixando no máximo uma de cada cor (a que estiver mais no final da lista).
;
;=====================================================================================================

;-----------------------------------------------------------------------------------------------------
;	FUNÇÃO existe-cor-na-lista? : ListaDeFormas CorDeForma -> Booleano
;-----------------------------------------------------------------------------------------------------
;	Dada uma lista de formas e uma cor de forma, verifica se há alguma forma desta cor na lista.
;
;	Exemplos:
;		(existe-cor-na-lista? (cons R1 (cons R2 (cons T1 (cons T2 (cons C1 empty))))) "green") = true
;		(existe-cor-na-lista? (cons R1 (cons R2 (cons T1 (cons T2 empty)))) "green") = false
;-----------------------------------------------------------------------------------------------------
(define (existe-cor-na-lista? lista cor)
  (cond
    ; Se a lista estiver vazia, devolver falso
    [(empty? lista) false]
    ; Se a primeira forma da lista for da cor procurada, devolver verdadeiro
    [(string=? (forma-cor (first lista)) cor) true]
    ; Senão, procurar a cor no resto da lista
    [else (existe-cor-na-lista? (rest lista) cor)]))

; Testes
(check-expect (existe-cor-na-lista? empty "green") false)
(check-expect (existe-cor-na-lista? (cons R1 (cons R2 (cons T1 (cons T2 (cons C1 empty))))) "green")
              true)
(check-expect (existe-cor-na-lista? (cons R1 (cons R2 (cons T1 (cons T2 empty)))) "green") false)

;-----------------------------------------------------------------------------------------------------
;	FUNÇÃO remove-formas-mesma-cor : ListaDeFormas -> ListaDeFormas
;-----------------------------------------------------------------------------------------------------
;	Dada uma lista de formas, remove formas da mesma cor da lista, deixando no máximo uma de cada
;	cor (a que estiver mais no final da lista).
;
;	Exemplos:
;		(remove-formas-mesma-cor (cons T1 (cons T2 (cons E1 (cons E2 empty))))
;			= (cons E1 (cons E2 empty))
;		(remove-formas-mesma-cor (cons C1 (cons C2 (cons E1 (cons E2 empty))))
;			= (cons C1 (cons C2 (cons E1 (cons E2 empty)))
;-----------------------------------------------------------------------------------------------------
(define (remove-formas-mesma-cor lista)
  (cond
    ; Se a lista estiver vazia, devolver lista vazia
    [(empty? lista) empty]
    ; Se existir a cor da primeira forma no resto da lista, devolver o resto da lista filtrado
    [(existe-cor-na-lista? (rest lista) (forma-cor (first lista)))
     (remove-formas-mesma-cor (rest lista))]
    ; Senão, devolver primeira forma da lista concatenada com o resto da lista filtrado
    [else (cons (first lista) (remove-formas-mesma-cor (rest lista)))]))

; Testes
(check-expect (remove-formas-mesma-cor empty) empty)
(check-expect (first (remove-formas-mesma-cor (cons T1 (cons T2 (cons E1 (cons E2 empty)))))) E1)
(check-expect (first (remove-formas-mesma-cor (cons C1 (cons C2 (cons E1 (cons E2 empty)))))) C1)

;=====================================================================================================
;   4.
;=====================================================================================================
;
;   O professor solicitou aos alunos um desenho com os seguintes requisitos:
;       (1) todos os 4 tipos de formas devem aparecer no desenho;
;       (2) devem ser usadas pelo menos 2 cores diferentes;
;       (3) para cada cor usada no desenho, o número de formas desenhadas desta cor deve ser par.
;
;   Construa 3 funções, uma para verificar cada um dos requisitos acima. As funções devem receber o
;   desenho de um aluno (lista de formas) e devolver verdadeiro ou falso, dependendo do desenho
;   satisfazer o requisito ou não. Os nomes das funções devem ser 4tipos? (requisito 1),
;   num-min-cores? (requisito 2) num-par-cores? (requisito 3). Dica: Utilize as funções definidas
;   nos exercícios anteriores para construir suas funções. Para verificar se um número é par, pode
;   ser usada a função pré-definida even? que, dado um número, verifica se ele é par.
;
;=====================================================================================================

;-----------------------------------------------------------------------------------------------------
;	FUNÇÃO 4tipos? : ListaDeFormas -> Booleano
;-----------------------------------------------------------------------------------------------------
;	Dada uma lista de formas, verifica se ela inclui todos os 4 tipos de formas ("retângulo",
;	"triângulo", "círculo" e "estrela").
;
;	Exemplos:
;		(4tipos? (cons R1 (cons T1 (cons C1 (cons E1 empty))))) = true
;		(4tipos? (cons R1 (cons T1 (cons C1 empty)))) = false
;-----------------------------------------------------------------------------------------------------
(define (4tipos? lista)
  (and (existe-forma-na-lista? lista "retângulo")
       (existe-forma-na-lista? lista "triângulo")
       (existe-forma-na-lista? lista "círculo")
       (existe-forma-na-lista? lista "estrela")))

; Testes
(check-expect (4tipos? empty) false)
(check-expect (4tipos? (cons R1 (cons T1 (cons C1 (cons E1 empty))))) true)
(check-expect (4tipos? (cons R1 (cons T1 (cons C1 empty)))) false)

;-----------------------------------------------------------------------------------------------------
;	FUNÇÃO existe-cor-diferente? : ListaDeFormas CorDeForma -> Booleano
;-----------------------------------------------------------------------------------------------------
;	Dada uma lista de formas e uma cor de forma, verifica se há uma forma de cor diferente desta na
;	lista.
;
;	Exemplos:
;		(existe-cor-diferente? (cons R1 (cons R2 empty)) "red") = true
;		(existe-cor-diferente? (cons R1 (cons E1 empty)) "red") = false
;-----------------------------------------------------------------------------------------------------
(define (existe-cor-diferente? lista cor)
  (cond
    ; Se a lista estiver vazia, devolver falso
    [(empty? lista) false]
    ; Se a primeira forma da lista for de cor diferente da procurada, devolver verdadeiro
    [(not (string=? (forma-cor (first lista)) cor)) true]
    ; Senão, procurar cor diferente no resto da lista
    [else (existe-cor-diferente? (rest lista) cor)]))

; Testes
(check-expect (existe-cor-diferente? empty "red") false)
(check-expect (existe-cor-diferente? (cons R1 (cons R2 empty)) "red") true)
(check-expect (existe-cor-diferente? (cons R1 (cons E1 empty)) "red") false)

;-----------------------------------------------------------------------------------------------------
;	FUNÇÃO num-min-cores? : ListaDeFormas -> Booleano
;-----------------------------------------------------------------------------------------------------
;	Dada uma lista de formas, verifica se há pelo menos 2 cores diferentes.
;
;	Exemplos:
;		(num-min-cores? (cons R1 (cons R2 (cons T1 empty)))) = true
;		(num-min-cores? (cons R1 (cons R2 empty))) = true
;		(num-min-cores? (cons R1 (cons E1 empty))) = false
;-----------------------------------------------------------------------------------------------------
(define (num-min-cores? lista)
  (cond
    [(empty? lista) false]
    [else (existe-cor-diferente? lista (forma-cor (first lista)))]))

; Testes
(check-expect (num-min-cores? empty) false)
(check-expect (num-min-cores? (cons R1 (cons R2 (cons T1 empty)))) true)
(check-expect (num-min-cores? (cons R1 (cons R2 empty))) true)
(check-expect (num-min-cores? (cons R1 (cons E1 empty))) false)

;-----------------------------------------------------------------------------------------------------
;	FUNÇÃO num-par-cor? : ListaDeFormas CorDeForma -> Booleano
;-----------------------------------------------------------------------------------------------------
;	Dada uma lista de formas e uma cor de forma, verifica se há um número par de formas desta cor
;	na lista.
;
;	Exemplos:
;		(num-par-cor? (cons R2 (cons E1 (cons E2 empty))) "blue") = true
;		(num-par-cor? (cons R2 (cons C1 (cons E1 empty))) "blue") = false
;-----------------------------------------------------------------------------------------------------
(define (num-par-cor? lista cor)
  (cond
    ; Se a lista estiver vazia, devolver verdadeiro
    [(empty? lista) true]
    ; Se a primeira forma for da cor procurada, verificar se o resto da lista possui quantidade
    ; ímpar da cor
    [(string=? (forma-cor (first lista)) cor) (not (num-par-cor? (rest lista) cor))]
    ; Senão, verificar o resto da lista
    [else (num-par-cor? (rest lista) cor)]))

; Testes
(check-expect (num-par-cor? empty "red") true)
(check-expect (num-par-cor? (cons R1 (cons R2 (cons T1 empty))) "red") true)
(check-expect (num-par-cor? (cons R1 (cons R2 (cons T1 empty))) "blue") false)

;-----------------------------------------------------------------------------------------------------
;	FUNÇÃO remove-formas-cor : ListaDeFormas CorDeForma -> ListaDeFormas
;-----------------------------------------------------------------------------------------------------
;	Dada uma lista de formas e uma cor de forma, remove as formas desta cor.
;
;	Exemplos:
;		(remove-formas-cor (cons R1 (cons R2 (cons E1 (cons E2 empty)))) "red")
;			= (cons R2 (cons E2 empty))
;		(remove-formas-cor (cons R1 (cons R2 (cons E1 (cons E2 empty)))) "blue")
;			= (cons R1 (cons E1 empty))
;-----------------------------------------------------------------------------------------------------
(define (remove-formas-cor lista cor)
  (cond
    ; Se a lista estiver vazia, devolver lista vazia
    [(empty? lista) empty]
    ; Se a primeira forma for da cor procurada, devolver o resto da lista filtrado
    [(string=? (forma-cor (first lista)) cor) (remove-formas-cor (rest lista) cor)]
    ; Senão, devolver a primeira forma concatenada com o resto da lista filtrado
    [else (cons (first lista) (remove-formas-cor (rest lista) cor))]))

; Testes
(check-expect (remove-formas-cor empty "red") empty)
(check-expect (first (remove-formas-cor (cons R1 (cons R2 (cons E1 (cons E2 empty)))) "red")) R2)
(check-expect (first (remove-formas-cor (cons R1 (cons R2 (cons E1 (cons E2 empty)))) "blue")) R1)

;-----------------------------------------------------------------------------------------------------
;	FUNÇÃO num-par-cores? : ListaDeFormas -> Booleano
;-----------------------------------------------------------------------------------------------------
;	Dada uma lista de formas, verifica se, para cada cor presente na lista, há um número par de
;	formas desta cor na lista.
;
;	Exemplos:
;		(num-par-cores? (cons R1 (cons R2 (cons T1 (cons T2 (cons C2 (cons E2 empty))))))) = true
;		(num-par-cores? (cons R1 (cons R2 (cons T1 (cons T2 (cons C2 empty)))))) = false
;-----------------------------------------------------------------------------------------------------
(define (num-par-cores? lista)
  (cond
    ; Se a lista estiver vazia, devolver verdadeiro
    [(empty? lista) true]
    ; Se a lista possuir um número par de formas com a cor da primeira forma, verificar a lista sem
    ; as formas desta cor
    [(num-par-cor? lista (forma-cor (first lista)))
     (num-par-cores? (remove-formas-cor (rest lista) (forma-cor (first lista))))]
    ; Senão, devolver falso
    [else false]))

; Testes
(check-expect (num-par-cores? empty) true)
(check-expect (num-par-cores? (cons R1 (cons R2 (cons T1 (cons T2 (cons C2 (cons E2 empty))))))) true)
(check-expect (num-par-cores? (cons R1 (cons R2 (cons T1 (cons T2 (cons C2 empty)))))) false)

;=====================================================================================================
;   5.
;=====================================================================================================
;
;   Desenvolva a função conta-requisitos que, dado um desenho (lista de formas), devolve o número
;   de requisitos que ele satisfaz (os requisitos são os 3 listados no exercício anterior).
;
;=====================================================================================================

;-----------------------------------------------------------------------------------------------------
;	FUNÇÃO boolean->number : Booleano -> Número
;-----------------------------------------------------------------------------------------------------
;	Dado um valor booleano, devolve 0, caso falso e 1, caso verdadeiro.
;
;	Exemplos:
;		(boolean->number false) = 0
;		(boolean->number true) = 1
;-----------------------------------------------------------------------------------------------------
(define (boolean->number bool)
  (cond
    [(boolean=? bool false) 0]
    [(boolean=? bool true) 1]))

; Testes
(check-expect (boolean->number false) 0)
(check-expect (boolean->number true) 1)

;-----------------------------------------------------------------------------------------------------
;	FUNÇÃO conta-requisitos : ListaDeFormas -> Número
;-----------------------------------------------------------------------------------------------------
;	Dado uma lista de formas, devolve o número de requisitos (4tipos?, num-min-cores? e
;	num-par-cores?) que ela satisfaz.
;
;	Exemplos:
;		(conta-requisitos (cons R1 (cons T1 (cons T1 (cons C1 (cons C1 (cons E1 empty))))))) = 3
;		(conta-requisitos (cons R1 (cons R2 (cons E1 (cons E2 empty))))) = 2
;		(conta-requisitos (cons R1 (cons E1 empty))) = 1
;		(conta-requisitos (cons R1 empty)) = 0
;-----------------------------------------------------------------------------------------------------
(define (conta-requisitos lista)
  (+ (boolean->number (4tipos? lista))
     (boolean->number (num-min-cores? lista))
     (boolean->number (num-par-cores? lista))))

; Testes
(check-expect (conta-requisitos empty) 1)
(check-expect (conta-requisitos (cons R2 (cons T2 (cons C2 (cons E2 empty))))) 3)
(check-expect (conta-requisitos (cons R1 (cons R2 (cons T1 (cons C2 empty))))) 2)
(check-expect (conta-requisitos (cons R1 (cons R2 empty))) 1)
(check-expect (conta-requisitos (cons R1 (cons T1 (cons E1 empty)))) 0)

;=====================================================================================================
;   6.
;=====================================================================================================
;
;   Para avaliar o desenho de cada aluno o professor adotou a seguinte regra:
;       • se o desenho atender os 3 requisitos, o conceito deve ser A;
;       • se o desenho atender apenas 2 requisitos, o conceito deve ser B;
;       • se o desenho atender apenas um requisito, o conceito deve ser C;
;       • se o desenho for vazio, o conceito deve ser E;
;       • caso contrário, o conceito deve ser D.
;
;   Construa a função que realiza esta avaliação, dado o registro de um aluno. A função deve se
;   chamar atribui-conceito-aluno e o resultado deve ser o registro do aluno com o conceito
;   correspondente ao desenho avaliado no campo do conceito do aluno.
;
;=====================================================================================================

;-----------------------------------------------------------------------------------------------------
;	FUNÇÃO atribui-conceito-aluno : Aluno -> Aluno
;-----------------------------------------------------------------------------------------------------
;	Dado o registro de um aluno, conta os requisitos satisfeitos pelo seu desenho e atribui o
;	conceito correspondente no campo de conceito.
;
;	Exemplos:
;		(aluno-conceito (atribui-conceito-aluno ALUNO3)) = (make-aluno _ _ "A")
;		(aluno-conceito (atribui-conceito-aluno ALUNO2)) = (make-aluno _ _ "B")
;-----------------------------------------------------------------------------------------------------
(define (atribui-conceito-aluno aluno)
  (make-aluno (aluno-nome aluno)
              (aluno-desenho aluno)
              (cond
                [(empty? (aluno-desenho aluno)) "E"]
                [else (string (integer->char (- 68 (conta-requisitos (aluno-desenho aluno)))))])))

; Testes
(check-expect (string=? (aluno-conceito (atribui-conceito-aluno ALUNO3)) "A") true)
(check-expect (string=? (aluno-conceito (atribui-conceito-aluno ALUNO2)) "B") true)
(check-expect (string=? (aluno-conceito (atribui-conceito-aluno ALUNO1)) "C") true)
(check-expect (string=? (aluno-conceito (atribui-conceito-aluno ALUNO4)) "D") true)
(check-expect (string=? (aluno-conceito (atribui-conceito-aluno ALUNO5)) "E") true)

;=====================================================================================================
;   7.
;=====================================================================================================
;
;   Defina a função atribui-conceitos que, dada a lista de alunos de uma turma, atribui conceitos a
;   todos os alunos da turma. O resultado deve ser uma lista de alunos.
;
;=====================================================================================================

;-----------------------------------------------------------------------------------------------------
;	FUNÇÃO atribui-conceitos : ListaDeAlunos -> ListaDeAlunos
;-----------------------------------------------------------------------------------------------------
;	Dada uma lista de alunos, atribui conceitos a todos os alunos da lista.
;
;	Exemplos:
;		(atribui-conceitos LISTA-ALUNOS1)
;			= (cons (make-aluno _ _ "C") (cons (make-aluno _ _ "B") ...))
;		(atribui-conceitos LISTA-ALUNOS3)
;			= (cons (make-aluno _ _ "B") (cons (make-aluno _ _ "D") ...))
;-----------------------------------------------------------------------------------------------------
(define (atribui-conceitos lista)
  (cond
    ; Se a lista estiver vazia, devolver lista vazia
    [(empty? lista) empty]
    ; Senão, atribuir conceito ao primeiro aluno da lista, ao resto da lista e concatenar
    [else (cons (atribui-conceito-aluno (first lista)) (atribui-conceitos (rest lista)))]))

; Testes
(check-expect (string=? (aluno-conceito (first (atribui-conceitos LISTA-ALUNOS1))) "C") true)
(check-expect (string=? (aluno-conceito (first (atribui-conceitos LISTA-ALUNOS2))) "C") true)

;=====================================================================================================
;   8.
;=====================================================================================================
;
;   Construa a função mostra-conceitos-turma que, dada uma lista de alunos de uma turma, gera uma
;   imagem mostrado todos os alunos desta turma, incluindo seus nomes, desenhos e conceitos. Você
;   pode escolher a melhor forma de mostrar os dados de cada aluno. A imagem dada é um exemplo,
;   você pode fazer de outra forma.
;
;   (Desafio - bônus de nota) Além de mostrar os dados dos alunos, devem ser mostradas também as
;   estatísticas da turma, contendo as porcentagens de conceitos A, B, C, D e E.
;
;=====================================================================================================

(define GRAY-400 (make-color 148 163 184))
(define GRAY-500 (make-color 100 116 139))
(define GRAY-600 (make-color 71 85 105))
(define GRAY-800 (make-color 30 41 59))

;-----------------------------------------------------------------------------------------------------
;	FUNÇÃO gap : Número Número -> Imagem
;-----------------------------------------------------------------------------------------------------
;	Dado um número para largura e um para altura, desenha um retângulo transparente com as
;	dimensões especificadas para agir como espaçamento.
;
;	Exemplos:
;		(gap 32 32) = <espaçamento bidimensional>
;		(gap 32 0) = <espaçamento horizontal>
;		(gap 0 32) = <espaçamento vertical>
;-----------------------------------------------------------------------------------------------------
(define (gap x y)
  (rectangle x y "solid" "transparent"))

;-----------------------------------------------------------------------------------------------------
;	FUNÇÃO margin : Número Número Imagem -> Imagem
;-----------------------------------------------------------------------------------------------------
;	Dado um número para o eixo horizontal, um para o vertical, e uma imagem, cobre a imagem com
;	espaços transparentes nas bordas, atuando como uma margem.
;
;	Exemplos:
;		(margin 32 32) = <margem total>
;		(margin 32 0) = <margem horizontal>
;		(margin 0 32) = <margem vertical>
;-----------------------------------------------------------------------------------------------------
(define (margin x y image)
  (beside (gap x 0) (above (gap 0 y) image (gap 0 y)) (gap x 0)))

;-----------------------------------------------------------------------------------------------------
;	FUNÇÃO background : Cor Imagem -> Imagem
;-----------------------------------------------------------------------------------------------------
;	Dado uma cor e uma imagem, adiciona um fundo da cor especificada atrás da imagem.
;
;	Exemplo:
;		(background "white" <imagem>) = <imagem com fundo branco>
;-----------------------------------------------------------------------------------------------------
(define (background color image)
  (overlay image (rectangle (image-width image) (image-height image) "solid" color)))

;-----------------------------------------------------------------------------------------------------
;   TIPO FlexDirection = "row" | "col"
;-----------------------------------------------------------------------------------------------------

;-----------------------------------------------------------------------------------------------------
;   TIPO AlignDirection = "left" | "right" | "top" | "bottom" | "middle" | "center"
;-----------------------------------------------------------------------------------------------------

;-----------------------------------------------------------------------------------------------------
;   TIPO ListaDeImagens = empty | (cons Imagem ListaDeImagem)
;-----------------------------------------------------------------------------------------------------

;-----------------------------------------------------------------------------------------------------
;	FUNÇÃO flex : FlexDirection AlignDirection Número ListaDeImagens -> Imagem
;-----------------------------------------------------------------------------------------------------
;	Dado uma direção de disposição, uma direção de alinhamento, um valor de espaçamento e uma lista
;	de imagens, dispõe as imagens na direção especificada, com o alinhamento e espaçamento
;	especificados em uma única imagem.
;
;	Exemplos:
;		(flex "row" "center" 8 <imagens>)
;			= <imagens dispostas horizontalmente, alinhadas no centro, espaçadas em 8px>
;		(flex "col" "left" 16 <imagens>)
;			= <imagens dispostas verticalmente, alinhadas na esquerda, espaçadas em 16px>
;-----------------------------------------------------------------------------------------------------
(define (flex direction align gap-size images)
  (cond
    ; Se a lista estiver vazia, devolver imagem vazia
    [(empty? images) empty-image]
    ; Se a direção for coluna, dispor imagens verticalmente
    [(string=? direction "col")
     (above/align align
                  ; Desenhar primeira imagem da lista
                  (first images)
                  ; Se houver próxima imagem, desenhar espaçamento
                  (cond
                    [(not (empty? (rest images))) (gap 0 gap-size)]
                    [else empty-image])
                  ; Desenhar resto das imagens
                  (flex "col" align gap-size (rest images)))]
    ; Se a direção for linha, dispor imagens horizontalmente
    [(string=? direction "row")
     (beside/align align
                   ; Desenhar primeira imagem da lista
                   (first images)
                   ; Se houver próxima imagem, desenhar espaçamento
                   (cond
                     [(not (empty? (rest images))) (gap gap-size 0)]
                     [else empty-image])
                   ; Desenhar resto das imagens
                   (flex "row" align gap-size (rest images)))]))

;-----------------------------------------------------------------------------------------------------
;	FUNÇÃO cria-lista-imagens-nomes : ListaDeAlunos -> ListaDeImagens
;-----------------------------------------------------------------------------------------------------
;	Dada uma lista de alunos, cria uma lista de imagens com o nome de cada aluno.
;
;	Exemplo:
;		(cria-lista-imagens-nomes LISTA-ALUNOS1) = (cons <imagem> (cons <imagem> ...))
;-----------------------------------------------------------------------------------------------------
(define (cria-lista-imagens-nomes alunos)
  (cond
    ; Se a lista estiver vazia, devolver lista vazia
    [(empty? alunos) empty]
    ; Senão, desenhar primeiro nome e concatenar com o resto dos nomes
    [else
     (cons (overlay (text (aluno-nome (first alunos)) 30 GRAY-800) (gap 0 72))
           (cria-lista-imagens-nomes (rest alunos)))]))

;-----------------------------------------------------------------------------------------------------
;	FUNÇÃO cria-lista-imagens-desenhos : ListaDeAlunos -> ListaDeImagens
;-----------------------------------------------------------------------------------------------------
;	Dada uma lista de alunos, cria uma lista de imagens com o desenho de cada aluno.
;
;	Exemplo:
;		(cria-lista-imagens-desenhos LISTA-ALUNOS1) = (cons <imagem> (cons <imagem> ...))
;-----------------------------------------------------------------------------------------------------
(define (cria-lista-imagens-desenhos alunos)
  (cond
    ; Se a lista estiver vazia, devolver lista vazia
    [(empty? alunos) empty]
    ; Senão, desenhar primeiro desenho e concatenar com o resto dos desenhos
    [else
     (cons (cond
             [(empty? (aluno-desenho (first alunos))) (gap 0 72)]
             [else (desenha-lista-formas (aluno-desenho (first alunos)))])
           (cria-lista-imagens-desenhos (rest alunos)))]))

;-----------------------------------------------------------------------------------------------------
;	FUNÇÃO cria-lista-imagens-conceitos : ListaDeAlunos -> ListaDeImagens
;-----------------------------------------------------------------------------------------------------
;	Dada uma lista de alunos, cria uma lista de imagens com o conceito de cada aluno.
;
;	Exemplo:
;		(cria-lista-imagens-conceitos LISTA-ALUNOS1) = (cons <imagem> (cons <imagem> ...))
;-----------------------------------------------------------------------------------------------------
(define (cria-lista-imagens-conceitos alunos)
  (cond
    ; Se a lista estiver vazia, devolver lista vazia
    [(empty? alunos) empty]
    ; Senão, desenhar primeiro conceito e concatenar com o resto dos conceitos
    [else
     (cons (overlay (text (aluno-conceito (first alunos)) 32 GRAY-600) (gap 0 72))
           (cria-lista-imagens-conceitos (rest alunos)))]))

;-----------------------------------------------------------------------------------------------------
;	TIPO Conceito = "A" | "B" | "C" | "D" | "E"
;-----------------------------------------------------------------------------------------------------

;-----------------------------------------------------------------------------------------------------
;	FUNÇÃO conta-conceito : Conceito ListaDeAlunos -> Número
;-----------------------------------------------------------------------------------------------------
;	Dada uma lista de alunos e um conceito, conta quantos alunos da lista possuem tal conceito.
;
;	Exemplos:
;		(conta-conceito "A" (atribui-conceitos LISTA-ALUNOS4)) = 2
;		(conta-conceito "E" (atribui-conceitos LISTA-ALUNOS3)) = 0
;-----------------------------------------------------------------------------------------------------
(define (conta-conceito conceito alunos)
  (cond
    ; Se a lista estiver vazia, devolver 0
    [(empty? alunos) 0]
    ; Senão, somar 1, caso aluno possua o conceito ou, 0, caso contrário, com o resto da contagem
    [else
     (+ (boolean->number (string=? (aluno-conceito (first alunos)) conceito))
        (conta-conceito conceito (rest alunos)))]))

; Testes
(check-expect (conta-conceito "A" (atribui-conceitos LISTA-ALUNOS4)) 2)
(check-expect (conta-conceito "E" (atribui-conceitos LISTA-ALUNOS3)) 0)

;-----------------------------------------------------------------------------------------------------
;	FUNÇÃO calcula-porcentagem-conceito : Conceito ListaDeAlunos -> Número
;-----------------------------------------------------------------------------------------------------
;	Dada uma lista de alunos e um conceito, calcula a porcentagem (0-100) de alunos da lista que
;	possuem tal conceito.
;
;	Exemplos:
;		(calcula-porcentagem-conceito "A" (atribui-conceitos LISTA-ALUNOS4)) = 20
;		(calcula-porcentagem-conceito "A" (atribui-conceitos LISTA-ALUNOS3)) = 25
;-----------------------------------------------------------------------------------------------------
(define (calcula-porcentagem-conceito conceito alunos)
  (* (/ (conta-conceito conceito alunos) (length alunos)) 100))

; Testes
(check-expect (calcula-porcentagem-conceito "A" (atribui-conceitos LISTA-ALUNOS4)) 20)
(check-expect (calcula-porcentagem-conceito "A" (atribui-conceitos LISTA-ALUNOS3)) 25)

;-----------------------------------------------------------------------------------------------------
;	FUNÇÃO desenha-coluna-tabela : String ListaDeImagens -> Imagem
;-----------------------------------------------------------------------------------------------------
;	Dado um nome e uma lista de imagens, desenha o nome seguido das imagens formatados como uma
;	coluna de tabela.
;
;	Exemplos:
;		(desenha-coluna-tabela "NOME" (cons <imagem> (cons <imagem> ...)))
;		(desenha-coluna-tabela "DESENHO" (cons <imagem> (cons <imagem> ...)))
;		(desenha-coluna-tabela "CONCEITO" (cons <imagem> (cons <imagem> ...)))
;-----------------------------------------------------------------------------------------------------
(define (desenha-coluna-tabela nome imagens)
  (above/align "left" (text nome 16 GRAY-400) (gap 0 36) (flex "col" "left" 44 imagens)))

;-----------------------------------------------------------------------------------------------------
;	FUNÇÃO desenha-estatistica : Conceito Número -> Imagem
;-----------------------------------------------------------------------------------------------------
;	Dado um conceito e uma porcentagem (0-100), desenha uma barra de tamanho dependente da
;	porcentagem, assim como o respectivo conceito e a porcentagem formatada.
;
;	Exemplos:
;		(desenha-estatistica "A" 20)
;		(desenha-estatistica "E" 0)
;-----------------------------------------------------------------------------------------------------
(define (desenha-estatistica conceito porcentagem)
  (beside (overlay/align "left" "middle" (text conceito 24 GRAY-500) (gap 22 0))
          (gap 28 0)
          (rectangle (* porcentagem 6) 32 "solid" GRAY-500)
          (gap 12 0)
          (text (string-append (number->string porcentagem) "%") 16 GRAY-400)))

;-----------------------------------------------------------------------------------------------------
;	FUNÇÃO desenha-tabela-alunos : ListaDeAlunos -> Imagem
;-----------------------------------------------------------------------------------------------------
;	Dada uma lista de alunos, desenha uma tabela contendo o nome de cada aluno, seu desenho, e seu
;	conceito.
;
;	Exemplo:
;		(desenha-tabela-alunos (atribui-conceitos LISTA-ALUNOS1))
;-----------------------------------------------------------------------------------------------------
(define (desenha-tabela-alunos alunos)
  (flex "row"
        "top"
        80
        (cons (desenha-coluna-tabela "NOME" (cria-lista-imagens-nomes alunos))
              (cons (desenha-coluna-tabela "DESENHO" (cria-lista-imagens-desenhos alunos))
                    (cons (desenha-coluna-tabela "CONCEITO" (cria-lista-imagens-conceitos alunos))
                          empty)))))

;-----------------------------------------------------------------------------------------------------
;	FUNÇÃO desenha-estatisticas-turma : ListaDeAlunos -> Imagem
;-----------------------------------------------------------------------------------------------------
;	Dada uma lista de alunos de uma turma, desenha um gráfico de barras verticais representando a
;	porcentagem de alunos que obtiveram cada conceito.
;
;	Exemplo:
;		(desenha-estatisticas-turma (atribui-conceitos LISTA-ALUNOS1))
;-----------------------------------------------------------------------------------------------------
(define (desenha-estatisticas-turma alunos)
  (above/align
   "left"
   (text "DISTRIBUIÇÃO DE CONCEITOS" 16 GRAY-400)
   (gap 0 36)
   (flex "col"
         "left"
         28
         (cons (desenha-estatistica "A" (calcula-porcentagem-conceito "A" alunos))
               (cons (desenha-estatistica "B" (calcula-porcentagem-conceito "B" alunos))
                     (cons (desenha-estatistica "C" (calcula-porcentagem-conceito "C" alunos))
                           (cons (desenha-estatistica "D" (calcula-porcentagem-conceito "D" alunos))
                                 (cons (desenha-estatistica "E"
                                                            (calcula-porcentagem-conceito "E" alunos))
                                       empty))))))))

;-----------------------------------------------------------------------------------------------------
;	FUNÇÃO mostra-conceitos-turma : ListaDeAlunos -> Imagem
;-----------------------------------------------------------------------------------------------------
;	Dada uma lista de alunos de uma turma, desenha a tabela contendo seus nomes, desenhos e
;	conceitos, e o gráfico mostrando as estatísticas da turma.
;
;	Exemplo:
;		(mostra-conceitos-turma (atribui-conceitos LISTA-ALUNOS1))
;-----------------------------------------------------------------------------------------------------
(define (mostra-conceitos-turma alunos)
  (background "white"
              (margin 128
                      128
                      (above/align "left"
                                   (desenha-tabela-alunos alunos)
                                   (gap 0 128)
                                   (desenha-estatisticas-turma alunos)))))

; Testes
(check-expect (image? (mostra-conceitos-turma (atribui-conceitos LISTA-ALUNOS1))) true)
(check-expect (image? (mostra-conceitos-turma (atribui-conceitos LISTA-ALUNOS2))) true)
(check-expect (image? (mostra-conceitos-turma (atribui-conceitos LISTA-ALUNOS3))) true)
(check-expect (image? (mostra-conceitos-turma (atribui-conceitos LISTA-ALUNOS4))) true)
