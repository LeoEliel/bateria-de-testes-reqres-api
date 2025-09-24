*** Settings ***
Resource    ../support/common/base.robot
Library  String
Library  Collections

*** Keywords ***

Fazer Requisição POST Para Registrar
    [Documentation]    Executa requisição POST para registrar novo usuário com email e senha
    [Tags]    POST    Request    Register    Auth
    [Arguments]    ${email}    ${password}
    ${payload}=    Create Dictionary    email=${email}    password=${password}
    ${response}=    POST On Session    ReqRes    /register    json=${payload}
    RETURN    ${response}

Fazer Requisição POST Para Registrar Sem Senha
    [Documentation]    Executa requisição POST para registrar usuário apenas com email (sem senha)
    [Tags]    POST    Request    Register    Auth    SadPath
    [Arguments]    ${email}
    ${payload}=    Create Dictionary    email=${email}
    ${response}=    POST On Session    ReqRes    /register    json=${payload}    expected_status=400
    RETURN    ${response}

Validar Resposta De Registro
    [Documentation]    Valida que o registro foi bem-sucedido e retornou um token válido
    [Tags]    Validation    Register    Auth    HappyPath    200
    [Arguments]    ${response}
    Status Should Be    200    ${response}
    Should Be String    ${response.json()['token']}

Validar Resposta De Registro Sem Senha
    [Documentation]    Valida que o registro sem senha retorna erro 400 com mensagem de erro
    [Tags]    Validation    Register    Auth    SadPath    400
    [Arguments]    ${response}
    Status Should Be    400    ${response}
    Should Be String    ${response.json()['error']}

Registrar Usuário
    [Documentation]    Registra novo usuário com email e senha e valida a resposta
    [Tags]    POST    Register    Auth    HappyPath
    [Arguments]    ${email}    ${password}
    ${response}=    Fazer Requisição POST Para Registrar    ${email}    ${password}
    Validar Resposta De Registro    ${response}

Registrar Usuário Sem Senha
    [Documentation]    Tenta registrar usuário apenas com email e valida o erro retornado
    [Tags]    POST    Register    Auth    SadPath
    [Arguments]    ${email}
    ${response}=    Fazer Requisição POST Para Registrar Sem Senha    ${email}
    Validar Resposta De Registro Sem Senha    ${response}
