create table usuario (	
	ID int IDENTITY
	CONSTRAINT pk_usuario primary key(ID),
	login varchar(25) 
	CONSTRAINT login_uq unique not null,
	senha varchar(20)
	CONSTRAINT senha_ck check (len(senha)>=6) not null,
)
create table coordenador (	
	ID int IDENTITY,
	CONSTRAINT pk_coordenador primary key(ID)
)
create table aluno (	
	ID int IDENTITY,
	CONSTRAINT pk_aluno primary key(ID)
)
create table professor (	
	ID int IDENTITY,
	CONSTRAINT pk_professor primary key(ID)
)

create table disciplina (	
	ID int IDENTITY,
	CONSTRAINT pk_disciplina primary key(ID)
)

create table DisciplinaOfertada (	
	ID int IDENTITY,
	CONSTRAINT pk_DisciplinaOfertada primary key(ID)
)

create table curso (	
	ID smallint IDENTITY,
	CONSTRAINT pk_coordenador primary key(ID)
)

create table SolicitacaoMatricula (	
	ID int IDENTITY,
	CONSTRAINT pk_SolicitacaoMatricula primary key(ID)
)

create table atividade (	
	ID int IDENTITY,
	CONSTRAINT pk_atividade primary key(ID)
)
create table AtividadeVinculada (	
	ID int IDENTITY,
	CONSTRAINT pk_AtividadeViculada primary key(ID)
)

create table Entrega (	
	ID int IDENTITY,
	CONSTRAINT pk_entrega primary key(ID)
)

create table mensagem (	
	ID varchar(300),
	CONSTRAINT pk_atividade primary key(ID)
)