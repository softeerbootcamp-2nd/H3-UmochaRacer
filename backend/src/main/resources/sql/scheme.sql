Drop table if exists `Trim`;
CREATE TABLE `Trim`
(
    `id`        Long PRIMARY KEY,
    `name`      varchar(255),
    `price`     integer,
    `image_src` varchar(255)
);

Drop table if exists Powertrain;
CREATE TABLE `Powertrain`
(
    `id`        Long PRIMARY KEY,
    `name`      varchar(255),
    `image_src` varchar(255),
    `price`     integer,
    `detail`    varchar(255),
    `comment`   varchar(255)
);

Drop table if exists Bodytype;
CREATE TABLE `Bodytype`
(
    `id`        Long PRIMARY KEY,
    `name`      varchar(255),
    `image_src` varchar(255),
    `price`     integer,
    `detail`    varchar(255),
    `comment`   varchar(255)
);

Drop table if exists Driving_System;
CREATE TABLE `Driving_System`
(
    `id`        Long PRIMARY KEY,
    `name`      varchar(255),
    `image_src` varchar(255),
    `price`     integer,
    `detail`    varchar(255),
    `comment`   varchar(255)
);

Drop table if exists Model;
CREATE TABLE `Model`
(
    `id`                Long PRIMARY KEY,
    `trim_id`           Long,
    `powertrain_id`     Long,
    `bodytype_id`       Long,
    `driving_system_id` Long,
    `price`             integer
);

Drop table if exists Trim_Exterior;
CREATE TABLE `Trim_Exterior`
(
    `id`                Long PRIMARY KEY,
    `trim_id`           Long,
    `exterior_color_id` Long
);

Drop table if exists Exterior_Color;
CREATE TABLE `Exterior_Color`
(
    `id`         Long PRIMARY KEY,
    `name`       varchar(255),
    `price`      integer,
    `color_code` varchar(255),
    `image_src`  varchar(255),
    `comment`    varchar(255)
);

Drop table if exists Interior_Color;
CREATE TABLE `Interior_Color`
(
    `id`                Long PRIMARY KEY,
    `exterior_color_id` Long,
    `name`              varchar(255),
    `price`             integer,
    `icon_src`          varchar(255),
    `image_src`         varchar(255),
    `comment`           varchar(255)
);

Drop table if exists Sales;
CREATE TABLE `Sales`
(
    `id`                Long PRIMARY KEY,
    `model_id`          Long,
    `exterior_color_id` Long,
    `interior_color_id` Long,
    `age`               integer,
    `gender`            varchar(255),
    `tag1`              Long,
    `tag2`              Long,
    `tag3`              Long
);

Drop table if exists Sales_Options;
CREATE TABLE `Sales_Options`
(
    `id`                   Long PRIMARY KEY,
    `sales_id`             Long,
    `additional_option_id` Long
);

Drop table if exists Additional_Option;
CREATE TABLE `Additional_Option`
(
    `id`            Long PRIMARY KEY,
    `name`          varchar(255),
    `top_option_id` Long,
    `detail`        varchar(255),
    `parts_src`     varchar(255),
    `price`         int,
    `image_src`     varchar(255),
    `flag`          ENUM ('BASIC', 'WHEEL', 'ADDITIONAL'),
    `category`      varchar(255)
);

Drop table if exists Tag;
CREATE TABLE `Tag`
(
    `id`   Long PRIMARY KEY,
    `name` varchar(255)
);

ALTER TABLE `Model`
    ADD FOREIGN KEY (`trim_id`) REFERENCES `Trim` (`id`);

ALTER TABLE `Model`
    ADD FOREIGN KEY (`powertrain_id`) REFERENCES `Powertrain` (`id`);

ALTER TABLE `Model`
    ADD FOREIGN KEY (`bodytype_id`) REFERENCES `BodyType` (`id`);

ALTER TABLE `Model`
    ADD FOREIGN KEY (`driving_system_id`) REFERENCES `Driving_System` (`id`);

ALTER TABLE `Trim_Exterior`
    ADD FOREIGN KEY (`trim_id`) REFERENCES `Trim` (`id`);

ALTER TABLE `Trim_Exterior`
    ADD FOREIGN KEY (`exterior_color_id`) REFERENCES `Exterior_Color` (`id`);

ALTER TABLE `Interior_Color`
    ADD FOREIGN KEY (`exterior_color_id`) REFERENCES `Exterior_Color` (`id`);

ALTER TABLE `Sales`
    ADD FOREIGN KEY (`model_id`) REFERENCES `Model` (`id`);

ALTER TABLE `Sales`
    ADD FOREIGN KEY (`exterior_color_id`) REFERENCES `Exterior_Color` (`id`);

ALTER TABLE `Sales`
    ADD FOREIGN KEY (`interior_color_id`) REFERENCES `Interior_Color` (`id`);

ALTER TABLE `Sales`
    ADD FOREIGN KEY (`tag1`) REFERENCES `Tag` (`id`);

ALTER TABLE `Sales`
    ADD FOREIGN KEY (`tag2`) REFERENCES `Tag` (`id`);

ALTER TABLE `Sales`
    ADD FOREIGN KEY (`tag3`) REFERENCES `Tag` (`id`);

ALTER TABLE `Sales_Options`
    ADD FOREIGN KEY (`sales_id`) REFERENCES `Sales` (`id`);

ALTER TABLE `Sales_Options`
    ADD FOREIGN KEY (`additional_option_id`) REFERENCES `Additional_Option` (`id`);

ALTER TABLE `Additional_Option`
    ADD FOREIGN KEY (`top_option_id`) REFERENCES `Additional_Option` (`id`);
