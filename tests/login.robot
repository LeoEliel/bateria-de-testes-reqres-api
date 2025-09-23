*** Settings ***
Resource  common.robot

*** Keywords ***

Fazer Requisição POST Para Login
    [Documentation]    Executa requisição POST para fazer login com email e senha
    [Tags]    POST    Request    Login    Auth
    [Arguments]    ${email}    ${password}
    RETURN    POST On Session    ReqRes    /login    json=&{email=${email}, password=${password}}

Fazer Requisição POST Para Login Sem Senha
    [Documentation]    Executa requisição POST para login apenas com email (sem senha)
    [Tags]    POST    Request    Login    Auth    SadPath
    [Arguments]    ${email}
    RETURN    POST On Session    ReqRes    /login    json=&{email=${email}}    expected_status=400

Validar Resposta De Login
    [Documentation]    Valida que o login foi bem-sucedido e retornou um token válido
    [Tags]    Validation    Login    Auth    HappyPath    200
    [Arguments]    ${response}
    Should Be Equal As Integers    ${response.status_code}    200
    Should Be String    ${response.json()['token']}

Validar Resposta De Login Sem Senha
    [Documentation]    Valida que o login sem senha retorna erro 400 com mensagem de erro
    [Tags]    Validation    Login    Auth    SadPath    400
    [Arguments]    ${response}
    Should Be Equal As Integers    ${response.status_code}    400
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