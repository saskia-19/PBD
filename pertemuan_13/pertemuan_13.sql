create table barang (kode_barang char(6) primary key, nama_barang varchar2(20), satuan_barang varchar2(10), stok_barang number(38,0));
create table pasok (kode_pasok char(6) primary key, kode_barang char(6), kode_suplier char(6), jumlah_pasok number(38,0), foreign key (kode_barang) references barang(kode_barang));
create table pembelian (kode_pembelian char(6) primary key, kode_barang char(6), kode_customer char(6), jumlah_pembelian number(38,0), foreign key (kode_barang) references barang(kode_barang));

insert into barang values ('B001', 'Lemari Es', 'unit', 11);
insert into barang values ('B002', 'Rice Cooker', 'buah', 23);
insert into barang values ('B003', 'TV', 'unit', 31);
insert into barang values ('B004', 'Radio', 'buah', 21);
insert into barang values ('B005', 'Meja', 'buah', 12);

insert into pasok values ('P001', 'B002', 's001', 5);
insert into pasok values ('P002', 'B003', 's002', 20);
insert into pasok values ('P003', 'B002', 's002', 26);

insert into pembelian values ('PB001', 'B001', 'c003', 30);
insert into pembelian values ('PB002', 'B003', 'c002', 8);
insert into pembelian values ('PB003', 'B003', 'c003', 14);

--TRIGGERS
--Latihan Before After Insert Update
create or replace trigger updatestok
after insert on pembelian
for each row
begin
    update barang set stok = stok - :new.jumlah where barang.kode_barang = :new.kode_barang;
End;

--No.1 [Ketikanlah perintah trigger berikut ini pada SQL command line anda]
set serveroutput on
create or replace trigger tr_coba
after update on barang
for each row
begin
dbms_output.put_line('Tabel barang telah diupdate');
end;
/

--No.2 [Setelah itu periksalah pengaruh trigger yang telah di buat dengan cara melakukan update terhadap table barang, apa yang terjadi ?]
Set serveroutput on
Update barang
 Set stok_barang = 15 where kode_barang='B001';
 
--No.3 [Menurut anda apa hubungan antara perintah trigger pada soal no 1 dengan perintah update pada soal no 2 ?]

--No.4 [Ketiklah perintah trigger berikut ini ]
create or replace trigger tr_cekstokbarang
before insert on barang
for each row
begin
if(:new.stok_barang < 0)
then
:new.stok_barang := 0;
dbms_output.put_line('Stok barang diubah menjadi 0');
end if;
end;
/
--Versi asdos
CREATE OR REPLACE TRIGGER cekstok
BEFORE INSERT ON pmebelian
FOR EACH ROW
DECLARE
    v_stok NUMBER;
BEGIN
    SELECT stok INTO v_stok
    FROM barang
    WHERE kode_barang = :NEW.kode_barang;
    
    IF :NEW.jumlah > v_stok THEN
        RAISE_APPLICATION_ERROR(-20001, 'Pembelian tidak bisa melebihi stok barang.');
    END IF;
END;

--No.5 [Setelah itu periksalah pengaruh trigger pada soal no 3 dengan cara melakukan penambahan data pada table barang namun stok_barang yang ditambahkan bernilai negative (minus), apa yang terjadi ?]
Set serveroutput on
Insert into barang values ('B006','kursi','unit',-5);
Select * from barang;

--No.6 [Menurut anda apa hubungan antara perintah trigger pada soal no 4 dengan perintah menambah pada soal no 5 ?]


--ALIAS DI DALAM TRIGGER
--No.1 [Ketiklah perintah trigger berikut ini]
create or replace trigger tr_insert_pasok
after insert on pasok
for each row
begin
update barang set stok_barang=stok_barang +:new.jumlah_pasok;
end;
/

--No. 2 [Setelah itu periksalah pengaruh trigger pada soal no 1 dengan cara menambahkan data pada table pasok , lalu lihat apa yang terjadi pada table pasok dan table barang ?]
Insert into pasok values ('P004','B002','s002',5);
Select * from pasok;
Select * from barang;

--No.3 [Jika dilihat dari perubahan data yang terjadi pada table barang, Menurut anda apa hubungan antara perintah trigger pada soal no 1 dengan perintah menambah data pada soal no 2 ?]


--SYARAT PULANG [BUKAN BAGIAN LAPRAK!]
--Trigger ketika ada insert pada tabel pasok
INSERT INTO pasok VALUES ('P005', 'B001', 's001', 3);
COMMIT;

SET SERVEROUTPUT ON SIZE 20000;
create or replace trigger tr_insert_pasok
after insert on pasok
for each row
declare
    v_stok_baru_pasok number;
begin
update barang set stok_barang=stok_barang +:new.jumlah_pasok where kode_barang = :new.kode_barang;
SELECT stok_barang into v_stok_baru_pasok FROM barang WHERE kode_barang = :NEW.kode_barang;
DBMS_OUTPUT.PUT_LINE('Stok ' || :NEW.kode_barang || 
                      ' bertambah ' || :NEW.jumlah_pasok || 
                      '. Stok baru: ' ||  v_stok_baru_pasok
                    );
end;
/

--Trigger ketika ada update pada tabel pasok
UPDATE pasok SET jumlah_pasok = 10 WHERE kode_pasok = 'P001';
COMMIT;

create or replace trigger update_pasok
after update on pasok
for each row
declare
    v_stok_baru_pasok NUMBER;
    v_selisih NUMBER := :OLD.jumlah_pasok - :NEW.jumlah_pasok;
begin
update barang set stok_barang=stok_barang + (:old.jumlah_pasok - :new.jumlah_pasok)
where kode_barang = :new.kode_barang;

SELECT stok_barang INTO v_stok_baru_pasok
    FROM barang 
    WHERE kode_barang = :NEW.kode_barang;
    
DBMS_OUTPUT.PUT_LINE('Trigger Update Pasok:');
DBMS_OUTPUT.PUT_LINE('Kode Barang: ' || :NEW.kode_barang);
DBMS_OUTPUT.PUT_LINE('Perubahan Stok: ' || 
    CASE WHEN v_selisih > 0 THEN '+' ELSE '' END || v_selisih);
DBMS_OUTPUT.PUT_LINE('Stok baru: ' || v_stok_baru_pasok);
end;
/

--Trigger ketika ada update pada tabel pembelian
UPDATE pembelian SET jumlah_pembelian = 10 WHERE kode_pembelian = 'PB001';
COMMIT;

create or replace trigger update_pembelian
after update on pembelian
for each row
declare
    v_stok_baru_pembelian NUMBER;
    v_selisih NUMBER := :OLD.jumlah_pembelian - :NEW.jumlah_pembelian;
begin
update barang set stok_barang = stok_barang + :old.jumlah_pembelian - :new.jumlah_pembelian 
where kode_barang = :new.kode_barang;

SELECT stok_barang INTO v_stok_baru_pembelian
FROM barang 
WHERE kode_barang = :NEW.kode_barang;

DBMS_OUTPUT.PUT_LINE('Trigger Update Pembelian:');
DBMS_OUTPUT.PUT_LINE('Kode Barang: ' || :NEW.kode_barang);
DBMS_OUTPUT.PUT_LINE('Perubahan Stok: ' || 
    CASE WHEN v_selisih > 0 THEN '+' ELSE '' END || v_selisih);
DBMS_OUTPUT.PUT_LINE('Stok baru: ' || v_stok_baru_pembelian);
end;
/

--[BUKAN BAGIAN LAPRAK!]
--note when update
--old.jumlah = 10 , new.jumlah = 8; stok barang = +2
--old.jumlah = 10, new.jumlah = 15; stok barang = -5

--note when update pasok
--kebalikan dengan pembelian