*** Settings ***
Resource  common.robot

*** Keywords ***

Gerar Nome De Usuário
    [Documentation]    Gera nome aleatório para testes de usuário
    [Tags]    DataGeneration    Faker    Users
    ${name}=    FakerLibrary.Name
    RETURN    ${name}

Gerar Profissão De Usuário
    [Documentation]    Gera profissão aleatória para testes de usuário
    [Tags]    DataGeneration    Faker    Users
    ${job}=     FakerLibrary.Job
    RETURN    ${job}

Gerar Email Válido
    [Documentation]    Gera um endereço de email aleatório válido
    [Tags]    DataGeneration    Faker    Email
    ${email}=    FakerLibrary.Email
    RETURN    ${email}

Gerar Senha Aleatória
    [Documentation]    Gera uma senha aleatória com 8 caracteres
    [Tags]    DataGeneration    Faker    Password
    ${password}=    FakerLibrary.Password    length=8
    RETURN    ${password}

Gerar ID Inexistente
    [Documentation]    Gera um ID aleatório entre 100-999 para testes de recursos inexistentes
    [Tags]    DataGeneration    Faker    ID    SadPath
    ${id}=    FakerLibrary.Random Int    min=100    max=999
    RETURN    ${id}

Gerar Dados Completos Para Teste
    [Documentation]    Gera conjunto completo de dados para testes (nome, profissão, email, senha e ID inexistente)
    [Tags]    DataGeneration    Faker    Complete
    ${name}=    Gerar Nome De Usuário
    ${job}=    Gerar Profissão De Usuário
    ${email}=    Gerar Email Válido
    ${password}=    Gerar Senha Aleatória
    ${id_inexistente}=    Gerar ID Inexistente
    RETURN    ${name}    ${job}    ${email}    ${password}    ${id_inexistente}