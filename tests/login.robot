*** Settings ***
Resource  common.robot

*** Keywords ***

Fazer Requisição POST Para Login
    [Arguments]    ${email}    ${password}
    ${payload}=    Create Dictionary    email=${email}    password=${password}
    ${response}=    POST On Session    ReqRes    /login    json=${payload}
    RETURN    ${response}

Login Usuário
    [Arguments]    ${email}    ${password}
    ${response}=    Fazer Requisição POST Para Login    ${email}    ${password}
    Should Be Equal As Integers    ${response.status_code}    200
    Dictionary Should Contain Key    ${response.json()}    token
    Should Be String    ${response.json()['token']}

Fazer Requisição POST Para Login Sem Senha
    [Arguments]    ${email}
    ${payload}=    Create Dictionary    email=${email}
    ${response}=    POST On Session    ReqRes    /login    json=${payload}    expected_status=400
    RETURN    ${response}

Login Usuário Sem Senha
    [Arguments]    ${email}
    ${response}=    Fazer Requisição POST Para Login Sem Senha    ${email}
    Should Be Equal As Integers    ${response.status_code}    400
    Dictionary Should Contain Key    ${response.json()}    error
    Should Be String    ${response.json()['error']}