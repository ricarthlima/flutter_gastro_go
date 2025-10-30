# GastroGo - Mini-app de Restaurantes

> Este projeto é uma solução para o **Desafio Mobile Flutter**, com foco em **arquitetura limpa**, **gerenciamento de estado reativo**, **testes** e **boas práticas** de desenvolvimento. Trata-se das telas iniciais de um aplicativo agregador de restaurantes, como iFood.

<p align="center">
  <img src="docs/gif.gif" alt="Tela inicial" height="500"/>
</p>

## ✨ Funcionalidades Implementadas

A lista de funcionalidades foi baseada no escopo do desafio.

### Arquitetura
- [x] Camadas separadas (`data/`, `domain/`, `presentation/`)
- [x] Gerenciamento de estado reativo (**MobX**)
- [x] Repository Pattern para isolar as fontes de dados

### Must-Have
- [x] UI Responsiva, Dark/Light Mode e Acessibilidade (Tooltips)
- [x] **Lista de Restaurantes**
  - [x] Exibição de Nome, Categoria, Rating e Distância
  - [x] Busca por texto (nome) e Filtro por categoria (exata)
  - [x] Ordenação por Rating ou Distância
- [x] **Tela de Detalhes**
  - [x] Informações do Restaurante + Lista de Pratos (nome, preço, vegano)
  - [x] Botão de favoritar (Restaurante e Prato)
- [x] **Favoritos**
  - [x] Tela com abas para Restaurantes e Pratos favoritos
  - [x] Persistência local (**ObjectBox**)
- [x] **Fonte de Dados**
  - [x] JSON local (`assets/restaurants.json`, `assets/dishes.json`)
- [x] **Estados Explícitos**
  - [x] Loading, Sucesso, Vazio e Erro (com botão de *Retry*)
- [x] **Testes**
  - [x] +5 Testes Unitários (Repositórios e UseCases)
  - [x] 2 Testes de Widget (Lista e Detalhes)

### Nice-to-Have
- [ ] Scroll Infinito (Despriorizado para focar na robustez da arquitetura core)
- [x] Animação Hero na imagem do card (da Lista para os Detalhes)
- [x] i18n (Internacionalização `pt-BR` e `en`)
- [x] Cache de Imagens (`cached_network_image`)
- [x] Simular API com `Future.delayed` e chance de erro (1 chance em 20 por motivos de RPG)
- [x] Pull-to-Refresh (`RefreshIndicator`) nas telas
- [x] Navegação robusta com `GoRouter`
- [x] Filtro "Apenas Vegano"


## 🏛️ Arquitetura e Decisões

Esta seção detalha as decisões de arquitetura tomadas, conforme solicitado na avaliação.

### 1. Arquitetura Limpa em Camadas
O projeto segue uma arquitetura limpa rigorosa, separando responsabilidades nas camadas `data/`, `domain/` e `presentation/`.
- **`presentation/`**: Contém a UI (Widgets) e o Gerenciamento de Estado (MobX Stores).
- **`domain/`**: Contém as regras de negócio puras (UseCases) e os contratos (Interfaces de Repositório).
- **`data/`**: Contém as implementações concretas dos repositórios e a lógica de acesso às fontes de dados (ObjectBox, JSON).

### 2. Gerenciamento de Estado (MobX)
Embora `Provider`, `Riverpod` ou `Bloc` fossem sugeridos, escolhi **MobX**.
- **Por quê:** MobX oferece um gerenciamento de estado reativo poderoso com o mínimo de *boilerplate*. Sua integração com `Observer` permite que os *widgets* se reconstruam de forma granular, e o sistema de `Actions` e `Computeds` se encaixa perfeitamente na arquitetura com `UseCases`.
- **Ciclo de Vida das Stores:**
  - `RestaurantListStore`, `ThemeStore` e `FavoritesStore` são registrados como **`LazySingleton`** no GetIt.
  - `DishListStore` (detalhes do restaurante) é registrada como **`Factory`**, garantindo instâncias isoladas.

### 3. Persistência Local (ObjectBox)
Optamos por **ObjectBox** em vez de `shared_preferences` ou `hive`.
- **Por quê:** ObjectBox é um banco de dados de objetos **fortemente tipado**, exigindo `Entities` (`FavoriteRestaurantEntity`, `FavoriteDishEntity`) e um `IFavoritesRepository` robusto, que encapsula toda a lógica de query (`.query()`, `.build()`, `.put()`, `.remove()`), reforçando princípios **SOLID**.
- Além disso, possui atualizações frequentes, enquanto o `hive` ou o `isar`parecem estar descontinuados não oficialmente.
- O `shared_preferences` foi usado para registrar a preferência de tema.

### 4. O Padrão "Backend Burro" (UseCases Híbridos)
- **Problema:** A fonte de dados é um JSON local, um "backend burro" que não sabe filtrar ou ordenar.
- **Decisão:** `UseCases` de filtro e ordenação aceitam uma lista opcional (`List<RestaurantDto>? restaurants`) para reutilizar os dados em memória.
- **Resultado:** A `Store` se torna um orquestrador eficiente, aplicando filtros e ordenações sem reconsultar o repositório, preservando o isolamento do domínio e a performance do app.

### 5. DTOs como Entidades de Domínio
- **Decisão:** Utilizar `DTOs` diretamente nas camadas `domain/` e `presentation/`. (Achatamento)
- **Motivo:** Como o app é *read-only*, criar `Entities` seria redundante. Essa escolha reduz *boilerplate* sem comprometer a clareza. E tempo, né.

### 6. Navegação (GoRouter)
- **Decisão:** Uso do `GoRouter`.
- **Motivo:** Permite rotas nomeadas e parâmetros (`/restaurants/dishes/:rid`) e suporte a transições suaves (`Hero`), além de aceitar objetos (`extra`) para inicialização otimizada.
- No futuro, e principalmente para esse tipo de app, **Deeplinks** podem ser configurados com o `GoRouter`.

## 🚀 Como Rodar o Projeto

### Pré-requisitos
- Flutter SDK (3.22.0 ou superior)
- Emulador ou dispositivo físico Android ou iOS
- IDE como VSCode, IntelliJ ou XCode

### 1. Instalação
```bash
# Clone o repositório
git clone <url-do-seu-repositorio>
cd gastro-go

# Instale as dependências
flutter pub get
```

### 2. Geração de Código (Obrigatória)
Este projeto usa **build_runner** para MobX, ObjectBox e i18n. Rode:
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

### 3. Executar o App
```bash
flutter run
```

## ✅ Qualidade e Automação

### 1. Linting (Análise Estática)
Configurado com **flutter_lints** e um `analysis_options.yaml` rigoroso, com regras como:
- `prefer_final_fields`
- `avoid_print`
- `curly_braces_in_flow_control_structures`
- `prefer_relative_imports`

Verificar o código:
```bash
flutter analyze
```

Corrigir automaticamente:
```bash
dart fix --apply
```

### 2. Testes
O projeto inclui testes unitários e de widget.

- **Unitários:** Cobrem todos os `UseCases` e Repositórios (`ObjectBoxFavoritesRepository`).
- **Widget:** Testam as telas `RestaurantsScreen` e `DishScreen`, com `Stores` mockadas via GetIt.

Executar todos os testes:
```bash
flutter test
```

### 3. CI (GitHub Actions)
Workflow em `.github/workflows/main.yml`, executado a cada `push` ou `pull_request` para `main`, rodando automaticamente:

```bash
flutter analyze
flutter test
flutter build apk --debug
```

---

Como sempre,
feito com 🩵 e Flutter por Ricarth Lima

*(Eu botava emojis nos meus READMEs muito antes de IAs viu)*