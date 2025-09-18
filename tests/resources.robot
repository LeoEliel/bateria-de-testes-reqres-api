*** Settings ***
Library  RequestsLibrary
Library  String
Library  Collections


*** Variables ***
${base_url}     https://reqres.in/api
${reqres_free_key}     reqres-free-v1

*** Keywords ***

# Cria sessão da API da Resres.in
Cria Sessão na URL
    ${headers}    Create Dictionary  x-api-key=${reqres_free_key}
    Create Session    alias=ReqRes    url=${base_url}    headers=${headers}

