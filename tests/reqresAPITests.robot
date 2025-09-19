*** Settings ***
Documentation    Suite de testes para validação da API reqres. Feito por Leonardo Eliel -- Unitest Squad
Resource         ./resources.robot

*** Test Cases ***
Cenário 1: Listar Usuários de uma página específica
    [Documentation]    Listar os usuários de uma página específica.
    [Tags]    API    GET    /users    HappyPath
    Cria Sessão na URL
    Listar Usuários Da Página    2

Cenário 2: Buscar um usuário existente
    [Documentation]    Buscar os dados do usuário com ID 2.
    [Tags]    API    GET    /users/{id}    HappyPath
    Cria Sessão na URL
    Buscar Usuário Por ID    2

Cenário 3: Buscar um usuário inexistente
    [Documentation]    Buscar usuário com ID inexistente (23).
    [Tags]    API    GET    /users/{id}    SadPath
    Cria Sessão na URL
    Buscar Usuário Inexistente    23

Cenário 4: Criar um novo usuário com sucesso
    [Documentation]    Criar um novo usuário e validar resposta.
    [Tags]    API    POST    /users    HappyPath
    Cria Sessão na URL
    Criar Novo Usuário    Leonardo Eliel    QA Engineer

Cenário 5: Atualizar um usuário com sucesso
    [Documentation]    Atualizar dados do usuário com ID 2.
    [Tags]    API    PUT    /users/{id}    HappyPath
    Cria Sessão na URL
    Atualizar Usuário    2    Leonardo Eliel    Senior QA

Cenário 6: Deletar um usuário com sucesso
    [Documentation]    Deletar usuário com ID 2.
    [Tags]    API    DELETE    /users/{id}    HappyPath
    Cria Sessão na URL
    Deletar Usuário    2

Cenário 7: Registrar um novo usuário com sucesso
    [Documentation]    Registrar usuário com email e senha válidos.
    [Tags]    API    POST    /register    HappyPath
    Cria Sessão na URL
    Registrar Usuário    eve.holt@reqres.in    pistol

Cenário 8: Tentar registrar usuário sem senha
    [Documentation]    Registrar usuário apenas com email, sem senha.
    [Tags]    API    POST    /register    SadPath
    Cria Sessão na URL
    Registrar Usuário Sem Senha    eve.holt@reqres.in

Cenário 9: Fazer login com sucesso
    [Documentation]    Login com email e senha válidos.
    [Tags]    API    POST    /login    HappyPath
    Cria Sessão na URL
    Login Usuário    eve.holt@reqres.in    pistol

Cenário 10: Tentar login sem senha
    [Documentation]    Login apenas com email, sem senha.
    [Tags]    API    POST    /login    SadPath
    Cria Sessão na URL
    Login Usuário Sem Senha    eve.holt@reqres.in

Cenário 11: Buscar recurso desconhecido existente
    [Documentation]    Buscar recurso desconhecido com ID 2.
    [Tags]    API    GET    /unknown/{id}    HappyPath
    Cria Sessão na URL
    Buscar Recurso Desconhecido    2

Cenário 12: Buscar recurso desconhecido inexistente
    [Documentation]    Buscar recurso desconhecido com ID inexistente (23).
    [Tags]    API    GET    /unknown/{id}    SadPath
    Cria Sessão na URL
    Buscar Recurso Desconhecido Inexistente    23