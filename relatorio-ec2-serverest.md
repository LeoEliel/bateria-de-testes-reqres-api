# Relatório EC2-AWS: Guia de Implantação da ServeRest

Este documento detalha o procedimento de provisionamento de uma máquina virtual **EC2 (Amazon Elastic Compute Cloud)** na **AWS (Amazon Web Services)** e a subsequente implantação da aplicação **ServeRest**. O relatório também documenta os desafios técnicos encontrados e as soluções implementadas.

---

## 1. Passo a Passo para Subir a ServeRest em uma Máquina EC2

O processo de implantação foi dividido em três fases principais: Configuração de Rede (VPC), Criação da Instância EC2 e Configuração do Ambiente da Aplicação.

### 1.1. Configuração de Rede e VPC
1.  **Login na AWS:** Acesso ao console da AWS com as credenciais de usuário.
2.  **Criação de Virtual Private Cloud (VPC):** Criação de uma rede virtual isolada e personalizada.
3.  **Configuração do Internet Gateway (IGW):** Criação e anexação do *Internet Gateway* à VPC para permitir comunicação com a internet.
4.  **Configuração de Tabelas de Rotas:** Definição de rotas para direcionar o tráfego da sub-rede pública para o *Internet Gateway* (rota `0.0.0.0/0` apontando para o IGW).

### 1.2. Criação e Provisionamento da Instância EC2
5.  **Criação da Instância EC2 (VM):** Lançamento de uma nova instância, escolhendo uma AMI (Amazon Machine Image) Linux.
    * **Configuração de Tags:** Aplicação de *Tags* para identificação (ex: `Name: ec2-pb-aws`).
    * **Habilitação de DHCP:** Garantia de que a instância receba automaticamente um endereço IP privado.
    * **Criação/Seleção do Keypair:** Geração ou seleção do par de chaves (`.pem`) necessário para acesso SSH.
    * **Configuração de Security Group (Regra Crítica Adicional):** Criação de um grupo de segurança para liberar o tráfego de entrada:
        * **Porta 22 (SSH):** Liberada para o IP da sua máquina ou para `0.0.0.0/0` (todos) para acesso.
        * **Porta 3000 (ServeRest):** Liberada para o IP da sua máquina ou para `0.0.0.0/0` para acesso à API.
6.  **Execução da Instância:** Início da instância EC2.

### 1.3. Acesso e Instalação da Aplicação
7.  **Acesso Remoto via SSH:** Conexão à instância utilizando o protocolo SSH e o arquivo `.pem`.
8.  **Atualização de Pacotes:** Execução de comandos para atualizar os pacotes do sistema operacional (ex: `sudo yum update -y`).
9.  **Preparação do Ambiente:** Criação de diretório do projeto e navegação para o mesmo (opcional, já que o `npx` pode ser executado em qualquer lugar).
10. **Instalação do Node.js:** Instalação do *runtime* **Node.js** e do **npm** (Node Package Manager).
11. **Instalação e Execução da ServeRest:** Execução do comando para instalar e iniciar a ServeRest via **npx** (Node Package Execute), que permite rodar o pacote sem instalação global:
    ```bash
    npx serverest@latest
    ```
12. **Validação:** Acesso à API ServeRest (Porta **3000** por padrão) via **Postman** ou navegador, utilizando o **IP Público** da instância EC2.

---

## 2. Desafios Superados (Troubleshooting)

Durante o processo de configuração e implantação, foram enfrentados e solucionados os seguintes desafios:

### Desafio 1: Falha no Lançamento devido a Keypair
* **Problema:** A chave privada (*keypair*), essencial para o acesso SSH, misteriosamente não era reconhecida ou estava inacessível no momento da tentativa de lançamento.
* **Solução:** O arquivo local (`.pem`) da chave inicial foi **apagado**. Em seguida, um **novo *keypair* foi gerado** no console da AWS e baixado, permitindo a sequência no processo de configuração da instância no EC2.

### Desafio 2: Perda de Conectividade Externa (Internet Gateway)
* **Problema:** O *Internet Gateway* (IGW) da VPC sumiu repentinamente após a criação da instância, impedindo a conexão via SSH (porta 22).
* **Solução:** Foi necessário **recriar o *Internet Gateway***, anexá-lo à VPC e, para garantir a correta associação dos recursos de rede, a **instância EC2 também foi recriada**.

### Desafio 3: Falha na Conexão SSH usando DNS Público
* **Problema:** A tentativa de conexão SSH utilizando o **DNS público** (hostname) fornecido pela AWS resultou em falha (timeout):
    ```bash
    ssh -i "ec2-pb-aws.pem" ec2-user@ec2-54-210-146-141.compute-1.amazonaws.com
    ```
* **Solução:** O problema foi resolvido ao **substituir o endereço de DNS pelo endereço de IP Público** da máquina no comando SSH, garantindo uma conexão direta e funcional:
    ```bash
    ssh -i "ec2-pb-aws.pem" ec2-user@54.210.146.141
    ```

---

## Próximos Passos
Este relatório deve ser **commitado** no repositório Git, na *branch* da Sprint de cada membro da Squad de forma individual.