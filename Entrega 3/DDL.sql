CREATE DATABASE Farmacia;

CREATE TABLE Empresa (
	ID_Empresa INT NOT NULL PRIMARY KEY,
	Telefone CHAR(11) NOT NULL,
    Email VARCHAR(70) NOT NULL UNIQUE,
    Alvara VARCHAR(20) NOT NULL UNIQUE, /*VERIFICAR*, TIVE QUE PEDIR UM HELP PARA O CHAT, ELE ME INSTRUIU A DECLARAR COMO TIPO JSON, POIS ALVARA NA REALIDADE E UM ATRIBUTO MULTIVALODO, SENDO ASSIM UM UNICO CAMPO GUARDA VARIOS DADOS MENORES COMO: NUMERO, VALIDADE, STATUS*/
    Razao_Social VARCHAR(50) NOT NULL,
    CEP CHAR(8) NOT NULL,
	Inscricao_Estadual VARCHAR(14) NOT NULL UNIQUE,
    Nome_Fantasia VARCHAR(50),
    CNAE CHAR(7) NOT NULL,
    Logradouro VARCHAR(50) NOT NULL,
    Cidade VARCHAR(30) NOT NULL,

	CONSTRAINT CHK_Telefone CHECK (REGEXP_LIKE(Telefone, '^[0-9]{10,11}$')),
    CONSTRAINT CHK_Email CHECK (REGEXP_LIKE(Email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')),
    CONSTRAINT CHK_CEP CHECK (REGEXP_LIKE(CEP, '^[0-9]{8}$')),
	CONSTRAINT CHK_CNAE CHECK (REGEXP_LIKE(CNAE, '^[0-9]{7}$'))
);


CREATE TABLE Pessoa (
	ID_Pessoa INT NOT NULL PRIMARY KEY,
    CPF CHAR(11) NOT NULL UNIQUE,
    RG CHAR(9),
    Nome VARCHAR(100) NOT NULL,
    Telefone CHAR(11) NOT NULL,
    CEP CHAR(8) NOT NULL,
    Genero VARCHAR(20),

    CONSTRAINT CHK_CPF CHECK (REGEXP_LIKE(CPF, '^[0-9]{11}$')),
	CONSTRAINT CHK_Pessoa_Telefone CHECK (REGEXP_LIKE(Telefone, '^[0-9]{10,11}$')),
    CONSTRAINT CHK_Pessoa_CEP CHECK (REGEXP_LIKE(CEP, '^[0-9]{8}$')),
	CONSTRAINT CHK_Genero CHECK (Genero IS NULL OR Genero IN ('Masculino', 'Feminino'))
);


CREATE TABLE Produto (
	ID_Produto INT NOT NULL PRIMARY KEY,
    Descricao VARCHAR(100) NOT NULL,
    Marca VARCHAR(50) NOT NULL,
    Preco_Custo DECIMAL(10,2) NOT NULL,
    Preco_Venda DECIMAL(10,2) NOT NULL,
    Lote_Fabricacao VARCHAR(30) NOT NULL,
    Tipo_Produto VARCHAR(30) NOT NULL,

    CONSTRAINT CHK_Preco_Custo CHECK (Preco_Custo >= 0),
    CONSTRAINT CHK_Preco_Venda CHECK (Preco_Venda >= 0),
    CONSTRAINT CHK_Tipo_Produto CHECK (Tipo_Produto IN ('Medicamento', 'Cosmetico', 'Higiene', 'Outros'))
);


CREATE TABLE Categoria (
	ID_Categoria INT NOT NULL PRIMARY KEY,
	Nome_Categoria VARCHAR(30) NOT NULL UNIQUE,
    Descricao VARCHAR(150)
);


CREATE TABLE Fornecedor (
	ID_Fornecedor INT NOT NULL PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    CPF_CNPJ VARCHAR(14) NOT NULL UNIQUE,
    Empresa VARCHAR(70) NOT NULL UNIQUE,
	Telefone CHAR(11) NOT NULL,
    
	CONSTRAINT CHK_Fornecedor_CPF_CNPJ CHECK (REGEXP_LIKE(CPF_CNPJ, '^([0-9]{11}|[0-9]{14})$')),
	CONSTRAINT CHK_Fornecedor_Telefone CHECK (REGEXP_LIKE(Telefone, '^[0-9]{10,11}$'))
);


CREATE TABLE Fabricante (
	ID_Fabricante INT NOT NULL PRIMARY KEY,
    CNPJ_Fabricante CHAR(14) NOT NULL UNIQUE,
    Nome_Fabricante VARCHAR(70) NOT NULL,
    SAC_Telefone CHAR(11) NOT NULL,
	UF_Sede CHAR(2) NOT NULL,

    CONSTRAINT CHK_CNPJ_Fabricante CHECK (REGEXP_LIKE(CNPJ_Fabricante, '^[0-9]{14}$')),
    CONSTRAINT CHK_SAC_Telefone CHECK (REGEXP_LIKE(SAC_Telefone, '^[0-9]{10,11}$')),
    CONSTRAINT CHK_UF_Sede CHECK (UF_Sede IN ('AC','AL','AP','AM','BA','CE','DF','ES','GO','MA','MT','MS','MG','PA','PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO'))
);


CREATE TABLE Servico (
	ID_Servico INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    Nome_Servico VARCHAR(100) NOT NULL UNIQUE,
    descricao VARCHAR(150),
    Valor_Servico DECIMAL(10,2) NOT NULL,

     CONSTRAINT CHK_Valor_ServicO CHECK (Valor_Servico > 0)
);


CREATE TABLE Cupom_Desconto (
	ID_Cupom INT NOT NULL PRIMARY KEY,
	Codigo_Cupom VARCHAR(20) NOT NULL UNIQUE,
    Percentual_Desconto DECIMAL(5,2) NOT NULL,
    Data_Validade DATE NOT NULL,

    CONSTRAINT CHK_Percentual_Desconto CHECK (Percentual_Desconto > 0 AND Percentual_Desconto <= 100.00)
);


CREATE TABLE Estoque (
	ID_Estoque INT NOT NULL PRIMARY KEY,
    Data_Entrada DATE NOT NULL,
    Localizacao VARCHAR(50) NOT NULL,
    Quantidade_Atual INT NOT NULL,
	ID_Empresa INT NOT NULL,

	FOREIGN KEY (ID_Empresa) REFERENCES Empresa (ID_Empresa),
    
	CONSTRAINT CHK_Quantidade_Atual CHECK (Quantidade_Atual >= 0)
);


CREATE TABLE Compra (
	ID_Compra INT NOT NULL PRIMARY KEY,
    Data_Compra DATE NOT NULL,
    Horario TIME NOT NULL,
    Valor_Final DECIMAL(10,2) NOT NULL,
    Desconto DECIMAL(10,2) DEFAULT 0.00,
    ID_Pessoa INT NOT NULL,

	FOREIGN KEY (ID_Pessoa) REFERENCES Pessoa (ID_Pessoa),

    CONSTRAINT CHK_Compra_Valores CHECK (Valor_Final > 0 AND Desconto >= 0)
);


CREATE TABLE Filial (
	ID_Filial INT NOT NULL UNIQUE,
	CNPJ_Filial CHAR(14) NOT NULL UNIQUE,
    Rua VARCHAR(70) NOT NULL,
    Numero INT NOT NULL,
    Bairro VARCHAR(50) NOT NULL,
    ID_Empresa INT NOT NULL,

    FOREIGN KEY (ID_Empresa) REFERENCES Empresa (ID_Empresa),

    CONSTRAINT CHK_CNPJ_Filial CHECK (REGEXP_LIKE(CNPJ_Filial, '^[0-9]{14}$'))
);


CREATE TABLE Matriz (
	CNPJ_Matriz CHAR(14) NOT NULL UNIQUE,
	ID_Empresa INT NOT NULL,

	FOREIGN KEY (ID_Empresa) REFERENCES Empresa (ID_Empresa),

    CONSTRAINT CHK_CNPJ_Matriz CHECK (REGEXP_LIKE(CNPJ_Matriz, '^[0-9]{14}$'))
);


CREATE TABLE Fiscalizacao (
	ID_Registro_Anvisa INT NOT NULL PRIMARY KEY,
    Data_Inspecao DATE NOT NULL,
    Status_Regularizacao VARCHAR(30) NOT NULL,
	Certificado_AFE CHAR(7) UNIQUE NOT NULL,
    ID_Empresa INT NOT NULL,
    
    FOREIGN KEY (ID_Empresa) REFERENCES Empresa (ID_Empresa),
    
    CONSTRAINT CHK_Certificado_AFE CHECK (REGEXP_LIKE(Certificado_AFE, '^[0-9]{7}$')),
    CONSTRAINT CHK_Status_Regularizacao CHECK (Status_Regularizacao IN ('Regular', 'Irregular', 'Pendente'))
);


CREATE TABLE Cliente (
	Data_Cadastro DATE NOT NULL,
	Pontos_Fidelidade INT NOT NULL DEFAULT 0,
	Rua VARCHAR(80) NOT NULL,
	Numero INT NOT NULL,
	Complemento VARCHAR(30),
	Bairro VARCHAR(50) NOT NULL,
	Cidade VARCHAR(50) NOT NULL,
	UF CHAR(2) NOT NULL,
	ID_Pessoa INT NOT NULL,
 
	FOREIGN KEY (ID_Pessoa) REFERENCES Pessoa (ID_Pessoa),
 
    CONSTRAINT CHK_Pontos_Fidelidade CHECK (Pontos_Fidelidade >= 0),
    CONSTRAINT CHK_Cliente_UF CHECK (UF IN ('AC','AL','AP','AM','BA','CE','DF','ES','GO','MA','MT','MS','MG','PA','PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO'))
);


CREATE TABLE Funcionario (
	Login_Sistema VARCHAR(50) NOT NULL UNIQUE,
    Nivel_Acesso VARCHAR(20) NOT NULL,
    Cargo VARCHAR(50) NOT NULL,
    Funcao VARCHAR(50),
    Salario DECIMAL(10,2) NOT NULL,
    Data_Admissao DATE NOT NULL,
    status_funcionario VARCHAR(20) NOT NULL,
    PIS_PASEP CHAR(11) NOT NULL UNIQUE,
    CTPS VARCHAR(15) NOT NULL UNIQUE,
	ID_Pessoa INT NOT NULL,

	FOREIGN KEY (ID_Pessoa) REFERENCES Pessoa (ID_Pessoa),

    CONSTRAINT CHK_Nivel_Acesso CHECK (Nivel_Acesso IN ('ADMIN', 'GERENTE', 'OPERADOR')),
    CONSTRAINT CHK_Salario CHECK (Salario > 0),
	CONSTRAINT CHK_PIS_PASEP CHECK (REGEXP_LIKE(PIS_PASEP, '^[0-9]{11}$')),
    CONSTRAINT CHK_Status_Funcionario CHECK (Status_Funcionario IN ('ATIVO', 'AFASTADO', 'DESLIGADO'))   
);


CREATE TABLE Farmaceutico (
    CRF VARCHAR(10) NOT NULL,
    UF_CRF CHAR(2) NOT NULL,
    Especialidade VARCHAR(50),
	ID_Pessoa INT NOT NULL,

	FOREIGN KEY (ID_Pessoa) REFERENCES Pessoa (ID_Pessoa),

    CONSTRAINT UF_CRF UNIQUE (CRF, UF_CRF),
    CONSTRAINT CHK_Farmaceutico_UF CHECK (UF_CRF IN ('AC','AL','AP','AM','BA','CE','DF','ES','GO','MA','MT','MS','MG','PA','PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO')),
    CONSTRAINT CHK_CRF_Numerico CHECK (REGEXP_LIKE(CRF, '^[0-9]+$'))
);


CREATE TABLE Presencial (
    NFCe_Numero BIGINT NOT NULL UNIQUE,
    Caixa INT NOT NULL,
	ID_Compra INT NOT NULL,

	FOREIGN KEY (ID_Compra) REFERENCES Compra (ID_Compra),

    CONSTRAINT CHK_NFCe_Numero CHECK (NFCe_Numero > 0)
);


CREATE TABLE On_Line (
	URL_Acesso VARCHAR(150) NOT NULL PRIMARY KEY,
    IP_Origem VARCHAR(45) NOT NULL,
    Hash_Transacao VARCHAR(64) NOT NULL UNIQUE,
    Data_Hora_Aprovacao DATETIME NOT NULL,
    Status_Pagamento VARCHAR(20) NOT NULL DEFAULT 'Pendente',
	ID_Compra INT NOT NULL,
    ID_Cupom INT,

	FOREIGN KEY (ID_Compra) REFERENCES Compra (ID_Compra),
	FOREIGN KEY (ID_Cupom) REFERENCES Cupom_Desconto (ID_Cupom),

    CONSTRAINT CHK_Status_Pagamento CHECK (Status_Pagamento IN ('PENDENTE', 'APROVADO', 'RECUSADO', 'ESTORNADO'))
);


CREATE TABLE Receita (
	ID_Receita INT NOT NULL PRIMARY KEY,
    Data_Emissao DATE NOT NULL,
    Data_Validade DATE NOT NULL,
    Data_Retencao DATE,
    UF_Conselho CHAR(2) NOT NULL,
    Tipo_Receita VARCHAR(30) NOT NULL,
    Encaminhamento_Anvisa VARCHAR(100),
	ID_Compra INT NOT NULL,

	FOREIGN KEY (ID_Compra) REFERENCES Compra (ID_Compra),

	CONSTRAINT CHK_UF_Conselho CHECK (UF_Conselho IN ('AC','AL','AP','AM','BA','CE','DF','ES','GO','MA','MT','MS','MG','PA','PB','PR','PE','PI','RJ','RN','RS','RO','RR','SC','SP','SE','TO')),
	CONSTRAINT CHK_Tipo_Receita CHECK (Tipo_Receita IN ('Simples', 'Controlada', 'Especial'))
);


CREATE TABLE Pagamento (
	ID_Pagamento INT NOT NULL PRIMARY KEY,
    Valor_Pago DECIMAL(10,2) NOT NULL,
    Data_Pagamento DATETIME NOT NULL,
    Metodo_Pagamento VARCHAR(30) NOT NULL,
	ID_Compra INT NOT NULL,

	FOREIGN KEY (ID_Compra) REFERENCES Compra (ID_Compra),

    CONSTRAINT CHK_Valor_Pago CHECK (Valor_Pago > 0),
    CONSTRAINT CHK_Metodo_Pagamento CHECK (Metodo_Pagamento IN ('Dinheiro', 'Cartao', 'Pix', 'Boleto'))
);


CREATE TABLE Entrega (
	ID_Entrega INT NOT NULL PRIMARY KEY,
	Status_Entrega VARCHAR(30) NOT NULL,
    Taxa_Entrega DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    Data_Hora_Saida DATETIME,
    Data_Hora_Chegada DATETIME,
    Codigo_Rastreio VARCHAR(50) UNIQUE,
    ID_Compra INT NOT NULL,
    
	FOREIGN KEY (ID_Compra) REFERENCES Compra (ID_Compra),
  
    CONSTRAINT CHK_Status_Entrega CHECK (Status_Entrega IN ('Pendente', 'Em Rota', 'Entregue', 'Cancelado')),
    CONSTRAINT CHK_Taxa_Entrega CHECK (Taxa_Entrega >= 0)
);


CREATE TABLE Item_Compra (
	Lote_Venda INT NOT NULL,
    Quantidade INT NOT NULL,
    Preco_Unidade DECIMAL(10,2) NOT NULL,
    Desconto_Item DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    ID_Compra INT NOT NULL,
	ID_Produto INT NOT NULL,
  
    PRIMARY KEY (ID_Compra, ID_Produto),

	FOREIGN KEY (ID_Compra) REFERENCES Compra (ID_Compra),
	FOREIGN KEY (ID_Produto) REFERENCES Produto (ID_Produto),

    CONSTRAINT CHK_Item_Compra_Valores CHECK (Quantidade > 0 AND Preco_Unidade > 0 AND Desconto_Item >= 0)
);


CREATE TABLE Item_Servico (
	Descricao VARCHAR(100),
    Data_Consumo DATETIME NOT NULL,
    Quantidade_Consumida INT NOT NULL,
	ID_Compra INT NOT NULL,
    ID_Servico INT NOT NULL,
    ID_Pessoa INT NOT NULL,
    
	PRIMARY KEY (ID_Compra, ID_Servico),

	FOREIGN KEY (ID_Compra) REFERENCES Compra (ID_Compra),
    FOREIGN KEY (ID_Servico) REFERENCES Servico (ID_Servico),
	FOREIGN KEY (ID_Pessoa) REFERENCES Pessoa (ID_Pessoa),
    
    CONSTRAINT CHK_Quantidade_Consumida CHECK (Quantidade_Consumida > 0)
);


CREATE TABLE Movimentacao_Estoque(
	Tipo_de_Movimentacao CHAR(1) NOT NULL,
    Finalidade_Motivo VARCHAR(100),
    Origem_e_Destino VARCHAR(100),
	Data_Hora_Movimentacao DATETIME NOT NULL,
    Saldo_Posterior INT NOT NULL,
    Lote_Movimentado INT NOT NULL,
    ID_Produto INT NOT NULL,
    ID_Pessoa INT NOT NULL,

    PRIMARY KEY (Tipo_de_Movimentacao, Data_Hora_Movimentacao, ID_Produto),

	FOREIGN KEY (ID_Produto) REFERENCES Produto (ID_Produto),
	FOREIGN KEY (ID_Pessoa) REFERENCES Pessoa (ID_Pessoa),
    
    CONSTRAINT CHK_Tipo_Movimentacao CHECK (Tipo_de_Movimentacao IN ('E', 'S'))
);


CREATE TABLE Convenio (
	Numero_Carteira INT NOT NULL PRIMARY KEY,
    Validade DATE NOT NULL,
    Desconto DECIMAL(5,2) NOT NULL DEFAULT 0.00,
	ID_Pessoa INT NOT NULL,

	FOREIGN KEY (ID_Pessoa) REFERENCES Pessoa (ID_Pessoa),

    CONSTRAINT CHK_Desconto CHECK (Desconto >= 0 AND Desconto <= 100.00)
);


/* RELACIONAMENTO (N,N)*/


CREATE TABLE Armazena (
	ID_Estoque INT NOT NULL,
    ID_Produto INT NOT NULL,
    Quantidade INT NOT NULL,
    
    PRIMARY KEY (ID_Estoque, ID_Produto),
    
    FOREIGN KEY (ID_Estoque) REFERENCES Estoque (ID_Estoque),
    FOREIGN KEY (ID_Produto) REFERENCES Produto (ID_Produto),
 
    CONSTRAINT CHK_Quantidade CHECK (Quantidade >= 0)
);


CREATE TABLE Fornece (
	ID_Fornecedor INT NOT NULL,
    ID_Produto INT NOT NULL,
    
	PRIMARY KEY (ID_Fornecedor, ID_Produto),
    
    FOREIGN KEY (ID_Fornecedor) REFERENCES Fornecedor (ID_Fornecedor),
    FOREIGN KEY (ID_Produto)    REFERENCES Produto (ID_Produto)
);


CREATE TABLE Produz (
	ID_Fabricante INT NOT NULL,
    ID_Produto INT NOT NULL,
    
    PRIMARY KEY (ID_Fabricante, ID_Produto),
 
    FOREIGN KEY (ID_Fabricante) REFERENCES Fabricante (ID_Fabricante),
    FOREIGN KEY (ID_Produto)    REFERENCES Produto (ID_Produto)
);


CREATE TABLE Classifica (
	ID_Produto INT NOT NULL,
    ID_Categoria INT NOT NULL,
    
	PRIMARY KEY (ID_Produto, ID_Categoria),
 
    FOREIGN KEY (ID_Produto)   REFERENCES Produto (ID_Produto),
    FOREIGN KEY (ID_Categoria) REFERENCES Categoria (ID_Categoria)
);


CREATE TABLE Consome (
    ID_Servico  INT NOT NULL,
    ID_Produto  INT NOT NULL,
 
    PRIMARY KEY (ID_Servico, ID_Produto),
 
    FOREIGN KEY (ID_Servico) REFERENCES Servico (ID_Servico),
    FOREIGN KEY (ID_Produto) REFERENCES Produto (ID_Produto)
);
    