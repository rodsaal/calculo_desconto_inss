# README

# Desafio Técnico Ruby on Rails – Impulso / Credishop

Este é o resultado do desafio técnico proposto pela Impulso / Credshop, implementado em Ruby on Rails 7 com foco em boas práticas, testes automatizados e experiência do usuário.

---

## 🚀 Funcionalidades

### 1. Cadastro de Proponentes
- Nome, CPF, data de nascimento e salário.
- Cálculo assíncrono do desconto do INSS.
- Cadastro de múltiplos endereços e contatos (com possibilidade de tipos repetidos).
- Validações completas via ActiveRecord e mensagens amigáveis.

### 2. Cálculo do INSS
- Baseado na tabela de alíquotas progressivas (2023).
- Realizado de forma automática e assíncrona no formulário.
- Serviço separado (`InssCalculatorService`) para manter a responsabilidade isolada.

### 3. Dashboard com Relatórios
- Listagem paginada dos proponentes (5 por página).
- Gráfico de distribuição de proponentes por faixa salarial (usando Chartkick + Chart.js).
- Ações de ver, editar e excluir proponentes com confirmação via modal.

### 4. Autenticação
- Implementada com Devise.
- Apenas usuários autenticados podem acessar as funcionalidades principais.

### 5. Background Job (Sidekiq + Whenever)
- Job agendado para recalcular os descontos de INSS diariamente.
- Integrado ao Redis e configurado com Cron.

### 6. Testes Automatizados
- Request specs com RSpec.
- Testes cobrindo criação, atualização, exclusão e validação de nested attributes.
- Autenticação simulada com `sign_in` do Devise nos testes.

### 7. Boas Práticas e Organização
- Utilização de `slim-rails` como template engine.
- Rubocop configurado para manter a padronização de código.
- Layout limpo com Bootstrap 5.
- Uso de partials e componentes reutilizáveis.

---

## 🛠️ Tecnologias e Gems

- Ruby 3.0
- Rails 7.1
- PostgreSQL
- Redis
- Devise
- Sidekiq
- Whenever
- RSpec
- FactoryBot + Faker
- Chartkick + Chart.js
- Slim
- Kaminari
- Rubocop

---

## 📦 Como rodar o projeto

1. Clone o repositório 

#### Via HTTPS:

```bash
git clone https://github.com/rodsaal/calculo_desconto_inss.git
cd calculo_desconto_inss
```

#### Ou via SSH:

```bash
git clone git@github.com:rodsaal/calculo_desconto_inss.git
cd calculo_desconto_inss
```

2. Instale as dependencias
```bash
bundle install
yarn install
```

3. Crie o banco de dados
```bash
rails db:create db:migrate db:seed
```

4. Rode o projeto localmente
```bash
bin/dev
```

5. Para executar os testes
```bash
rspec
```

---

## 🙋‍♂️ Autor

**Rodrigo Santos de Almeida**  
[LinkedIn](https://www.linkedin.com/in/rodrigo-almeida-404233a1/) | [GitHub](https://github.com/rodsaal)