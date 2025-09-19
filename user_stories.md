Abaixo estão as estórias de usuário,com os Critérios de Aceitação detalhados para cada cenário.

---

### **Rota: `/api/users`**

#### **Método: `GET` (Listar Usuários)**

* **Estória:** O usuário deseja listar os usuários cadastrados em uma página específica.
    * **Cenário:** Listar usuários com sucesso para uma página específica.
        * **Dado** que a API está disponível.
        * **Quando** eu fizer uma requisição `GET` para `/api/users?page=2`.
        * **Então** a resposta deve ter o status `200 OK`.
        * **E** a resposta deve conter uma lista de usuários da página 2.
        * **Critérios de Aceitação:**
            * O `status code` da resposta HTTP deve ser `200`.
            * O corpo da resposta deve ser um objeto JSON contendo as chaves: `page`, `per_page`, `total`, `total_pages`, e `data`.
            * O valor da chave `page` deve ser `2`.
            * A chave `data` deve ser um array de objetos de usuário.
            * Cada objeto de usuário no array `data` deve conter as chaves: `id`, `email`, `first_name`, `last_name`, e `avatar`.

* **Estória:** O usuário deseja buscar um usuário específico.
    * **Cenário:** Buscar um usuário existente.
        * **Dado** que o usuário com ID `2` existe.
        * **Quando** eu fizer uma requisição `GET` para `/api/users/2`.
        * **Então** a resposta deve ter o status `200 OK`.
        * **E** a resposta deve conter os dados do usuário com ID `2`.
        * **Critérios de Aceitação:**
            * O `status code` da resposta HTTP deve ser `200`.
            * O corpo da resposta deve ser um objeto JSON.
            * O JSON deve conter uma chave `data`.
            * O objeto dentro de `data` deve ter uma chave `id` com o valor `2`.
            * O objeto dentro de `data` deve conter chaves não nulas para `email`, `first_name`, `last_name`, e `avatar`.

    * **Cenário:** Buscar um usuário inexistente.
        * **Dado** que o usuário com ID `23` não existe.
        * **Quando** eu fizer uma requisição `GET` para `/api/users/23`.
        * **Então** a resposta deve ter o status `404 Not Found`.
        * **Critérios de Aceitação:**
            * O `status code` da resposta HTTP deve ser `404`.
            * O corpo da resposta deve estar vazio.

#### **Método: `POST` (Criar Usuário)**

* **Estória:** O usuário deseja criar um novo usuário.
    * **Cenário:** Criar um novo usuário com sucesso.
        * **Dado** que eu tenho os dados de um novo usuário (nome e trabalho).
        * **Quando** eu fizer uma requisição `POST` para `/api/users` com os dados do novo usuário.
        * **Então** a resposta deve ter o status `201 Created`.
        * **E** a resposta deve conter os dados do usuário criado.
        * **Critérios de Aceitação:**
            * O `status code` da resposta HTTP deve ser `201`.
            * O corpo da resposta deve ser um objeto JSON.
            * O JSON deve conter as chaves `name` e `job` com os mesmos valores enviados na requisição.
            * O JSON deve conter uma chave `id` (string) e uma chave `createdAt` (timestamp).

#### **Método: `PUT` (Atualizar Usuário)**

* **Estória:** O usuário deseja atualizar os dados de um usuário existente.
    * **Cenário:** Atualizar um usuário com sucesso.
        * **Dado** que o usuário com ID `2` existe.
        * **E** que eu tenho novos dados para este usuário (nome e trabalho).
        * **Quando** eu fizer uma requisição `PUT` para `/api/users/2` com os novos dados.
        * **Então** a resposta deve ter o status `200 OK`.
        * **E** a resposta deve conter os dados atualizados.
        * **Critérios de Aceitação:**
            * O `status code` da resposta HTTP deve ser `200`.
            * O corpo da resposta deve ser um objeto JSON.
            * O JSON deve conter as chaves `name` e `job` com os valores atualizados.
            * O JSON deve conter a chave `updatedAt` com um timestamp recente.

#### **Método: `DELETE` (Deletar Usuário)**

* **Estória:** O usuário deseja deletar um usuário existente.
    * **Cenário:** Deletar um usuário com sucesso.
        * **Dado** que o usuário com ID `2` existe.
        * **Quando** eu fizer uma requisição `DELETE` para `/api/users/2`.
        * **Então** a resposta deve ter o status `204 No Content`.
        * **Critérios de Aceitação:**
            * O `status code` da resposta HTTP deve ser `204`.
            * O corpo da resposta deve estar vazio.

---

### **Rota: `/api/register`**

#### **Método: `POST` (Registrar Usuário)**

* **Estória:** O usuário deseja se registrar no sistema.
    * **Cenário:** Registrar um novo usuário com sucesso.
        * **Dado** que eu tenho um email (`eve.holt@reqres.in`) e senha válidos.
        * **Quando** eu fizer uma requisição `POST` para `/api/register` com o email e a senha.
        * **Então** a resposta deve ter o status `200 OK`.
        * **E** a resposta deve conter um `id` e um `token`.
        * **Critérios de Aceitação:**
            * O `status code` da resposta HTTP deve ser `200`.
            * O corpo da resposta deve ser um objeto JSON.
            * O JSON deve conter uma chave `id` com valor numérico.
            * O JSON deve conter uma chave `token` com valor de string não nulo.

    * **Cenário:** Tentar registrar um usuário sem a senha.
        * **Dado** que eu tenho um email válido mas não informo a senha.
        * **Quando** eu fizer uma requisição `POST` para `/api/register` apenas com o email.
        * **Então** a resposta deve ter o status `400 Bad Request`.
        * **E** a resposta deve conter uma mensagem de erro.
        * **Critérios de Aceitação:**
            * O `status code` da resposta HTTP deve ser `400`.
            * O corpo da resposta deve ser um objeto JSON.
            * O JSON deve conter uma chave `error` com o valor `"Missing password"`.

---

### **Rota: `/api/login`**

#### **Método: `POST` (Fazer Login)**

* **Estória:** O usuário deseja fazer login no sistema.
    * **Cenário:** Fazer login com sucesso.
        * **Dado** que eu tenho um email e senha de um usuário registrado.
        * **Quando** eu fizer uma requisição `POST` para `/api/login` com o email e a senha.
        * **Então** a resposta deve ter o status `200 OK`.
        * **E** a resposta deve conter um `token`.
        * **Critérios de Aceitação:**
            * O `status code` da resposta HTTP deve ser `200`.
            * O corpo da resposta deve ser um objeto JSON.
            * O JSON deve conter uma chave `token` com valor de string não nulo.

    * **Cenário:** Tentar fazer login sem a senha.
        * **Dado** que eu tenho um email de um usuário registrado, mas não tenho a senha.
        * **Quando** eu fizer uma requisição `POST` para `/api/login` apenas com o email.
        * **Então** a resposta deve ter o status `400 Bad Request`.
        * **E** a resposta deve conter uma mensagem de erro.
        * **Critérios de Aceitação:**
            * O `status code` da resposta HTTP deve ser `400`.
            * O corpo da resposta deve ser um objeto JSON.
            * O JSON deve conter uma chave `error` com o valor `"Missing password"`.

---

### **Rota: `/api/unknown`**

#### **Método: `GET` (Listar Recursos Desconhecidos)**

* **Estória:** O usuário deseja buscar um recurso desconhecido específico.
    * **Cenário:** Buscar um recurso existente.
        * **Dado** que o recurso com ID `2` existe.
        * **Quando** eu fizer uma requisição `GET` para `/api/unknown/2`.
        * **Então** a resposta deve ter o status `200 OK`.
        * **E** a resposta deve conter os dados do recurso.
        * **Critérios de Aceitação:**
            * O `status code` da resposta HTTP deve ser `200`.
            * O corpo da resposta deve ser um objeto JSON com uma chave `data`.
            * O objeto `data` deve conter as chaves `id`, `name`, `year`, `color`, e `pantone_value`.
            * O valor de `data.id` deve ser `2`.

    * **Cenário:** Buscar um recurso inexistente.
        * **Dado** que o recurso com ID `23` não existe.
        * **Quando** eu fizer uma requisição `GET` para `/api/unknown/23`.
        * **Então** a resposta deve ter o status `404 Not Found`.
        * **Critérios de Aceitação:**
            * O `status code` da resposta HTTP deve ser `404`.
            * O corpo da resposta deve ser um objeto JSON vazio `{}`.