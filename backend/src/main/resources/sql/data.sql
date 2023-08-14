-- sql은 작은 따옴표로
insert into detail(id, title, description, image_src, info) values(1, '타이틀', '상세한 설명 줄글 좌라락','url' ,'최대출력: 100,  최소출력 :34 json 형식');
insert into detail(id, title, description, image_src, info) values(2, '디젤 2.2', '높은 토크로 파워풀한 드라이빙 가능','url' ,'최대출력: 100,  최소출력 :34 json 형식');
insert into detail(id, title, description, image_src, info) values(3, '2WD', '2륜 구동이에요~!','url' ,null);
insert into detail(id, title, description, image_src, info) values(4, '휠&타이어', '강력 브레이크로 사고 유발 감소','url' ,null);
insert into detail(id, title, description, image_src, info) values(5, '아무 디테일', '아무 설명','url' ,null);

insert into Powertrain(id, name, image_src, price,  detail_id,comment) values(1, '디젤2.2', 'url', 123456, 1,'연료 <cardb>효율</cardb>이 좋아요!');
insert into Powertrain(id, name, image_src, price,  detail_id, comment) values(2, '가솔린3.8', 'url', 8080,2, '가솔린 따봉');

insert into Driving_system(id, name, image_src, price,  detail_id,comment) values(1, '2륜', 'url', 0, 3,'2륜은 싸요 따봉');
insert into Driving_system(id, name, image_src, price,  detail_id,comment) values(2, '4륜', 'url',400000, 3,'따봉');

insert into Bodytype(id, name, image_src, price,  detail_id,comment) values(1, '7인승', 'url',0, 1,'가족이 적군요 따봉');
insert into Bodytype(id, name, image_src, price,  detail_id,comment) values(2, '8인승', 'url',0, 1,'대가족이시군요 국가의 미래!');

insert into Exterior_color(id, name, image_src, price,comment, color_code) values(1, '어비스 블랙', 'url',0,'세련미를 추구하는 타입이시군요', '222222');
insert into Exterior_color(id, name, image_src, price,comment, color_code) values(2, '화이트펄', 'url',100000,'돈이 많으시군요', 'F3F3F3');
insert into Exterior_color(id, name, image_src, price,comment, color_code) values(3, '블루', 'url',100000,'돈이 많으시군요', 'eeeeee');
insert into Exterior_color(id, name, image_src, price,comment, color_code) values(4, '노랑', 'url',22222,'돈이 많으시군요', '000000');
insert into Exterior_color(id, name, image_src, price,comment, color_code) values(5, '빨강', 'url',11111,'돈이 많으시군요', '000000');
insert into Exterior_color(id, name, image_src, price,comment, color_code) values(6, '녹색', 'url',11111,'돈이 많으시군요', '111111');
insert into Exterior_color(id, name, image_src, price,comment, color_code) values(7, '회색', 'url',11111,'돈이 많으시군요', '222222');

insert into Interior_color(id, name, image_src, price,comment, icon_src, exterior_color_id) values(1, '검', 'url',0,'시크한 당신에게 안성맞춤', 'icon url', null);
insert into Interior_color(id, name, image_src, price,comment, icon_src, exterior_color_id) values(2, '빨', 'url',10000,'레드햇', 'icon url', null);
insert into Interior_color(id, name, image_src, price,comment, icon_src, exterior_color_id) values(3, '블루', 'url',20000,'싱잉 마 블루우우', 'icon url',1);
insert into Interior_color(id, name, image_src, price,comment, icon_src, exterior_color_id) values(4, '주', 'url',0,'차는 무슨색? 주황', 'icon url', null);
insert into Interior_color(id, name, image_src, price,comment, icon_src, exterior_color_id) values(5, '노', 'url',0,'노랑통닭', 'icon url', 2);
insert into Interior_color(id, name, image_src, price,comment, icon_src, exterior_color_id) values(6, '보라', 'url',0,'보라해', 'icon url', 2);

insert into additional_option(id, name, image_src, price,detail_id ,parts_src, top_option_id, category) values(1, '온열시트',   'url', 99999,5, '파츠 사진', null, 'SAFETY');
insert into additional_option(id, name, image_src, price,detail_id ,parts_src, top_option_id, category) values(2, '전방 감지 카메라', 'url', 11111,5, '파츠 사진', null,  'PERFORMANCE');
insert into additional_option(id, name, image_src, price,detail_id ,parts_src, top_option_id, category) values(3, '이름 짓기 귀찮다2', 'url', 22222,5, '파츠 사진', null, 'MULTIMEDIA');
insert into additional_option(id, name, image_src, price,detail_id ,parts_src, top_option_id, category) values(4, '아무거나123', 'url', 3333,5, '파츠 사진', null,'AI_SAFETY');
insert into additional_option(id, name, image_src, price,detail_id ,parts_src, top_option_id, category) values(5, '아무거나123', 'url', 3333,5, '파츠 사진', null,'PERFORMANCE');
insert into additional_option(id, name, image_src, price,detail_id ,parts_src, top_option_id, category) values(6, '페이징 체크용1', 'url', 3333,5, '파츠 사진', null, 'PERFORMANCE');
insert into additional_option(id, name, image_src, price,detail_id ,parts_src, top_option_id, category) values(7, '페이징 체크용2', 'url', 3333,5, '파츠 사진', null,  'PERFORMANCE');
insert into additional_option(id, name, image_src, price,detail_id ,parts_src, top_option_id, category) values(8, '페이징 체크용3', 'url', 3333,5, '파츠 사진', null, 'PERFORMANCE');
insert into additional_option(id, name, image_src, price,detail_id ,parts_src, top_option_id, category) values(9, '페이징 체크용4', 'url', 3333,5, '파츠 사진', null,  'PERFORMANCE');
insert into additional_option(id, name, image_src, price,detail_id ,parts_src, top_option_id, category) values(10, '페이징 체크용5', 'url', 3333,5, '파츠 사진', null, 'PERFORMANCE');
insert into additional_option(id, name, image_src, price,detail_id ,parts_src, top_option_id, category) values(11, '페이징 체크용6', 'url', 3333,5, '파츠 사진', null, 'PERFORMANCE');
insert into additional_option(id, name, image_src, price,detail_id ,parts_src, top_option_id, category) values(12, '페이징 체크용7', 'url', 3333,5, '파츠 사진', null, 'PERFORMANCE');
insert into additional_option(id, name, image_src, price,detail_id ,parts_src, top_option_id, category) values(13, '페이징 체크용8', 'url', 3333,5, '파츠 사진', null, 'PERFORMANCE');
insert into additional_option(id, name, image_src, price,detail_id ,parts_src, top_option_id, category) values(14, '페이징 체크용9', 'url', 3333,5, '파츠 사진', null, 'PERFORMANCE');
insert into additional_option(id, name, image_src, price,detail_id ,parts_src, top_option_id, category) values(15, '페이징 체크용10', 'url', 3333,5, '파츠 사진', null, 'PERFORMANCE');

insert into additional_option(id, name, image_src, price,detail_id ,parts_src, top_option_id, category) values(50, '패키지1', 'url', 993311,5,  '파츠 사진', null, 'SYSTEM');
insert into additional_option(id, name, image_src, price,detail_id ,parts_src, top_option_id, category) values(51, '하위옵1', 'url', 65423, 5,  null, 50, 'OUTER_DEVICE');
insert into additional_option(id, name, image_src, price,detail_id ,parts_src, top_option_id, category) values(52, '하위옵2', 'url', 200000,5,  '파츠 사진', 50, 'INNER_DEVICE');
insert into additional_option(id, name, image_src, price,detail_id ,parts_src, top_option_id, category) values(53, '하위옵3', 'url', 30003,5,  null , 50, 'SYSTEM');

insert into wheel(id, name, image_src, price,parts_src, sub_wheel_id, flag, comment, detail_id) values(90, '알콘 어쩌고', 'url', 100000, 'H 지뉴인', null, 'BASIC', '기본 휠',5);
insert into wheel(id, name, image_src, price,parts_src, sub_wheel_id, flag, comment, detail_id) values(91, '알콘 2222', 'url', 200000, '엔 퍼포먼스', null, 'ADDITIONAL', '브레이크와 세트세트', 4);
insert into wheel(id, name, image_src, price,parts_src, sub_wheel_id, flag, comment) values(92, '무슨 브레이크', 'url', 0, '엔 퍼포먼스', 91, 'ADDITIONAL', '강력한 제동을 제공');
insert into wheel(id, name, image_src, price,parts_src, sub_wheel_id, flag, comment) values(93, '무슨무슨 휠', 'url', 34242, '엔 퍼포먼스', 91, 'ADDITIONAL', '비싸고 오프로드에 강한 휠');

insert into `trim`(id, name, price, image_src) values(1, 'Exclusive', 38960000, 'url');
insert into `trim`(id, name, price, image_src) values(2, 'Le Blanc', 41980000, 'url');
insert into `trim`(id, name, price, image_src) values(3, 'Prestige', 46240000, 'url');
insert into `trim`(id, name, price, image_src) values(4, 'Calligraphy', 51060000, 'url');

insert into trim_exterior(id, trim_id, exterior_color_id) values(1, 1, 1);
insert into trim_exterior(id, trim_id, exterior_color_id) values(2, 1, 2);
insert into trim_exterior(id, trim_id, exterior_color_id) values(3, 1, 3);
insert into trim_exterior(id, trim_id, exterior_color_id) values(4, 1, 4);
insert into trim_exterior(id, trim_id, exterior_color_id) values(5, 2, 1);
insert into trim_exterior(id, trim_id, exterior_color_id) values(6, 2, 2);
insert into trim_exterior(id, trim_id, exterior_color_id) values(8, 3, 1);
insert into trim_exterior(id, trim_id, exterior_color_id) values(9, 3, 2);
insert into trim_exterior(id, trim_id, exterior_color_id) values(10, 3, 3);
insert into trim_exterior(id, trim_id, exterior_color_id) values(11, 3, 4);
insert into trim_exterior(id, trim_id, exterior_color_id) values(12, 3, 5);
insert into trim_exterior(id, trim_id, exterior_color_id) values(13, 3, 6);
insert into trim_exterior(id, trim_id, exterior_color_id) values(14, 4, 1);
insert into trim_exterior(id, trim_id, exterior_color_id) values(15, 4, 1);
insert into trim_exterior(id, trim_id, exterior_color_id) values(16, 4, 2);
insert into trim_exterior(id, trim_id, exterior_color_id) values(17, 4, 3);
insert into trim_exterior(id, trim_id, exterior_color_id) values(18, 4, 4);

insert into trim_interior(id, trim_id, interior_color_id) values(1, 1, 1);
insert into trim_interior(id, trim_id, interior_color_id) values(2, 1, 2);
insert into trim_interior(id, trim_id, interior_color_id) values(3, 1, 3);
insert into trim_interior(id, trim_id, interior_color_id) values(4, 1, 4);
insert into trim_interior(id, trim_id, interior_color_id) values(6, 2, 1);
insert into trim_interior(id, trim_id, interior_color_id) values(7, 2, 6);
insert into trim_interior(id, trim_id, interior_color_id) values(8, 3, 3);
insert into trim_interior(id, trim_id, interior_color_id) values(9, 3, 2);
insert into trim_interior(id, trim_id, interior_color_id) values(10, 4, 6);
insert into trim_interior(id, trim_id, interior_color_id) values(11, 4, 5);
insert into trim_interior(id, trim_id, interior_color_id) values(12, 4, 4);
insert into trim_interior(id, trim_id, interior_color_id) values(13, 4, 6);

insert into trim_additional_option(id, trim_id, additional_option_id)
values (1, 1, 1),
       (2, 1, 2),
       (3, 1, 3),
       (4, 1, 4),
       (5, 1, 5),
       (6, 1, 6),
       (7, 1, 7),
       (8, 1, 8),
       (9, 1, 9),
       (10, 1, 10),
       (11, 1, 11),
       (12, 1, 12),
       (13, 1, 13),
       (14, 1, 14),
       (15, 1, 15),

       (16, 2, 1),
       (17, 2, 12),
       (18, 2, 13),
       (19, 2, 14),
       (20, 2, 15),

       (21, 3, 1),
       (22, 3, 2),
       (23, 3, 3),
       (24, 3, 4),

       (25, 4, 9),
       (26, 4, 10),
       (27, 4, 12),
       (28, 4, 11),
       (29, 4, 13),
       (30, 4, 14);
