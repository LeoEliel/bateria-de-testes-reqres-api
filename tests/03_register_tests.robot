*** Settings ***
Documentation    Suite de testes para validação do endpoint /register  API reqres. Feito por Leonardo Eliel -- Unitest Squad
Resource    ../keywords/register_keywords.robot
Resource    ../variaveis/reqres_variaveis.robot
Test Setup    Setup Teste
Test Teardown    Teardown Teste

*** Test Cases ***
Cenário 7: Registrar um novo usuário com sucesso
    [Documentation]    Testa o registro de novo usuário com email e senha válidos, validando token de autenticação
    [Tags]    API    POST    /register    HappyPath
    Registrar Usuário    ${SHARED_EMAIL}    ${SHARED_PASSWORD}

Cenário 8: Tentar registrar usuário sem senha
    [Documentation]    Testa o comportamento da API ao tentar registrar usuário sem senha, validando erro 400
    [Tags]    API    POST    /register    SadPath
    Registrar Usuário Sem Senha    usu@rio_sem_senha.in