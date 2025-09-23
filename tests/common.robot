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

# Cria sessão da API da Reqres.in
Cria Sessão na URL
    ${headers}=    Create Dictionary    x-api-key=${reqres_free_key}    accept=application/json    Content-Type=application/json
    Create Session    ReqRes    ${base_url}    headers=${headers}