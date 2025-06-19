#lang racket

(require 2htdp/image)
(require rackunit)

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

;; Funções úteis do pacote de imagens (para maiores informações e exemplos, consultar o manual):

;; rotate: Número Imagem -> Imagem
;; Dado um ângulo (em graus) e uma imagem, gera uma nova imagem rotacionando a imagem original
;; no ângulo dado.

;; line: Número Número StringOuPen -> Imagem
;; Dados as as coordenadas x e y de um ponto e uma cor, desenha uma reta desta cor
;; ligando este ponto ao ponto (0,0). O terceiro argumento pode ser também uma caneta (estrutura pen), neste caso se
;; pode fazer linhas diferentes (ver decrição de pen a seguir).

;; Um elemento da estrutura pen é composto por 5 campos: cor (String), largura da linha da caneta (Numero),
;; estilo (String, pode ser "solid", "dash", "dot", ...), o estilo do início/fim da linha ("round", "butt" ou "projecting") e
;; o estilo para unir linhas ("round", "bevel", "miter").

;; image-width: Imagem -> Número
;; Dada uma imagem, devolve a sua largura (em número de pixels)

;; overlay/align/offset: String String Imagem Número Imagem -> Imagem
;; Dados os tipos de alinhameno das imagens na horizontal ("right", "left" ou "center") e na vertical ("bottom", "top" ou "center"),
;; a primeira imagem, o valor do descolamento e a segunda imagem, sobrepõe as imagens considerando os alinhamnentos e descolcamento dados.

;; ========================================================================================
;;                              DEFINIÇÕES DE DADOS
;; ========================================================================================

;; Definição de constantes:

(define LARGURA 400) ;; largura da cena
(define ALTURA 400) ;; altura da cena
(define CENA-VAZIA (empty-scene 400 400))

;; Definição de tipos de dados:
;; ------------
;; TIPO FIGURA:
;; ------------
(define-struct figura (coord-x coord-y altura cor))
;; Um elemento do conjunto Figura é
;;     (make-figura x y a c), onde
;;   x: Número, é a coordenada x do centro da figura
;;   y: Número, é a coordenada y do centro da figura
;;   a : Número, é a altura da figura
;;   c : Número, número que representa a cor da figura, de acordo com a função gera-cor

;; =====================
;; DEFINIÇÕES DE FUNÇÕES
;; =====================

;; ========================
;; FUNÇÃO GERA-COR:
;; ========================
;; gera-cor : Número -> String
;; Dado um número positivo, devolve uma de 5 cores: "red", "blue", "green", "yellow" ou "cyan".
;; Exemplos:
;;      (gera-cor 3) = "yellow"
;;      (gera-cor 55) = "red"
(define (gera-cor n)
  (cond
    [(= (remainder n 5) 0) "red"]
    [(= (remainder n 5) 1) "blue"]
    [(= (remainder n 5) 2) "green"]
    [(= (remainder n 5) 3) "yellow"]
    [(= (remainder n 5) 4) "cyan"]))

;; ========================
;; FUNÇÃO DESENHA-TRIANGULO:
;; ========================
;; desenha-triangulo : Número String ->  Imagem
;; Obj.: Dados um tamanho de lado e uma cor, desenha um triângulo.
;; Exemplos:
;;     (desenha-triangulo 20 "red") = .
;;     (desenha-triangulo 50 "darkgreen") = .
(define (desenha-triangulo lado cor)
  (triangle lado "outline" cor))

;; ========================
;; FUNÇÃO DESENHA-QUADRADO:
;; ========================
;; desenha-quadrado : Número String ->  Imagem
;; Obj.: Dados um tamanho de lado e uma cor, desenha um quadrado.
;; Exemplos:
;;     (desenha-quadrado 20 "red") = .
;;     (desenha-quadrado 50 "darkgreen") = .
(define (desenha-quadrado lado cor)
  (square lado "outline" cor))

;; ========================
;; FUNÇÃO SIERPISNKI:
;; ========================

;; sierpinski: Número String -> Imagem
;; Obj: Dados o tamanho do lado e uma cor, desenha um triângulo de Sierpinski
;; desta cor cujo lado do triângulo externo é o lado passado como argumento.
;; Exemplos:
;;        (sierpinski 50 "red") = .
(define (sierpinski lado cor) ;; Dados um lado e uma cor
  (cond
    ;; se o lado for muito pequeno, desenhar um triângulo com o lado dado
    [(<= lado 5) (desenha-triangulo lado cor)]
    ;; senão
    ;;      desenha um triângulo de sierpinksi com a metade do tamanho do lado
    ;;      e dá o nome de TRIANGULO para este desenho:
    [else
     (local ((define TRIANGULO (sierpinski (/ lado 2) cor)))
            ;; e monta a imagem do triângulo de sierpinski colocando um TRIANGULO
            ;; acima de dois outros TRIANGULOs:
            (above TRIANGULO (beside TRIANGULO TRIANGULO)))]))

;; Argumentação de terminação:
;; Este programa sempre termina porque:
;; (a) Existe um caso base (sem recursão) que é quando o tamanho do lado é menor ou igual a 5.
;;     Neste caso, o programa simplesmente desenha um triângulo com este lado.
;; (b) Cada chamada recursiva é realizada tendo como argumento a metade do lado,
;;     que é um número estritamente menor que o lado, e portanto mais próximo
;;     de se tornar menor que 5 (lembrando que a chamada recursiva só ocorre se o lado for >=5).
;; (c) As funções <=, above, beside e cond terminam, pois são pré-definidas da linguagem.
;;     A função desenha-triangulo termina, pois somente usa funções pré-definidas e não tem laços.

;; Não modifique nada até este ponto!!!
;; A partir daqui estão os exercícios a serem resolvidos.

;=====================================================================================================
;	QUESTÃO 1
;=====================================================================================================

;-----------------------------------------------------------------------------------------------------
;	sierpinski-sem-local : Número String -> Imagem
;-----------------------------------------------------------------------------------------------------
;	Dados o tamanho do lado e uma cor, desenha um triângulo de Sierpinski desta cor cujo lado do
;	triângulo externo é o lado passado como argumento.
;
;	Exemplos:
;		(sierpinski-sem-local 50 "red") = .
;-----------------------------------------------------------------------------------------------------
(define (sierpinski-sem-local lado cor)
  (cond
    ; se o lado for muito pequeno, desenhar um triângulo com o lado dado
    [(<= lado 5) (desenha-triangulo lado cor)]
    ; senão
    [else
     ; desenha um triângulo de sierpinksi com a metade do tamanho do lado
     (above (sierpinski-sem-local (/ lado 2) cor)
            ; acima de dois outros triângulos de sierpinksi com a metade do tamanho do lado
            (beside (sierpinski-sem-local (/ lado 2) cor) (sierpinski-sem-local (/ lado 2) cor)))]))

; Testes
(check-equal? (image? (sierpinski-sem-local 50 "red")) #t)

;=====================================================================================================
;	QUESTÃO 2
;=====================================================================================================

;-----------------------------------------------------------------------------------------------------
;	tapete-sierpinski : Número String -> Imagem
;-----------------------------------------------------------------------------------------------------
;	Dados o tamanho do lado e uma cor, desenha um tapete de Sierpinski desta cor cujo lado do
;	quadrado externo é o lado passado como argumento.
;
;	Exemplos:
;		(tapete-sierpinski 50 "red") = .
;-----------------------------------------------------------------------------------------------------
(define (tapete-sierpinski lado cor)
  (cond
    ; se o lado for muito pequeno, desenhar um quadrado com o lado dado
    [(<= lado 5) (square lado "solid" cor)]
    ; senão
    [else
     ; definir nomes locais:
     (local
      ; seja NOVO-LADO o lado dos novos tapetes que serão
      ; desenhados, definido por um terço do lado dado:
      ; seja T um tapete de sierpinski com o lado NOVO-LADO:
      ; seja TB um quadrado com o lado NOVO-LADO todo branco:
      ((define NOVO-LADO (/ lado 3)) (define T (tapete-sierpinski NOVO-LADO cor))
                                     (define TB (desenha-quadrado NOVO-LADO "white")))
      ; montar uma imagem com as seguinte linhas, uma acima da outra: três tapetes de sierpinski com
      ; NOVO-LADO, um ao lado do outro
      (above (beside T T T)
             ; um quadrado branco com NOVO-LADO no meio de dois tapetes de sierpinski com NOVO-LADO
             (beside T TB T)
             ; três tapetes de sierpinski com NOVO-LADO, um ao lado do outro
             (beside T T T)))]))

; Argumentação de terminação:
; Este programa sempre termina porque:
; (a) Existe um caso base (sem recursão) que é quando o tamanho do lado é menor ou igual a 5. Neste
;	  caso, o programa simplesmente desenha um quadrado com este lado.
; (b) Cada chamada recursiva é realizada tendo como argumento um terço do lado, que é um número
;	  estritamente menor que o lado, e portanto mais próximo de se tornar menor que 5 (lembrando
;	  que a chamada recursiva só ocorre se o lado for >=5).
; (c) As funções <=, above, beside e cond terminam, pois são pré-definidas da linguagem. A função
;	  desenha-quadrado termina, pois somente usa funções pré-definidas e não tem laços.

; Testes
(check-equal? (image? (tapete-sierpinski 50 "red")) #t)

;=====================================================================================================
;	QUESTÃO 3
;=====================================================================================================

;-----------------------------------------------------------------------------------------------------
;	árvore : Número String -> Imagem
;-----------------------------------------------------------------------------------------------------
;	Dados uma altura e uma cor, desenha uma árvore da altura fornecida cujas folhas são da cor
;	passada como argumento.
;
;	Exemplos:
;		(árvore 500 "pink") = .
;-----------------------------------------------------------------------------------------------------
(define (árvore altura cor)
  (local
   ; seja TRONCO uma linha marrom da altura dada:
   ((define TRONCO (line 0 altura (make-pen "brown" (/ altura 10) "solid" "round" "bevel"))))
   (cond
     ; se a altura for muito pequena:
     [(<= altura 50)
      ; desenhar o TRONCO com um círculo da cor dada na ponta
      (overlay/align/offset "center" "top" (circle (/ altura 4) "solid" cor) 0 (/ altura 8) TRONCO)]
     ; senão:
     [else
      ; seja ARVORE-MENOR uma árvore com metade da altura dada:
      (local ((define ARVORE-MENOR (árvore (/ altura 2) cor)))
             ; desenhar lado a lado, alinhado ao topo: uma ARVORE-MENOR rotacionada 45°, um TRONCO e
             ; uma ARVORE-MENOR rotacionada -45°
             (beside/align "top" (rotate 45 ARVORE-MENOR) TRONCO (rotate -45 ARVORE-MENOR)))])))

; Chamadas da função árvore (pelo menos 3, colocadas lado a lado):
(beside/align "bottom" (árvore 1200 "green") (árvore 800 "pink") (árvore 400 "red"))

; Testes
(check-equal? (image? (árvore 500 "pink")) #t)

;; ==============================================================
;; 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4 4
;; ==============================================================

;; desenha-tapete-sierpinski: Figura -> Imagem
;; Obj: Dada uma Figura, desenhar um tapete de Sierpinski com base nos dados da figura.
(define (desenha-tapete-sierpinski fig)
  (tapete-sierpinski (figura-altura fig) (gera-cor (figura-cor fig))))

;; desenha-sierpinski: Figura -> Imagem
;; Obj: Dada uma Figura, desenhar um triângulo de Sierpinski com base dos dados da figura.
(define (desenha-sierpinski fig)
  (sierpinski (/ (* 2 (figura-altura fig) (sqrt 3)) 3) (gera-cor (figura-cor fig))))

;; desenha-árvore: Figura -> Imagem
;; Obj: Dada uma Figura, desenhar uma árvore com base nos dados da figura.
(define (desenha-árvore fig)
  (árvore (figura-altura fig) (gera-cor (figura-cor fig))))

;; Constantes para testes:
(define FIG1 (make-figura 5 5 100 5))
(define FIG2 (make-figura 0 0 250 1))
(define FIG3 (make-figura 10 10 50 2))
(define FIG4 (make-figura 15 15 90 4))
(define FIG5 (make-figura 0 0 100 3))
(define FIG6 (make-figura 70 70 10 1))
(define FIG7 (make-figura -5 -5 25 2))
(define FIG8 (make-figura 450 50 10 7))

;; Chamadas da função desenha-tapete-sierpinski (pele menos 3, colocadas lado a lado):
(desenha-tapete-sierpinski FIG1)
(desenha-tapete-sierpinski FIG2)
(desenha-tapete-sierpinski FIG3)

;; Chamadas da função desenha-sierpinski (pele menos 3, colocadas lado a lado):
(desenha-sierpinski FIG4)
(desenha-sierpinski FIG1)
(desenha-sierpinski FIG5)

;; Chamadas da função desenha-árvore (pele menos 3, colocadas lado a lado):
(desenha-árvore FIG3)
(desenha-árvore FIG4)
(desenha-árvore FIG2)

;; ==============================================================
;; 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5
;; ==============================================================

;; AUXILIAR: verifica-tam: Figura -> Booleano
;; Obj: Dada uma figura, verificar se sua altura é maior ou igual a 250
;; Exemplos e testes:
; (check-expect (verifica-tam FIG1) #f)
; (check-expect (verifica-tam FIG2) #t)

(define (verifica-tam fig)
  (>= (figura-altura fig) 250))

;; AUXILIAR: aumenta-tam: Figura -> Figura
;; Obj: Dada uma figura, aumentar seu tamanho por 1.5
;; Exemplos e testes:
; (check-expect (aumenta-tam FIG1) (make-figura 5 5 150 5))
; (check-expect (aumenta-tam FIG8) (make-figura 450 50 15 7))

(define (aumenta-tam fig)
  (make-figura (figura-coord-x fig)
               (figura-coord-y fig)
               (* 1.5 (figura-altura fig))
               (figura-cor fig)))

;; desenha-figuras: (Figura --> Image) Figura --> Cena
;; Obj: Dada uma função que gera a imagem de uma figura e uma figura, gerar uma cena
;; com várias imagens desta figura até certo critério ser atendido.

(define (desenha-figuras fun f)
  ;; Dadas uma função e uma Figura, verificar:
  (cond
    ;; se a figura dada tiver altura maior ou igual a 250, desenhar a cena vazia.
    [(verifica-tam f) CENA-VAZIA]
    ;; caso contrário, desenhar:
    [else
     ;; uma cena com a figura original, e
     (place-image (fun (figura-altura f) (gera-cor (figura-cor f)))
                  (figura-coord-x f)
                  (figura-coord-y f)
                  ;; as demais figuras, modificando sua altura de maneira recursiva
                  (desenha-figuras fun (aumenta-tam f)))]))

;;; OBS: Modificamos a função do modelo do template

;; Terminação: Assumindo que a função fun (argumento da função) termina,
;;  este programa termina porque:
;; (a) Existe o caso base não-recursivo, que é de parada quando a altura da forma é menor ou igual a 250.
;; (b) A função auxiliar usada aumenta-tam garante que, a cada chamada recursiva, a figura passada estará mais
;;     próxima do caso base.
;; (c) Todas as outras funções utilizadas são pré-definidas ou utilizam funções auxiliares formadas por outras
;;     funções pré-definidas. Portanto, todas estas encerram.

;;===============================================================
;; 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5 5
;;===============================================================

;; (a) Critérios de terminação: funções do tipo Figura -> Booleano

;; cor-quente: Figura -> Booleano
;; Obj: Dada uma figura, verificar se sua cor é quente. Caso seja, devolver true, caso contrário, devolver false.
;; Exemplos e testes:
; (check-expect (cor-quente FIG1) #true)
; (check-expect (cor-quente FIG2) #false)

(define (cor-quente f)
  (not (or (string=? (gera-cor (figura-cor f)) "cyan") (string=? (gera-cor (figura-cor f)) "blue"))))

;; ======

;; cor-vermelha: Figura -> Booleano
;; Obj: Dada uma figura, verificar se sua cor é vermelha. Caso seja, devolver true, caso contrário, devolver false.
;; Exemplos e testes:
; (check-expect (cor-vermelha FIG1) #true)
; (check-expect (cor-vermelha FIG2) #false)

(define (cor-vermelha f)
  (string=? (gera-cor (figura-cor f)) "red"))

;; ======

;; fora-da-cena: Figura -> Booleano
;; Obj: Dada uma figura, verificar se suas coordenadas estão fora da cena (CENA-VAZIA). Caso estejam,
;;      devolver true, caso contrário, devolver false.
;; Exemplos e testes:
; (check-expect (fora-da-cena FIG2) #false)
; (check-expect (fora-da-cena FIG7) #true)

(define (fora-da-cena f)
  (or (or (> (figura-coord-x f) LARGURA) (> (figura-coord-y f) ALTURA))
      (or (negative? (figura-coord-x f)) (negative? (figura-coord-y f)))))

;; ======

;; verifica-tam: função já definida na linha 286
;; verifica-tam: Figura -> Booleano
;; Obj: Dada uma figura, verificar se sua altura é maior ou igual a 250

;; ======

;; (b) Funções de modificação de figuras, tipo Figura -> Figura

;; muda-cor: Figura -> Figura
;; Obj: Dada uma figura, modificar sua cor por 1.
;; Exemplos e testes:

(define (muda-cor f)
  ;; figura original:
  (make-figura (figura-coord-x f)
               (figura-coord-y f)
               (figura-altura f)
               ;; somar 1 ao valor da cor da figura
               (+ 1 (figura-cor f))))

;; ======

;; muda-coord-x: Figura -> Figura
;; Obj: Dada uma figura, modificar sua coordenada em X entre 0 e 450.
;; Exemplos e testes:

(define (muda-coord-x f)
  ;; gerar um número aleatório para a coordenada em X
  (make-figura (random 450) (figura-coord-y f) (figura-altura f) (figura-cor f)))

;; ======

;; muda-coord-y: Figura -> Figura
;; Obj: Dada uma figura, modificar sua coordenada em Y entre 0 e 450.

(define (muda-coord-y f)
  (make-figura (figura-coord-x f)
               ;; gerar um número aleatório para a coordenada em Y
               (random 450)
               (figura-altura f)
               (figura-cor f)))

;; ======

;; muda-coord-geral: Figura -> Figura
;; Obj: Dada uma figura, modificar suas coordenadas em X e Y entre 0 e 450.

(define (muda-coord-geral f)
  ;; gerar número aleatório para a coordenada em X
  (make-figura (random 450)
               ;; gerar número aleatório para a coordenada em Y
               (random 450)
               (figura-altura f)
               (figura-cor f)))

;; ======

;; aumenta-tam: função já definida na linha 293
;; aumenta-tam: Figura -> Figura
;; Obj: Dada uma figura, aumentar seu tamanho por 1.5

;; ======

;; (c) Função desenha-figuras-gen
;; desenha-figuras-gen: (Figura -> Imagem) Figura (Figura -> Booleano) (Figura -> Figura) --> Cena

(define (desenha-figuras-gen des fig test alt)
  ;; Dadas uma função de desenho, uma Figura, uma função de teste, e uma função que altera a Figura original, verificar:
  (cond
    ;; se a função de teste der true, encerrar o desenho.
    [(test fig) CENA-VAZIA]
    ;; caso contrário, desenhar:
    [else
     ;; uma cena com a figura original, e
     (place-image (des (figura-altura fig) (gera-cor (figura-cor fig)))
                  (figura-coord-x fig)
                  (figura-coord-y fig)
                  ;; as demais figuras, modificando o critério com a função dada
                  (desenha-figuras-gen des (alt fig) test alt))]))

(desenha-figuras-gen sierpinski FIG1 fora-da-cena muda-coord-geral)
(desenha-figuras-gen desenha-triangulo FIG5 cor-vermelha muda-cor)
(desenha-figuras-gen árvore FIG4 verifica-tam aumenta-tam)
(desenha-figuras-gen tapete-sierpinski FIG3 fora-da-cena muda-coord-x)

;; (d) Argumentação sobre a terminação das chamadas:

;; Terminação:
;;  (a) Todos as funções utilizadas para testes são terminadas quando um critério é atingido. Além disso, todas elas utilizam
;;      apenas outras funções pré-definidas da linguagem, que são finitas.
;;  (b) Cada chamada recursiva da função que modifica a figura deixa o(s) argumento(s) da Figura original mais próximo(s) do
;;      critério de parada da função de teste, com exceção das funções que mudam as coordenadas. Neste caso, deve-se levar em
;;      consideração que a função random está para entre 0 e 450, sendo que de 401 até 450 o critério de terminação é atingido.
;;      Enquanto existe a possibilidade de looping para esta função, é pouco provável. Além disso, todas as funções utilizam
;;      apenas outras funções pré-definidas da linguagem, que são finitas.
;;  (c) Como desenha-figuras-gen funciona de maneira recursiva usando uma função de teste e outra que aproxima a Figura ao caso
;;      base do teste, a função em questão sempre irá acabar.
