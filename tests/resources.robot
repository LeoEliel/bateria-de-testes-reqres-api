*** Settings ***
Library  RequestsLibrary
Library  String
Library  Collections

*** Variables ***
${base_url}         https://reqres.in/api/
${reqres_free_key}  reqres-free-v1
&{empty_dict}    

*** Keywords ***

# Cria sessão da API da Reqres.in
Cria Sessão na URL
    ${headers}=    Create Dictionary    x-api-key=${reqres_free_key}    accept=application/json    Content-Type=application/json
    Create Session    ReqRes    ${base_url}    headers=${headers}

Listar Usuários Da Página
    [Arguments]    ${pagina}
    ${response}=    GET On Session    ReqRes    url=users?page=${pagina}
    Should Be Equal As Integers    ${response.status_code}    200
    Dictionary Should Contain Key    ${response.json()}    data
    ${usuarios}=    Get From Dictionary    ${response.json()}    data
    Should Be True    ${usuarios} != []

Buscar Usuário Por ID
    [Arguments]    ${id}
    ${response}=    GET On Session    ReqRes    /users/${id}
    Should Be Equal As Integers    ${response.status_code}    200
    Dictionary Should Contain Key    ${response.json()}    data
    ${usuario}=    Get From Dictionary    ${response.json()}    data
    Should Be Equal As Integers    ${usuario['id']}    ${id}

Buscar Usuário Inexistente
    [Arguments]    ${id}
    ${response}=    GET On Session    ReqRes    /users/${id}    expected_status=404
    Should Be Equal As Integers    ${response.status_code}    404
    Should Be Equal    ${response.json()}    ${empty_dict}

Criar Novo Usuário
    [Arguments]    ${name}    ${job}
    ${payload}=    Create Dictionary    name=${name}    job=${job}
    ${response}=    POST On Session    ReqRes    /users    json=${payload}
    Should Be Equal As Integers    ${response.status_code}    201
    Dictionary Should Contain Key    ${response.json()}    id
    Dictionary Should Contain Key    ${response.json()}    createdAt

Atualizar Usuário
    [Arguments]    ${id}    ${name}    ${job}
    ${payload}=    Create Dictionary    name=${name}    job=${job}
    ${response}=    PUT On Session    ReqRes    /users/${id}    json=${payload}
    Should Be Equal As Integers    ${response.status_code}    200
    Dictionary Should Contain Key    ${response.json()}    updatedAt

Deletar Usuário
    [Arguments]    ${id}
    ${response}=    DELETE On Session    ReqRes    /users/${id}
    Should Be Equal As Integers    ${response.status_code}    204
    Should Be Empty    ${response.content}

Registrar Usuário
    [Arguments]    ${email}    ${password}
    ${payload}=    Create Dictionary    email=${email}    password=${password}
    ${response}=    POST On Session    ReqRes    /register    json=${payload}
    Should Be Equal As Integers    ${response.status_code}    200
    Dictionary Should Contain Key    ${response.json()}    token

Registrar Usuário Sem Senha
    [Arguments]    ${email}
    ${payload}=    Create Dictionary    email=${email}
    ${response}=    POST On Session    ReqRes    /register    json=${payload}    expected_status=400
    Should Be Equal As Integers    ${response.status_code}    400
    Dictionary Should Contain Key    ${response.json()}    error

Login Usuário
    [Arguments]    ${email}    ${password}
    ${payload}=    Create Dictionary    email=${email}    password=${password}
    ${response}=    POST On Session    ReqRes    /login    json=${payload}
    Should Be Equal As Integers    ${response.status_code}    200
    Dictionary Should Contain Key    ${response.json()}    token

Login Usuário Sem Senha
    [Arguments]    ${email}
    ${payload}=    Create Dictionary    email=${email}
    ${response}=    POST On Session    ReqRes    /login    json=${payload}    expected_status=400
    Should Be Equal As Integers    ${response.status_code}    400
    Dictionary Should Contain Key    ${response.json()}    error

Buscar Recurso Desconhecido
    [Arguments]    ${id}
    ${response}=    GET On Session    ReqRes    /unknown/${id}
    Should Be Equal As Integers    ${response.status_code}    200
    Dictionary Should Contain Key    ${response.json()}    data

Buscar Recurso Desconhecido Inexistente
    [Arguments]    ${id}
    ${response}=    GET On Session    ReqRes    /unknown/${id}    expected_status=404
    Should Be Equal As Integers    ${response.status_code}    404
    Should Be Equal    ${response.json()}    ${empty_dict}