*** Settings ***
Documentation    Suite de testes para validação da do endpoint /unknown  API reqres. Feito por Leonardo Eliel -- Unitest Squad
Resource    ../keywords/unknown_keywords.robot
Resource    ../variaveis/reqres_variaveis.robot

Test Setup    Setup Teste
Test Teardown    Teardown Teste

*** Test Cases ***
Cenário 11: Buscar recurso desconhecido existente
    [Documentation]    Testa a busca de um recurso desconhecido existente, validando estrutura e tipos de dados
    [Tags]    API    GET    /unknown/{id}    HappyPath
    Buscar Recurso Desconhecido    2

Cenário 12: Buscar recurso desconhecido inexistente
    [Documentation]    Testa o comportamento da API ao buscar recurso desconhecido inexistente, validando erro 404
    [Tags]    API    GET    /unknown/{id}    SadPath
    ${id_inexistente}=    Gerar ID Inexistente
    Buscar Recurso Desconhecido Inexistente    ${id_inexistente}