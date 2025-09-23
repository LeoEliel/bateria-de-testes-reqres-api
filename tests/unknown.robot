*** Settings ***
Resource  common.robot

*** Keywords ***

Fazer Requisição GET Para Buscar Recurso Desconhecido
    [Documentation]    Executa requisição GET para buscar um recurso desconhecido pelo ID
    [Tags]    GET    Request    Unknown    Resource
    [Arguments]    ${id}
    RETURN    GET On Session    ReqRes    /unknown/${id}

Fazer Requisição GET Para Buscar Recurso Desconhecido Inexistente
    [Documentation]    Executa requisição GET para buscar um recurso desconhecido que não existe
    [Tags]    GET    Request    Unknown    Resource    SadPath
    [Arguments]    ${id}
    RETURN    GET On Session    ReqRes    /unknown/${id}    expected_status=404

Validar Resposta De Recurso Desconhecido
    [Documentation]    Valida estrutura e tipos de dados do recurso desconhecido retornado
    [Tags]    Validation    Unknown    Resource    HappyPath    200
    [Arguments]    ${response}
    Should Be Equal As Integers    ${response.status_code}    200
    ${resource}=    Set Variable    ${response.json()['data']}
    FOR    ${field}    IN    id    name    year    color    pantone_value
        Dictionary Should Contain Key    ${resource}    ${field}
    END
    Should Be True    isinstance(${resource['id']}, int)
    Should Be True    isinstance(${resource['year']}, int)
    FOR    ${field}    IN    name    color    pantone_value
        Should Be String    ${resource['${field}']}
    END

Validar Resposta De Recurso Desconhecido Inexistente
    [Documentation]    Valida que a busca por recurso inexistente retorna erro 404
    [Tags]    Validation    Unknown    Resource    SadPath    404
    [Arguments]    ${response}
    Should Be Equal As Integers    ${response.status_code}    404
    Should Be Equal    ${response.json()}    ${empty_dict}

Buscar Recurso Desconhecido
    [Documentation]    Busca um recurso desconhecido pelo ID e valida a resposta
    [Tags]    GET    Unknown    Resource    HappyPath
    [Arguments]    ${id}
    ${response}=    Fazer Requisição GET Para Buscar Recurso Desconhecido    ${id}
    Validar Resposta De Recurso Desconhecido    ${response}

Buscar Recurso Desconhecido Inexistente
    [Documentation]    Tenta buscar um recurso desconhecido inexistente e valida o erro 404
    [Tags]    GET    Unknown    Resource    SadPath    404
    [Arguments]    ${id}
    ${response}=    Fazer Requisição GET Para Buscar Recurso Desconhecido Inexistente    ${id}
    Validar Resposta De Recurso Desconhecido Inexistente    ${response}