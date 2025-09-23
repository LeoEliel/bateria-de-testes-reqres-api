*** Settings ***
Resource  common.robot

*** Keywords ***

Gerar Dados De Usuário
    ${name}=    FakerLibrary.Name
    ${job}=     FakerLibrary.Job
    RETURN    ${name}    ${job}

Gerar Email Válido
    ${email}=    FakerLibrary.Email
    RETURN    ${email}

Gerar Senha Aleatória
    ${password}=    FakerLibrary.Password    length=8
    RETURN    ${password}

Gerar ID Inexistente
    ${id}=    FakerLibrary.Random Int    min=100    max=999
    RETURN    ${id}

Gerar Dados Completos Para Teste
    ${name}    ${job}=    Gerar Dados De Usuário
    ${email}=    Gerar Email Válido
    ${password}=    Gerar Senha Aleatória
    ${id_inexistente}=    Gerar ID Inexistente
    RETURN    ${name}    ${job}    ${email}    ${password}    ${id_inexistente}