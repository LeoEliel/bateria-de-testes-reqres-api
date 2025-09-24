*** Settings ***
Resource    ../support/common/base.robot
Library  String
Library  Collections

*** Keywords ***

Fazer Requisição GET Para Listar Usuários
    [Documentation]    Executa requisição GET para listar usuários de uma página específica, trazendo 6 por página por padrão.
    [Tags]    GET    Request    Users
    [Arguments]    ${page}=1    ${per_page}=6
    ${response}=    GET On Session    ReqRes    url=users?page=${page}&per_page=${per_page}
    RETURN    ${response}
Fazer Requisição GET Para Buscar Usuário
    [Documentation]    Executa requisição GET para buscar um usuário específico pelo ID
    [Tags]    GET    Request    Users
    [Arguments]    ${id}
    ${response}=    GET On Session    ReqRes    /users/${id}
    RETURN    ${response}
Fazer Requisição GET Para Buscar Usuário Inexistente
    [Documentation]    Executa requisição GET para buscar um usuário que não existe
    [Tags]    GET    Request    Users    SadPath
    [Arguments]    ${id}
    ${response}=    GET On Session    ReqRes    /users/${id}    expected_status=404
    RETURN    ${response}

Fazer Requisição DELETE Para Deletar Usuário
    [Documentation]    Executa requisição DELETE para remover um usuário
    [Tags]    DELETE    Request    Users    Erase
    [Arguments]    ${id}
    ${response}=    DELETE On Session    ReqRes    /users/${id}
    RETURN    ${response}

Fazer Requisição POST Para Criar Usuário
    [Documentation]    Executa requisição POST para criar um novo usuário
    [Tags]    POST    Request    Users    Create
    [Arguments]    ${name}    ${job}
    ${payload}=    Create Dictionary    name=${name}    job=${job}
    ${response}=    POST On Session    ReqRes    /users    json=${payload}
    RETURN    ${response}
Fazer Requisição PUT Para Atualizar Usuário
    [Documentation]    Executa requisição PUT para atualizar dados de um usuário existente
    [Tags]    PUT    Request    Users    Update
    [Arguments]    ${id}    ${name}    ${job}
    ${payload}=    Create Dictionary    name=${name}    job=${job}
    ${response}=    PUT On Session    ReqRes    /users/${id}    json=${payload}
    RETURN    ${response}
Listar Usuários Da Página
    [Documentation]    Lista usuários de uma página específica e valida a resposta
    [Tags]    GET    Users    HappyPath
    [Arguments]    ${pagina}=1
    ${response}=    Fazer Requisição GET Para Listar Usuários    ${pagina}
    Validar Resposta Da Listagem De Usuários    ${response}


Buscar Usuário Por ID
    [Documentation]    Busca um usuário pelo ID e valida a resposta
    [Tags]    GET    Users    HappyPath
    [Arguments]    ${id}
    ${response}=    Fazer Requisição GET Para Buscar Usuário    ${id}
    Validar Resposta De Busca De Usuário    ${response}    ${id}
Buscar Usuário Inexistente
    [Documentation]    Tenta buscar um usuário inexistente e valida o erro 404
    [Tags]    GET    Users    SadPath    404
    [Arguments]    ${id}
    ${response}=    Fazer Requisição GET Para Buscar Usuário Inexistente    ${id}
    Validar Resposta De Usuário Inexistente    ${response}
Criar Novo Usuário
    [Documentation]    Cria um novo usuário e valida a resposta de criação
    [Tags]    POST    Users    Create    HappyPath
    [Arguments]    ${name}    ${job}
    ${response}=    Fazer Requisição POST Para Criar Usuário    ${name}    ${job}
    Validar Resposta De Criação De Usuário    ${response}
Atualizar Usuário
    [Documentation]    Atualiza dados de um usuário e valida a resposta de atualização
    [Tags]    PUT    Users    Update    HappyPath
    [Arguments]    ${id}    ${name}    ${job}
    ${response}=    Fazer Requisição PUT Para Atualizar Usuário    ${id}    ${name}    ${job}
    Validar Resposta De Atualização De Usuário    ${response}
Deletar Usuário
    [Documentation]    Deleta um usuário e valida a resposta de deleção
    [Tags]    DELETE    Users    Erase    HappyPath
    [Arguments]    ${id}
    ${response}=    Fazer Requisição DELETE Para Deletar Usuário    ${id}
    Validar Resposta De Deleção De Usuário    ${response}


Validar Resposta Da Listagem De Usuários
    [Documentation]    Valida estrutura da resposta de listagem de usuários incluindo paginação e dados dos usuários
    [Tags]    Validation    Users    Pagination
    [Arguments]    ${response}
    Log To Console    ${response}
    Status Should Be    200    ${response}
    ${json}=    Set Variable    ${response.json()}
    FOR    ${field}    IN    page    per_page    total    total_pages
        Dictionary Should Contain Key    ${json}    ${field}
        Should Be True    isinstance(${json['${field}']}, int)
    END
    Dictionary Should Contain Key    ${json}    data
    Should Be True    ${json['data']} != []
    FOR    ${user}    IN    @{json['data']}
        FOR    ${field}    IN    id    email    first_name    last_name    avatar
            Dictionary Should Contain Key    ${user}    ${field}
        END
        Should Be True    isinstance(${user['id']}, int)
        FOR    ${field}    IN    email    first_name    last_name    avatar
            Should Be String    ${user['${field}']}
        END
    END
Validar Resposta De Atualização De Usuário
    [Documentation]    Valida que o usuário foi atualizado com sucesso e contém data de atualização
    [Tags]    Validation    Users    Update    200
    [Arguments]    ${response}
    Status Should Be    200    ${response}
    Dictionary Should Contain Key    ${response.json()}    updatedAt
Validar Resposta De Deleção De Usuário
    [Documentation]    Valida que o usuário foi deletado com sucesso (status 204 e conteúdo vazio)
    [Tags]    Validation    Users    Erase    204
    [Arguments]    ${response}
    Status Should Be    204    ${response}
    Should Be Empty    ${response.content}
Validar Resposta De Busca De Usuário
    [Documentation]    Valida se a resposta contém os dados corretos do usuário buscado
    [Tags]    Validation    Users    HappyPath
    [Arguments]    ${response}    ${id}
    Status Should Be    200    ${response}
    Should Be Equal As Integers    ${response.json()['data']['id']}    ${id}
Validar Resposta De Usuário Inexistente
    [Documentation]    Valida que a resposta retorna erro 404 para usuário inexistente
    [Tags]    Validation    Users    SadPath    404
    [Arguments]    ${response}
    Status Should Be    404    ${response}
    Should Be Equal    ${response.json()}    ${empty_dict}
Validar Resposta De Criação De Usuário
    [Documentation]    Valida que o usuário foi criado com sucesso (status 201) e contém ID e data de criação
    [Tags]    Validation    Users    Create    201
    [Arguments]    ${response}
    Status Should Be    201    ${response}
    FOR    ${field}    IN    id    createdAt
        Dictionary Should Contain Key    ${response.json()}    ${field}
    END