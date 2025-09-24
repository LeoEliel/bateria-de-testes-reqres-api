* Settings *
Resource    ../support/fixtures/dynamics.robot

*** Variables ***
${base_url}         https://reqres.in/api/
${reqres_free_key}  reqres-free-v1
&{empty_dict}

*** Keywords ***
Gerar Dados Compartilhados
    [Documentation]    Gera dados de usuário que serão compartilhados entre todos os testes
    ${name}    ${job}=    Gerar Dados De Usuário
    ${email}=    Set Variable    eve.holt@reqres.in
    ${password}=    Gerar Senha Aleatória
    Set Global Variable    ${SHARED_NAME}    ${name}
    Set Global Variable    ${SHARED_JOB}    ${job}
    Set Global Variable    ${SHARED_EMAIL}    ${email}
    Set Global Variable    ${SHARED_PASSWORD}    ${password}