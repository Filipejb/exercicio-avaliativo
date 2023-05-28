#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#define MAX_USERS 1000

typedef struct {
    int id;
    char nome[100];
    char email[100];
    char sexo[15];
    char endereco[200];
    double altura;
    int vacina;
} Usuario;

Usuario usuarios[MAX_USERS];
int numUsuarios = 0;
int proximoID = 1;

// Função para verificar se o email é válido
int validarEmail(const char *email) {
    const char *at = strchr(email, '@');
    return at != NULL;
}


int validarSexo(const char *sexo) {
    return strcmp(sexo, "Feminino") == 0 ||
           strcmp(sexo, "Masculino") == 0 ||
           strcmp(sexo, "Indiferente") == 0;
}


int validarAltura(double altura) {
    return altura >= 1.0 && altura <= 2.0;
}


void adicionarUsuario() {
    if (numUsuarios >= MAX_USERS) {
        printf("Limite de usuários atingido.\n");
        return;
    }

    Usuario novoUsuario;

    novoUsuario.id = proximoID++;

    printf("Digite o nome completo: ");
    scanf("%99[^\n]", novoUsuario.nome);
    getchar(); // Limpar o caractere de nova linha do buffer de entrada

    printf("Digite o email: ");
    scanf("%99[^\n]", novoUsuario.email);
    getchar(); // Limpar o caractere de nova linha do buffer de entrada

    while (!validarEmail(novoUsuario.email)) {
        printf("Email inválido. Digite novamente: ");
        scanf("%99[^\n]", novoUsuario.email);
        getchar(); // Limpar o caractere de nova linha do buffer de entrada
    }

    printf("Digite o sexo (Feminino, Masculino ou Indiferente): ");
    scanf("%14[^\n]", novoUsuario.sexo);
    getchar(); // Limpar o caractere de nova linha do buffer de entrada

    while (!validarSexo(novoUsuario.sexo)) {
        printf("Sexo inválido. Digite novamente: ");
        scanf("%14[^\n]", novoUsuario.sexo);
        getchar(); // Limpar o caractere de nova linha do buffer de entrada
    }

    printf("Digite o endereço: ");
    scanf("%199[^\n]", novoUsuario.endereco);
    getchar(); // Limpar o caractere de nova linha do buffer de entrada

    printf("Digite a altura (entre 1 e 2 metros): ");
    scanf("%lf", &novoUsuario.altura);
    getchar(); // Limpar o caractere de nova linha do buffer de entrada

    while (!validarAltura(novoUsuario.altura)) {
        printf("Altura inválida. Digite novamente: ");
        scanf("%lf", &novoUsuario.altura);
        getchar(); // Limpar o caractere de nova linha do buffer de entrada
    }

    printf("Vacina (0 - Não, 1 - Sim): ");
    scanf("%d", &novoUsuario.vacina);
    getchar(); // Limpar o caractere de nova linha do buffer de entrada

    usuarios[numUsuarios] = novoUsuario;
    numUsuarios++;

    printf("O usuário foi cadastrado com sucesso!\n");
}


void exibirUsuario(const Usuario *usuario) {
    printf("ID: %d\n", usuario->id);
    printf("Nome: %s\n", usuario->nome);
    printf("Email: %s\n", usuario->email);
    printf("Sexo: %s\n", usuario->sexo);
    printf("Endereço: %s\n", usuario->endereco);
    printf("Altura: %.2f\n", usuario->altura);
    printf("Vacina: %d\n", usuario->vacina);
}


void exibirUsuarios() {
    if (numUsuarios == 0) {
        printf("Não há usuários cadastrados.\n");
        return;
    }

    for (int i = 0; i < numUsuarios; i++) {
        printf("Usuário %d:\n", i + 1);
        exibirUsuario(&usuarios[i]);
        printf("\n");
    }
}


void editarUsuario() {
    if (numUsuarios == 0) {
        printf("Não há usuários cadastrados.\n");
        return;
    }

    int id;
    printf("Digite o ID do usuário que deseja editar: ");
    scanf("%d", &id);
    getchar(); // Limpar o caractere de nova linha do buffer de entrada

    for (int i = 0; i < numUsuarios; i++) {
        if (usuarios[i].id == id) {
            exibirUsuario(&usuarios[i]);

            printf("Digite o novo nome: ");
            scanf("%99[^\n]", usuarios[i].nome);
            getchar(); // Limpar o caractere de nova linha do buffer de entrada

            printf("Digite o novo email: ");
            scanf("%99[^\n]", usuarios[i].email);
            getchar(); // Limpar o caractere de nova linha do buffer de entrada

            while (!validarEmail(usuarios[i].email)) {
                printf("Email inválido. Digite novamente: ");
                scanf("%99[^\n]", usuarios[i].email);
                getchar(); // Limpar o caractere de nova linha do buffer de entrada
            }

            printf("Digite o novo sexo (Feminino, Masculino ou Indiferente): ");
            scanf("%14[^\n]", usuarios[i].sexo);
            getchar(); // Limpar o caractere de nova linha do buffer de entrada

            while (!validarSexo(usuarios[i].sexo)) {
                printf("Sexo inválido. Digite novamente: ");
                scanf("%14[^\n]", usuarios[i].sexo);
                getchar(); // Limpar o caractere de nova linha do buffer de entrada
            }

            printf("Digite o novo endereço: ");
            scanf("%199[^\n]", usuarios[i].endereco);
            getchar(); // Limpar o caractere de nova linha do buffer de entrada

            printf("Digite a nova altura (entre 1 e 2 metros): ");
            scanf("%lf", &usuarios[i].altura);
            getchar(); // Limpar o caractere de nova linha do buffer de entrada

            while (!validarAltura(usuarios[i].altura)) {
                printf("Altura inválida. Digite novamente: ");
                scanf("%lf", &usuarios[i].altura);
                getchar(); // Limpar o caractere de nova linha do buffer de entrada
            }

            printf("Vacina (0 - Não, 1 - Sim): ");
            scanf("%d", &usuarios[i].vacina);
            getchar(); // Limpar o caractere de nova linha do buffer de entrada

            printf("Os dados do usuário foram atualizados com sucesso!\n");
            return;
        }
    }

    printf("Usuário com ID %d não encontrado.\n", id);
}


void excluirUsuario() {
    if (numUsuarios == 0) {
        printf("Não há usuários cadastrados.\n");
        return;
    }

    int id;
    printf("Digite o ID do usuário que deseja excluir: ");
    scanf("%d", &id);
    getchar(); // Limpar o caractere de nova linha do buffer de entrada

    for (int i = 0; i < numUsuarios; i++) {
        if (usuarios[i].id == id) {
            exibirUsuario(&usuarios[i]);

            for (int j = i; j < numUsuarios - 1; j++) {
                usuarios[j] = usuarios[j + 1];
            }

            numUsuarios--;

            printf("O usuário foi excluído com sucesso!\n");
            return;
        }
    }

    printf("Usuário com ID %d não encontrado.\n", id);
}

  void fazerRestauracao() {
    FILE *arquivo = fopen("backup.txt", "r");

    if (arquivo == NULL) {
        printf("Erro ao abrir o arquivo de backup.\n");
        return;
    }

    numUsuarios = 0;
    while (numUsuarios < MAX_USERS && fscanf(arquivo, "%d|%[^|]|%[^|]|%[^|]|%[^|]|%lf|%d\n",
                                           &usuarios[numUsuarios].id,
                                           usuarios[numUsuarios].nome,
                                           usuarios[numUsuarios].email,
                                           usuarios[numUsuarios].sexo,
                                           usuarios[numUsuarios].endereco,
                                           &usuarios[numUsuarios].altura,
                                           &usuarios[numUsuarios].vacina) == 7) {
        numUsuarios++;
    }

    fclose(arquivo);

    printf("Restauração concluída. Foram recuperados %d usuários.\n", numUsuarios);
}


void fazerBackup() {
    FILE *arquivo = fopen("backup.txt", "w");

    if (arquivo == NULL) {
        printf("Erro ao criar o arquivo de backup.\n");
        return;
    }

    for (int i = 0; i < numUsuarios; i++) {
        fprintf(arquivo, "%d|%s|%s|%s|%s|%.2f|%d\n",
                usuarios[i].id,
                usuarios[i].nome,
                usuarios[i].email,
                usuarios[i].sexo,
                usuarios[i].endereco,
                usuarios[i].altura,
                usuarios[i].vacina);
    }

    fclose(arquivo);

    printf("Backup concluído. Os dados foram salvos no arquivo backup.txt.\n");
}


int main() {
    int opcao;

    srand(time(NULL)); // Inicializar o gerador de números aleatórios

    do {
        printf("Selecione uma opção:\n");
        printf("1. Adicionar usuário\n");
        printf("2. Exibir usuários\n");
        printf("3. Editar usuário\n");
        printf("4. Excluir usuário\n");
        printf("5. Fazer backup\n");
        printf("6. Fazer restauração\n");
        printf("7. sair\n");
        printf("Opção: ");
        scanf("%d", &opcao);
        getchar(); // Limpar o caractere de nova linha do buffer de entrada
        printf("\n");

        switch (opcao) {
            case 1:
                adicionarUsuario();
                break;
            case 2:
                exibirUsuarios();
                break;
            case 3:
                editarUsuario();
                break;
            case 4:
                excluirUsuario();
                break;
            case 5:
                fazerBackup();
                break;
            case 6:
                 fazerRestauracao();
                break;
            case 7:
                printf("Encerrando o programa...\n");
                break;
            default:
                printf("Opção inválida. Digite novamente.\n");
                break;
        }

        printf("\n");
    } while (opcao != 8);

    return 0;
}
