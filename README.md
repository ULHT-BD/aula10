# aula10
Nesta aula olhamos para junções horizontais como forma de obter conteúdo de mais de uma relação através de relações. Vemos exemplos de vários tipos de junções internas INNER JOIN e externas OUTER JOIN.
Falamos ainda sobre nested queries como forma de efetuar junções horizontais.
Bom trabalho!

[0. Requisitos](#0-requisitos)

[1. Junção Horizontal](#1-junção-horizontal)

[2. Nested Query](#2-nested-query)

[3. Resoluções](#3-resoluções)

[Bibliografia e Referências](#bibliografia-e-referências)

[Outros](#outros)

## 0. Requisitos
Requisitos: Para esta aula, precisa de ter o ambiente de trabalho configurado ([Docker](https://www.docker.com/products/docker-desktop/) com [base de dados HR](https://github.com/ULHT-BD/aula03/blob/main/docker_db_aula03.zip) e [DBeaver](https://dbeaver.io/download/)). Caso ainda não o tenha feito, veja como fazer seguindo o passo 1 da [aula03](https://github.com/ULHT-BD/aula03/edit/main/README.md#1-prepare-o-seu-ambiente-de-trabalho).

Caso já tenha o docker pode iniciá-lo usando o comando ```docker start mysgbd``` no terminal, ou através do interface gráfico do docker-desktop:
<img width="1305" alt="image" src="https://user-images.githubusercontent.com/32137262/194916340-13af4c85-c282-4d98-a571-9c4f7b468bbb.png">

Deve também ter o cliente DBeaver.

## 1. Integridade Referencial
A junção horizontal permite recuperar dados de várias relações em simultâneo a efetuando associações através de valores em chaves estrangeiras. Corresponde a efetuar um produto cartesiano seguido de uma seleção. Em SQL esta operacao e conseguida com recurso a clausula JOIN.

A juncao pode ser feita de varias formas: INNER JOIN (juncao interna) ou OUTER JOIN (juncao externa) a esquerda ou a direita.

A sintaxe geral e:

``` sql
SELECT t1.col1, t1.col2, t2.col3, t2.col4 
FROM tabela1 t1
  [LEFT/RIGHT] [INNER/OUTER] JOIN tabela2 t2 ON t1.col1 = t2.col3
);
```

Por exemplo,

<img width="759" alt="image" src="https://user-images.githubusercontent.com/32137262/204396892-a62fe137-447b-4958-a727-980d4bbd969c.png">

Podemos obter informação sobre veiculos (matricula, marca) e respetivos proprietarios (nif e nome) usando a query:

``` sql
SELECT
  v.matricula, v.marca, p.nif, p.nome
FROM veiculo v JOIN proprietário p ON v.nif = p.nif;
```

O resultado da execução da query é:

<img width="602" alt="image" src="https://user-images.githubusercontent.com/32137262/204397360-22b5e0ab-5254-4fe5-b009-ec46d6ce144f.png">


O quadro seguinte resume os varios tipos de JOIN.

<img width="848" alt="image" src="https://user-images.githubusercontent.com/32137262/204397593-6118a241-1d2b-430b-861f-a0c0f901a92c.png">


### Exercícios
Considere a Base de Dados seguinte:

Disciplina(id, nome, carga_horaria, prof_id), prof_id:FK(Professor)

Professor(nif, nome, telefone, email) 

Escreva o código SQL que permite obter:
1. Criar as relações Disciplina e Professor e inserir alguns tuplos que permitam testar as queries seguintes 

2. Nome das disciplinas (e.g. Fundamentos de Programação, Programação I, etc) cuja carga horário é superior a 20h

3. Informação de id e nome de disciplinas e respetivos professores

4. Professores de disciplinas com carga horária superior a 40h

5. Disciplinas sem professores associados


## 2. Actions
Podemos definir ações de forma programática quando ocorrem alterações às referências. A ação por defeito é ```RESTRICT``` provocando um erro ao tentar remover ou alterar uma chave estrangeira. Podemos definir ações para a ocorrência de eventos sobre uma chave estrangeira, quando alterado (```ON UPDATE```) ou quando é removido (```ON DELETE```).

O comportamento por defeito e restringir ```RESTRICT``` dar erro. Outras alternativas sao 
- ```CASCADE``` - efeito em cascata se tuplo referencia (ou master) for removido/alterado os tuplos referenciados serão removidos/alterados
- ```SET NULL``` - se tuplo referencia (ou master) for removido/alterado o atributo FK nos tuplos referenciados serão atualizados para valor ```NULL```
- ```NO ACTION``` - nenhuma acao
- ```SET DEFAULT``` -  se tuplo referencia (ou master) for removido/alterado o atributo FK nos tuplos referenciados serão atualizados para valor definido como default

Exemplo de uma definicao de chave estrangeira com definicao de uma acao:

``` sql
CREATE TABLE tabela (
  definicao-de-colunas,
  CONSTRAINT fk_tabela_tabelaref FOREIGN KEY (coluna) REFERENCES tabela-referencia(coluna) 
    ON UPDATE DELETE CASCADE
);
```

Ou se alterarmos uma tabela existente adicionando restrições de integridade e com acoes diferentes para alteracao e remocao:

``` sql
ALTER TABLE tabela
ADD CONSTRAINT fk_tabela_tabelaref FOREIGN KEY (coluna) REFERENCES tabela-referencia(coluna) 
  ON DELETE CASCADE 
  ON UPDATE SET NULL
);
```


### Exercícios
Altere a base de dados que criou no exercício anterior para o seguinte:
1. Altere a BD do exercício 1.1 tal que quando um departamento é removido, todos os empregados desse departamento são removidos e para que quando o departamente é alterado perde referência para o valor null
2. Experimente remover o departamento IT e alterar o departamento RH
3. Altere a BD em 1.3 tal que quando um departamento é removido, os seus empregados deixam de pertencer a qualquer departamento.


## 3. Resoluções
[Resolução dos exercícios em aula](https://github.com/ULHT-BD/aula09/blob/main/aula10_resolucao.sql)

[Resolução do trabalho de casa](https://github.com/ULHT-BD/aula09/blob/main/TPC_a09_resolucao.sql)

## Bibliografia e Referências
* [Slides aula (+material extra)](https://github.com/ULHT-BD/aula10/blob/main/Aula10.pdf) 
* [mysqltutorial - CREATE TABLE](https://www.mysqltutorial.org/mysql-create-table/)
* [mysqltutorial - Data Types](https://www.mysqltutorial.org/mysql-data-types.aspx)
* [MySQL - Data Types](https://dev.mysql.com/doc/refman/8.0/en/data-types.html)
* [mysqltutorial - Storage Engines](https://www.mysqltutorial.org/understand-mysql-table-types-innodb-myisam.aspx)
* [w3schools - MySQL Functions](https://www.w3schools.com/mysql/mysql_ref_functions.asp)

## Outros
Para dúvidas e discussões pode juntar-se ao grupo slack da turma através do [link](
https://join.slack.com/t/ulht-bd/shared_invite/zt-1iyiki38n-ObLCdokAGUG5uLQAaJ1~fA) (atualizado 2022-11-03)
