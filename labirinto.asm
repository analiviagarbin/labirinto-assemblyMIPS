# Ana Flor Oliveira de Stefani
# Ana Lívia de M. Garbin
# Fernando Barbosa

# Labirinto Estático em Assembly MIPS

# Inicializar dados
.data
    boasvindas: .asciiz "Bem-vindo ao Labirinto!\n"
    vitoria: .asciiz "Parabéns! Você finalizou o labirinto\n"
    guia: .asciiz "Você deve chegar até a saída (S) a partir da entrada (E).\n"
    mapa: .asciiz "XXXXXXXXXX\nE  XXXXXXX\nXX XXXXXXX\nXX XXXXXXX\nXX XXXXXXX\nXX XXXXXXX\nXX XXXXXXX\nXX XXXXXXX\nXX XXXXXXX\nXX     XXX\nXXXXXX   S\nXXXXXXXXXX\n"
    guia1: .asciiz "Entradas aceitas são: C (cima), B (baixo), D (direita) e E (esquerda).\n"
    guia2: .asciiz "Você deve inserir o caminho completo e teclar Enter para ser validado.\n"
    guia3: .asciiz "Lembre-se! O jogo é case-sensitive, responda apenas com letras maiúsculas.\n"
    caminho_correto: .asciiz "DDBBBBBBBBDDDDBDDD\n"
    erro: .asciiz "Entrada inválida! Tente novamente.\n"
    input_buffer: .space 20 # Tamanho máximo da entrada do jogador

.text

# Tela principal e instruções do jogo
main:
    li $v0, 4
    la $a0, boasvindas
    syscall
    li $v0, 4
    la $a0, guia
    syscall
    li $v0, 4
    la $a0, guia1
    syscall
    li $v0, 4
    la $a0, guia2
    syscall
    li $v0, 4
    la $a0, guia3
    syscall
    li $v0, 4
    la $a0, mapa
    syscall
    jal jogar

# Função para receber entrada do jogador e verificar imediatamente
receberentrada:
    li $v0, 8
    la $a0, input_buffer
    li $a1, 20
    syscall

    # Verificar a entrada do jogador em relação ao caminho correto
    la $t0, caminho_correto
    la $t1, input_buffer
    li $t2, 0

check_loop:
    lb $t3, ($t0)
    lb $t4, ($t1)

    beqz $t3, exit_check

    beq $t3, $t4, valid_input

    # Se não for uma entrada válida, mostrar mensagem de erro
    li $v0, 4
    la $a0, erro
    syscall
    j receberentrada

valid_input:
    addi $t0, $t0, 1
    addi $t1, $t1, 1
    addi $t2, $t2, 1
    j check_loop

exit_check:
    # Se chegou até aqui, a entrada é válida
    li $v0, 4
    la $a0, vitoria
    syscall
    li $v0, 10
    syscall
    jr $ra

# Função principal do jogo
jogar:
    # Verifique a entrada do jogador
    j receberentrada
