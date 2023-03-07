Create table insanlar 
(
	id int,
isim varchar(20),
soyisim varchar(20),
mevki varchar(30),
adres varchar(30),
ise_giris_tar date,
maas int
	);
	

INSERT INTO insanlar VALUES(12345,'Ahmet','OZ','QA','Istanbul','10-04-10',5000);
INSERT INTO insanlar VALUES(12346,'Mehmet','OZ','QA','Istanbul','11-03-07',4760);
INSERT INTO insanlar VALUES(12348,'Ali','CAN','QA','Istanbul','12-01-09',4500);
INSERT INTO insanlar VALUES(12349,'Burak','KAYA','DEV','Ankara','10-06-12',6000);
INSERT INTO insanlar VALUES(12340,'Burak','KADA','DEV','Ankara','06-03-11',6000);
INSERT INTO insanlar VALUES(12350,'Veli','YILDIZ','DEV','Izmir','11-06-08',7000);
INSERT INTO insanlar VALUES(12360,'Ferhat','YAVAS','QA','Izmir','10-06-09',6700);
INSERT INTO insanlar VALUES(12361,'Faris','MANGA','DEV','Bursa','09-04-07',8000);
INSERT INTO insanlar VALUES(12362,'Jon','BLACK','QA','Bursa','01-03-02',5000);
INSERT INTO insanlar VALUES(12363,'Tom','JERY','QA','Kocaeli','4-03-07',5500);
INSERT INTO insanlar VALUES(12364,'Meltem','ASLAN','QA','Erzurum','12-05-08',5500);
INSERT INTO insanlar VALUES(12365,'Meltem','KOCA','DEV','Erzurum','11-05-08',5600);
INSERT INTO insanlar VALUES(12366,'Esma','KAS','DEV','Erzurum','10-01-12',8600);
INSERT INTO insanlar VALUES(12367,'Elif','KARA','QA','Istanbul','10-01-12',null);
INSERT INTO insanlar VALUES(12367,'Canan','FILO','DEV','Istanbul','10-01-12',null);


select * from insanlar;


CREATE TABLE markalar
(
marka_id int,
marka_isim VARCHAR(20), 
calisan_sayisi int
);

INSERT INTO markalar VALUES(100, 'Vakko', 12000);
INSERT INTO markalar VALUES(101, 'Pierre Cardin', 18000);
INSERT INTO markalar VALUES(102, 'Adidas', 10000);
INSERT INTO markalar VALUES(103, 'LCWaikiki', 21000);
select * from markalar;



CREATE TABLE urunler
(
	
urun_id int,
urun_isim VARCHAR(50),
urun_fiyat int );
	
INSERT INTO urunler VALUES( 1001,'Glass', '15'); 
INSERT INTO urunler VALUES( 1002,'Phone', '1500'); 
INSERT INTO urunler VALUES( 1003,'TV', '2000');
INSERT INTO urunler VALUES( 1004,'Laptop', '1750');
INSERT INTO urunler VALUES( 1005,'Shoes', '50'); 
INSERT INTO urunler VALUES( 1006,'Tshirt', '10');
INSERT INTO urunler VALUES( 1007,'Jewelry', '60');

select * from urunler;
DROP TABLE urunler cascade;

do $$

	declare
	
	insanlar_count integer :=0;
	
	begin
	select count(*)  --insanlar sayısını getirir
	into insanlar_count --Query den gelen sayıyı insanlar_count değişkenine atar
	from insanlar;      -- tabloyu seçer
	raise notice 	'The number of insanlar is %',  insanlar_count; --String yazarak yer tutucu % ile yazdırıyorum
	
	
end $$ ;

---------

do $$

declare

counter int:=1;
first_name varchar(50) :='Jon';
last_name varchar(50) :='Black';
urun_name varchar(50) :='Tv';
payment numeric(6,2) :=1250.00;

begin
	raise notice '% % % % has been paid % USD',
				counter,
				first_name,
				last_name,
				urun_name,
				payment;

end $$ ;

--------TABLODAN VERIABLE ALMA-------

do $$
declare
	insanlar_isim insanlar.isim%type; -- datatype insanlar tablusundan belirledim
	
begin
	select isim --tablodan isim i belirledim
	from insanlar --insanlar tablosunu seçtim
	into insanlar_isim --oluşturduğum instance veriable a atadım 
	where id=12345;  --tablodan ismi çağırmak için id ile seçim yaptırdım
	
	raise notice 'insanlar isim id 12345 :%', insanlar_isim;  -- not ile yazdırdım

end $$;


-----********* 	İÇ İÇE BLOK------*********
do $$
<<outher_block>>
declare
	new_calisan_sayisi markalar.calisan_sayisi%type;
begin
	select calisan_sayisi
	from markalar
	into new_calisan_sayisi
	where id=100;
	
	raise notice 'Markalardan Vakko çalışan sayısı :%',new_calisan_sayisi;
	declare
	
	
	end;
	
	raise notice 'new_calisan_sayisi Vakko %', new_calisan_sayisi;
	
	
	end outher_block $$ ;
