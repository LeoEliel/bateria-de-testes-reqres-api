*** Settings ***
Documentation    Suite de testes para validação da API reqres. Feito por Leonardo Eliel -- Unitest Squad
Resource    ./login.robot
Resource    ./users.robot
Resource    ./register.robot
Resource    ./unknown.robot
Resource    ./dynamics.robot
*** Test Cases ***
Cenário 1: Listar Usuários de uma página específica
    [Documentation]    Testa a listagem de usuários com paginação, validando estrutura da resposta e dados dos usuários
    [Tags]    API    GET    /users    HappyPath
    Cria Sessão na URL
    Listar Usuários Da Página    2

Cenário 2: Buscar um usuário existente
    [Documentation]    Testa a busca de um usuário específico pelo ID, validando que os dados corretos são retornados
    [Tags]    API    GET    /users/{id}    HappyPath
    Cria Sessão na URL
    Buscar Usuário Por ID    2

Cenário 3: Buscar um usuário inexistente
    [Documentation]    Testa o comportamento da API ao buscar um usuário que não existe, validando erro 404
    [Tags]    API    GET    /users/{id}    SadPath
    Cria Sessão na URL
    ${id_inexistente}=    Gerar ID Inexistente
    Buscar Usuário Inexistente    ${id_inexistente}

Cenário 4: Criar um novo usuário com sucesso
    [Documentation]    Testa a criação de um novo usuário com dados válidos, validando resposta de sucesso
    [Tags]    API    POST    /users    HappyPath
    Cria Sessão na URL
    ${name}    ${job}=    Gerar Dados Completos Para Teste
    Criar Novo Usuário    ${name}    ${job}

Cenário 5: Atualizar um usuário com sucesso
    [Documentation]    Testa a atualização de dados de um usuário existente, validando resposta de sucesso
    [Tags]    API    PUT    /users/{id}    HappyPath
    Cria Sessão na URL
    ${name}    ${job}=    Gerar Dados Completos Para Teste
    Atualizar Usuário    2    ${name}    ${job}

Cenário 6: Deletar um usuário com sucesso
    [Documentation]    Testa a deleção de um usuário, validando que a operação foi bem-sucedida
    [Tags]    API    DELETE    /users/{id}    HappyPath
    Cria Sessão na URL
    Deletar Usuário    2

Cenário 7: Registrar um novo usuário com sucesso
    [Documentation]    Testa o registro de novo usuário com email e senha válidos, validando token de autenticação
    [Tags]    API    POST    /register    HappyPath
    Cria Sessão na URL
    Registrar Usuário    eve.holt@reqres.in    pistol

Cenário 8: Tentar registrar usuário sem senha
    [Documentation]    Testa o comportamento da API ao tentar registrar usuário sem senha, validando erro 400
    [Tags]    API    POST    /register    SadPath
    Cria Sessão na URL
    Registrar Usuário Sem Senha    eve.holt@reqres.in

Cenário 9: Fazer login com sucesso
    [Documentation]    Testa o login com credenciais válidas, validando token de autenticação retornado
    [Tags]    API    POST    /login    HappyPath
    Cria Sessão na URL
    Login Usuário    eve.holt@reqres.in    pistol

Cenário 10: Tentar login sem senha
    [Documentation]    Testa o comportamento da API ao tentar fazer login sem senha, validando erro 400
    [Tags]    API    POST    /login    SadPath
    Cria Sessão na URL
    Login Usuário Sem Senha    eve.holt@reqres.in

Cenário 11: Buscar recurso desconhecido existente
    [Documentation]    Testa a busca de um recurso desconhecido existente, validando estrutura e tipos de dados
    [Tags]    API    GET    /unknown/{id}    HappyPath
    Cria Sessão na URL
    Buscar Recurso Desconhecido    2

Cenário 12: Buscar recurso desconhecido inexistente
    [Documentation]    Testa o comportamento da API ao buscar recurso desconhecido inexistente, validando erro 404
    [Tags]    API    GET    /unknown/{id}    SadPath
    Cria Sessão na URL
    ${id_inexistente}=    Gerar ID Inexistente
    Buscar Recurso Desconhecido Inexistente    ${id_inexistente}