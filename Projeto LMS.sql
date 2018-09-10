create table usuario (	
	ID int IDENTITY
	CONSTRAINT pk_usuario primary key(ID),
	login varchar(25) 
	CONSTRAINT login_uq unique not null,
	senha varchar(20)
	CONSTRAINT senha_ck check (len(senha)>=6) not null,
	DtExpiracao datetime,

)
ALTER TABLE usuario ADD
		CONSTRAINT DF_dtExpiracao DEFAULT('1900/01/01') FOR DtExpiracao;

create table coordenador (	
	ID int IDENTITY,
	CONSTRAINT pk_coordenador primary key(ID),
	Id_usuario int not null
	CONSTRAINT FK_Id_usuario FOREIGN KEY (Id_usuario)
		REFERENCES usuario (ID),
	Nome varchar(50) not null,
	Email varchar(50) not null
	CONSTRAINT Email_uq unique, 
	Celular char(11) not null
	CONSTRAINT Celular_uq unique,

	
)

create table aluno (	
	ID int IDENTITY,
	CONSTRAINT pk_aluno primary key(ID),
	ID_usuario int not null
	CONSTRAINT FK_aluno_Id_usuario FOREIGN KEY (Id_usuario)
		REFERENCES usuario (ID),
	Nome varchar(50) not null,
	Email varchar(50) not null
	CONSTRAINT Email_aluno_uq unique,
	Celular char(11) not null
	CONSTRAINT Celular_aluno_uq unique,
	RA char(7) not null,
	Foto varchar(500)
)

create table professor (	
	ID int IDENTITY
	CONSTRAINT pk_professor primary key(ID),
	Id_usuario int not null
	CONSTRAINT FK_professor_id_usuario FOREIGN KEY (Id_usuario)
		REFERENCES usuario (ID),
	Email varchar(50) not null
	CONSTRAINT Email_professor_UQ unique,
	Celular char(11) not null
	CONSTRAINT Celular_professor_UQ unique,
	Apelido varchar(30)
	
)

create table disciplina (	
	ID int IDENTITY
	CONSTRAINT pk_disciplina primary key(ID),
	Nome varchar(50)
	CONSTRAINT nome_disciplina_UQ unique,
	Data_Disciplina datetime
	CONSTRAINT DF_Data_disciplina DEFAULT(GETDATE()) FOR Data_Disciplina,
	Status_Disciplina varchar(8)
	CONSTRAINT CK_STATUS
		CHECK(Status_Disciplina in('Aberto','Fechado'))
	CONSTRAINT DF_STATUS DEFAULT('Aberto') FOR Status_Disciplina,
	PlanoDeEnsino varchar(50),
	CargaHoraria char(2)
	CONSTRAINT CK_Carga_Horaria
		CHECK(CargaHoraria in(40,80)),
	Competencias varchar(20),
	Habilidades varchar(30),
	Ementa varchar(200),
	ConteudoProgramatico varchar(100),
	BibliografiaBasica varchar(300),
	BibliografiaComplementar varchar(200),
	PercentualPratico smallint
	CONSTRAINT CK_Percentual_Pratico
		CHECK((len(PercentualPratico)>=00 AND < 100)),
	PercentualTeorico smallint
	CONSTRAINT CK_Percentual_Teorico
		CHECK((len(PercentualTeorico)>=00 AND PercentualTeorico <= 100)),
	IdCoordenador int not null
	CONSTRAINT FK_IdCoordenador FOREIGN KEY (IdCoordenador)
		REFERENCES coordenador (ID)
)

create table DisciplinaOfertada (	
	ID int IDENTITY,
	CONSTRAINT pk_DisciplinaOfertada primary key(ID),
	IdCoordenador int not null
	CONSTRAINT FK_IdCoordenador_DO FOREIGN KEY (IdCoordenador)
		REFERENCES coordenador (ID),
	DtInicioMatricula datetime,
	DtFimMatricula datetime,
	IdDisciplina int NOT NULL
	CONSTRAINT FK_IdDisciplina FOREIGN KEY (IdDisciplina)
		REFERENCES disciplina (ID),
	IdCurso int NOT NULL 
	CONSTRAINT FK_IdCurso FOREIGN KEY (IdCurso)
		REFERENCES curso (ID),
	ANO smallint NOT NULL
	CONSTRAINT CK_ANO CHECK (ANO >= 1900 AND ANO <= 2100),
	SEMESTRE tinyint NOT NULL
	CONSTRAINT CK_SEMESTRE CHECK(SEMESTRE >= 1 AND SEMESTRE <= 2),
	TURMA varchar (50) NOT NULL
	CONSTRAINT CK_TURMA CHECK (TURMA >= a  and TURMA <= z),
	IdProfessor int
	CONSTRAINT FK_IdProfessor FOREIGN KEY (IdProfessor)
		REFERENCES professor(ID),
	Metodologia varchar(50), 
	Recursos varchar(50),
	CriterioAvaliacao varchar(50),
	PlanoDeAulas varchar(50)
)

create table curso (	
	ID smallint IDENTITY,
	CONSTRAINT pk_curso primary key(ID),
	Nome varchar(30) not null
	CONSTRAINT Nome_curso_UQ unique
)

create table SolicitacaoMatricula (	
	ID int IDENTITY,
	CONSTRAINT pk_SolicitacaoMatricula primary key(ID),
	IdAluno int NOT NULL
	CONSTRAINT FK_IdAluno FOREIGN KEY (IdAluno)
		REFERENCES aluno (ID),
	IdDisciplinaOfertada int NOT NULL
	CONSTRAINT FK_IdDisciplinaOfertada FOREIGN KEY (IdDisciplinaOfertada)
		REFERENCES DisciplinaOfertada (ID),
	DtSolicitacao datetime NOT NULL
	CONSTRAINT DF_DtSolicitacao DEFAULT (GETDATE()) FOR DtSolicitacao,
	IdCoordenador int 
	CONSTRAINT FK_IdCoordenador FOREIGN KEY (IdCoordenador)
		REFERENCES coordenador (ID),
	StatusSolicitacaoMatricula varchar(50)
	CONSTRAINT DF_StatusSolicitacaoMatricula DEFAULT ('Solicitada') FOR StatusSolicitacaoMatricula
	CONSTRAINT CK_StatusSolicitacaoMatricula CHECK (StatusSolicitacaoMatricula in ('Solicitada', 'Rejeitada','Cancelada')),



)

create table atividade (	
	ID int IDENTITY,
	CONSTRAINT pk_atividade primary key(ID),
	Titulo varchar(40) not null
	CONSTRAINT Titulo_UQ unique,
	Descricao varchar(300),
	Tipo varchar(20) NOT NULL
	CONSTRAINT CK_TIPO
		CHECK(Tipo in('Resposta Aberta','Teste')),
	Extras varchar(500),
	IdProfessor int NOT NULL
	CONSTRAINT FK_IdProfessor FOREIGN KEY (IDProfessor)
		REFERENCES professor (ID)
)
create table AtividadeVinculada (	
	ID int IDENTITY,
	CONSTRAINT pk_AtividadeViculada primary key(ID),
	IdAtividade int NOT NULL
	CONSTRAINT FK_IdAtividade FOREIGN KEY (IdAtividade)
		REFERENCES atividade(ID),
	IdProfessor int NOT NULL
	CONSTRAINT FK_IdProfessor FOREIGN KEY (IdProfessor)
		REFERENCES professor (ID),
	IdDisciplinaOfertada int NOT NULL
	CONSTRAINT FK_IdDisciplinaOfertada FOREIGN KEY (IdDisciplinaOfertada)
		REFERENCES DisciplinaOfertada (ID),
	Rotulo char(3) NOT NULL,
	StatusAtividadeVinculada varchar(20)
	CONSTRAINT CK_StatusAtividadeVinculada CHECK (StatusAtividadeVinculada in ('Disponibilizada','Aberta', 'Fechada', 'Encerrada', 'Prorrogada')),
	DtInicioRespostas datetime NOT NULL,
	DtFimRespostas datetime NOT NULL

)

create table Entrega (	
	ID int IDENTITY,
	CONSTRAINT pk_entrega primary key(ID),
	IdAluno int NOT NULL
	CONSTRAINT FK_IdAluno FOREIGN KEY (IdAluno)
		REFERENCES aluno (ID),
	IdAtividadeVinculada int NOT NULL
	CONSTRAINT FK_IdAtividadeVinculada FOREIGN KEY (IdAtividadeVinculada)
		REFERENCES AtividadeVinculada(ID),
	Titulo varchar (30) NOT NULL,
	Resposta varchar (500) NOT NULL,
	DtEntrega datetime NOT NULL
	CONSTRAINT DF_DtEntrega DEFAULT (GETDATE()) FOR DtEntrega,
	StatusEntrega varchar(10) NOT NULL
	CONSTRAINT DF_StatusEntrega DEFAULT ('Entregue') FOR StatusEntrega
	CONSTRAINT CK_StatusEntrega CHECK (StatusEntrega in ('Entregue','Corrigido')),
	IdProfessor int 
	CONSTRAINT FK_IdProfessor FOREIGN KEY (IdProfessor)
		REFERENCES professor(ID),
	Nota decimal (4,2)
	CONSTRAINT CK_Nota CHECK(Nota >= 0 and Nota <= 10),
	DtAvaliacao datetime,
	Obs varchar(300)


)

create table mensagem (	
	ID int IDENTITY,
	CONSTRAINT pk_mensagem primary key(ID),
	IDAluno int NOT NULL
	CONSTRAINT FK_IDAluno FOREIGN KEY (IDAluno)
		REFERENCES Aluno (ID),
	IDProfessor int NOT NULL
	CONSTRAINT FK_IdProfessor_mensagem FOREIGN KEY (IDProfessor)
		REFERENCES professor (ID),
	Assunto varchar(200) NOT NULL,
	referencia varchar (50) NOT NULL,
	conteudo varchar (50) NOT NULL,
	StatusMensagem varchar (10) NOT NULL
	CONSTRAINT DF_StatusMensagem DEFAULT ('Enviado') FOR StatusMensagem
	CONSTRAINT CK_StatusMensagem CHECK (StatusMensagem in ('Enviado','Lido','Respondido')),
	Resposta varchar(100)
)