*** Settings ***
Library  RequestsLibrary
Resource  ../../variaveis/reqres_variaveis.robot

*** Keywords ***

# Setup e Teardown
Setup Teste
    [Documentation]    Configura sessão HTTP antes de cada teste
    ${headers}=    Create Dictionary    x-api-key=${reqres_free_key}    accept=application/json    Content-Type=application/json
    Create Session    ReqRes    ${base_url}    headers=${headers}

Teardown Teste
    [Documentation]    Limpa sessão HTTP após cada teste
    Delete All Sessions