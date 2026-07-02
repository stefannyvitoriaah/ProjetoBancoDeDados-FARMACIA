-- CONSULTAS COMPLEXAS PARA O SISTEMA
-- CONSULTA 1: Subconsulta IN (Não Correlacionada):Ex:. Busca o nome e o CPF de todas as pessoas que são Clientes cadastrados, filtrando apenas os que residem no estado de São Paulo ('SP').

SELECT p.Nome, p.CPF 
FROM Pessoa p
WHERE p.ID_Pessoa IN (
    SELECT c.ID_Pessoa 
    FROM Cliente c 
    WHERE c.UF = 'SP'
);

-- CONSULTA 2: Subconsulta Correlacionada (EXISTS): Ex:. Retorna a descrição e o preço de venda dos produtos que possuem um preço de venda superior à média de preço de venda de todos os produtos do seu mesmo tipo (ex: Medicamento, Cosmético).

SELECT p1.Descricao, p1.Preco_Venda, p1.Tipo_Produto
FROM Produto p1
WHERE p1.Preco_Venda > (
    SELECT AVG(p2.Preco_Venda)
    FROM Produto p2
    WHERE p2.Tipo_Produto = p1.Tipo_Produto
);

-- CONSULTA 3: Operador de Conjunto (UNION):Ex:. Consolida uma lista única de contatos telefônicos de todas as entidades externas associadas à rede (Fornecedores e Fabricantes), identificando a origem do registro para auditoria de comunicação.

SELECT Nome AS Identificacao, Telefone, 'Fornecedor' AS Tipo_Entidade
FROM Fornecedor
UNION
SELECT Nome_Fabricante AS Identificacao, SAC_Telefone AS Telefone, 'Fabricante' AS Tipo_Entidade
FROM Fabricante;

-- CONSULTA 4: Subconsulta com Função de Agregação (MAX):Ex:. Busca os dados da compra (ID, Data, Valor Final) que registrou o maior desconto concedido na história do sistema.

SELECT c.ID_Compra, c.Data_Compra, c.Valor_Final, c.Desconto
FROM Compra c
WHERE c.Desconto = (
    SELECT MAX(Desconto) 
    FROM Compra
);

-- CONSULTA 5: Operador de Conjunto / Subconsulta de Exclusão (NOT IN):Ex:;. Identifica quais produtos cadastrados no sistema nunca foram vendidos,ou seja, não constam em nenhuma relação da tabela Item_Compra. Excelente para 
-- análise de estoque parado.
SELECT p.ID_Produto, p.Descricao, p.Marca
FROM Produto p
WHERE p.ID_Produto NOT IN (
    SELECT DISTINCT ic.ID_Produto 
    FROM Item_Compra ic
);

-- CONSULTA 6: Subconsulta Correlacionada com Múltiplas Tabelas: Ex:.Lista o nome e o cargo dos funcionários (da tabela Pessoa e Funcionario) 
-- que foram os responsáveis por registrar movimentações de saída ('S') no estoque.
SELECT p.Nome, f.Cargo
FROM Pessoa p
JOIN Funcionario f ON p.ID_Pessoa = f.ID_Pessoa
WHERE EXISTS (
    SELECT 1 
    FROM Movimentacao_Estoque me
    WHERE me.ID_Pessoa = p.ID_Pessoa 
      AND me.Tipo_de_Movimentacao = 'S'
);