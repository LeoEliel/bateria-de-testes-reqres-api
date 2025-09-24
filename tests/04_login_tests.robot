*** Settings ***
Documentation    Suite de testes para validação do endpoint /login  API reqres. Feito por Leonardo Eliel -- Unitest Squad
Resource    ../keywords/login_keywords.robot
Resource    ../variaveis/reqres_variaveis.robot
Suite Setup    Gerar Dados Compartilhados
Test Setup    Setup Teste
Test Teardown    Teardown Teste

*** Test Cases ***
Cenário 9: Fazer login com sucesso
    [Documentation]    Testa o login com credenciais válidas, validando token de autenticação retornado
    [Tags]    API    POST    /login    HappyPath
    Login Usuário    ${SHARED_EMAIL}    ${SHARED_PASSWORD}

Cenário 10: Tentar login sem senha
    [Documentation]    Testa o comportamento da API ao tentar fazer login sem senha, validando erro 400
    [Tags]    API    POST    /login    SadPath
    Login Usuário Sem Senha    usu@rio_sem_senha.in
