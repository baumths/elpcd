# ***TODO* list do projeto**

## ➜ **FEATURES**

1) Nova VIEW `SearchView` para buscas, com histórico
    - Novo campo no banco de dados `searchHistoryBox`
2) Novo `HelperTexts` para auxiliar novos usuários
    - Exemplo: "prefixar o código das classes com zeros para que
    - o algoritmo consiga ordenar a árvore corretamente"
3) Nova `TableView` para visualização do TTD
4) Criar outros BloC para as features, como:
    - Exportação de Csv, para que possa haver uma indicação de progresso
    - `HomeBloc` > permitirá remover as regras de negócio de dentro dos Widgets

## ➜ **WISHLIST**

> ## Treeview
> *Criar minha prórpia versão da TreeView novamente,
> mas dessa vez me baseando no widget da Google: [flutter_simple_treeview]*
> #### **Justificativa**:
> *O widget citado é composto por vários `Column`, renderizando muitos widgets de uma só vez,
> causando problemas de performance em árvores muito grandes*
> #### **Hipótese**:
> *Talvez alterando os `Column` por `Listview.builder` melhore a performance da árvore como um todo*
> - **Atualização:** usar `CustomScrollView` com `Slivers`, melhora a performance e customização da árvore
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
