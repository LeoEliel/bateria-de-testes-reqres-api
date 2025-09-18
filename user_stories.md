Histórias de usuário formatadas com Markdown para melhor legibilidade.

---

### **Rota: `/api/users`**

#### **Método: `GET` (Listar Usuários)**

* **Estória:** O usuário deseja listar os usuários cadastrados.
    * **Cenário:** Listar usuários com sucesso.
        * **Dado** que a API está disponível.
        * **Quando** eu fizer uma requisição `GET` para `/api/users`.
        * **Então** a resposta deve ter o status `200 OK`.
        * **E** a resposta deve conter uma lista de usuários.

* **Estória:** O usuário deseja buscar um usuário específico.
    * **Cenário:** Buscar um usuário existente.
        * **Dado** que o usuário com ID `2` existe.
        * **Quando** eu fizer uma requisição `GET` para `/api/users/2`.
        * **Então** a resposta deve ter o status `200 OK`.
        * **E** a resposta deve conter os dados do usuário com ID `2`.
    * **Cenário:** Buscar um usuário inexistente.
        * **Dado** que o usuário com ID `23` não existe.
        * **Quando** eu fizer uma requisição `GET` para `/api/users/23`.
        * **Então** a resposta deve ter o status `404 Not Found`.

#### **Método: `POST` (Criar Usuário)**

* **Estória:** O usuário deseja criar um novo usuário.
    * **Cenário:** Criar um novo usuário com sucesso.
        * **Dado** que eu tenho os dados de um novo usuário (nome e trabalho).
        * **Quando** eu fizer uma requisição `POST` para `/api/users` com os dados do novo usuário.
        * **Então** a resposta deve ter o status `201 Created`.
        * **E** a resposta deve conter o nome, trabalho, ID e data de criação do novo usuário.

#### **Método: `PUT` (Atualizar Usuário)**

* **Estória:** O usuário deseja atualizar os dados de um usuário existente.
    * **Cenário:** Atualizar um usuário com sucesso.
        * **Dado** que o usuário com ID `2` existe.
        * **E** que eu tenho novos dados para este usuário (nome e trabalho).
        * **Quando** eu fizer uma requisição `PUT` para `/api/users/2` com os novos dados.
        * **Então** a resposta deve ter o status `200 OK`.
        * **E** a resposta deve conter os dados atualizados do usuário.

#### **Método: `PATCH` (Atualizar Parcialmente o Usuário)**

* **Estória:** O usuário deseja atualizar parcialmente os dados de um usuário existente.
    * **Cenário:** Atualizar parcialmente um usuário com sucesso.
        * **Dado** que o usuário com ID `2` existe.
        * **E** que eu tenho um novo nome para este usuário.
        * **Quando** eu fizer uma requisição `PATCH` para `/api/users/2` com o novo nome.
        * **Então** a resposta deve ter o status `200 OK`.
        * **E** a resposta deve conter os dados atualizados do usuário.

#### **Método: `DELETE` (Deletar Usuário)**

* **Estória:** O usuário deseja deletar um usuário existente.
    * **Cenário:** Deletar um usuário com sucesso.
        * **Dado** que o usuário com ID `2` existe.
        * **Quando** eu fizer uma requisição `DELETE` para `/api/users/2`.
        * **Então** a resposta deve ter o status `204 No Content`.

---

### **Rota: `/api/register`**

#### **Método: `POST` (Registrar Usuário)**

* **Estória:** O usuário deseja se registrar no sistema.
    * **Cenário:** Registrar um novo usuário com sucesso.
        * **Dado** que eu tenho um email e senha válidos para registro.
        * **Quando** eu fizer uma requisição `POST` para `/api/register` com o email e a senha.
        * **Então** a resposta deve ter o status `200 OK`.
        * **E** a resposta deve conter um `id` e um `token`.
    * **Cenário:** Tentar registrar um usuário sem a senha.
        * **Dado** que eu tenho um email válido para registro, mas não tenho a senha.
        * **Quando** eu fizer uma requisição `POST` para `/api/register` apenas com o email.
        * **Então** a resposta deve ter o status `400 Bad Request`.
        * **E** a resposta deve conter uma mensagem de erro indicando que a senha está faltando.

---

### **Rota: `/api/login`**

#### **Método: `POST` (Fazer Login)**

* **Estória:** O usuário deseja fazer login no sistema.
    * **Cenário:** Fazer login com sucesso.
        * **Dado** que eu tenho um email e senha de um usuário registrado.
        * **Quando** eu fizer uma requisição `POST` para `/api/login` com o email e a senha.
        * **Então** a resposta deve ter o status `200 OK`.
        * **E** a resposta deve conter um `token`.
    * **Cenário:** Tentar fazer login sem a senha.
        * **Dado** que eu tenho um email de um usuário registrado, mas não tenho a senha.
        * **Quando** eu fizer uma requisição `POST` para `/api/login` apenas com o email.
        * **Então** a resposta deve ter o status `400 Bad Request`.
        * **E** a resposta deve conter uma mensagem de erro indicando que a senha está faltando.

---

### **Rota: `/api/unknown`**

#### **Método: `GET` (Listar Recursos Desconhecidos)**

* **Estória:** O usuário deseja listar os recursos desconhecidos.
    * **Cenário:** Listar recursos com sucesso.
        * **Dado** que a API está disponível.
        * **Quando** eu fizer uma requisição `GET` para `/api/unknown`.
        * **Então** a resposta deve ter o status `200 OK`.
        * **E** a resposta deve conter uma lista de recursos.

* **Estória:** O usuário deseja buscar um recurso desconhecido específico.
    * **Cenário:** Buscar um recurso existente.
        * **Dado** que o recurso com ID `2` existe.
        * **Quando** eu fizer uma requisição `GET` para `/api/unknown/2`.
        * **Então** a resposta deve ter o status `200 OK`.
        * **E** a resposta deve conter os dados do recurso com ID `2`.
    * **Cenário:** Buscar um recurso inexistente.
        * **Dado** que o recurso com ID `23` não existe.
        * **Quando** eu fizer uma requisição `GET` para `/api/unknown/23`.
        * **Então** a resposta deve ter o status `404 Not Found`.