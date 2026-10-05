# Desi & João — Site de Casamento

Site do casamento de Desi & João (19 de Junho de 2027, São Paulo).
Tema visual celestial (céu estrelado + dourado) inspirado no `save_the_date.jpeg`.

## Stack

- **Ruby** 3.3.8 (via rbenv)
- **Rails** 8.1
- **PostgreSQL** 16
- **Tailwind CSS** 4 (via `tailwindcss-rails`) + Propshaft
- **Hotwire** (Turbo + Stimulus)
- **Active Storage** (disco local) para upload de imagens
- **Trix** (rich-text editor) no admin, via importmap

## Pré-requisitos

Antes de começar, garanta que tem instalado:

```bash
ruby -v          # precisa de 3.3.x (rbenv recomendado)
psql --version   # PostgreSQL 16
```

Se não tem o Ruby 3.3.8 via rbenv:

```bash
rbenv install 3.3.8
```

## Primeira instalação

```bash
# 1. Usar a versão certa do Ruby no projeto
rbenv local 3.3.8

# 2. Instalar as gems do projeto
bundle install

# 3. Iniciar o PostgreSQL (uma vez por boot, se não estiver rodando)
brew services start postgresql@16

# 4. Criar o banco de dados e rodar as migrations
bin/rails db:create db:migrate

# 5. Popular o conteúdo inicial das páginas (seeds)
bin/rails db:seed

# 6. (Opcional) Recompilar o CSS do Tailwind
bin/rails tailwindcss:build
```

## Rodando o projeto

```bash
bin/dev
```

Isso sobe dois processos juntos via Foreman:

- **web:** servidor Rails em `http://localhost:3000`
- **css:** watch do Tailwind (recompila o CSS automaticamente quando você edita `app/assets/tailwind/application.css`)

Abra `http://localhost:3000` no navegador.

> Se a porta 3000 estiver ocupada (`Errno::EADDRINUSE`):
> ```bash
> lsof -ti:3000 | xargs kill -9
> rm -f tmp/pids/server.pid
> ```

### Alternativa (sem Foreman)

Em dois terminais separados:

```bash
# Terminal 1 — servidor
bin/rails server

# Terminal 2 — watch do Tailwind
bin/rails tailwindcss:watch
```

## Páginas do site

| Rota          | Página              |
|---------------|--------------------|
| `/`           | Home (Save the Date)|
| `/info`       | O Casamento        |
| `/travel`     | Dicas de Viagem    |
| `/rsvp`       | Confirmação de presença *(em breve — Parte 3)* |

## Área administrativa

### Editando conteúdo (edit in place)

A forma mais fácil de editar é direto pelo site:

1. Acesse `http://localhost:3000/admin` e faça login (uma vez por sessão do navegador):
   ```
   usuário: admin
   senha:   desi_e_joao_2027
   ```
2. Depois de logar, navegue pelo site normal (`/`, `/info`, `/travel`).
3. Cada texto editável mostra um botão **"Editar"** ao passar o mouse — clique e edite ali mesmo (editor rich-text Trix). Salvar atualiza no lugar, sem recarregar a página.
4. Na galeria de viagem (`/travel`), aparece **"＋ Adicionar imagem"** e botões **"Remover"** em cada foto.
5. Uma barra dourada no rodapé indica **"✦ Modo edição ativo"**.

> Para sair do modo edição: feche o navegador (Basic Auth fica em cache até fechar).

### Painel admin tradicional (fallback)

`http://localhost:3000/admin` também tem um painel completo, caso prefira:

- **Dashboard** — visão geral
- **Seções** — listar/criar/editar/remover seções de texto
- **Imagens** — listar/upload/remover imagens

> Para mudar a senha, edite o [.env](.env) e reinicie o servidor.

## Estrutura do conteúdo editável

O conteúdo das páginas está no banco, na tabela `page_sections`,
identificado por `page` + `name` (chave única). Exemplos:

| page   | name                | o que é                          |
|--------|---------------------|----------------------------------|
| home   | save_the_date       | título "Save the Date"           |
| home   | name_1 / name_2     | nomes dos noivos                 |
| home   | date / location     | data e local                     |
| info   | intro               | parágrafo de introdução          |
| info   | schedule            | ordem da cerimônia (HTML)       |
| info   | map_embed_url       | URL do mapa do Google Maps       |
| travel | stay_body           | texto de hospedagem             |
| travel | flights_body        | texto de voos                   |

Imagens ficam em `page_images`, identificadas por `page` + `section`
(ex: `travel` / `gallery` para a galeria de viagem).

## Estrutura de pastas

```
app/
├── assets/
│   ├── images/            # suas imagens (fundo, monograma, uploads via admin)
│   ├── tailwind/application.css  # CSS source (edite aqui)
│   └── builds/tailwind.css       # build gerado (não edite)
├── controllers/
│   ├── pages_controller.rb       # páginas públicas
│   └── admin/                    # área admin (Basic Auth)
├── models/
│   ├── page_section.rb           # conteúdo de texto
│   └── page_image.rb             # imagens (Active Storage)
└── views/
    ├── layouts/application.html.erb       # layout público
    ├── layouts/admin/application.html.erb # layout admin
    ├── pages/                            # views públicas
    └── admin/                             # views admin
db/
└── seeds.rb                # conteúdo inicial das páginas
```

## Comandos úteis

```bash
bin/rails db:seed          # repopula o conteúdo das páginas
bin/rails db:reset         # apaga e recria o banco + seeds
bin/rails tailwindcss:build  # compila o CSS uma vez
bin/rails console          # console do Rails
bin/rails routes          # lista todas as rotas
```

## Próximos passos

- [ ] **Parte 3:** página de RSVP (confirmação de presença) com formulário que salva no banco + painel admin com lista e export CSV.
