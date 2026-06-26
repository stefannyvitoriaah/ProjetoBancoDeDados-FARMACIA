2- Regras de Negócio (RN)
​
  
  Gestão de Pessoas e Acesso
​
  
  2.1 – Unicidade de Pessoa: Toda Pessoa deve possuir um CPF único. O sistema deve impedir o cadastro duplicado, validando se o CPF já existe como Cliente ou Funcionário.
​
  
  2.2 – Hierarquia de Acesso: O atributo Nível_Acesso da entidade Funcionário determina quais módulos (Estoque, Vendas, Financeiro) podem ser acessados via Login_Sistema.
​Vendas e Atendimento
​
  
  2.3 – Venda Presencial vs. Online: Toda Compra deve ser categorizada obrigatoriamente como Presencial (exigindo ID_Caixa) ou Online (exigindo Hash_Transação e gerando uma Entrega).
​
  
  2.4 – Fidelidade: O atributo Pontos_Fidelidade do Cliente deve ser incrementado em 1 ponto a cada R$ 10,00 em Valor_Final de uma Compra.
​
  
  2.5 – Desconto de Convênio: O Desconto em uma compra só será aplicado se a Validade da carteira do Convênio for maior ou igual à data atual da Compra.
​Saúde e Vigilância Sanitária (Anvisa)
​
  
  2.6 – Retenção de Receita: Para produtos da entidade Drogaria com Tarja "Preta" ou "Vermelha sob retenção", o sistema exige obrigatoriamente o vínculo de uma Receita com UF_Conselho e Data_de_Validade válida.
​
  
  2.7 – Validação de Registro: Nenhum produto pode ser vendido ou estocado se o Registro_MS (na entidade Produto) não estiver vinculado a um ID_Registro_Anvisa com Status_Regularização igual a "Ativo".
​Estoque e Logística
​
  
  2.8 – Rastreabilidade de Lote: Toda Movimentação_Estoque deve registrar obrigatoriamente o Lote_Movimentado. Em caso de venda, o Lote_Venda em Item_venda deve subtrair a quantidade correspondente no Estoque.
​
  
  2.9 – Inventário por Filial: A Quantidade_atual no Estoque é isolada por Filial. Uma movimentação entre filiais deve gerar um registro de "Saída" na origem e "Entrada" no destino.
​
  
  2.10 – Alerta de Validade: O sistema deve bloquear a venda de qualquer Produto cuja Data_de_Validade no Estoque seja inferior à data atual.
​Serviços e Entrega
​
  
  2.11 – Requisitos de Serviço: Para a entidade Serviços (ex: aplicação de injetáveis), se Requisitos_Receita for verdadeiro, o sistema deve exigir o upload ou registro da Receita antes de finalizar o atendimento.
  
  
  2.12 – Taxa de Entrega: O valor da Taxa_Entrega na entidade Entrega deve ser somado ao Valor_Final da Compra apenas para pedidos da categoria Online