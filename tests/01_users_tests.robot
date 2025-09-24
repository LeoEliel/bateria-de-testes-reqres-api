*** Settings ***
Documentation    Suite de testes para validação do endpoint /users da API reqres. Feito por Leonardo Eliel -- Unitest Squad
Resource    ../keywords/users_keywords.robot
Resource    ../variaveis/reqres_variaveis.robot
Suite Setup    Gerar Dados Compartilhados
Test Setup    Setup Teste
Test Teardown    Teardown Teste

*** Test Cases ***
Cenário 1: Listar Usuários de uma página específica
    [Documentation]    Testa a listagem de usuários com paginação, validando estrutura da resposta e dados dos usuários
    [Tags]    API    GET    /users    HappyPath
    Listar Usuários Da Página    2

Cenário 2: Buscar um usuário existente
    [Documentation]    Testa a busca de um usuário específico pelo ID, validando que os dados corretos são retornados
    [Tags]    API    GET    /users/{id}    HappyPath
    Buscar Usuário Por ID    2

Cenário 3: Buscar um usuário inexistente
    [Documentation]    Testa o comportamento da API ao buscar um usuário que não existe, validando erro 404
    [Tags]    API    GET    /users/{id}    SadPath
    ${id_inexistente}=    Gerar ID Inexistente
    Buscar Usuário Inexistente    ${id_inexistente}

Cenário 4: Criar um novo usuário com sucesso
    [Documentation]    Testa a criação de um novo usuário com dados válidos, validando resposta de sucesso
    [Tags]    API    POST    /users    HappyPath
    Criar Novo Usuário    ${SHARED_NAME}    ${SHARED_JOB}

Cenário 5: Atualizar um usuário com sucesso
    [Documentation]    Testa a atualização de dados de um usuário existente, validando resposta de sucesso
    [Tags]    API    PUT    /users/{id}    HappyPath
    Atualizar Usuário    2    ${SHARED_NAME}    ${SHARED_JOB}

Cenário 6: Deletar um usuário com sucesso
    [Documentation]    Testa a deleção de um usuário, validando que a operação foi bem-sucedida
    [Tags]    API    DELETE    /users/{id}    HappyPath
    Deletar Usuário    2
