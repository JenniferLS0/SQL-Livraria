create database db_webB;

use db_webB;

create table tbl_Cliente(
cd_Cliente int primary key auto_increment,
nm_Cliente varchar(80) not null,
nm_Logradouro varchar(80) not null,
no_Logradouro varchar (5) not null,
ds_Complemento varchar(30) not null,
nm_bairro varchar(30) not null,
login varchar(80) not null,
senha char(6) not null
);

create table no_Telefone(
cd_Cliente int,
no_Telefone varchar(11),
CONSTRAINT primary key(cd_cliente, no_telefone),
CONSTRAINT foreign key(cd_Cliente) references tbl_Cliente(cd_Cliente)
);

create table tbl_Clifi(
cd_Cliente int,
no_CPF varchar(11),
foreign key(cd_Cliente) references tbl_Cliente(cd_Cliente)
);

create table tbl_Clijuri(
cd_Cliente int,
no_CNPJ varchar(14) not null,
foreign key(cd_Cliente) references tbl_Cliente(cd_CLiente)
);

create table tbl_Pagamento(
cd_Pagto int primary key auto_increment,
ds_Pagto varchar (30) not null
);

create table tbl_Compra(
cd_Compra int primary key auto_increment,
dt_Compra date not null,
vl_Total decimal(10,2) not null,
cd_Cliente int not null,
cd_Pagto int not null,
foreign key(cd_Cliente) references tbl_Cliente(cd_Cliente),
foreign key(cd_Pagto) references tbl_Pagamento(cd_Pagto)
);

create table tbl_Produto(
cd_Produto int primary key auto_increment,
nm_Produto varchar(80) not null,
vl_Produto decimal(10,2) not null
);

create table tbl_itens_Compra(
cd_Produto int,
cd_Compra int,
qt_Itens int,
vl_Total decimal(10,2),
primary key(cd_Produto, cd_Compra),
foreign key (cd_Produto) references tbl_Produto(cd_Produto),
foreign key (cd_Compra) references tbl_Compra(cd_Compra)
);

create table tbl_Fornecedor(
cd_Forn int primary key auto_increment,
nm_Forn varchar(80) not null
);

create table tbl_FoneForn(
cd_Forn int,
no_Telefone varchar(11),
primary key (cd_Forn, no_Telefone),
foreign key (cd_Forn) references tbl_Fornecedor(cd_Forn)
);

create table tbl_Fornecimento(
cd_Forn int,
cd_Produto int,
dt_Compra date not null,
primary key(cd_Forn,cd_Produto),
constraint foreign key(cd_Forn) references tbl_Fornecedor(cd_Forn),
constraint foreign key(cd_Produto) references tbl_Produto(cd_Produto)
);

create table tbl_Categoria(
cd_Cat int primary key auto_increment,
nm_Cat varchar(80) not null
);

create table tbl_prod_Cat(
cd_Cat int,
cd_Produto int,
primary key (cd_Cat, cd_Produto),
foreign key(cd_Cat) references tbl_Categoria(cd_Cat),
foreign key(cd_Produto) references tbl_Produto(cd_Produto)
);

create table tbl_Tamanho (
cd_Tamanho int primary key auto_increment,
sg_TAmanho varchar(2) not null
);

create table tbl_Prod_Tam(
cd_Tamanho int,
cd_Produto int,
qt_Produto int not null,
primary key(cd_Tamanho,cd_Produto),
foreign key(cd_Tamanho) references tbl_Tamanho(cd_Tamanho),
foreign key(cd_Produto) references tbl_Produto(cd_Produto)
);

alter table no_Telefone rename to tbl_Telefone;
alter table tbl_Telefone modify column no_Telefone varchar(11) not null;
alter table tbl_Clifi rename tbl_PF;
alter table tbl_PF modify column no_CPF char(11) not null;
alter table tbl_Clijuri rename tbl_PJ;
alter table tbl_PJ modify column no_CNPJ char(14) not null;
alter table tbl_categoria add column ds_status bit not null;

desc tbl_pj;
desc tbl_Categoria;

drop procedure myProcedure;

DELIMITER //
	Create procedure sp_InsCat(
		in vCat varchar (80),
		in vStatus bit
)
 begin
 insert into tbl_Categoria (nm_Cat,ds_Status) values (vCat, vStatus);
 end //
 DELIMITER ;
 
call sp_InsCat('Lançamentos',1);
call sp_InsCat('Filmes & TV',1);
call sp_InsCat('Series',1);
call sp_InsCat('Games',1);
call sp_InsCat('Nerd',1);
call sp_InsCat('Divertidas',1);

DELIMITER //
create procedure sp_MostrarCat()
	Begin
		select * from tbl_Categoria;
        end //
DELIMITER ;

call sp_MostrarCat();


drop procedure if exists sp_InsTamanho;
DELIMITER //
create procedure sp_InsTamanho(
	IN vTamanho varchar(2)
    )
    begin
    insert into tbl_Tamanho(sg_Tamanho) values (vTamanho);
    end //
DELIMITER ;

call sp_InsTamanho('P');
call sp_InsTamanho('M');
call sp_InsTamanho('X');
call sp_InsTamanho('XX');

DELIMITER //
create procedure sp_MostrarTamanho()
	Begin
		select * from tbl_Tamanho;
        end //
DELIMITER ;

call sp_MostrarTamanho();

DELIMITER //
create procedure sp_AltTamanho(
	in vTamanho varchar(2),
    in vCodigo int
)
    begin
    update Tbl_Tamanho 
    set sg_TAmanho = vTamanho
    where cd_Tamanho = vCodigo;
    end //
DELIMITER ;

call sp_AltTamanho ('G',1);
call sp_AltTamanho ('GG',2);