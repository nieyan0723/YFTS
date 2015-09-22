
/*
If tables exist, drop those tables
*/
drop table yfts_own;
drop table yfts_trans;
drop table yfts_user;
drop table yfts_stock;

/*
For user table:
*/
create table yfts_user
(
	user_id number(8),
	username varchar2(20) not null,
	password varchar2(20) not null,
	email varchar2(50) not null,
	firstname varchar2(30),
	lastname varchar2(30),
	balance number not null,
	authority varchar2(20) not null,
	enabled number(1),
	constraint yfts_user_pk primary key (user_id),
	constraint yfts_user_unique unique (username,email)
);

/*
For stock table:
*/
create table yfts_stock
(
	stock_id number(5),
	symbol varchar2(10) not null,
	stockname varchar2(50) not null,
	constraint yfts_stock_pk primary key (stock_id),
	constraint yfts_stock_unique unique (symbol)
);

/*
For ownership table:
*/
create table yfts_own
(
	user_id number(8),
	stock_id number(5),
	quantity number(10) not null,
	constraint yfts_own_quantity_ck check (quantity >= 0),
	constraint yfts_own_pk  primary key (user_id,stock_id),
	constraint yfts_own_uid_fk foreign key (user_id) references yfts_user (user_id),
	constraint yfts_own_sid_fk foreign key (stock_id) references yfts_stock (stock_id)
);

/*
For transaction table:
*/
create table yfts_trans
(
	trans_id number,
	user_id number(8),
	stock_id number(5),
	amount number(12) not null,
	price number(5,2) not null,
	trans_time date,
	constraint yfts_trans_amount_ck check (amount >= 0),
	constraint yfts_trans_price_ck check (price >= 0),
	constraint yfts_trans_pk primary key (trans_id),
	constraint yfts_trans_uid_fk foreign key (user_id) references yfts_user (user_id),
	constraint yfts_trans_sid_fk foreign key (stock_id) references yfts_stock (stock_id)
);