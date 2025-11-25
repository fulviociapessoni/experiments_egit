-- User [User]
create table `user` (
   `user_id`  varchar(255)  not null,
   `secret_key`  varchar(255),
   `first_name`  varchar(255),
   `last_name`  varchar(255),
   `gender`  varchar(255),
   `birth_date`  date,
   `shipping_address`  varchar(255),
   `createdat`  datetime,
   `updatedat`  datetime,
  primary key (`user_id`)
);


-- Class 1 [cls1u]
create table `class_1` (
   `oid`  integer  not null,
   `attribute30`  varchar(255),
  primary key (`oid`)
);


-- Class 2 [cls2u]
create table `class_2` (
   `oid`  integer  not null,
   `attribute32`  varchar(255),
  primary key (`oid`)
);


-- Class 3 [cls3n]
create table `class_3` (
   `oid`  integer  not null,
   `attribute37`  varchar(255),
   `attribute36`  varchar(255),
   `attribute35`  varchar(255),
   `attribute34`  varchar(255),
  primary key (`oid`)
);


-- Combination [ent4]
create table `combination` (
   `oid`  integer  not null,
   `code`  integer,
   `description`  longtext,
   `name`  varchar(255),
   `price`  double precision,
   `photo`  varchar(255),
   `start_date`  date,
   `end_date`  date,
   `highlighted`  bit,
   `createdat`  datetime,
   `updatedat`  datetime,
  primary key (`oid`)
);


-- Store [ent5]
create table `store` (
   `oid`  integer  not null,
   `address`  varchar(255),
   `email`  varchar(255),
   `map`  varchar(255),
   `photo`  varchar(255),
  primary key (`oid`)
);


-- Category [pkg1#ent1]
create table `category` (
   `oid`  integer  not null,
   `category`  varchar(255),
   `createdat`  datetime,
   `updatedat`  datetime,
  primary key (`oid`)
);


-- Image [pkg1#ent7]
create table `image` (
   `oid`  integer  not null,
   `description`  longtext,
   `picture`  varchar(255),
   `createdat`  datetime,
   `updatedat`  datetime,
  primary key (`oid`)
);


-- Product [pkg1#ent8]
create table `product` (
   `oid`  integer  not null,
   `code`  integer,
   `description`  longtext,
   `name`  varchar(255),
   `price`  double precision,
   `thumbnail`  varchar(255),
   `highlighted`  bit,
   `createdat`  datetime,
   `updatedat`  datetime,
  primary key (`oid`)
);


-- Tech Record [pkg1#ent9]
create table `tech_record` (
   `oid`  integer  not null,
   `colors`  varchar(255),
   `dimensions`  varchar(255),
   `createdat`  datetime,
   `updatedat`  datetime,
  primary key (`oid`)
);


-- TechRecord_Product [rel10]
create table `techrecord_product` (
   `product_oid`  integer not null,
   `tech_record_oid`  integer not null,
  primary key (`product_oid`, `tech_record_oid`)
);
alter table `techrecord_product`   add index fk_techrecord_product_product (`product_oid`), add constraint fk_techrecord_product_product foreign key (`product_oid`) references `product` (`oid`);
alter table `techrecord_product`   add index fk_techrecord_product_tech_rec (`tech_record_oid`), add constraint fk_techrecord_product_tech_rec foreign key (`tech_record_oid`) references `tech_record` (`oid`);


-- Image_Product [rel11]
alter table `image`  add column  `product_oid`  integer;
alter table `image`   add index fk_image_product (`product_oid`), add constraint fk_image_product foreign key (`product_oid`) references `product` (`oid`);


-- Category_Product [rel12]
alter table `product`  add column  `category_oid`  integer;
alter table `product`   add index fk_product_category (`category_oid`), add constraint fk_product_category foreign key (`category_oid`) references `category` (`oid`);


-- Product_Combination [rel9]
create table `product_combination` (
   `product_oid`  integer not null,
   `combination_oid`  integer not null,
  primary key (`product_oid`, `combination_oid`)
);
alter table `product_combination`   add index fk_product_combination_product (`product_oid`), add constraint fk_product_combination_product foreign key (`product_oid`) references `product` (`oid`);
alter table `product_combination`   add index fk_product_combination_combina (`combination_oid`), add constraint fk_product_combination_combina foreign key (`combination_oid`) references `combination` (`oid`);


-- User.full name [User#att9]
create view `user_full_name_view` as
select AL1.`user_id` as `user_id`,  concat(AL1.`first_name`, ' ', AL1.`last_name`) as `der_attr`
from  `user` AL1 ;


-- Combination.# products [ent4#att51]
create view `combination_products_number_vi` as
select AL1.`oid` as `oid`, count(distinct AL2.`product_oid`) as `der_attr`
from  `combination` AL1 
               left outer join `product_combination` AL2 on AL1.`oid`=AL2.`combination_oid`
group by AL1.`oid`;


-- Category.# products [pkg1#ent1#att8]
create view `category_products_number_view` as
select AL1.`oid` as `oid`, count(distinct AL2.`oid`) as `der_attr`
from  `category` AL1 
               left outer join `product` AL2 on AL1.`oid`=AL2.`category_oid`
group by AL1.`oid`;


-- Product.# photos [pkg1#ent8#att50]
create view `product_photos_number_view` as
select AL1.`oid` as `oid`, count(distinct AL2.`oid`) as `der_attr`
from  `product` AL1 
               left outer join `image` AL2 on AL1.`oid`=AL2.`product_oid`
group by AL1.`oid`;


-- Class Services Mapping
create table WR_DELETE_HISTORY(
  `OID`  integer  not null,
  `OBJECT_ID` varchar(200) not null,
  `CLASS_ID` varchar(32) not null,
  `DELETED_AT` datetime not null,
  primary key (`OID`))
ENGINE=InnoDB;

create index IDX_WR_CLASS_ID on WR_DELETE_HISTORY(`CLASS_ID`);
create index IDX_WR_OBJECT_ID on WR_DELETE_HISTORY(`DELETED_AT`);


