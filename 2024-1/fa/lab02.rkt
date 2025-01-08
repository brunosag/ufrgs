#lang racket

(require rackunit)
(require 2htdp/image)

;=====================================================================================================
;   1.
;=====================================================================================================
;
;   Defina um tipo de dados chamado Pet, que deve registrar o nome de um animal de estimação (pet),
;   a sua cor, a sua idade, o nome do seu dono e o tipo de animal ele é (ex.: "Gato", "Cachorro",
;   "Cavalo", etc). O nome do pet, a cor o nome do dono e o tipo do animal devem ser do tipo
;   String, e a idade deve ser do tipo Número. Defina 4 constantes cujos valores sejam do tipo Pet.
;
;   Defina também um tipo de dados chamado Vet, que deve registrar o nome de um veterinário, o seu
;   turno de plantão (que pode ser "Manhã", "Tarde" ou "Noite"), a sua especialidade (o tipo de
;   animal que ele atende) e os três espaços de atendimentos deste veterinário. O nome, o turno e a
;   especialidade devem ser do tipo String. Cada espaço de atendimento pode ser um animal (tipo
;   Pet) ou pode estar livre (neste caso, deve ser utilizada a string "livre"). Defina 4 constantes
;   cujos valores sejam do tipo Vet.
;
;   Você deve usar EXATAMENTE os nomes dos tipos de dados e a ordem dos argumentos definidos acima,
;   mas pode escolher os nomes que quiser para os atributos).
;
;=====================================================================================================

;-----------------------------------------------------------------------------------------------------
;   tipo Pet
;-----------------------------------------------------------------------------------------------------
;   nome:         String,    nome do pet
;   cor:          String,    cor do pet ("Preto", "Marrom", "Cinza", etc)
;   idade:        Número,    idade do pet
;   nome-dono:    String,    nome do dono do pet
;   tipo:         String,    tipo de animal ("Gato", "Cachorro", "Cavalo", etc)
;-----------------------------------------------------------------------------------------------------
(define-struct Pet (nome cor idade nome-dono tipo))

(define PET1 (make-Pet "Rex" "Marrom" 5 "João" "Cachorro"))
(define PET2 (make-Pet "Mimi" "Branco" 3 "Maria" "Gato"))
(define PET3 (make-Pet "Pé de Pano" "Preto" 10 "José" "Cavalo"))
(define PET4 (make-Pet "Branquinho" "Branco" 1 "Ana" "Cachorro"))

;-----------------------------------------------------------------------------------------------------
;   tipo Vet
;-----------------------------------------------------------------------------------------------------
;   nome:             String,                           nome do veterinário
;   turno:            ("Manhã" | "Tarde" | "Noite"),    turno de plantão
;   especialidade:    String,                           tipo de animal atendido
;   espaco1:          (Pet | "livre"),                  primeiro espaço de atendimento
;   espaco2:          (Pet | "livre"),                  segundo espaço de atendimento
;   espaco3:          (Pet | "livre"),                  terceiro espaço de atendimento
;-----------------------------------------------------------------------------------------------------
(define-struct Vet (nome turno especialidade espaco1 espaco2 espaco3))

(define VET1 (make-Vet "Dr. Fulano" "Manhã" "Cachorro" PET1 "livre" "livre"))
(define VET2 (make-Vet "Dr. Beltrano" "Tarde" "Gato" "livre" PET2 "livre"))
(define VET3 (make-Vet "Dr. Sicrano" "Noite" "Cavalo" "livre" "livre" PET3))
(define VET4 (make-Vet "Dr. Ciclano" "Manhã" "Cachorro" "livre" "livre" "livre"))

;=====================================================================================================
;   2.
;=====================================================================================================
;
;   Desenvolva um função chamada é-pet? que, dado um Pet ou uma String, verifica se a entrada é do
;   tipo Pet ou do tipo String, retornando verdadeiro se for do tipo Pet e falso caso contrário.
;
;=====================================================================================================

;-----------------------------------------------------------------------------------------------------
;   é-pet? : (Pet | String) -> Boolean
;-----------------------------------------------------------------------------------------------------
;   Dado um Pet ou uma String, verifica se a entrada é do tipo Pet ou do tipo String, retornando
;   verdadeiro se for do tipo Pet e falso caso contrário.
;
;   Exemplos:
;       (é-pet? PET1) = #t
;       (é-pet? "x") = #f
;-----------------------------------------------------------------------------------------------------
(define (é-pet? entrada)
  (Pet? entrada))

; Testes
(check-eq? (é-pet? PET1) #t)
(check-eq? (é-pet? "x") #f)

;=====================================================================================================
;   3.
;=====================================================================================================
;
;   Construa uma função verifica-disponibilidade que, dado um veterinário, verifica se ele está
;   disponível para atender um novo pet, ou seja, caso algum de seus espaços de atendimento seja
;   "livre", devolve verdadeiro, caso contrário, gera um resultado falso.
;
;=====================================================================================================

;-----------------------------------------------------------------------------------------------------
;   verifica-disponibilidade : Vet -> Boolean
;-----------------------------------------------------------------------------------------------------
;   Dado um veterinário, verifica se ele está disponível para atender um novo pet, ou seja, caso
;   algum de seus espaços de atendimento seja "livre", devolve verdadeiro, caso contrário, gera um
;   resultado falso.
;
;   Exemplos:
;       (verifica-disponibilidade (make-Vet "x" "x" "x" "livre" "livre" "livre")) = #t
;       (verifica-disponibilidade (make-Vet "x" "x" "x" PET1 "livre" PET2)) = #t
;       (verifica-disponibilidade (make-Vet "x" "x" "x" PET1 PET2 PET3)) = #f
;-----------------------------------------------------------------------------------------------------
(define (verifica-disponibilidade vet)
  (not (and (é-pet? (Vet-espaco1 vet)) (é-pet? (Vet-espaco2 vet)) (é-pet? (Vet-espaco3 vet)))))

; Testes
(check-eq? (verifica-disponibilidade (make-Vet "x" "x" "x" "livre" "livre" "livre")) #t)
(check-eq? (verifica-disponibilidade (make-Vet "x" "x" "x" PET1 "livre" PET2)) #t)
(check-eq? (verifica-disponibilidade (make-Vet "x" "x" "x" PET1 PET2 PET3)) #f)

;=====================================================================================================
;   4.
;=====================================================================================================
;
;   Quando um animal chega na petshop para ser atendido, deve ser verificado se o veterinário pode
;   ou não atendê-lo. Desenvolva uma função chamada adiciona-pet que, dado um veterinário e um
;   animal, nesta ordem, realiza o encaminhamento deste animal para este veterinário. O animal deve
;   ser inserido na primeira posição de atendimento livre do veterinário, gerando assim um novo
;   registro de veterinário. Caso não seja possível o encaixe (ou seja, caso todas as posições
;   estejam ocupadas), devolver a frase "Sem horário disponível".
;
;=====================================================================================================

(define (primeiro-espaco-livre vet)
  (cond
    [(not (é-pet? (Vet-espaco1 vet))) 1]
    [(not (é-pet? (Vet-espaco2 vet))) 2]
    [(not (é-pet? (Vet-espaco3 vet))) 3]
    [else 0]))

;-----------------------------------------------------------------------------------------------------
;   adiciona-pet : Vet Pet -> (Vet | "Sem horário disponível")
;-----------------------------------------------------------------------------------------------------
;   Dado um veterinário e um animal, realiza o encaminhamento deste animal para este veterinário. O
;   animal é inserido na primeira posição de atendimento livre do veterinário, gerando assim um
;   novo registro de veterinário. Caso não seja possível o encaixe (ou seja, caso todas as posições
;   estejam ocupadas), devolve a frase "Sem horário disponível".
;
;   Exemplos:
;       (adiciona-pet (make-Vet "x" "x" "x" PET1 PET2 PET3) PET4) = "Sem horário disponível"
;       (adiciona-pet (make-Vet "x" "x" "x" PET1 "livre" "livre") PET2)
;           = (make-Vet "x" "x" "x" PET1 PET2 "livre")
;-----------------------------------------------------------------------------------------------------
(define (adiciona-pet vet pet)
  (cond
    [(not (verifica-disponibilidade vet)) "Sem horário disponível"]
    [else
     (make-Vet (Vet-nome vet)
               (Vet-turno vet)
               (Vet-especialidade vet)
               (cond
                 [(= (primeiro-espaco-livre vet) 1) pet]
                 [else (Vet-espaco1 vet)])
               (cond
                 [(= (primeiro-espaco-livre vet) 2) pet]
                 [else (Vet-espaco2 vet)])
               (cond
                 [(= (primeiro-espaco-livre vet) 3) pet]
                 [else (Vet-espaco3 vet)]))]))

; Testes
(check-eq? (adiciona-pet (make-Vet "x" "x" "x" PET1 PET2 PET3) PET4) "Sem horário disponível")
(check-eq? (Vet-espaco2 (adiciona-pet (make-Vet "x" "x" "x" PET1 "livre" "livre") PET2)) PET2)

;=====================================================================================================
;   5.
;=====================================================================================================
;
;   Defina um tipo de dados chamado PetShop, que deve registrar o nome da petshop, o endereço, o
;   telefone de contato, e os dois veterinários que estão de plantão no momento (coloque os
;   atributos da estrutura nesta ordem). O nome e o endereço devem ser do tipo String, o telefone
;   do tipo Número. Os veterinários de plantão devem ser do tipo Vet ou podem ser a string "vago"
;   (representando que um dos plantonistas não está disponível). Defina 3 constantes cujos valores
;   sejam do tipo PetShop.
;
;=====================================================================================================

;-----------------------------------------------------------------------------------------------------
;   tipo PetShop
;-----------------------------------------------------------------------------------------------------
;   nome:            String,            nome da petshop
;   endereco:        String,            endereço da petshop
;   telefone:        Número,            telefone de contato
;   plantonista1:    (Vet | "vago"),    primeiro veterinário de plantão
;   plantonista2:    (Vet | "vago"),    segundo veterinário de plantão
;-----------------------------------------------------------------------------------------------------
(define-struct PetShop (nome endereco telefone plantonista1 plantonista2))

(define PETSHOP1 (make-PetShop "PetShop A" "Rua A, 123" 12345678 VET1 VET2))
(define PETSHOP2 (make-PetShop "PetShop B" "Rua B, 456" 87654321 VET3 "vago"))
(define PETSHOP3 (make-PetShop "PetShop C" "Rua C, 789" 13579246 "vago" VET4))

;=====================================================================================================
;   6.
;=====================================================================================================
;
;   No momento da troca de turno, o registro da petshop deve ser atualizado, removendo os
;   veterinários que não atuam no novo turno de trabalho. Construa uma função chamada
;   termina-plantão que, dados uma PetShop e o novo turno (que pode ser "Manhã", "Tarde" ou
;   "Noite"), nesta ordem, remove do registro os veterinários que não atuam neste novo turno. No
;   caso de um veterinário ser removido, o registro deste veterinário na petshop deve atualizado
;   para ao valor "vago".
;
;=====================================================================================================

;-----------------------------------------------------------------------------------------------------
;   termina-plantão : PetShop ("Manhã" | "Tarde" | "Noite") -> PetShop
;-----------------------------------------------------------------------------------------------------
;   Dados uma PetShop e o novo turno, remove do registro os veterinários que não atuam neste novo
;   turno. No caso de um veterinário ser removido, o registro deste veterinário na petshop é
;   atualizado para ao valor "vago".
;
;   Exemplos:
;       (termina-plantão PETSHOP1 "Manhã")
;           = (make-PetShop "PetShop A" "Rua A, 123" 12345678 VET1 "vago")
;       (termina-plantão PETSHOP2 "Tarde")
;           = (make-PetShop "PetShop B" "Rua B, 456" 87654321 "vago" "vago")
;       (termina-plantão PETSHOP3 "Manhã")
;           = (make-PetShop "PetShop C" "Rua C, 789" 13579246 "vago" VET4)
;-----------------------------------------------------------------------------------------------------
(define (termina-plantão petshop novo-turno)
  (make-PetShop
   (PetShop-nome petshop)
   (PetShop-endereco petshop)
   (PetShop-telefone petshop)
   (cond
     [(eq? (PetShop-plantonista1 petshop) "vago") "vago"]
     [(string=? (Vet-turno (PetShop-plantonista1 petshop)) novo-turno) (PetShop-plantonista1 petshop)]
     [else "vago"])
   (cond
     [(eq? (PetShop-plantonista2 petshop) "vago") "vago"]
     [(string=? (Vet-turno (PetShop-plantonista2 petshop)) novo-turno) (PetShop-plantonista2 petshop)]
     [else "vago"])))

; Testes
(check-equal? (PetShop-plantonista1 (termina-plantão PETSHOP1 "Manhã")) VET1)
(check-equal? (PetShop-plantonista2 (termina-plantão PETSHOP1 "Manhã")) "vago")
(check-equal? (PetShop-plantonista1 (termina-plantão PETSHOP2 "Tarde")) "vago")
(check-equal? (PetShop-plantonista2 (termina-plantão PETSHOP2 "Tarde")) "vago")
(check-equal? (PetShop-plantonista1 (termina-plantão PETSHOP3 "Manhã")) "vago")
(check-equal? (PetShop-plantonista2 (termina-plantão PETSHOP3 "Manhã")) VET4)

;=====================================================================================================
;   7.
;=====================================================================================================
;
;   Quando um animal chega na petshop para atendimento, é necessário verificar se algum dos
;   veterinários de plantão presta atendimento para este tipo de animal e tem horário livre para
;   atendê-lo. Desenvolva uma função chamada aloca-pet-vet que, dados um animal (tipo Pet) e uma
;   petshop (tipo PetShop), nesta ordem, verifica se algum dos veterinários que estão de plantão
;   atende este tipo de animal e se possui vaga para o seu atendimento. Em caso positivo, deve-se
;   incluir este animal no primeiro espaço de atendimento livre do veterinário e atualizar o
;   registro da petshop. Caso contrário, deve-se retornar a mensagem "Sem horário disponível".
;
;=====================================================================================================

(define (vet-atende-pet? vet pet)
  (and (Vet? vet) (string=? (Vet-especialidade vet) (Pet-tipo pet))))

(define (vet-alocavel petshop pet)
  (cond
    [(and (vet-atende-pet? (PetShop-plantonista1 petshop) pet)
          (verifica-disponibilidade (PetShop-plantonista1 petshop)))
     1]
    [(and (vet-atende-pet? (PetShop-plantonista2 petshop) pet)
          (verifica-disponibilidade (PetShop-plantonista2 petshop)))
     2]
    [else 0]))

;-----------------------------------------------------------------------------------------------------
;   aloca-pet-vet : Pet PetShop -> (PetShop | "Sem horário disponível")
;-----------------------------------------------------------------------------------------------------
;   Dados um pet e uma petshop, verifica se algum dos veterinários que estão de plantão atende este
;   tipo de animal e se possui vaga para o seu atendimento. Em caso positivo, o animal é incluído
;   no primeiro espaço de atendimento livre do veterinário e o registro da petshop é atualizado.
;   Caso contrário, retorna a mensagem "Sem horário disponível".
;
;   Exemplo:
;       (aloca-pet-vet PET4 PETSHOP1)
;           = (make-PetShop ... (make-Vet ... PET1 PET4 "livre") VET2)
;       (aloca-pet-vet PET1 PETSHOP2) = "Sem horário disponível"
;-----------------------------------------------------------------------------------------------------
(define (aloca-pet-vet pet petshop)
  (cond
    [(= (vet-alocavel petshop pet) 0) "Sem horário disponível"]
    [else
     (make-PetShop
      (PetShop-nome petshop)
      (PetShop-endereco petshop)
      (PetShop-telefone petshop)
      (cond
        [(= (vet-alocavel petshop pet) 1) (adiciona-pet (PetShop-plantonista1 petshop) pet)]
        [else (PetShop-plantonista1 petshop)])
      (cond
        [(= (vet-alocavel petshop pet) 2) (adiciona-pet (PetShop-plantonista2 petshop) pet)]
        [else (PetShop-plantonista2 petshop)]))]))

; Testes
(check-eq? (Vet-espaco1 (PetShop-plantonista1 (aloca-pet-vet PET4 PETSHOP1))) PET1)
(check-eq? (Vet-espaco2 (PetShop-plantonista1 (aloca-pet-vet PET4 PETSHOP1))) PET4)
(check-eq? (Vet-espaco3 (PetShop-plantonista1 (aloca-pet-vet PET4 PETSHOP1))) "livre")
(check-eq? (PetShop-plantonista2 (aloca-pet-vet PET4 PETSHOP1)) VET2)
(check-eq? (aloca-pet-vet PET1 PETSHOP2) "Sem horário disponível")

;=====================================================================================================
;   8.
;=====================================================================================================
;
;   Desenvolva uma função chamada gera-lista-atendimentos que recebe uma PetShop e gera uma lista
;   dos atendimentos que serão realizados nesta petshop pelos veterinários de plantão. A saída
;   desta função deve ser uma imagem contendo o nome, endereço e telefone da petshop e, para cada
;   veterinário de plantão, o nome do veterinário e os animais que serão atendidos. Para cada
;   animal atendido, devem ser mostrados o nome, o tipo de animal e a idade.
;
;=====================================================================================================

(define TEXTO-TAMANHO 20)
(define TEXTO-COR (color 0 0 0 190))
(define FUNDO-COR (color 226 227 198))
(define LINHA-LARGURA 280)
(define LINHA-ALTURA (+ TEXTO-TAMANHO (exact-floor (/ TEXTO-TAMANHO 5))))

(define SEPARADOR (make-string (exact-floor (/ LINHA-LARGURA (* TEXTO-TAMANHO 0.6))) #\-))
(define QUEBRA-LINHA " ")

(define (gap x y)
  (rectangle x y "solid" FUNDO-COR))

(define (margin size image)
  (beside (gap size (+ (image-height image) (* size 2)))
          (above (gap (image-width image) size) image (gap (image-width image) size))
          (gap size (+ (image-height image) (* size 2)))))

(define (imprime-texto texto negrito)
  (overlay/align "left"
                 "middle"
                 (text/font (string-upcase texto)
                            TEXTO-TAMANHO
                            TEXTO-COR
                            "Courier Prime"
                            "default"
                            "normal"
                            (cond
                              [negrito "bold"]
                              [else "normal"])
                            #f)
                 (rectangle LINHA-LARGURA LINHA-ALTURA "solid" FUNDO-COR)))

(define (imprime-pet pet)
  (cond
    [(Pet? pet)
     (above (imprime-texto QUEBRA-LINHA #f)
            (imprime-texto (Pet-nome pet) #t)
            (imprime-texto (Pet-tipo pet) #f)
            (imprime-texto (string-append (number->string (Pet-idade pet)) " anos") #f))]
    [else empty-image]))

(define (imprime-vet vet)
  (cond
    [(Vet? vet)
     (above (imprime-texto (Vet-nome vet) #t)
            (imprime-pet (Vet-espaco1 vet))
            (imprime-pet (Vet-espaco2 vet))
            (imprime-pet (Vet-espaco3 vet))
            (imprime-texto SEPARADOR #f))]
    [else empty-image]))

;-----------------------------------------------------------------------------------------------------
;   gera-lista-atendimentos : PetShop -> Imagem
;-----------------------------------------------------------------------------------------------------
;   Dado um petshop, devolve uma imagem contendo o nome, endereço e telefone da petshop e, para
;   cada veterinário de plantão, o nome do veterinário e os animais que serão atendidos. Para cada
;   animal atendido, são mostrados o nome, o tipo de animal e a idade.
;
;   Exemplo:
;       (gera-lista-atendimentos PETSHOP1)
;-----------------------------------------------------------------------------------------------------
(define (gera-lista-atendimentos petshop)
  (margin 16
          (above (imprime-texto (PetShop-nome petshop) #t)
                 (imprime-texto (PetShop-endereco petshop) #f)
                 (imprime-texto (number->string (PetShop-telefone petshop)) #f)
                 (imprime-texto SEPARADOR #f)
                 (imprime-vet (PetShop-plantonista1 petshop))
                 (imprime-vet (PetShop-plantonista2 petshop)))))

(check-true (image? (gera-lista-atendimentos PETSHOP1)))
