-- sql은 작은 따옴표로
insert into detail(id, title, description, image_src, info) values(1, '타이틀', '상세한 설명 줄글 좌라락','url' ,'최대출력: 100,  최소출력 :34 json 형식');
insert into detail(id, title, description, image_src, info) values(2, '디젤 2.2', '높은 토크로 파워풀한 드라이빙 가능','url' ,'최대출력: 100,  최소출력 :34 json 형식');
insert into detail(id, title, description, image_src, info) values(3, '2WD', '2륜 구동이에요~!','url' ,null);
insert into detail(id, title, description, image_src, info) values(4, '휠&타이어', '강력 브레이크로 사고 유발 감소','url' ,null);
insert into detail(id, title, description, image_src, info) values(5, '아무 디테일', '아무 설명','url' ,null);


insert into Powertrain(id, name, image_src, price,  detail_id,comment) values(12, '디젤2.2', 'url', 123456, 1,'연료 <cardb>효율</cardb>이 좋아요!');
insert into Powertrain(id, name, image_src, price,  detail_id, comment) values(1, '가솔린3.8', 'url', 8080,2, '가솔린 따봉');

insert into Driving_system(id, name, image_src, price,  detail_id,comment) values(234, '2륜', 'url', 0, 3,'2륜은 싸요 따봉');
insert into Driving_system(id, name, image_src, price,  detail_id,comment) values(11, '4륜', 'url',400000, 3,'따봉');

insert into Bodytype(id, name, image_src, price,  detail_id,comment) values(5, '7인승', 'url',0, 1,'가족이 적군요 따봉');

insert into Exterior_color(id, name, image_src, price,comment, color_code) values(1, '어비스 블랙', 'url',0,'세련미를 추구하는 타입이시군요', '222222');
insert into Exterior_color(id, name, image_src, price,comment, color_code) values(2, '화이트펄', 'url',100000,'돈이 많으시군요', 'F3F3F3');
insert into Interior_color(id, name, image_src, price,comment, icon_src, exterior_color_id) values(32, '블루', 'url',0,'외장색에 종속됨', 'icon url',1);
insert into Interior_color(id, name, image_src, price,comment, icon_src, exterior_color_id) values(2, '가죽 리얼블랙', 'url',0,'시크한 당신에게 안성맞춤', 'icon url', null);

insert into additional_option(id, name, image_src, price,detail_id ,parts_src, top_option_id, flag, category) values(2, '온열시트',   'url', 99999,5, '파츠 사진', null, 'ADDITIONAL', 'SAFETY');
insert into additional_option(id, name, image_src, price,detail_id ,parts_src, top_option_id, flag, category) values(3, '전방 감지 카메라', 'url', 654321,5, '파츠 사진', null, 'ADDITIONAL', 'PERFORMANCE');
insert into additional_option(id, name, image_src, price,detail_id ,parts_src, top_option_id, flag, category) values(10, '패키지1', 'url', 993311,5,  '파츠 사진', null, 'ADDITIONAL', 'PERFORMANCE');
insert into additional_option(id, name, image_src, price,detail_id ,parts_src, top_option_id, flag, category) values(90, '하위옵1', 'url', 65423, 5,  null, 10, 'ADDITIONAL', 'SEAT');
insert into additional_option(id, name, image_src, price,detail_id ,parts_src, top_option_id, flag, category) values(91, '하위옵2', 'url', 200000,5,  '파츠 사진', 10, 'ADDITIONAL', 'SEAT');
insert into additional_option(id, name, image_src, price,detail_id ,parts_src, top_option_id, flag, category) values(92, '하위옵3', 'url', 30003,5,  null , 10, 'ADDITIONAL', 'MULTIMEDIA');

insert into wheel(id, name, image_src, price,parts_src, sub_wheel_id, flag, comment, detail_id) values(99, '알콘 어쩌고', 'url', 100000, 'H 지뉴인', null, 'BASIC', '기본 휠',5);
insert into wheel(id, name, image_src, price,parts_src, sub_wheel_id, flag, comment, detail_id) values(2, '알콘 2222', 'url', 200000, '엔 퍼포먼스', null, 'ADDITIONAL', '브레이크와 세트세트', 4);
insert into wheel(id, name, image_src, price,parts_src, sub_wheel_id, flag, comment, detail_id) values(123, '무슨 브레이크', 'url', 0, '엔 퍼포먼스', 2, 'ADDITIONAL', '강력한 제동을 제공', null);
insert into wheel(id, name, image_src, price,parts_src, sub_wheel_id, flag, comment, detail_id) values(55, '무슨무슨 휠', 'url', 34242, '엔 퍼포먼스', 2, 'ADDITIONAL', '비싸고 오프로드에 강한 휠', null);

