*** Settings ***
Resource  common.robot

*** Keywords ***

Fazer Requisição POST Para Registrar
    [Arguments]    ${email}    ${password}
    ${payload}=    Create Dictionary    email=${email}    password=${password}
    ${response}=    POST On Session    ReqRes    /register    json=${payload}
    RETURN    ${response}

Registrar Usuário
    [Arguments]    ${email}    ${password}
    ${response}=    Fazer Requisição POST Para Registrar    ${email}    ${password}
    Should Be Equal As Integers    ${response.status_code}    200
    Dictionary Should Contain Key    ${response.json()}    token
    Should Be String    ${response.json()['token']}

Fazer Requisição POST Para Registrar Sem Senha
    [Arguments]    ${email}
    ${payload}=    Create Dictionary    email=${email}
    ${response}=    POST On Session    ReqRes    /register    json=${payload}    expected_status=400
    RETURN    ${response}

Registrar Usuário Sem Senha
    [Arguments]    ${email}
    ${response}=    Fazer Requisição POST Para Registrar Sem Senha    ${email}
    Should Be Equal As Integers    ${response.status_code}    400
    Dictionary Should Contain Key    ${response.json()}    error
    Should Be String    ${response.json()['error']}
