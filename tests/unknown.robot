*** Settings ***
Resource  common.robot

*** Keywords ***

Fazer Requisição GET Para Buscar Recurso Desconhecido
    [Arguments]    ${id}
    ${response}=    GET On Session    ReqRes    /unknown/${id}
    RETURN    ${response}

Buscar Recurso Desconhecido
    [Arguments]    ${id}
    ${response}=    Fazer Requisição GET Para Buscar Recurso Desconhecido    ${id}
    Should Be Equal As Integers    ${response.status_code}    200
    Dictionary Should Contain Key    ${response.json()}    data
    ${recurso}=    Get From Dictionary    ${response.json()}    data
    Dictionary Should Contain Key    ${recurso}    id
    Dictionary Should Contain Key    ${recurso}    name
    Dictionary Should Contain Key    ${recurso}    year
    Dictionary Should Contain Key    ${recurso}    color
    Dictionary Should Contain Key    ${recurso}    pantone_value
    Should Be True    isinstance(${recurso['id']}, int)
    Should Be String    ${recurso['name']}
    Should Be True    isinstance(${recurso['year']}, int)
    Should Be String    ${recurso['color']}
    Should Be String    ${recurso['pantone_value']}

Fazer Requisição GET Para Buscar Recurso Desconhecido Inexistente
    [Arguments]    ${id}
    ${response}=    GET On Session    ReqRes    /unknown/${id}    expected_status=404
    RETURN    ${response}

Buscar Recurso Desconhecido Inexistente
    [Arguments]    ${id}
    ${response}=    Fazer Requisição GET Para Buscar Recurso Desconhecido Inexistente    ${id}
    Should Be Equal As Integers    ${response.status_code}    404
    Should Be Equal    ${response.json()}    ${empty_dict}