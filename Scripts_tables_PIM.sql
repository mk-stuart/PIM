----TABELA NI_USER_LEVEL

CREATE TABLE ni_user_level( 
	 user_level_id   		 NUMBER not null,
	 description			 VARCHAR2(20) not null,
     CONSTRAINT pk_user_level primary key (user_level_id)
    );

INSERT INTO new_itens_owner.ni_user_level
VALUES(0, 'ADMIN');
INSERT INTO new_itens_owner.ni_user_level
VALUES(1, 'MANAGER');
INSERT INTO new_itens_owner.ni_user_level
VALUES(2, 'USER');
-----------------------
---TABELA NI_USER---

CREATE TABLE ni_user( 
	 user_id   		 NUMBER not null,
	 user_level_id   NUMBER DEFAULT 2,
     first_name      VARCHAR2(20) not null, 
	 last_name       VARCHAR2(25) not null,
	 cpf             VARCHAR2(14) not null,
     email			 VARCHAR2(25) not null,	
     password	     VARCHAR2(25) not null,
     phone_number    VARCHAR2(10),
	 celphone_number VARCHAR2(10),
     birth_date      DATE  DEFAULT NULL,
     register_date   DATE  DEFAULT SYSDATE, 
	 CONSTRAINT fk_user_level FOREIGN KEY (user_level_id) 
				references new_itens_owner.ni_user_level(user_level_id),
     CONSTRAINT pk_user primary key (user_id)
    );

CREATE SEQUENCE ni_seq_user
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

-----
DECLARE
teste number;
begin
ni_sp_insert_user('begoin','endoin','teste','senha','3698-7412','CELPHONE_NUMBER_IN', SYSDATE, to_date('19760321','YYYYMMDD'),teste);
end;
/ 
-------------
------------------------- ni_product-------------------

CREATE TABLE ni_product( 
	product_id   		NUMBER not null,
	name				VARCHAR2(100),
	model				VARCHAR2(50),
	description			VARCHAR2(200),
	barcode				NUMBER(13),
	register_date       DATE DEFAULT SYSDATE,
	price				FLOAT,
    CONSTRAINT pk_product primary key (product_id)
    );

CREATE SEQUENCE ni_seq_product
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

-------------------------------------------------------
------------------------- ni_category-------------------

CREATE TABLE ni_category( 
	category_id   		NUMBER not null,
	father_category_id  NUMBER default 0,
	description			VARCHAR2(200),
    CONSTRAINT pk_category primary key (category_id)
    );
	
CREATE SEQUENCE ni_seq_category
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

CREATE TABLE ni_product_category( 
	product_id          NUMBER not null,
	category_id			NUMBER not null,
	 CONSTRAINT fk_category_product FOREIGN KEY (product_id) 
				references new_itens_owner.ni_product(product_id),
	 CONSTRAINT fk_product_category FOREIGN KEY (category_id) 
				references new_itens_owner.ni_category(category_id)		
    );

-------------------------------------------------------
------------------------- ni_feature -------------------

CREATE TABLE ni_feature( 
	feature_id   		NUMBER not null,
	father_feature_id   NUMBER default 0,
	description			VARCHAR2(200),
    CONSTRAINT pk_feature primary key (feature_id)
    );
	
CREATE SEQUENCE ni_seq_feature
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

CREATE TABLE ni_product_feature( 
	product_id          NUMBER not null,
	feature_id			NUMBER not null,
	 CONSTRAINT fk_feature_product FOREIGN KEY (product_id) 
				references new_itens_owner.ni_product(product_id),
	 CONSTRAINT fk_product_feature FOREIGN KEY (feature_id) 
				references new_itens_owner.ni_feature(feature_id)			
    );

-------------------------------------------------------
------------------------- ni_tag_search -------------------

CREATE TABLE ni_tag_search( 
	tag_search_id   	NUMBER not null,
	description			VARCHAR2(200),
    CONSTRAINT pk_tag_search primary key (tag_search_id)
    );
	
CREATE SEQUENCE ni_seq_tag_search
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

CREATE TABLE ni_product_tag_search( 
	product_id          NUMBER not null,
	tag_search_id	    NUMBER not null,
	 CONSTRAINT fk_tag_search_product FOREIGN KEY (product_id) 
				references new_itens_owner.ni_product(product_id),
	 CONSTRAINT fk_product_tag_search FOREIGN KEY (tag_search_id) 
				references new_itens_owner.ni_tag_search(tag_search_id)			
    );

-------------------------------------------------------
------------------------- ni_lot -------------------
CREATE TABLE ni_lot_status(
	lot_status_id		NUMBER not null,
	description			VARCHAR2(20),
	 CONSTRAINT pk_lot_status primary key (lot_status_id)
);

INSERT INTO new_itens_owner.ni_lot_status
VALUES(1, 'NEW');
INSERT INTO new_itens_owner.ni_lot_status
VALUES(2, 'SELLING');
INSERT INTO new_itens_owner.ni_lot_status
VALUES(3, 'SOLD');

CREATE TABLE ni_lot( 
	lot_id   			NUMBER not null,
	product_id  		NUMBER not null,
	lot_status_id       NUMBER DEFAULT 1,
	begin_amount		NUMBER not null,
	amount      		NUMBER,
	purchase_price_unit FLOAT not null,
	provider			VARCHAR2(200),
	entry		        DATE DEFAULT SYSDATE,
	sold_out			DATE,
	CONSTRAINT fk_lot_product FOREIGN KEY (product_id) 
				references new_itens_owner.ni_product(product_id),
	CONSTRAINT fk_lot_status FOREIGN KEY (lot_status_id) 
				references new_itens_owner.ni_lot_status(lot_status_id),
    CONSTRAINT pk_lot primary key (lot_id)
    );
	
CREATE SEQUENCE ni_seq_lot
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;
--------------------------------------------------------
-------------------- ni_interests_area -----------------

CREATE TABLE ni_interests_area(
	interests_area_id		NUMBER not null,
	description				VARCHAR2(20),
	 CONSTRAINT pk_interests_area primary key (interests_area_id)
);

CREATE TABLE ni_user_interests_area( 
	user_id   			NUMBER not null,
	interests_area_id  NUMBER not null,
	CONSTRAINT fk_user_interests_area FOREIGN KEY (user_id) 
				references new_itens_owner.ni_user(user_id),
	CONSTRAINT fk_interests_area_user FOREIGN KEY (interests_area_id) 
				references new_itens_owner.ni_interests_area(interests_area_id)
    );
	
CREATE SEQUENCE ni_seq_ni_interests_areas
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

--------------------------------------------------------
------------------- ni_address -------------------------
CREATE TABLE ni_uf(
	 uf_id NUMBER not null,
	 uf VARCHAR2(20),
	 CONSTRAINT pk_uf PRIMARY KEY (uf_id)
   );

CREATE TABLE ni_address(
	 address_id 	 NUMBER not null,
	 user_id 		 NUMBER not null,
     uf_id 			 NUMBER not null,
	 street 		 VARCHAR2(50),
	 address_number  NUMBER not null,
	 complement 	 VARCHAR2(30),
	 reference_point VARCHAR2(50),
	 district 		 VARCHAR2(30),
	 city 			 VARCHAR2(30),
	 cep 			 VARCHAR2(9),
	 active 		 INT DEFAULT 1,
	 CONSTRAINT fk_address_user FOREIGN KEY (user_id) 
				references new_itens_owner.ni_user(user_id),
	 CONSTRAINT fk_address_uf FOREIGN KEY (uf_id) 
				references new_itens_owner.ni_uf(uf_id),
	 CONSTRAINT pk_address PRIMARY KEY (address_id)
	);

CREATE SEQUENCE ni_seq_address
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

--------------------------------------------------------
------------------- ni_sale ----------------------------

CREATE TABLE ni_sale( 
	sale_id   			NUMBER not null,
	user_id		  		NUMBER not null,
	sale_status_id      NUMBER DEFAULT 1,
	address_id			NUMBER not null,
	sale_date      		DATE DEFAULT SYSDATE,
	CONSTRAINT fk_sale_user FOREIGN KEY (user_id) 
				references new_itens_owner.ni_user(user_id),
	CONSTRAINT fk_sale_status FOREIGN KEY (sale_status_id) 
				references new_itens_owner.ni_sale_status(sale_status_id),
	CONSTRAINT fk_sale_address FOREIGN KEY (address_id) 
				references new_itens_owner.ni_address(address_id),
    CONSTRAINT pk_sale primary key (sale_id)
    );
	
CREATE TABLE ni_sale_status(
	sale_status_id		NUMBER not null,
	description			VARCHAR2(20) not null,
	CONSTRAINT pk_sale_status primary key (sale_status_id)
);

INSERT INTO new_itens_owner.ni_sale_status
values (1, 'NEW');
INSERT INTO new_itens_owner.ni_sale_status
values (2, 'IN_TRANSIT');
INSERT INTO new_itens_owner.ni_sale_status
values (3, 'FINISHED');
INSERT INTO new_itens_owner.ni_sale_status
values (4, 'CANCELED');

CREATE TABLE ni_product_sale(
	product_id			NUMBER not null,
	sale_id				NUMBER not null,
	price				FLOAT,
	CONSTRAINT fk_sale_product FOREIGN KEY (sale_id) 
				references new_itens_owner.ni_sale(sale_id),
	CONSTRAINT fk_product_sale FOREIGN KEY (product_id) 
				references new_itens_owner.ni_product(product_id)
);

CREATE SEQUENCE ni_seq_sale
INCREMENT BY 1
START WITH 1
NOMAXVALUE
NOCYCLE
NOCACHE;

------------------------------------------------------------------


