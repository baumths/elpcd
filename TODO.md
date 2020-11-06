# ***TODO* list do projeto**

> ## **! ! !**
> 
> A aplicação está atualmente QUEBRADA!
> Durante a inserção de dados na tela de Descrição,
> quando o usuário usa o Scroll e os campos saem da tela,
> os dados são perdidos.
>
> ## **O formulário precisa ser refatorado.**
> ---

## ➜ **HOMEVIEW**

- Mover Drawer para o seu proprio widget

## ➜ **DESCRIPTIONVIEW**

1) Tornar o `DescriptionManager` fixo, apenas alterando seus dados
    - `DescriptionView` se tornaria uma rota fixa
    - `DescriptionManager` seria exposto pelo provider
2) Indicar no `AppBar` em que modo está `[EDIT, VIEW, NEW]`
3) Separar o formulário em 3 abas (para melhorar a performance)
    - Em muitos casos o usuário criará classes simples com apenas `código` e `nome`
4) Criar uma barra de ações no rodapé `[SAVE, EDIT, REMOVE, ADD_CHILD]`


## ➜ **EXPORTAÇÃO**

- Remover conteúdo do CSV cujos campos estiverem em branco

## ➜ **FEATURES**

1) Nova VIEW `SearchView` para buscas, com histórico
    - Novo campo no banco de dados `searchHistoryBox`
2) Novo `HelperTexts` para auxiliar novos usuários
    - Exemplo: "prefixar o código das classes com zeros para que
    - o algoritmo consiga ordenar a árvore corretamente"
3) Nova `TableView` para visualização do TTD

## ➜ **FIXME**

- Organizar melhor o sistema de importação/exportação de arquivos
    - Está uma bagunça, deveria estar centralizado em um único arquivo
- Remover o `ScaffoldKey` da `DescriptionView`, pois não está sendo utilizado.
- Remover o `ScrollController` da `DescriptionView`, pois não está sendo utilizado.

## ➜ **WISHLIST**

> ## Treeview
> *Criar minha prórpia versão da TreeView novamente,
> mas dessa vez me baseando no widget da Google: [flutter_simple_treeview]*
> #### **Justificativa**:
> *O widget citado é composto por vários `Column`, renderizando muitos widgets de uma só vez,
> causando problemas de performance em árvores muito grandes*
> #### **Hipótese**:
> *Talvez alterando os `Column` por `Listview.builder` melhore a performance da árvore como um todo*
> #### **Objetivos**:
> ➜ Melhorar a performance da árvore
> 
> ➜ Botão de expandir/recolher nodes
>   - Melhorar o tema (reduzir o `splashRadius`)
>   - Adicionar animações ao botão (Rotacionar)
> 
> ➜ Estudar se é possível que o widget dos filhos deslize até o seu lugar durante expansão/recolhimento.
>   - Impactos na performance?

[flutter_simple_treeview]: https://github.com/google/flutter.widgets/tree/master/packages/flutter_simple_treeview
