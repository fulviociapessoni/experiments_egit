-- Device [Device]
create table `device` (
   `oid`  integer  not null,
   `device_id`  varchar(255),
   `notification_device_id`  varchar(255),
   `model`  varchar(255),
   `platform`  varchar(255),
   `platform_version`  varchar(255),
   `browser`  varchar(255),
  primary key (`oid`)
) ENGINE=InnoDB;


-- User [User]
create table `user` (
   `user_id`  varchar(255)  not null,
   `refresh_token`  varchar(1000),
   `token_expiration_date`  datetime,
   `secret_key`  varchar(255),
   `first_name`  varchar(255),
   `last_name`  varchar(255),
   `gender`  varchar(255),
   `birth_date`  date,
   `shipping_address`  varchar(255),
   `createdat`  datetime,
   `updatedat`  datetime,
  primary key (`user_id`)
) ENGINE=InnoDB;


-- Authorized Grant Type [authAgt]
create table `authorized_grant_type` (
   `oid`  integer  not null,
   `name`  varchar(255),
  primary key (`oid`)
);


-- Application [authApl]
create table `application` (
   `app_id`  varchar(255)  not null,
   `refresh_token_validity`  integer,
   `access_token_validity`  integer,
   `authorities`  varchar(255),
   `secret`  varchar(255),
   `description`  varchar(255),
   `name`  varchar(255),
   `type`  varchar(255),
  primary key (`app_id`)
);


-- Approval [authApv]
create table `approval` (
   `updated_at`  datetime,
   `expiration_date`  datetime,
   `status`  varchar(255),
   `scope`  varchar(255),
   `oid`  integer  not null,
  primary key (`oid`)
);


-- Code [authCod]
create table `code` (
   `code`  varchar(255)  not null,
   `authentication`  varchar(255),
   `authenticationblob` longblob,
   `creation_date`  datetime,
  primary key (`code`)
);


-- Identity [authIdy]
create table `identity` (
   `expired`  bit,
   `locked`  bit,
   `password`  varchar(255),
   `user_id`  varchar(255)  not null,
   `disabled`  bit,
   `attempts_number`  integer,
   `password_expiration_date`  datetime,
   `email`  varchar(255),
   `auth_admin`  bit,
   `first_name`  varchar(255),
   `last_name`  varchar(255),
  primary key (`user_id`)
);


-- Refresh Token [authRft]
create table `refresh_token` (
   `oid`  integer  not null,
   `token`  varchar(1000),
   `expiration_date`  datetime,
  primary key (`oid`)
);


-- Authorized Resource [authRsc]
create table `authorized_resource` (
   `oid`  integer  not null,
   `name`  varchar(255),
  primary key (`oid`)
);


-- Scope [authScp]
create table `scope` (
   `oid`  integer  not null,
   `auto_approve`  bit,
   `name`  varchar(255),
  primary key (`oid`)
);

-- Claim [authClaim]
create table `claim` (
   `oid`  integer  not null,
   `key`  varchar(255),
   `value`  varchar(255),
  primary key (`oid`)
);

-- Claim_Identity [authClaim_Idy]
create table `claim_identity` (
   `claim_oid`  integer not null,
   `identity_user_id`  varchar(255) not null,
  primary key (`claim_oid`, `identity_user_id`)
);
alter table `claim_identity`   add index fk_claim_identity_claim (`claim_oid`), add constraint fk_claim_identity_claim foreign key (`claim_oid`) references `claim` (`oid`);
alter table `claim_identity`   add index fk_claim_identity_identity (`identity_user_id`), add constraint fk_claim_identity_identity foreign key (`identity_user_id`) references `identity` (`user_id`);


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
) ENGINE=InnoDB;


-- Store [ent5]
create table `store` (
   `oid`  integer  not null,
   `address`  varchar(255),
   `email`  varchar(255),
   `map`  varchar(255),
   `photo`  varchar(255),
  primary key (`oid`)
) ENGINE=InnoDB;


-- Category [pkg1#ent1]
create table `category` (
   `oid`  integer  not null,
   `category`  varchar(255),
   `createdat`  datetime,
   `updatedat`  datetime,
  primary key (`oid`)
) ENGINE=InnoDB;


-- Image [pkg1#ent7]
create table `image` (
   `oid`  integer  not null,
   `description`  longtext,
   `picture`  varchar(255),
   `createdat`  datetime,
   `updatedat`  datetime,
  primary key (`oid`)
) ENGINE=InnoDB;


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
) ENGINE=InnoDB;


-- Tech Record [pkg1#ent9]
create table `tech_record` (
   `oid`  integer  not null,
   `colors`  varchar(255),
   `dimensions`  varchar(255),
   `createdat`  datetime,
   `updatedat`  datetime,
  primary key (`oid`)
) ENGINE=InnoDB;

-- Device_Application [authDevice_Apl]
alter table `device`  add column  `application_app_id`  varchar(255);
alter table `device`   add index fk_device_application (`application_app_id`), add constraint fk_device_application foreign key (`application_app_id`) references `application` (`app_id`);

-- Device_Identity [authDevice_Idy]
alter table `device`  add column  `identity_user_id`  varchar(255);
alter table `device`   add index fk_device_identity (`identity_user_id`), add constraint fk_device_identity foreign key (`identity_user_id`) references `identity` (`user_id`);

-- TechRecord_Product [rel10]
create table `techrecord_product` (
   `product_oid`  integer not null,
   `tech_record_oid`  integer not null,
  primary key (`product_oid`, `tech_record_oid`)
) ENGINE=InnoDB;
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
) ENGINE=InnoDB;
alter table `product_combination`   add index fk_product_combination_product (`product_oid`), add constraint fk_product_combination_product foreign key (`product_oid`) references `product` (`oid`);
alter table `product_combination`   add index fk_product_combination_combina (`combination_oid`), add constraint fk_product_combination_combina foreign key (`combination_oid`) references `combination` (`oid`);

-- AuthorizedGrantType_Application [authAgt_Apl]
alter table `authorized_grant_type`  add column  `application_app_id`  varchar(255);
alter table `authorized_grant_type`   add index fk_authorized_grant_type_appli (`application_app_id`), add constraint fk_authorized_grant_type_appli foreign key (`application_app_id`) references `application` (`app_id`);


-- Approval_Application [authApv_Apl]
alter table `approval`  add column  `application_app_id`  varchar(255);
alter table `approval`   add index fk_approval_application (`application_app_id`), add constraint fk_approval_application foreign key (`application_app_id`) references `application` (`app_id`);


-- Approval_Identity [authApv_Idy]
alter table `approval`  add column  `identity_user_id`  varchar(255);
alter table `approval`   add index fk_approval_identity (`identity_user_id`), add constraint fk_approval_identity foreign key (`identity_user_id`) references `identity` (`user_id`);


-- RefreshToken_Application [authRft_Apl]
alter table `refresh_token`  add column  `application_app_id`  varchar(255);
alter table `refresh_token`   add index fk_refresh_token_application (`application_app_id`), add constraint fk_refresh_token_application foreign key (`application_app_id`) references `application` (`app_id`);


-- RefreshToken_Identity [authRft_Idy]
alter table `refresh_token`  add column  `identity_user_id`  varchar(255);
alter table `refresh_token`   add index fk_refresh_token_identity (`identity_user_id`), add constraint fk_refresh_token_identity foreign key (`identity_user_id`) references `identity` (`user_id`);


-- AuthorizedResource_Application [authRsc_Apl]
alter table `authorized_resource`  add column  `application_app_id`  varchar(255);
alter table `authorized_resource`   add index fk_authorized_resource_applica (`application_app_id`), add constraint fk_authorized_resource_applica foreign key (`application_app_id`) references `application` (`app_id`);


-- Scope_Application [authScp_Apl]
alter table `scope`  add column  `application_app_id`  varchar(255);
alter table `scope`   add index fk_scope_application (`application_app_id`), add constraint fk_scope_application foreign key (`application_app_id`) references `application` (`app_id`);


-- User.full name [User#att9]
create view `user_full_name_view` as
select AL1.`user_id` as `oid`,  concat(AL1.`first_name`, ' ', AL1.`last_name`) as `der_attr`
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


-- Data Services Mapping
create table WR_DELETE_HISTORY(
  `OID`  integer  not null,
  `OBJECT_ID` varchar(200) not null,
  `CLASS_ID` varchar(32) not null,
  `DELETED_AT` datetime not null,
  primary key (`OID`))
ENGINE=InnoDB;

create index IDX_WR_CLASS_ID on WR_DELETE_HISTORY(`CLASS_ID`);
create index IDX_WR_OBJECT_ID on WR_DELETE_HISTORY(`DELETED_AT`);



INSERT INTO `CATEGORY` (`oid`, `category`) VALUES (19, 'Tables');
INSERT INTO `CATEGORY` (`oid`, `category`) VALUES (20, 'Chairs');
INSERT INTO `CATEGORY` (`oid`, `category`) VALUES (21, 'Lamps');



INSERT INTO `PRODUCT` (`oid`, `CODE`, `DESCRIPTION`, `NAME`, `PRICE`, `THUMBNAIL`, `category_oid`, `HIGHLIGHTED`) VALUES (1, 5125, 'Stainless steel meets crystal and silk to make the comfort and look.', 'Wilderness', 1500, 'upload/small_chair_5.jpg', 20, 0);
INSERT INTO `PRODUCT` (`oid`, `CODE`, `DESCRIPTION`, `NAME`, `PRICE`, `THUMBNAIL`, `category_oid`, `HIGHLIGHTED`) VALUES (2, 5125, 'The spirit of tradition, renovated by the most modern technologies and design.', 'Pink fantasy', 3500, 'upload/small_table_1.jpg', 19, 0);
INSERT INTO `PRODUCT` (`oid`, `CODE`, `DESCRIPTION`, `NAME`, `PRICE`, `THUMBNAIL`, `category_oid`, `HIGHLIGHTED`) VALUES (3, 5125, 'Brighten up your living room with warmly illuminating ideas.', 'Allair', 4550, 'upload/small_chair_2.jpg', 20, 0);
INSERT INTO `PRODUCT` (`oid`, `CODE`, `DESCRIPTION`, `NAME`, `PRICE`, `THUMBNAIL`, `category_oid`, `HIGHLIGHTED`) VALUES (4, 6755, 'The spirit of tradition, renovated by the most modern technologies and design.', 'Amplitude', 3000, 'upload/small_chair_2.jpg', 20, 0);
INSERT INTO `PRODUCT` (`oid`, `CODE`, `DESCRIPTION`, `NAME`, `PRICE`, `THUMBNAIL`, `category_oid`, `HIGHLIGHTED`) VALUES (5, 8630, 'Perfect for your office, unbeatable for your home, the most versatile interior design is found at Acme.', 'Baronetto', 3000, 'upload/small_lamp_4.jpg', 21, 0);
INSERT INTO `PRODUCT` (`oid`, `CODE`, `DESCRIPTION`, `NAME`, `PRICE`, `THUMBNAIL`, `category_oid`, `HIGHLIGHTED`) VALUES (6, 1243, 'Make your house a home with the best interior design and the unprecedented quality of our products.', 'Atlas', 1000, 'upload/small_table_4.jpg', 19, 0);
INSERT INTO `PRODUCT` (`oid`, `CODE`, `DESCRIPTION`, `NAME`, `PRICE`, `THUMBNAIL`, `category_oid`, `HIGHLIGHTED`) VALUES (7, 1237, 'Perfect for your office, unbeatable for your home, the most versatile interior design is found at Acme.', 'Aladdin', 1500, 'upload/small_table_1.jpg', 19, 1);
INSERT INTO `PRODUCT` (`oid`, `CODE`, `DESCRIPTION`, `NAME`, `PRICE`, `THUMBNAIL`, `category_oid`, `HIGHLIGHTED`) VALUES (8, 7145, 'High quality Italian design for relaxing and enjoying life with your family and friends.', 'Silvestream', 1500, 'upload/small_lamp_1.jpg', 21, 0);
INSERT INTO `PRODUCT` (`oid`, `CODE`, `DESCRIPTION`, `NAME`, `PRICE`, `THUMBNAIL`, `category_oid`, `HIGHLIGHTED`) VALUES (9, 4678, 'Perfect for your office, unbeatable for your home, the most versatile interior design is found at Acme.', 'Sara', 500, 'upload/small_lamp_2.jpg', 21, 0);
INSERT INTO `PRODUCT` (`oid`, `CODE`, `DESCRIPTION`, `NAME`, `PRICE`, `THUMBNAIL`, `category_oid`, `HIGHLIGHTED`) VALUES (10, 1243, 'Meet with friends in the comfort of a stylish and functional setting.', 'Mambo', 1000, 'upload/small_table_1.jpg', 19, 0);
INSERT INTO `PRODUCT` (`oid`, `CODE`, `DESCRIPTION`, `NAME`, `PRICE`, `THUMBNAIL`, `category_oid`, `HIGHLIGHTED`) VALUES (11, 1237, 'Stainless steel meets crystal and silk to make the comfort and look.', 'Euclid', 4550, 'upload/small_table_1.jpg', 19, 0);
INSERT INTO `PRODUCT` (`oid`, `CODE`, `DESCRIPTION`, `NAME`, `PRICE`, `THUMBNAIL`, `category_oid`, `HIGHLIGHTED`) VALUES (13, 4678, 'Create your space and make it flexible enough to fit whatever the moment calls for, from meeting friends to enjoying your family.', 'Andros', 1200, 'upload/small_lamp_1.jpg', 21, 0);
INSERT INTO `PRODUCT` (`oid`, `CODE`, `DESCRIPTION`, `NAME`, `PRICE`, `THUMBNAIL`, `category_oid`, `HIGHLIGHTED`) VALUES (14, 7145, 'High quality Italian design for relaxing and enjoying life with your family and friends.', 'Byron', 1000, 'upload/small_chair_3.jpg', NULL, 0);
INSERT INTO `PRODUCT` (`oid`, `CODE`, `DESCRIPTION`, `NAME`, `PRICE`, `THUMBNAIL`, `category_oid`, `HIGHLIGHTED`) VALUES (16, 1237, 'Create your space and make it flexible enough to fit whatever the moment calls for, from meeting friends to enjoying your family.', 'Landscape', 500, 'upload/small_table_3.jpg', 19, 0);
INSERT INTO `PRODUCT` (`oid`, `CODE`, `DESCRIPTION`, `NAME`, `PRICE`, `THUMBNAIL`, `category_oid`, `HIGHLIGHTED`) VALUES (17, 4123, 'The spirit of tradition, renovated by the most modern technologies and design.', 'Rodolfo', 4550, 'upload/small_table_1.jpg', 19, 0);
INSERT INTO `PRODUCT` (`oid`, `CODE`, `DESCRIPTION`, `NAME`, `PRICE`, `THUMBNAIL`, `category_oid`, `HIGHLIGHTED`) VALUES (21, 9876, 'A fabulous piece of furniture for relaxing with friends.', 'Lucid', 234, 'upload/small_table_5.jpg', 19, 0);
INSERT INTO `PRODUCT` (`oid`, `CODE`, `DESCRIPTION`, `NAME`, `PRICE`, `THUMBNAIL`, `category_oid`, `HIGHLIGHTED`) VALUES (22, 3456, 'A marvellous lamp shedding a new light to your family life.', 'Blue Fountain', 124, 'upload/small_lamp_5.jpg', 21, 0);



INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (1, 'The spirit of tradition, renovated by the most modern technologies and design.', 'upload/lamp_2.jpg', 14);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (2, 'High quality Italian design for relaxing and enjoying life with your family and friends.', 'upload/table_2.jpg', NULL);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (3, 'Brighten up your living room with warmly illuminating ideas.', 'upload/table_1.jpg', 11);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (4, 'Meet with friends in the comfort of a stylish and functional setting.', 'upload/lamp_4.jpg', 11);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (5, 'Perfect for your office, unbeatable for your home, the most versatile interior design is found at Acme.', 'upload/chair_3.jpg', 3);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (6, 'Brighten up your living room with warmly illuminating ideas.', 'upload/lamp_4.jpg', 4);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (7, 'Perfect for your office, unbeatable for your home, the most versatile interior design is found at Acme.', 'upload/lamp_3.jpg', 10);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (8, 'Make your house a home with the best interior design and the unprecedented quality of our products.', 'upload/lamp_1.jpg', 17);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (9, 'The spirit of tradition, renovated by the most modern technologies and design.', 'upload/table_3.jpg', 2);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (10, 'Brighten up your living room with warmly illuminating ideas.', 'upload/chair_1.jpg', 3);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (11, 'Meet with friends in the comfort of a stylish and functional setting.', 'upload/table_5.jpg', 8);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (12, 'High quality Italian design for relaxing and enjoying life with your family and friends.', 'upload/table_1.jpg', NULL);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (13, 'The spirit of tradition, renovated by the most modern technologies and design.', 'upload/table_5.jpg', NULL);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (14, 'Stainless steel meets crystal and silk to make the comfort and look.', 'upload/lamp_5.jpg', NULL);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (15, 'The spirit of tradition, renovated by the most modern technologies and design.', 'upload/chair_1.jpg', NULL);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (16, 'Make your house a home with the best interior design and the unprecedented quality of our products.', 'upload/lamp_5.jpg', 1);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (17, 'High quality Italian design for relaxing and enjoying life with your family and friends.', 'upload/table_4.jpg', 9);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (18, 'Stainless steel meets crystal and silk to make the comfort and look.', 'upload/chair_3.jpg', 6);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (19, 'The spirit of tradition, renovated by the most modern technologies and design.', 'upload/chair_4.jpg', 16);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (20, 'Brighten up your living room with warmly illuminating ideas.', 'upload/table_4.jpg', 2);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (21, 'Brighten up your living room with warmly illuminating ideas.', 'upload/lamp_5.jpg', 8);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (22, 'Meet with friends in the comfort of a stylish and functional setting.', 'upload/lamp_2.jpg', 7);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (23, 'Brighten up your living room with warmly illuminating ideas.', 'upload/table_2.jpg', 14);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (24, 'Perfect for your office, unbeatable for your home, the most versatile interior design is found at Acme.', 'upload/chair_5.jpg', NULL);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (25, 'Make your house a home with the best interior design and the unprecedented quality of our products.', 'upload/table_2.jpg', NULL);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (26, 'The spirit of tradition, renovated by the most modern technologies and design.', 'upload/chair_4.jpg', 16);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (27, 'Meet with friends in the comfort of a stylish and functional setting.', 'upload/table_4.jpg', NULL);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (28, 'Create your space and make it flexible enough to fit whatever the moment calls for, from meeting friends to enjoying your family.', 'upload/table_5.jpg', 10);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (29, 'Create your space and make it flexible enough to fit whatever the moment calls for, from meeting friends to enjoying your family.', 'upload/chair_1.jpg', 11);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (30, 'Perfect for your office, unbeatable for your home, the most versatile interior design is found at Acme.', 'upload/chair_5.jpg', 4);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (31, 'Brighten up your living room with warmly illuminating ideas.', 'upload/chair_5.jpg', 1);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (32, 'Perfect for your office, unbeatable for your home, the most versatile interior design is found at Acme.', 'upload/table_4.jpg', 11);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (33, 'Brighten up your living room with warmly illuminating ideas.', 'upload/lamp_4.jpg', 16);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (34, 'Stainless steel meets crystal and silk to make the comfort and look.', 'upload/lamp_4.jpg', 17);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (35, 'Create your space and make it flexible enough to fit whatever the moment calls for, from meeting friends to enjoying your family.', 'upload/lamp_5.jpg', NULL);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (36, 'Make your house a home with the best interior design and the unprecedented quality of our products.', 'upload/lamp_3.jpg', 8);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (37, 'High quality Italian design for relaxing and enjoying life with your family and friends.', 'upload/table_1.jpg', NULL);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (38, 'The spirit of tradition, renovated by the most modern technologies and design.', 'upload/chair_2.jpg', NULL);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (39, 'The spirit of tradition, renovated by the most modern technologies and design.', 'upload/table_2.jpg', 3);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (40, 'Make your house a home with the best interior design and the unprecedented quality of our products.', 'upload/table_4.jpg', NULL);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (41, 'Perfect for your office, unbeatable for your home, the most versatile interior design is found at Acme.', 'upload/lamp_4.jpg', NULL);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (42, 'Perfect for your office, unbeatable for your home, the most versatile interior design is found at Acme.', 'upload/table_5.jpg', 13);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (43, 'Meet with friends in the comfort of a stylish and functional setting.', 'upload/lamp_4.jpg', NULL);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (44, 'Brighten up your living room with warmly illuminating ideas.', 'upload/lamp_3.jpg', 16);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (45, 'Perfect for your office, unbeatable for your home, the most versatile interior design is found at Acme.', 'upload/table_3.jpg', NULL);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (46, 'Create your space and make it flexible enough to fit whatever the moment calls for, from meeting friends to enjoying your family.', 'upload/chair_4.jpg', 4);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (47, 'Brighten up your living room with warmly illuminating ideas.', 'upload/table_5.jpg', 5);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (48, 'The spirit of tradition, renovated by the most modern technologies and design.', 'upload/table_4.jpg', 13);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (49, 'High quality Italian design for relaxing and enjoying life with your family and friends.', 'upload/table_3.jpg', 8);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (50, 'Meet with friends in the comfort of a stylish and functional setting.', 'upload/chair_3.jpg', 11);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (51, 'Brighten up your living room with warmly illuminating ideas.', 'upload/chair_4.jpg', 4);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (52, 'Brighten up your living room with warmly illuminating ideas.', 'upload/chair_4.jpg', 4);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (53, 'The spirit of tradition, renovated by the most modern technologies and design.', 'upload/table_2.jpg', 3);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (54, 'Make your house a home with the best interior design and the unprecedented quality of our products.', 'upload/chair_4.jpg', 16);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (55, 'High quality Italian design for relaxing and enjoying life with your family and friends.', 'upload/table_3.jpg', 17);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (56, 'Stainless steel meets crystal and silk to make the comfort and look.', 'upload/lamp_3.jpg', 11);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (57, 'Meet with friends in the comfort of a stylish and functional setting.', 'upload/table_2.jpg', 10);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (58, 'Meet with friends in the comfort of a stylish and functional setting.', 'upload/lamp_1.jpg', 1);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (59, 'Meet with friends in the comfort of a stylish and functional setting.', 'upload/table_5.jpg', NULL);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (60, 'Brighten up your living room with warmly illuminating ideas.', 'upload/lamp_5.jpg', 11);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (61, 'Brighten up your living room with warmly illuminating ideas.', 'upload/chair_2.jpg', NULL);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (62, 'Create your space and make it flexible enough to fit whatever the moment calls for, from meeting friends to enjoying your family.', 'upload/table_3.jpg', NULL);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (63, 'High quality Italian design for relaxing and enjoying life with your family and friends.', 'upload/chair_3.jpg', 9);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (64, 'The spirit of tradition, renovated by the most modern technologies and design.', 'upload/chair_1.jpg', 17);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (65, 'Make your house a home with the best interior design and the unprecedented quality of our products.', 'upload/table_4.jpg', 10);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (66, 'Meet with friends in the comfort of a stylish and functional setting.', 'upload/lamp_3.jpg', 1);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (67, 'Meet with friends in the comfort of a stylish and functional setting.', 'upload/table_3.jpg', 3);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (68, 'Meet with friends in the comfort of a stylish and functional setting.', 'upload/lamp_3.jpg', 2);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (69, 'Meet with friends in the comfort of a stylish and functional setting.', 'upload/chair_3.jpg', 6);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (70, 'Stainless steel meets crystal and silk to make the comfort and look.', 'upload/table_4.jpg', 3);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (71, 'High quality Italian design for relaxing and enjoying life with your family and friends.', 'upload/chair_3.jpg', 8);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (72, 'Brighten up your living room with warmly illuminating ideas.', 'upload/chair_4.jpg', 1);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (73, 'Create your space and make it flexible enough to fit whatever the moment calls for, from meeting friends to enjoying your family.', 'upload/table_5.jpg', 2);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (74, 'The spirit of tradition, renovated by the most modern technologies and design.', 'upload/lamp_4.jpg', NULL);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (75, 'Meet with friends in the comfort of a stylish and functional setting.', 'upload/lamp_1.jpg', 4);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (76, 'Brighten up your living room with warmly illuminating ideas.', 'upload/table_5.jpg', 7);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (77, 'Stainless steel meets crystal and silk to make the comfort and look.', 'upload/chair_5.jpg', 3);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (78, 'The spirit of tradition, renovated by the most modern technologies and design.', 'upload/lamp_1.jpg', 3);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (79, 'Brighten up your living room with warmly illuminating ideas.', 'upload/lamp_3.jpg', 7);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (80, 'Stainless steel meets crystal and silk to make the comfort and look.', 'upload/lamp_1.jpg', 10);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (81, 'Create your space and make it flexible enough to fit whatever the moment calls for, from meeting friends to enjoying your family.', 'upload/chair_4.jpg', 6);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (82, 'High quality Italian design for relaxing and enjoying life with your family and friends.', 'upload/table_2.jpg', 13);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (83, 'High quality Italian design for relaxing and enjoying life with your family and friends.', 'upload/table_4.jpg', 17);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (84, 'Meet with friends in the comfort of a stylish and functional setting.', 'upload/lamp_3.jpg', 11);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (85, 'The spirit of tradition, renovated by the most modern technologies and design.', 'upload/chair_2.jpg', NULL);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (86, 'Create your space and make it flexible enough to fit whatever the moment calls for, from meeting friends to enjoying your family.', 'upload/table_2.jpg', 9);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (87, 'The spirit of tradition, renovated by the most modern technologies and design.', 'upload/lamp_4.jpg', 5);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (88, 'Stainless steel meets crystal and silk to make the comfort and look.', 'upload/chair_3.jpg', NULL);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (89, 'Make your house a home with the best interior design and the unprecedented quality of our products.', 'upload/table_3.jpg', NULL);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (90, 'Meet with friends in the comfort of a stylish and functional setting.', 'upload/lamp_1.jpg', 1);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (91, 'Stainless steel meets crystal and silk to make the comfort and look.', 'upload/table_2.jpg', 16);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (92, 'Make your house a home with the best interior design and the unprecedented quality of our products.', 'upload/lamp_4.jpg', 17);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (93, 'Perfect for your office, unbeatable for your home, the most versatile interior design is found at Acme.', 'upload/lamp_3.jpg', 4);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (94, 'Make your house a home with the best interior design and the unprecedented quality of our products.', 'upload/table_5.jpg', 11);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (95, 'Create your space and make it flexible enough to fit whatever the moment calls for, from meeting friends to enjoying your family.', 'upload/chair_4.jpg', NULL);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (96, 'Create your space and make it flexible enough to fit whatever the moment calls for, from meeting friends to enjoying your family.', 'upload/lamp_2.jpg', 2);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (97, 'Stainless steel meets crystal and silk to make the comfort and look.', 'upload/table_2.jpg', NULL);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (98, 'The spirit of tradition, renovated by the most modern technologies and design.', 'upload/chair_2.jpg', NULL);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (99, 'Perfect for your office, unbeatable for your home, the most versatile interior design is found at Acme.', 'upload/lamp_4.jpg', 6);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (100, 'Brighten up your living room with warmly illuminating ideas.', 'upload/lamp_4.jpg', 5);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (101, 'A speheric object for a spheric world.', 'upload/image2.jpg', NULL);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (102, 'See the beauty of this article in the glitter of the night.', 'upload/lamp_5.jpg', 22);
INSERT INTO `image` (`oid`, `DESCRIPTION`, `PICTURE`, `product_oid`) VALUES (103, 'A mix of technology and innovative design that will add value to your h', 'upload/lamp_4.jpg', 22);



INSERT INTO `COMBINATION` (`oid`, `CODE`, `DESCRIPTION`, `NAME`, `PRICE`, `PHOTO`, `start_date`, `end_date`, `HIGHLIGHTED`) VALUES (1, 1237, 'Perfect for your office, unbeatable for your home, the most versatile interior design is found at Acme.', 'Home Bargain', 3000, 'upload/combo_2.jpg', '2002-01-01 00:00:00', '2003-01-01 00:00:00', 1);
INSERT INTO `COMBINATION` (`oid`, `CODE`, `DESCRIPTION`, `NAME`, `PRICE`, `PHOTO`, `start_date`, `end_date`, `HIGHLIGHTED`) VALUES (2, 9898, 'Make your house a home with the best interior design and the unprecedented quality of our products.', 'Style & Value', 4550, 'upload/combo_1.jpg', '2002-02-05 00:00:00', '2002-11-03 00:00:00', 0);
INSERT INTO `COMBINATION` (`oid`, `CODE`, `DESCRIPTION`, `NAME`, `PRICE`, `PHOTO`, `start_date`, `end_date`, `HIGHLIGHTED`) VALUES (3, 1237, 'Meet with friends in the comfort of a stylish and functional setting.', 'Pick of the site', 500, 'upload/combo_3.jpg', '2002-01-01 00:00:00', '2003-01-01 00:00:00', 0);
INSERT INTO `COMBINATION` (`oid`, `CODE`, `DESCRIPTION`, `NAME`, `PRICE`, `PHOTO`, `start_date`, `end_date`, `HIGHLIGHTED`) VALUES (4, 4123, 'Perfect for your office, unbeatable for your home, the most versatile interior design is found at Acme.', 'Value set', 3500, 'upload/combo_3.jpg', '2002-07-31 00:00:00', '2003-07-09 00:00:00', 0);
INSERT INTO `COMBINATION` (`oid`, `CODE`, `DESCRIPTION`, `NAME`, `PRICE`, `PHOTO`, `start_date`, `end_date`, `HIGHLIGHTED`) VALUES (5, 1243, 'Make your house a home with the best interior design and the unprecedented quality of our products.', 'Big Bundle', 2000, 'upload/combo_1.jpg', '2002-01-01 00:00:00', '2003-01-01 00:00:00', 0);
INSERT INTO `COMBINATION` (`oid`, `CODE`, `DESCRIPTION`, `NAME`, `PRICE`, `PHOTO`, `start_date`, `end_date`, `HIGHLIGHTED`) VALUES (6, 6755, 'Perfect for your office, unbeatable for your home, the most versatile interior design is found at Acme.', 'Special of the day', 500, 'upload/combo_2.jpg', '2002-01-01 00:00:00', '2003-01-01 00:00:00', 0);
INSERT INTO `COMBINATION` (`oid`, `CODE`, `DESCRIPTION`, `NAME`, `PRICE`, `PHOTO`, `start_date`, `end_date`, `HIGHLIGHTED`) VALUES (7, 9871, 'Perfect for your office, unbeatable for your home, the most versatile interior design is found at Acme.', 'Christmas Special', 3000, 'upload/combo_5.jpg', '2002-03-06 00:00:00', '2002-10-01 00:00:00', 0);



INSERT INTO `PRODUCT_COMBINATION` (`product_oid`, `combination_oid`) VALUES (2, 2);
INSERT INTO `PRODUCT_COMBINATION` (`product_oid`, `combination_oid`) VALUES (2, 3);
INSERT INTO `PRODUCT_COMBINATION` (`product_oid`, `combination_oid`) VALUES (2, 5);
INSERT INTO `PRODUCT_COMBINATION` (`product_oid`, `combination_oid`) VALUES (2, 7);
INSERT INTO `PRODUCT_COMBINATION` (`product_oid`, `combination_oid`) VALUES (3, 7);
INSERT INTO `PRODUCT_COMBINATION` (`product_oid`, `combination_oid`) VALUES (4, 3);
INSERT INTO `PRODUCT_COMBINATION` (`product_oid`, `combination_oid`) VALUES (4, 4);
INSERT INTO `PRODUCT_COMBINATION` (`product_oid`, `combination_oid`) VALUES (5, 2);
INSERT INTO `PRODUCT_COMBINATION` (`product_oid`, `combination_oid`) VALUES (5, 6);
INSERT INTO `PRODUCT_COMBINATION` (`product_oid`, `combination_oid`) VALUES (5, 7);
INSERT INTO `PRODUCT_COMBINATION` (`product_oid`, `combination_oid`) VALUES (7, 2);
INSERT INTO `PRODUCT_COMBINATION` (`product_oid`, `combination_oid`) VALUES (7, 3);
INSERT INTO `PRODUCT_COMBINATION` (`product_oid`, `combination_oid`) VALUES (8, 1);
INSERT INTO `PRODUCT_COMBINATION` (`product_oid`, `combination_oid`) VALUES (8, 7);
INSERT INTO `PRODUCT_COMBINATION` (`product_oid`, `combination_oid`) VALUES (9, 4);
INSERT INTO `PRODUCT_COMBINATION` (`product_oid`, `combination_oid`) VALUES (10, 2);
INSERT INTO `PRODUCT_COMBINATION` (`product_oid`, `combination_oid`) VALUES (11, 2);
INSERT INTO `PRODUCT_COMBINATION` (`product_oid`, `combination_oid`) VALUES (11, 3);
INSERT INTO `PRODUCT_COMBINATION` (`product_oid`, `combination_oid`) VALUES (11, 6);
INSERT INTO `PRODUCT_COMBINATION` (`product_oid`, `combination_oid`) VALUES (13, 4);
INSERT INTO `PRODUCT_COMBINATION` (`product_oid`, `combination_oid`) VALUES (13, 5);
INSERT INTO `PRODUCT_COMBINATION` (`product_oid`, `combination_oid`) VALUES (14, 5);
INSERT INTO `PRODUCT_COMBINATION` (`product_oid`, `combination_oid`) VALUES (21, 2);
INSERT INTO `PRODUCT_COMBINATION` (`product_oid`, `combination_oid`) VALUES (21, 5);
INSERT INTO `PRODUCT_COMBINATION` (`product_oid`, `combination_oid`) VALUES (22, 4);



INSERT INTO `STORE` (`oid`, `ADDRESS`, `EMAIL`, `MAP`, `PHOTO`) VALUES (1, 'Oslo', 'mailto:customer-care@acme.com', 'upload/map_1.jpg', 'upload/location_1.jpg');
INSERT INTO `STORE` (`oid`, `ADDRESS`, `EMAIL`, `MAP`, `PHOTO`) VALUES (2, 'Barcelona', 'mailto:customer-care@acme.com', 'upload/map_1.jpg', 'upload/location_1.jpg');
INSERT INTO `STORE` (`oid`, `ADDRESS`, `EMAIL`, `MAP`, `PHOTO`) VALUES (3, 'New York', 'mailto:customer-care@acme.com', 'upload/map_1.jpg', 'upload/location_1.jpg');
INSERT INTO `STORE` (`oid`, `ADDRESS`, `EMAIL`, `MAP`, `PHOTO`) VALUES (5, 'Montreal', 'mailto:customer-care@acme.com', 'upload/map_1.jpg', 'upload/location_1.jpg');
INSERT INTO `STORE` (`oid`, `ADDRESS`, `EMAIL`, `MAP`, `PHOTO`) VALUES (6, 'Hamburg', 'mailto:customer-care@acme.com', 'upload/map_1.jpg', 'upload/location_1.jpg');
INSERT INTO `STORE` (`oid`, `ADDRESS`, `EMAIL`, `MAP`, `PHOTO`) VALUES (7, 'Berlin', 'mailto:customer-care@acme.com', 'upload/map_1.jpg', 'upload/location_1.jpg');
INSERT INTO `STORE` (`oid`, `ADDRESS`, `EMAIL`, `MAP`, `PHOTO`) VALUES (8, 'Hong Kong', 'mailto:customer-care@acme.com', 'upload/map_1.jpg', 'upload/location_1.jpg');
INSERT INTO `STORE` (`oid`, `ADDRESS`, `EMAIL`, `MAP`, `PHOTO`) VALUES (9, 'Madrid', 'mailto:customer-care@acme.com', 'upload/map_1.jpg', 'upload/location_1.jpg');
INSERT INTO `STORE` (`oid`, `ADDRESS`, `EMAIL`, `MAP`, `PHOTO`) VALUES (10, 'Copenhagen', 'mailto:customer-care@acme.com', 'upload/map_1.jpg', 'upload/location_1.jpg');
INSERT INTO `STORE` (`oid`, `ADDRESS`, `EMAIL`, `MAP`, `PHOTO`) VALUES (11, 'Chicago', 'mailto:customer-care@acme.com', 'upload/map_1.jpg', 'upload/location_1.jpg');
INSERT INTO `STORE` (`oid`, `ADDRESS`, `EMAIL`, `MAP`, `PHOTO`) VALUES (12, 'London', 'mailto:customer-care@acme.com', 'upload/map_1.jpg', 'upload/location_1.jpg');
INSERT INTO `STORE` (`oid`, `ADDRESS`, `EMAIL`, `MAP`, `PHOTO`) VALUES (13, 'Sidney', 'mailto:customer-care@acme.com', 'upload/map_1.jpg', 'upload/location_1.jpg');
INSERT INTO `STORE` (`oid`, `ADDRESS`, `EMAIL`, `MAP`, `PHOTO`) VALUES (15, 'Tokio', 'mailto:customer-care@acme.com', 'upload/map_1.jpg', 'upload/location_1.jpg');



INSERT INTO `tech_record` (`oid`, `COLORS`, `DIMENSIONS`) VALUES (1, 'upload/colors.jpg', '144x34x300');
INSERT INTO `tech_record` (`oid`, `COLORS`, `DIMENSIONS`) VALUES (2, 'upload/colors.jpg', '144x111x100');
INSERT INTO `tech_record` (`oid`, `COLORS`, `DIMENSIONS`) VALUES (3, 'upload/colors.jpg', '144x34x300');
INSERT INTO `tech_record` (`oid`, `COLORS`, `DIMENSIONS`) VALUES (4, 'upload/colors.jpg', '144x34x100');
INSERT INTO `tech_record` (`oid`, `COLORS`, `DIMENSIONS`) VALUES (5, 'upload/colors.jpg', '144x111x100');
INSERT INTO `tech_record` (`oid`, `COLORS`, `DIMENSIONS`) VALUES (6, 'upload/colors.jpg', '11x23x23');
INSERT INTO `tech_record` (`oid`, `COLORS`, `DIMENSIONS`) VALUES (7, 'upload/colors.jpg', '144x23x170');
INSERT INTO `tech_record` (`oid`, `COLORS`, `DIMENSIONS`) VALUES (8, 'upload/colors.jpg', '144x34x100');
INSERT INTO `tech_record` (`oid`, `COLORS`, `DIMENSIONS`) VALUES (9, 'upload/colors.jpg', '144x34x150');
INSERT INTO `tech_record` (`oid`, `COLORS`, `DIMENSIONS`) VALUES (10, 'upload/colors.jpg', '144x34x300');
INSERT INTO `tech_record` (`oid`, `COLORS`, `DIMENSIONS`) VALUES (11, 'upload/colors.jpg', '144x34x150');
INSERT INTO `tech_record` (`oid`, `COLORS`, `DIMENSIONS`) VALUES (12, 'upload/colors.jpg', '144x34x150');
INSERT INTO `tech_record` (`oid`, `COLORS`, `DIMENSIONS`) VALUES (13, 'upload/colors.jpg', '144x111x100');
INSERT INTO `tech_record` (`oid`, `COLORS`, `DIMENSIONS`) VALUES (14, 'upload/colors.jpg', '144x11x130');
INSERT INTO `tech_record` (`oid`, `COLORS`, `DIMENSIONS`) VALUES (15, 'upload/colors.jpg', '144x11x130');
INSERT INTO `tech_record` (`oid`, `COLORS`, `DIMENSIONS`) VALUES (16, 'upload/colors.jpg', '144x111x100');
INSERT INTO `tech_record` (`oid`, `COLORS`, `DIMENSIONS`) VALUES (17, 'upload/colors.jpg', '144x34x300');
INSERT INTO `tech_record` (`oid`, `COLORS`, `DIMENSIONS`) VALUES (18, 'upload/colors.jpg', '544x33x100');
INSERT INTO `tech_record` (`oid`, `COLORS`, `DIMENSIONS`) VALUES (19, 'upload/colors.jpg', '144x111x100');
INSERT INTO `tech_record` (`oid`, `COLORS`, `DIMENSIONS`) VALUES (20, 'upload/colors.jpg', '144x11x130');
INSERT INTO `tech_record` (`oid`, `COLORS`, `DIMENSIONS`) VALUES (21, 'upload/colors.jpg', '23x45x67');
INSERT INTO `tech_record` (`oid`, `COLORS`, `DIMENSIONS`) VALUES (22, 'upload/colors.jpg', '4x5x6');
INSERT INTO `tech_record` (`oid`, `COLORS`, `DIMENSIONS`) VALUES (23, 'upload/colors.jpg', '12x34x11');



INSERT INTO `techrecord_product` (`product_oid`, `tech_record_oid`) VALUES (1, 12);
INSERT INTO `techrecord_product` (`product_oid`, `tech_record_oid`) VALUES (2, 9);
INSERT INTO `techrecord_product` (`product_oid`, `tech_record_oid`) VALUES (3, 13);
INSERT INTO `techrecord_product` (`product_oid`, `tech_record_oid`) VALUES (4, 15);
INSERT INTO `techrecord_product` (`product_oid`, `tech_record_oid`) VALUES (5, 3);
INSERT INTO `techrecord_product` (`product_oid`, `tech_record_oid`) VALUES (6, 8);
INSERT INTO `techrecord_product` (`product_oid`, `tech_record_oid`) VALUES (7, 2);
INSERT INTO `techrecord_product` (`product_oid`, `tech_record_oid`) VALUES (8, 17);
INSERT INTO `techrecord_product` (`product_oid`, `tech_record_oid`) VALUES (9, 14);
INSERT INTO `techrecord_product` (`product_oid`, `tech_record_oid`) VALUES (10, 1);
INSERT INTO `techrecord_product` (`product_oid`, `tech_record_oid`) VALUES (11, 19);
INSERT INTO `techrecord_product` (`product_oid`, `tech_record_oid`) VALUES (13, 10);
INSERT INTO `techrecord_product` (`product_oid`, `tech_record_oid`) VALUES (14, 20);
INSERT INTO `techrecord_product` (`product_oid`, `tech_record_oid`) VALUES (16, 5);
INSERT INTO `techrecord_product` (`product_oid`, `tech_record_oid`) VALUES (17, 6);
INSERT INTO `techrecord_product` (`product_oid`, `tech_record_oid`) VALUES (21, 21);
INSERT INTO `techrecord_product` (`product_oid`, `tech_record_oid`) VALUES (22, 23);


INSERT INTO `USER` (`user_id`, `first_name`, `last_name`) VALUES ('manager', 'app', 'manager');
INSERT INTO `USER` (`user_id`, `first_name`, `last_name`) VALUES ('john', 'john', 'doe');
INSERT INTO `USER` (`user_id`, `first_name`, `last_name`) VALUES ('RemoteActionsUser', 'RemoteActionsUser', 'RemoteActionsUser');


INSERT INTO `application` VALUES ('TestApp',2592000,3600,NULL,'K+XacLXyrbiurt0aX255xK+81DUcJstD/0VH523U9/L9QtGEal0ffPXTzqaLgYulT9jvT0+LgeySybtpiMkF4dXrkjU=','The application being testeds','TestApp','WEB');
INSERT INTO `application` VALUES ('RemoteActions',2592000,3600,NULL,'OhA9oFgVECpviDScOTC27zeAHMVGqFIl4Z16mgLgYx6CMW8K9iBHvLRFeZR+gEcoghOH33WrOZOmS+kN76XRnUTBlWo=','RemoteActions','RemoteActions','WEB');
INSERT INTO `application` VALUES ('AcmeDS',2592000,3600,NULL,'Zu1ztNYcyYHuVdZyBFxaWVFXiBscWyJ9edEYbstf7dm/XduZ9SVsFtL4pvujSXkC3IR2pD53oP1e/dZE7aUjXvQTaZo=','Form','Form','WEB');
INSERT INTO `authorized_grant_type` VALUES (4,'client_credentials','TestApp'),(5,'password','TestApp'),(6,'refresh_token','TestApp');
INSERT INTO `authorized_grant_type` VALUES (7,'client_credentials','RemoteActions'),(8,'password','RemoteActions'),(9,'refresh_token','RemoteActions');
INSERT INTO `authorized_resource` VALUES (5,'gateway-resource','TestApp'),(6,'AcmeDS','TestApp');
INSERT INTO `authorized_resource` VALUES (7,'AcmeDS','RemoteActions'),(8,'gateway-resource','RemoteActions');
INSERT INTO `identity` VALUES (0,0,'CDQDYubDrvkbju7mw24HFEcDPQKCLea1RbXfWBna9eqoeOvUoOormSTJQShLRgnkGKXIA8bVK8Ww1TFVTSdZH66Dx3s=','admin',0,0,NULL,'wradmin@webratio.com',0,'admin','admin');
INSERT INTO `identity` VALUES (0,0,'TG6wyj3ZQSfKcfuwjWzj3eCxpjbAb1X3M4g+Hu5XQkKIBMjlYfNakSt6sfrl2nMp1FuZVU6QPfoQL5N4O01sOKMki0A=','manager',0,0,NULL,'wradmin@webratio.com',0,'app', 'manager');
INSERT INTO `identity` VALUES (0,0,'OeY6IOmwf+sk00Mahy76kV5rVcZqCY3ev29oqDoTL4/jbhVOBkyPV4zXAAdUIGMFvu2Zg0YOJJiJZTqcIRXL+vsh8DU=','expiredpwd',0,0,'2017-12-31 23:59:59','wradmin@webratio.com',0,'expiredpwd','expiredpwd');
INSERT INTO `identity` VALUES (1,0,'4zwOaKOddNqeuOUNLq9y8skhSNSJZgTS6nE5XTVddPKxFx7Mw5lirpfNzOfZgM2aXt/+Tqv81mKfya1FnLxZOqgC7RQ=', 'expired', 0, 0, '2020-12-31 23:59:59.000', 'wradmin@webratio.com', 0,'expired','expired');
INSERT INTO `identity` VALUES (0,1,'61T4ge/+3OYhO8MOAzrItKbCu66lLpgiK17Dk51dSOmLkvGHhuiri9XJEXOLmdPwUUuG3xMxAmsLlE50hJo31iv1wlw=', 'locked', 0, 0, '2020-12-31 23:59:59.000', 'wradmin@webratio.com', 0,'locked','locked');
INSERT INTO `identity` VALUES (0,0,'rZRx1FMtovhGAiohgvkbUSNjy2f0bCDRoWr8DH00E57vM7PUvRNtpSqZPfxHVguajImBHDGGk/wjcIxe1C+y8olv1I8=', 'disabled', 1, 0, '2020-12-31 23:59:59.000', 'wradmin@webratio.com', 0,'disabled','disabled');
INSERT INTO `identity` VALUES (0,0,'PeV+OAANiPPrVP/htgGeGQv7jkAVFZc84TmCRjv9JNKF4z1FOByBBSPnLAlz2TkVezdsJy2TwT/UxawCQfRvkPRnXn0=', 'john', 0, 0, NULL, 'john.doe@acme.com', 0,'john', 'doe');
INSERT INTO `identity` VALUES (0,0,'ixv/Ju5HYpuOO+SvH7q1gK7WzkRmvzT/tf064k2Vk4T4pxzQ0GLSmj4v+yadvJFHuAAswCgA1IxvdRFgfLwmFkku8bo=','RemoteActionsUser',0,0,NULL,'RemoteActionsUser@domain.com',0,'RemoteActionsUser', 'RemoteActionsUser');
INSERT INTO `approval` (`status`, `scope`, `oid`, `application_app_id`, `identity_user_id`) VALUES ('APPROVED', 'managers', 4, 'TestApp', 'manager');
INSERT INTO `approval` (`status`, `scope`, `oid`, `application_app_id`, `identity_user_id`) VALUES ('APPROVED', 'customers', 5, 'TestApp', 'manager');
INSERT INTO `approval` (`status`, `scope`, `oid`, `application_app_id`, `identity_user_id`) VALUES ('APPROVED', 'customers', 6, 'TestApp', 'john');
INSERT INTO `approval` (`status`, `scope`, `oid`, `application_app_id`, `identity_user_id`) VALUES ('APPROVED','password_change',8,'RemoteActions','RemoteActionsUser');
INSERT INTO `approval` (`status`, `scope`, `oid`, `application_app_id`, `identity_user_id`) VALUES ('APPROVED', 'managers', 9, 'AcmeDS', 'manager');
INSERT INTO `approval` (`status`, `scope`, `oid`, `application_app_id`, `identity_user_id`) VALUES ('APPROVED', 'customers', 10, 'AcmeDS', 'manager');
INSERT INTO `approval` (`status`, `scope`, `oid`, `application_app_id`, `identity_user_id`) VALUES ('APPROVED', 'customers', 11, 'AcmeDS', 'john');
INSERT INTO `approval` (`status`, `scope`, `oid`, `application_app_id`, `identity_user_id`) VALUES ('APPROVED', 'adm', 12, 'AcmeDS', 'manager');
INSERT INTO `scope` (`oid`, `auto_approve`, `name`, `application_app_id`) VALUES (5, 1, 'identity_registration', 'TestApp');
INSERT INTO `scope` (`oid`, `auto_approve`, `name`, `application_app_id`) VALUES (6, 1, 'password_change', 'TestApp');
INSERT INTO `scope` (`oid`, `auto_approve`, `name`, `application_app_id`) VALUES (7, 1, 'customers', 'TestApp');
INSERT INTO `scope` (`oid`, `auto_approve`, `name`, `application_app_id`) VALUES (8, 1, 'managers', 'TestApp');
INSERT INTO `scope` (`oid`, `auto_approve`, `name`, `application_app_id`) VALUES (9, 1, 'anonymous_user', 'TestApp');
INSERT INTO `scope` (`oid`, `auto_approve`, `name`, `application_app_id`) VALUES (10,1,'anonymous_user','RemoteActions');
INSERT INTO `scope` (`oid`, `auto_approve`, `name`, `application_app_id`) VALUES (11,1,'password_change','RemoteActions');
