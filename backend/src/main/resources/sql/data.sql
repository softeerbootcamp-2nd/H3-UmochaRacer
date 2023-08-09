-- sql은 작은 따옴표로
insert into Powertrain(id, name, image_src, price, detail,comment) values(12, '디젤2.2', 'url', 123456, '최대출력 몇','연료 <cardb>효율</cardb>이 좋아요!');
insert into Powertrain(id, name, image_src, price, detail, comment) values(1, '가솔린3.8', 'url', 8080,'json으로 넣을 컬럼', '가솔린 따봉');

insert into Driving_system(id, name, image_src, price, detail,comment) values(234, '2륜', 'url', 0, '2륜으로 구동','2륜은 싸요 따봉');
insert into Driving_system(id, name, image_src, price, detail,comment) values(11, '4륜', 'url',400000, '4륜으로 구동','따봉');

insert into Bodytype(id, name, image_src, price, detail,comment) values(5, '7인승', 'url',0, '널널한 7인승','가족이 적군요 따봉');

insert into Exterior_color(id, name, image_src, price,comment, color_code) values(1, '어비스 블랙', 'url',0,'세련미를 추구하는 타입이시군요', '222222');
insert into Exterior_color(id, name, image_src, price,comment, color_code) values(2, '화이트펄', 'url',100000,'돈이 많으시군요', 'F3F3F3');
insert into Interior_color(id, name, image_src, price,comment, icon_src, exterior_color_id) values(32, '블루', 'url',0,'외장색에 종속됨', 'icon url',1);
insert into Interior_color(id, name, image_src, price,comment, icon_src, exterior_color_id) values(2, '가죽 리얼블랙', 'url',0,'시크한 당신에게 안성맞춤', 'icon url', null);

insert into additional_option(id, name, image_src, price,detail,parts_src, top_option_id, `type`) values(1, '머플러 어쩌고', 'url', 1234,'배기구 두 개', '사진', null, 'ADDITIONAL');
insert into additional_option(id, name, image_src, price,detail,parts_src, top_option_id, `type`) values(2, '온열시트',   'url', 99999,'겨울에도 따뜻하게', '파츠 사진', null, 'ADDITIONAL');
insert into additional_option(id, name, image_src, price,detail,parts_src, top_option_id, `type`) values(3, '전방 감지 카메라', 'url', 654321, '전방을 감지', '파츠 사진', null, 'ADDITIONAL');
insert into additional_option(id, name, image_src, price,detail,parts_src, top_option_id, `type`) values(10, '패키지1', 'url', 993311, '패키지1', '파츠 사진', null, 'ADDITIONAL');
insert into additional_option(id, name, image_src, price,detail,parts_src, top_option_id, `type`) values(90, '하위옵1', 'url', 65423, '하위1',  null, 10, 'ADDITIONAL');
insert into additional_option(id, name, image_src, price,detail,parts_src, top_option_id, `type`) values(91, '하위옵2', 'url', 2, '하위2', '파츠 사진', 10, 'ADDITIONAL');
insert into additional_option(id, name, image_src, price,detail,parts_src, top_option_id, `type`) values(92, '하위옵3', 'url', 33, '하3', null , 10, 'ADDITIONAL');

insert into additional_option(id, name, image_src, price,detail,parts_src, top_option_id, `type`) values(99, '알콘 어쩌고', 'url', 100000,'강력한 휠', 'H 지뉴인', null, 'WHEEL');
insert into additional_option(id, name, image_src, price,detail,parts_src, top_option_id, `type`) values(123, '알콘 2222', 'url', 200000,'브레이크 좋음', '엔 퍼포먼스', null, 'WHEEL');


