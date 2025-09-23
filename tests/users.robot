*** Settings ***
Resource  common.robot

*** Keywords ***

#Listar Usuários Da Página
#    [Arguments]    ${pagina}    ${por_pagina}
#    ${response}=    Fazer Requisição GET Para Listar Usuários    ${pagina}    ${por_pagina}
#    Validar Resposta Da Listagem De Usuários    ${response}

Fazer Requisição GET Para Listar Usuários
    [Arguments]    ${pagina}=1
    ${response}=    GET On Session    ReqRes    url=users?page=${pagina}
    RETURN    ${response}

Listar Usuários Da Página
    [Arguments]    ${pagina}=1
    ${response}=    Fazer Requisição GET Para Listar Usuários    ${pagina}
    Validar Resposta Da Listagem De Usuários    ${response}

Validar Resposta Da Listagem De Usuários
    [Arguments]    ${response}
    Should Be Equal As Integers    ${response.status_code}    200
    ${json_response}=    Set Variable    ${response.json()}
    Dictionary Should Contain Key    ${json_response}    page
    Dictionary Should Contain Key    ${json_response}    per_page
    Dictionary Should Contain Key    ${json_response}    total
    Dictionary Should Contain Key    ${json_response}    total_pages
    Dictionary Should Contain Key    ${json_response}    data
    Should Be True    isinstance(${json_response['page']}, int)
    Should Be True    isinstance(${json_response['per_page']}, int)
    Should Be True    isinstance(${json_response['total']}, int)
    Should Be True    isinstance(${json_response['total_pages']}, int)
    ${usuarios}=    Get From Dictionary    ${json_response}    data
    Should Be True    ${usuarios} != []
    FOR    ${usuario}    IN    @{usuarios}
        Dictionary Should Contain Key    ${usuario}    id
        Dictionary Should Contain Key    ${usuario}    email
        Dictionary Should Contain Key    ${usuario}    first_name
        Dictionary Should Contain Key    ${usuario}    last_name
        Dictionary Should Contain Key    ${usuario}    avatar
        Should Be True    isinstance(${usuario['id']}, int)
        Should Be String    ${usuario['email']}
        Should Be String    ${usuario['first_name']}
        Should Be String    ${usuario['last_name']}
        Should Be String    ${usuario['avatar']}
    END
    

Fazer Requisição GET Para Buscar Usuário
    [Arguments]    ${id}
    ${response}=    GET On Session    ReqRes    /users/${id}
    RETURN    ${response}

Buscar Usuário Por ID
    [Arguments]    ${id}
    ${response}=    Fazer Requisição GET Para Buscar Usuário    ${id}
    Should Be Equal As Integers    ${response.status_code}    200
    Dictionary Should Contain Key    ${response.json()}    data
    ${usuario}=    Get From Dictionary    ${response.json()}    data
    Should Be Equal As Integers    ${usuario['id']}    ${id}

Buscar Usuário Inexistente
    [Arguments]    ${id}
    ${response}=    GET On Session    ReqRes    /users/${id}    expected_status=404
    Should Be Equal As Integers    ${response.status_code}    404
    Should Be Equal    ${response.json()}    ${empty_dict}

Fazer Requisição POST Para Criar Usuário
    [Arguments]    ${name}    ${job}
    ${payload}=    Create Dictionary    name=${name}    job=${job}
    ${response}=    POST On Session    ReqRes    /users    json=${payload}
    RETURN    ${response}

Criar Novo Usuário
    [Arguments]    ${name}    ${job}
    ${response}=    Fazer Requisição POST Para Criar Usuário    ${name}    ${job}
    Should Be Equal As Integers    ${response.status_code}    201
    Dictionary Should Contain Key    ${response.json()}    id
    Dictionary Should Contain Key    ${response.json()}    createdAt

Fazer Requisição PUT Para Atualizar Usuário
    [Arguments]    ${id}    ${name}    ${job}
    ${payload}=    Create Dictionary    name=${name}    job=${job}
    ${response}=    PUT On Session    ReqRes    /users/${id}    json=${payload}
    RETURN    ${response}

Atualizar Usuário
    [Arguments]    ${id}    ${name}    ${job}
    ${response}=    Fazer Requisição PUT Para Atualizar Usuário    ${id}    ${name}    ${job}
    Should Be Equal As Integers    ${response.status_code}    200
    Dictionary Should Contain Key    ${response.json()}    updatedAt

Fazer Requisição DELETE Para Deletar Usuário
    [Arguments]    ${id}
    ${response}=    DELETE On Session    ReqRes    /users/${id}
    RETURN    ${response}

Deletar Usuário
    [Arguments]    ${id}
    ${response}=    Fazer Requisição DELETE Para Deletar Usuário    ${id}
    Should Be Equal As Integers    ${response.status_code}    204
    Should Be Empty    ${response.content}