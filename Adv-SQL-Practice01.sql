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
	where marka_id=100;
	
	raise notice 'Outher Markalardan Vakko çalışan sayısı :%',new_calisan_sayisi; -- Dış blok
	declare
	new_calisan_sayisi integer :=0;
	begin
	raise notice 'Inner Markalardan Vakko çalışan sayısı :%',new_calisan_sayisi; --İç blok
	raise notice 'Outher new_calisan_sayisi Vakko %', outher_block.new_calisan_sayisi; --dış blok
	
	end;
			
	raise notice 'Outher new_calisan_sayisi Vakko %', new_calisan_sayisi; -- dış blok
	
	
	end outher_block $$ ;
	
	-- *************** Row Type Ornek****************
	
	do $$

declare
	new_markalar markalar%rowtype; -- markaların özelleiklerini taşıyan bir tablo yapıldı
	
	begin
	select *
	from markalar
	into new_markalar 
	where marka_id =100;

	raise notice 'Marka id marka isim % %',-- olusturulan tablodan marka isim ve id çağırıldı
			new_markalar.marka_isim,
			new_markalar.marka_id;
			end $$;
			
			
	--************************Record Type Ornek ************
	
	do $$
declare
	new_urunler record; --record data türünde new_urunler isminde değişken oluşturuldu
begin
	select urun_isim, urun_fiyat
	into new_urunler
	from urunler
	where urun_id = 1001;
	
	raise notice '% % ' , new_urunler.urun_isim, new_urunler.urun_fiyat; --record data türünde new_urunler tablosundan isim ve fiyat yazdırıldı
	
	
end $$;	

-- ************ Constant Ornek *******************
do $$
declare
	zaman constant time := now();

begin
	raise notice 'bloğun çalışma zamanı : %', zaman;

end $$ ;


--- *****************If Statement Ornek **************

	do $$
	declare
	istenen_urun urunler%rowtype; --urun objesini özelliklerini taşır
	istenen_urunId urunler.urun_id%type :=10061; --urunler tablosuna git id si 1001 olanı getir anlamında
	begin
	select * from urunler
	into istenen_urun
	where urun_id = istenen_urunId;
	
	if not found then 
		raise notice 'Getirdiğiniz id li urun bulunamadı : %', istenen_urunId;
		end if;
	
	end $$
--************ IF-THEN-ELSE ornek**************
	
	do $$
declare
	istenen_urun urunler%rowtype; --istenen urun objesi oluşturdruk
	istenen_urunId urunler.urun_id%type := 10011;
begin
	select *
	from urunler
	where urun_id = istenen_urunId
	into istenen_urun;
	
	if found then
		raise notice '%', istenen_urun.urun_isim;-- bu objeden .urun_isim çağırılarak urunler tablosu gibi hareket etmesi sağlanıyor
	else
		raise notice 'İstediğiniz % li urun mevcut değil', istenen_urunId; 
	end if;
	
end $$;


 --	Task : 1002 id li urun varsa ;
	--		fiyatı 150 nin altında ise ucuz,
	--		150<fiyat<1000 ise normal,
	--		fiyat>1000 ise pahalı yazalım
	
	do $$
declare
	istenen_urun urunler%rowtype;
	istenen_urunId urunler.urun_id%type := 1001;
	istenen_urun_fiyat urunler.urun_fiyat%type:=15;
begin
	select *
	from urunler
	where urun_id=istenen_urunId
	into istenen_urun;
	raise notice 'Fiyat % %',istenen_urun_fiyat,istenen_urunId;
	
	if istenen_urun_fiyat < 150 then
		raise notice 'Ucuz';
	elseif istenen_urun_fiyat>150 and istenen_urun_fiyat<1000 then
		raise notice 'Normal';
	else
		raise notice 'Pahalı';
	end if;
	
end $$;

--2.yol
	
	do $$
declare
	istenen_urun urunler%rowtype; -- urunlerle aynı özellikleri taşıyan table objesi olusturuldu
	note varchar(50); -- not için değişken
begin
	select *from urunler --bütün ürünler tablosundan değişkenler kullanılabilir
	
	into istenen_urun -- ürünler tablosu özellikleri bu tabloya koyuldu
	
	where urun_id = 1002; -- çağırılacak id
	
	if not found then
		raise notice 'urun bulunamadı'; -- ürün bulunamazsa diğer kodlar okunmaz
	else
		if istenen_urun.urun_fiyat>0 and istenen_urun.urun_fiyat <=150 then
		   	note='Ucuz';
			elseif istenen_urun.urun_fiyat>150 and istenen_urun.urun_fiyat<1000 then
			note='Normal';
			elseif istenen_urun.urun_fiyat>1000  then
			note='Pahalı';
			else
			note='Tanımlanamıyor';
			
		end if;
		raise notice '% urun fiyatı : % %',note, istenen_urun.urun_isim,istenen_urun.urun_fiyat; -- oluşturulan objeden ürünler tablosu gibi değişken çağrılabilir
	end if;
end $$;	

-- ******** Case Statement Ornek**************************


-- Task : Marka ismine göre klasik-spor-casual uygun olup olmadığını ekrana yazalım

DO $$
DECLARE
    note varchar(50); -- note için değişken
    marka_ismi markalar.marka_isim%TYPE; -- markalardan marka_isim özelliklerini taşıyan değişken oluşturuldu
BEGIN
    SELECT marka_isim FROM markalar --marka_isim markalardan çağrıldı
    INTO marka_ismi --çağrılan değişken marka_ismi'nin içine koyuldu
    WHERE marka_isim='Adidas'; -- istediğimiz sorguyu sağlayan şart
    
    IF FOUND THEN
        CASE marka_ismi
            WHEN 'Vakko' THEN note = 'Klasik'; --şart Vakko ise ekranda Klasik yazma durumu
            WHEN 'Pierre Cardin' THEN note = 'Klasik';
            WHEN 'Adidas' THEN note = 'Spor';
		 	WHEN 'LCWaikiki' THEN note = 'Casual';
            ELSE 
                note = 'Tanimlanamadi...';
        END CASE;
        RAISE NOTICE '%', note;
    END IF;
    
END $$; 

--Task 1 : Ürünler tablosundaki urun sayısı 10 dan az ise "urun sayısı az" yazdırın, 
--10 dan çok ise "urun sayısı yeterli" yazdıralım

do $$
declare
	sayi integer :=0;
		
begin
	SELECT count(*) FROM urunler  -- 4
	into sayi; -- sayi=4
	
	if (sayi<10) then
			raise notice 'Urun sayısı az';
		else
			raise notice 'Urun sayısı yeterli';
	end if;
end $$;

--2Yol
do $$
declare
	alert varchar(50);
	urun_sayisi int;
begin
	select count(*)
	from urunler
	into urun_sayisi;
		
	if urun_sayisi>10 then
		alert='urun sayısı yeterli';
	elseif urun_sayisi<10 then
		alert='urun sayısı az';
	else
		alert='urun sayisi 10';
	end if;
	raise notice '%', alert;
end $$

--  ************** LOOP Ornek *************************************
-- Task : Fibonacci serisinde, belli bir sıradaki sayıyı ekrana getirelim

-- Fibonacci Serisi : 1,1,2,3,5,8,13,...

DO $$
DECLARE
	n integer :=3;
	counter integer :=0;
	i integer :=0;
	j integer :=i+1;
	fib integer :=0;	

BEGIN 
	if(n<1) then
		fib:=0;
	end if;
	loop
		exit when counter =n;
		counter := counter +1;
		select j, (i+j) into i,j;	
	end loop;
	fib:=i;
	raise notice '%', fib;
	
END $$;
	
	-- ************ WHILE LOOP Ornek *************************
	
	-- Task : 20 dan 200 e kadar counter değerlerini ekrana basalım
	
	DO $$
DECLARE
	n integer :=200;
	counter integer :=19;

BEGIN
	WHILE counter<n LOOP
		counter:=counter+1;
		raise notice '%', counter;
	END LOOP;

END $$;

-- Cevap 2:

DO $$

DECLARE
	counter integer :=19;

BEGIN 
	WHILE counter<200 LOOP
		counter := counter+1;
		raise notice '%', counter;
	END LOOP;	

END $$ ;

-- Task : sayac isminde bir degisken olusturun ve dongu icinde sayaci birer artirin,  
 --her dongude sayacin degerini ekrana basin ve sayac degeri 
 --200 e esit olunca donguden cikin
 
 
	DO $$

DECLARE
sayac integer :=0;
begin
	loop
	exit when sayac =201;
	raise notice '%', sayac;
	sayac = sayac+1;

END LOOP;	

END $$ ;

-- **************** FOR LOOP Ornek ************

-- in counter 20 den 200 e kadar dönsün

do $$
begin
	for counter in 20..200 loop
		raise notice 'counter: %', counter;
	end loop;	

end $$;
-- in counter 20 den 200 e kadar 5 atlayarak dönsün
do $$
begin
	for counter in  20..200 by 5 loop
	raise notice 'counter: %', counter;
	end loop;
end $$;

-- 20 den 200 e kadar tersten yazdır-- reverse ( Ornek )
do $$
begin
	for counter in reverse 200..20 loop
	raise notice 'counter: %', counter;
	end loop;
end $$ ;


-- 20 den 200 e kadar  yazdır
do $$
begin
	for counter in  20..200 loop
	raise notice 'counter: %', counter;
	end loop;
end $$ ;


-- Task : 10 dan 20 ye kadar 2 ser 2 ser ekrana sayilari basalim :

do $$
begin
	for counter in   20..200 by 5 loop
	raise notice 'counter: %', counter;
	end loop;
end $$;

-- Task : 10 dan 20 ye kadar 2 ser 2 ser ekrana  sayilari ters şekilde basalim :
do $$
begin
	for counter in  reverse 200..20 by 2  loop
	raise notice 'counter: %', counter;
	end loop;
end $$;


-- Task : olusturulan array'in elemanlarini array seklinde gosterelim :

do $$

declare
	array_int int[] := array [12,34,3253,25,56,53,58,88]; 
	var int[];

begin
	for var in select array_int loop
	raise notice '%', var;
	end loop;

end $$;

-- Task : olusturulan array'in elemanlarini array seklinde gosterelim :

do $$

declare
	arrayA char[] := array ['a','b','c','d','s','k','l','i']; 
	newA char[];

begin
	for newA in select arrayA loop
	raise notice '%', newA;
	end loop;

end $$;

-- DB de loop kullanımı Ornekler
-- Task : markaları  çalışan sayısına  göre sıraladığımızda en uzun 2 markayı gösterelim
select marka_isim , calisan_sayisi from markalar
	 
	  order by calisan_sayisi desc limit 2
	  
	----
	
	  do $$
declare
new_markalar record;
begin
	for new_markalar in select marka_isim, calisan_sayisi from markalar order by calisan_sayisi desc limit 2 loop
	raise notice '% ( % calisan sayisi )', new_markalar.marka_isim,new_markalar.calisan_sayisi;
end loop ;
end $$;


  -- Task :  İnsanlar tablosundan maaşı  en buyuk ilk 10 kisiyi ekrana yazalim
  
  do $$
declare
insanlar_a record;
begin
	for insanlar_a in select maas , isim  from insanlar order by  maas desc limit 10 loop
	raise notice '% ( % )', insanlar_a.maas, insanlar_a.isim ;
end loop ;
end $$;

isim varchar(20),
soyisim varchar(20),
mevki varchar(30),
adres varchar(30),
ise_giris_tar date,
maas int


-- Task : continue yapisi kullanarak 1 dahil 10 a kadar olan çift sayilari ekrana basalim
-- ************** CONTINUE Ornekler****************
-- mevcut iterasyonu atmalak icin kullanilir
do $$
declare
	counter integer :=0;
begin

	loop
	counter := counter+1; --loop içinde counter değeri 1 artırılır
	exit when counter>10; -- counter 10 dan büyük olursa loop biter
	continue when mod(counter,2)=1; -- counter mod foksiyonu ile tek sayılar görmezden gelinir
	raise notice 'counter: %', counter; -- değer ekrana yazdırılır
	end loop;
end $$ ;

-- ********************************************************	
--  ********************* FUNCTION ***********************
-- ********************************************************

-- İnsanlar tablomuzdaki belirli maas arasindaki insanların sayisini getiren bir fonsiyon yazalim

create or replace function get_insanlar_count(baslangıc_maas int , bitis_maas int )	
returns int
language plpgsql
as

$$
	declare
		get_insanlar_count integer ;
	begin
		select count(*) 
		into get_insanlar_count
		from insanlar
		where maas between baslangıc_maas and bitis_maas;
		
		return get_insanlar_count;	
	end $$;


-- 1.yol:	( positional notation)

select get_insanlar_count(6000,10000);	

-- 2. yol : ( named notation)
select get_insanlar_count(
	
	baslangıc_maas:= 6000,
	bitis_maas := 10000
	);
	
	
-- Task : parametre olarak girilen iki sayının toplamını veren iki_sayiyi_toplami adında fonksiyon yazalım



create or replace function iki_sayiyi_toplami(sayi_a int , sayi_b int )	
returns int
language plpgsql
as

	$$
	declare
		toplam int ;
	begin
	toplam := sayi_a+sayi_b;
	return toplam;
	end $$;


select iki_sayiyi_toplami(100,50);

-- Task : parametre olarak girilen iki sayının çarpımını veren iki_sayiyi_çarp adında fonksiyon yazalım



create or replace function iki_sayiyi_çarp(sayi_a int , sayi_b int )	
returns int
language plpgsql
as

	$$
	declare
		carpim int ;
	begin
	carpim := sayi_a*sayi_b;
	return carpim;
	end $$;


select iki_sayiyi_çarp(100,50);
