*** Settings ***
Resource    ../support/common/base.robot
Resource    ../variaveis/reqres_variaveis.robot
Library  String
Library  Collections

*** Keywords ***

Fazer Requisição POST Para Login
    [Documentation]    Executa requisição POST para fazer login com email e senha
    [Tags]    POST    Request    Login    Auth
    [Arguments]    ${email}    ${password}
    ${payload}=    Create Dictionary    email=${email}    password=${password}
    ${response}=    POST On Session    ReqRes    /login    json=${payload}
    RETURN    ${response}

Fazer Requisição POST Para Login Sem Senha
    [Documentation]    Executa requisição POST para login apenas com email (sem senha)
    [Tags]    POST    Request    Login    Auth    SadPath
    [Arguments]    ${email}
    ${payload}=    Create Dictionary    email=${email}
    ${response}=    POST On Session    ReqRes    /login    json=${payload}    expected_status=400
    RETURN    ${response}

Validar Resposta De Login
    [Documentation]    Valida que o login foi bem-sucedido e retornou um token válido
    [Tags]    Validation    Login    Auth    HappyPath    200
    [Arguments]    ${response}
    Status Should Be    200    ${response}
    Should Be String    ${response.json()['token']}

Validar Resposta De Login Sem Senha
    [Documentation]    Valida que o login sem senha retorna erro 400 com mensagem de erro
    [Tags]    Validation    Login    Auth    SadPath    400
    [Arguments]    ${response}
    Status Should Be    400    ${response}
    Should Be String    ${response.json()['error']}

Login Usuário
    [Documentation]    Realiza login de usuário com email e senha e valida a resposta
    [Tags]    POST    Login    Auth    HappyPath
    [Arguments]    ${email}    ${password}
    ${response}=    Fazer Requisição POST Para Login    ${email}    ${password}
    Validar Resposta De Login    ${response}

Login Usuário Sem Senha
    [Documentation]    Tenta fazer login apenas com email e valida o erro retornado
    [Tags]    POST    Login    Auth    SadPath
    [Arguments]    ${email}
    ${response}=    Fazer Requisição POST Para Login Sem Senha    ${email}
    Validar Resposta De Login Sem Senha    ${response}