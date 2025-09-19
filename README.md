# Bateria de Testes - API Reqres

Este projeto contém uma suíte de testes automatizados para validação da API pública [Reqres](https://reqres.in/), utilizando Robot Framework.

## Estrutura do Projeto

- `tests/resources.robot`: Arquivo de recursos com todos os keywords customizados para interação com a API Reqres.
- `tests/reqresAPITests.robot`: Suíte de testes principal, cobrindo todos os cenários das estórias de usuário.
- `README.md`: Este arquivo de documentação.
- `user_stories.md`: Estórias de usuário e critérios de aceitação utilizados como base para os testes.
- `log.html`, `output.xml`, `report.html`: Relatórios gerados após a execução dos testes.

## O que foi feito

- Implementação de keywords para cada operação da API (listar, buscar, criar, atualizar, deletar usuários, registrar e login).
- Criação de variáveis globais para URL base e chave de API.
- Testes automatizados para todos os cenários descritos nas estórias de usuário, incluindo casos de sucesso e erro (Happy Path e Sad Path).
- Validação dos status de resposta, estrutura dos dados e mensagens de erro conforme documentação da API Reqres.
- Organização dos testes em cenários claros e documentados, facilitando manutenção e entendimento.

## Como executar

1. Instale o [Robot Framework](https://robotframework.org/) e a biblioteca [RequestsLibrary](https://github.com/MarketSquare/RequestsLibrary):
	```bash
	pip install robotframework robotframework-requests
	```
2. Execute a suíte de testes:
	```bash
	robot tests/reqresAPITests.robot
	```
3. Consulte os relatórios gerados (`log.html`, `report.html`) para análise dos resultados.

## Autor

Leonardo Eliel
Unitest Squad

---

Este projeto é apenas para fins de estudo e demonstração de automação de testes de APIs REST.