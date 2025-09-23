*** Settings ***
Library  RequestsLibrary
Library  String
Library  Collections
Library  FakerLibrary

*** Variables ***
${base_url}         https://reqres.in/api/
${reqres_free_key}  reqres-free-v1
&{empty_dict}    

*** Keywords ***

# Setup e Teardown
Setup Teste
    [Documentation]    Configura sessão HTTP antes de cada teste
    ${headers}=    Create Dictionary    x-api-key=${reqres_free_key}    accept=application/json    Content-Type=application/json
    Create Session    ReqRes    ${base_url}    headers=${headers}

Teardown Teste
    [Documentation]    Limpa sessão HTTP após cada teste
    Delete All Sessions

# Cria sessão da API da Reqres.in (mantido para compatibilidade)
Cria Sessão na URL
    [Documentation]    Cria sessão HTTP para a API Reqres (deprecated - use Setup Teste)
    ${headers}=    Create Dictionary    x-api-key=${reqres_free_key}    accept=application/json    Content-Type=application/json
    Create Session    ReqRes    ${base_url}    headers=${headers}