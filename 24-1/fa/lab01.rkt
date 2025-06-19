#lang racket

(require 2htdp/image)
(require rackunit)

; ===================================================================================================
;  CONSTANTES
; ===================================================================================================

; Desenhos
(define PACMAN (rotate 30 (wedge 30 300 "solid" "gold")))
(define MESA (circle 300 "solid" "brown"))
(define PLAYER (above (circle 30 "solid" "salmon") (ellipse 30 60 "solid" "blue")))

; Fundos
(define CARTA-FUNDO-PADRAO (rectangle 100 150 "solid" "slategray"))
(define CARTA-FUNDO-VIDA (rectangle 100 150 "solid" "lightgreen"))
(define CARTA-FUNDO-ATAQUE (rectangle 100 150 "solid" "lightred"))
(define CARTA-FUNDO-DEFESA (rectangle 100 150 "solid" "lightblue"))
(define CARTA-FUNDO-TRUNFO (rectangle 100 150 "solid" "orchid"))

; Bordas
(define CARTA-BORDA (rectangle 110 160 "outline" "white"))
(define CARTA-ATRIBUTOS-BORDA (rectangle 85 68 "outline" "black"))

; Strings
(define VIDA "vida")
(define ATAQUE "ataque")
(define DEFESA "defesa")
(define TRUNFO "trunfo")

; ===================================================================================================
;	FUNÇÕES
; ===================================================================================================

;-----------------------------------------------------------------------------------------------------
;   cria-carta : Imagem Imagem Número Número Número -> Imagem
;-----------------------------------------------------------------------------------------------------
;
;   Dado o desenho da carta, o fundo escolhido referente ao maior atributo e os valores de cada um
;   dos três atributos da carta, devolve uma Imagemm com a carta montada.
;
;   Exemplos:
; 		(cria-carta PACMAN CARTA-FUNDO-VIDA 40 20 20)
;
;-----------------------------------------------------------------------------------------------------

(define (cria-carta-texto string)
  (text string 18 "red"))

(define (cria-carta-atributos hp atk def)
  (overlay/offset (above (cria-carta-texto "HP") (cria-carta-texto "ATK") (cria-carta-texto "DEF"))
                  45
                  0
                  (above (cria-carta-texto (number->string hp))
                         (cria-carta-texto (number->string atk))
                         (cria-carta-texto (number->string def)))))

(define (cria-carta sprite fundo hp atk def)
  (overlay
   (overlay/offset sprite
                   0
                   70
                   (overlay/offset (cria-carta-atributos hp atk def) 0 -2 CARTA-ATRIBUTOS-BORDA))
   (overlay fundo CARTA-BORDA)))

; Testes
(check-true (image? (cria-carta PACMAN CARTA-FUNDO-PADRAO 91 88 6)))
(check-true (image? (cria-carta PACMAN CARTA-FUNDO-VIDA 95 66 9)))
(check-true (image? (cria-carta PACMAN CARTA-FUNDO-ATAQUE 84 56 46)))
(check-true (image? (cria-carta PACMAN CARTA-FUNDO-DEFESA 22 19 39)))
(check-true (image? (cria-carta PACMAN CARTA-FUNDO-TRUNFO 97 72 44)))

;-----------------------------------------------------------------------------------------------------
;   maior-atributo-fundo : String -> Imagem
;-----------------------------------------------------------------------------------------------------
;
;   Dado uma string, que pode ser qualquer um dos três atributos (VIDA, ATAQUE ou DEFESA) ou o tipo
;   trunfo, devolve o fundo que deve ser colocado na carta referente ao atributo escolhido. Caso a
;   carta não possua o melhor valor em nenhum dos atributos devolve o fundo padrão.
;
;   Exemplos:
;       (maior-atributo-fundo VIDA)
;       (maior-atributo-fundo "x")
;
;-----------------------------------------------------------------------------------------------------

(define (maior-atributo-fundo atributo)
  (cond
    [(string=? atributo VIDA) CARTA-FUNDO-VIDA]
    [(string=? atributo ATAQUE) CARTA-FUNDO-ATAQUE]
    [(string=? atributo DEFESA) CARTA-FUNDO-DEFESA]
    [(string=? atributo TRUNFO) CARTA-FUNDO-TRUNFO]
    [else CARTA-FUNDO-PADRAO]))

; Testes
(check-true (image? (maior-atributo-fundo VIDA)))
(check-true (image? (maior-atributo-fundo ATAQUE)))
(check-true (image? (maior-atributo-fundo DEFESA)))
(check-true (image? (maior-atributo-fundo TRUNFO)))
(check-true (image? (maior-atributo-fundo "x")))

;-----------------------------------------------------------------------------------------------------
;   verifica-maior : string Número Número Número Número Número Número -> string
;-----------------------------------------------------------------------------------------------------
;
;   Dado o atributo que será verificado nesta rododa e os valores da carta de cada um dos
;   jogadores, devolve qual o jogador que ganhou. Se ambos os valores do atributo escolhido forem
;   iguais, devolver empate.
;
;   Exemplos:
; 		(verifica-maior VIDA 30 20 10 10 20 30) = "JOGADOR 1 GANHOU"
; 		(verifica-maior ATAQUE 30 20 10 10 20 30) = "EMPATE"
; 		(verifica-maior DEFESA 30 20 10 10 20 30) = "JOGADOR 2 GANHOU"
; 		(verifica-maior VIDA 30 20 10 30 20 30) = "EMPATE"
;
;-----------------------------------------------------------------------------------------------------

(define (verifica-maior-string p1-valor p2-valor)
  (cond
    [(> p1-valor p2-valor) "JOGADOR 1 GANHOU"]
    [(< p1-valor p2-valor) "JOGADOR 2 GANHOU"]
    [else "EMPATE"]))

(define (verifica-maior atributo p1-hp p1-atk p1-def p2-hp p2-atk p2-def)
  (cond
    [(string=? atributo VIDA) (verifica-maior-string p1-hp p2-hp)]
    [(string=? atributo ATAQUE) (verifica-maior-string p1-atk p2-atk)]
    [(string=? atributo DEFESA) (verifica-maior-string p1-def p2-def)]))

; Testes
(check-equal? (verifica-maior VIDA 30 20 10 10 20 30) "JOGADOR 1 GANHOU")
(check-equal? (verifica-maior ATAQUE 30 20 10 10 20 30) "EMPATE")
(check-equal? (verifica-maior DEFESA 30 20 10 10 20 30) "JOGADOR 2 GANHOU")
(check-equal? (verifica-maior VIDA 30 20 10 30 20 30) "EMPATE")

;-----------------------------------------------------------------------------------------------------
; verifica-trunfo : boolean boolean -> Número
;-----------------------------------------------------------------------------------------------------
;
; Dados as condições se as cartas dos jogadores são trunfos ou não, verifica quem foi o vencedor
; correspondente. Caso ambos ou nenhum dos jogadores possuir o trunfo, o resultado é empate. Obs:
; Atribua valor '1' se o primeiro jogador venceu, valor '2' se o segundo jogador venceu e qualquer
; outro valor em caso de empate.
;
; Exemplos:
; 		(verifica-trunfo #t #f) = 1
; 		(verifica-trunfo #f #t) = 2
; 		(verifica-trunfo #t #t) = 0
; 		(verifica-trunfo #f #f) = 0
;
;-----------------------------------------------------------------------------------------------------

(define (verifica-trunfo p1-trunfo p2-trunfo)
  (cond
    [(and p1-trunfo (not p2-trunfo)) 1]
    [(and p2-trunfo (not p1-trunfo)) 2]
    [else 0]))

; Testes
(check-equal? (verifica-trunfo #t #f) 1)
(check-equal? (verifica-trunfo #f #t) 2)
(check-equal? (verifica-trunfo #t #t) 0)
(check-equal? (verifica-trunfo #f #f) 0)

;-----------------------------------------------------------------------------------------------------
;   verifica-rodada : string Número Número Número boolean Número Número Número boolean -> string
;-----------------------------------------------------------------------------------------------------
;
;   Dado o atributo da rodada, bem como os atributos das cartas de cada jogador, e se elas são do
;   tipo trunfo ou não, devolve qual dos jogadores venceu esta rodada ou se houve empate.
;
;    Exemplos:
; 		(verifica-rodada VIDA 30 20 10 #f 20 10 30 #t) = "JOGADOR 2 GANHOU"
; 		(verifica-rodada VIDA 30 20 10 #f 20 10 30 #f) = "JOGADOR 1 GANHOU"
; 		(verifica-rodada ATAQUE 30 10 10 #f 20 10 30 #f) = "EMPATE"
;
;-----------------------------------------------------------------------------------------------------

(define (verifica-rodada atributo p1-hp p1-atk p1-def p1-trunfo p2-hp p2-atk p2-def p2-trunfo)
  (cond
    [(eq? (verifica-trunfo p1-trunfo p2-trunfo) 1) "JOGADOR 1 GANHOU"]
    [(eq? (verifica-trunfo p1-trunfo p2-trunfo) 2) "JOGADOR 2 GANHOU"]
    [else (verifica-maior atributo p1-hp p1-atk p1-def p2-hp p2-atk p2-def)]))

; Testes
(check-equal? (verifica-rodada VIDA 30 20 10 #f 20 10 30 #t) "JOGADOR 2 GANHOU")
(check-equal? (verifica-rodada VIDA 30 20 10 #f 20 10 30 #f) "JOGADOR 1 GANHOU")
(check-equal? (verifica-rodada ATAQUE 30 10 10 #f 20 10 30 #f) "EMPATE")

;-----------------------------------------------------------------------------------------------------
;   desenha-mao : Imagem Imagem Imagem Imagem -> Imagem
;-----------------------------------------------------------------------------------------------------
;
;   Dados as cartas dos jogadores e *[a imagem dos jogadores]*, devolve a imagem da situação do
;   jogo atual
;
;   Exemplos:
; 		(desenha-mao CARTA-P1 CARTA-P2 PLAYER PLAYER)
;
;-----------------------------------------------------------------------------------------------------

(define CARTA-P1 (cria-carta PACMAN CARTA-FUNDO-ATAQUE 40 20 20))
(define CARTA-P2 (cria-carta PACMAN CARTA-FUNDO-DEFESA 40 60 20))

; TODO: add gap as an utility function for the whole program and refactor with it
(define (gap x y)
  (rectangle x y "solid" "transparent"))

(define (desenha-mao-jogador sprite string)
  (above (text string 20 "gainsboro") (gap 0 20) sprite))

(define (desenha-mao-mesa carta-p1 carta-p2)
  (overlay (beside carta-p1 (gap 140 0) carta-p2) MESA))

(define (desenha-mao carta-p1 carta-p2 sprite-p1 sprite-p2)
  (beside (desenha-mao-jogador sprite-p1 "JOGADOR 1")
          (gap 50 0)
          (desenha-mao-mesa carta-p1 carta-p2)
          (gap 50 0)
          (desenha-mao-jogador sprite-p2 "JOGADOR 2")))

; Testes
(check-true (image? (desenha-mao CARTA-P1 CARTA-P2 PLAYER PLAYER)))

;-----------------------------------------------------------------------------------------------------
;   desenha-rodada : Sting Imagem Imagem Número Número Número Boolean Imagem Imagem Número Número
;   Número Boolean -> Imagem
;-----------------------------------------------------------------------------------------------------
;
;   Dados as cartas dos jogadores e *[a imagem dos jogadores]*, os valores de suas cartas e se os
;   jogadores possuem ou não uma carta do tipo trunfo, desenha o resultado da rodada do jogo atual.
;
;   Exemplos:
;       (desenha-rodada ATAQUE PLAYER CARTA-P1 40 20 20 #f PLAYER CARTA-P2 40 60 20 #f)
;
;-----------------------------------------------------------------------------------------------------

; TODO: normalize all function parameter names in the program using this model
(define (desenha-rodada atributo
                        p1-sprite
                        p1-carta
                        p1-hp
                        p1-atk
                        p1-def
                        p1-trunfo
                        p2-sprite
                        p2-carta
                        p2-hp
                        p2-atk
                        p2-def
                        p2-trunfo)
  (above (desenha-mao p1-carta p2-carta p1-sprite p2-sprite)
         (gap 0 50)
         (text (verifica-rodada atributo p1-hp p1-atk p1-def p1-trunfo p2-hp p2-atk p2-def p2-trunfo)
               48
               "gainsboro")))

; Testes
(check-true (image? (desenha-rodada ATAQUE PLAYER CARTA-P1 40 20 20 #f PLAYER CARTA-P2 40 60 20 #f)))
