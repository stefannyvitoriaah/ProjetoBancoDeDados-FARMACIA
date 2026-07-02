INSERT INTO Pessoa (ID_Pessoa, CPF, RG, Nome, Telefone, CEP, Genero) 
VALUES
	(1, '43403674002', '105782932', 'Pedro Cavalcanti Barros', '44935438007', '87308859', 'Masculino'),
    (2, '57322937953', '102664821', 'Isabelle Costa Castro', '44930533343', '87302895', 'Feminino'),
    (3, '16765134930', '354339710', 'Beatriz Rodrigues Barbosa', '44934714817', '87301130', 'Feminino'),
    (4, '57693682929', '151875248', 'Carlos Almeida Azevedo', '44925071238', '87305330', 'Masculino'),
    (5, '77519214982', '250834169', 'Fernanda Dias Oliveira', '44922072516', '87302345', 'Feminino'),
    (6, '50571876943', '301992630', 'Melissa Ferreira Carvalho', '44922396889', '87302170', 'Feminino'),
    (7, '27215676919', '388554034', 'Miguel Araujo Almeida', '44934669768', '87301150', 'Masculino'),
    (8, '56838526921', '314906885', 'Ana Correia Barbosa', '44925562056', '87302293', 'Feminino'),
    (9, '42618645928', '250603305', 'Ágatha Martins Ferreira', '44923572551', '87301110', 'Feminino'),
    (10, '60516592939', '479621627', 'Guilherme Carvalho Souza', '44927444288', '87309408', 'Masculino');
    
    

INSERT INTO Cliente (ID_Pessoa, Data_Cadastro, Pontos_Fidelidade, Rua, Numero, Complemento, Bairro, Cidade, UF)
VALUES
    (1, '2023-01-15', 50, 'Av. Armelindo Trombini', 2700, NULL, 'Jardim Flora II', 'Campo Mourão', 'PR'),
    (2, '2024-03-22', 85, 'Av. Perimetral Tancredo de Almeida Neves', 1481, 'Apto 12', 'Área Urbanizada II', 'Campo Mourão', 'PR'),
    (3, '2023-06-10', 0, 'Rua Francisco Ferreira Albuquerque', 1059, NULL, 'Centro', 'Campo Mourão', 'PR'),
    (4, '2026-08-05', 20, 'Rua Dom Jaime Luiz Coelho', 179, NULL, 'Jardim Lar Paraná', 'Campo Mourão', 'PR'),
    (5, '2024-04-03', 50, 'Rua Edmundo Mercer', 2149, NULL, 'Jardim Copacabana', 'Campo Mourão', 'PR'),
    (6, '2024-01-18', 54, 'Rua São Josafat', 1181, NULL, 'Centro', 'Campo Mourão', 'PR'),
    (7, '2025-02-27', 20, 'Rua Silvério Farago', 111, NULL, 'Parque São João', 'Campo Mourão', 'PR'),
    (8, '2024-09-01', 0, 'Rua Araruna', 2044, NULL, 'Jardim Voidelo', 'Campo Mourão', 'PR'),
    (9, '2026-03-19', 0, 'Rua Prefeito Roberto Brzezinski', 701, NULL, 'Centro', 'Campo Mourão', 'PR'),    
    (10, '2025-01-09', 0, 'Rua Antônio Vargas Netto', 300, NULL, 'Jardim Modelo', 'Campo Mourão', 'PR');



INSERT INTO Produto (ID_Produto, Descricao, Marca, Preco_Custo, Preco_Venda, Lote_Fabricacao, Tipo_Produto) 
VALUES
	(1, 'Dipirona Sódica 500mg 20 comprimidos', 'EMS', 3.80, 8.90, 'LOT2024A01', 'Medicamento'),
    (2, 'Shampoo Anticaspa 400ml', 'Clear', 9.70, 21.90, 'LOT2024D02', 'Higiene'),
    (3, 'Omeprazol 20mg 28 cápsulas', 'Medley', 5.20, 14.50, 'LOT2024E05', 'Medicamento'),
    (4, 'Fio Dental Encerado 50m', 'Oral-B', 2.10, 5.90, 'LOT2024H04', 'Higiene'),
    (5, 'Álcool em Gel 70% 500ml', 'Asseptgel', 4.20, 10.90, 'LOT2024I08', 'Higiene'),
	(6, 'Soro Fisiológico 0,9% 250ml', 'Farmax', 2.20, 5.90, 'LOT2024J06', 'Medicamento'),
    (7, 'Vitamina C 1g Efervescente 10 comprimidos', 'Aceviton', 6.50, 15.90, 'LOT2024G11', 'Medicamento'),
    (8, 'Amoxicilina 500mg 21 cápsulas', 'Eurofarma', 12.50, 28.90, 'LOT2024B03', 'Medicamento'),
	(9, 'Protetor Solar FPS 60 200ml', 'La Roche-Posay', 48.00, 89.90, 'LOT2024C07', 'Cosmetico'),
    (10, 'Hidratante Corporal Manteiga Karité 250ml', 'Nivea', 11.30, 24.90, 'LOT2024F09', 'Cosmetico');

INSERT INTO Compra (ID_Compra, Data_Compra, Horario, Valor_Final, Desconto, ID_Pessoa)
VALUES
	(1, '2025-02-03', '09:14:00', 37.80, 0.00, 1),
	(2, '2025-02-10', '14:32:00', 63.40, 5.00, 3),
	(3, '2025-03-01', '11:05:00', 28.90, 0.00, 5),
	(4, '2025-03-15', '16:47:00', 54.30, 8.00, 7),
	(5, '2025-04-02', '08:21:00', 19.40, 0.00, 2),
	(6, '2025-04-18', '13:58:00', 86.70, 10.00, 9),
	(7, '2025-05-05', '10:33:00', 44.50, 0.00, 4),
	(8, '2025-05-20', '17:11:00', 32.80, 3.00, 6),
	(9, '2025-06-01', '09:45:00', 71.60, 0.00, 8),
	(10, '2025-06-10', '15:22:00', 25.90, 2.00, 10);



INSERT INTO Item_Compra (Lote_Venda, Quantidade, Preco_Unidade, Desconto_Item, ID_Compra, ID_Produto) VALUES
	(1001, 2, 8.90, 0.00, 1, 1),
	(1002, 1, 28.90, 0.00, 2, 2),
	(1003, 1, 49.90, 5.00, 3, 3),
	(1004, 1, 21.90, 0.00, 4, 4),
	(1005, 2, 14.50, 0.00, 5, 5),
	(1006, 1, 24.90, 0.00, 6, 6),
	(1007, 3, 12.90, 8.00, 7, 7),
	(1008, 2, 5.90, 0.00, 8, 8),
	(1009, 2, 9.50, 0.00, 9, 9),
	(1010, 10, 4.90, 0.00, 10, 10);
    
INSERT INTO Pagamento (ID_Pagamento, Valor_Pago, Data_Pagamento, Metodo_Pagamento, ID_Compra) VALUES
(1, 37.80, '2025-02-03 09:15:00', 'Pix', 1),
(2, 63.40, '2025-02-10 14:33:00', 'Cartao', 2),
(3, 28.90, '2025-03-01 11:06:00', 'Dinheiro', 3),
(4, 54.30, '2025-03-15 16:48:00', 'Cartao', 4),
(5, 19.40, '2025-04-02 08:22:00', 'Pix', 5),
(6, 86.70, '2025-04-18 13:59:00', 'Boleto', 6),
(7, 44.50, '2025-05-05 10:34:00', 'Cartao', 7),
(8, 32.80, '2025-05-20 17:12:00', 'Pix', 8),
(9, 71.60, '2025-06-01 09:46:00', 'Cartao', 9),
(10, 25.90, '2025-06-10 15:23:00', 'Dinheiro', 10);