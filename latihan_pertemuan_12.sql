--DASAR PL/SQL
--No.1
BEGIN
DBMS_OUTPUT.PUT_LINE('Belajar Oracle');
END;
/ 

--No.2
SET SERVEROUTPUT ON
/

--No.3
-- ini latihan pl/sql pertama [menampilkan nama, alamat, dan website dari customer_id = 23]
set serveroutput on
declare
    nama varchar2 (30);
    alamat varchar2 (30);
    website varchar2 (30);
begin
    select name, address, website  
    into nama, alamat, website
    from customers
    where customer_id = 23;
    
    dbms_output.put_line('Data Customer dengan kode c023');
    dbms_output.put_line('Nama : ' || nama);
    dbms_output.put_line('Alamat : ' || alamat);
    dbms_output.put_line('Website : ' || website);
end;
/

--RECORD DALAM PL/SQL ORACLE
-- ini tuh latihan pl/sql nomor 2
set serveroutput on
DECLARE
  TYPE pelanggan IS RECORD(
    customer_id NUMBER,
    nama VARCHAR2(255),
    alamat VARCHAR2(255)
  );
  pe pelanggan;
BEGIN
  pe.customer_id := 100;
  pe.nama := 'Oscar';
  pe.alamat := 'Aussie';
  
  DBMS_OUTPUT.PUT_LINE('ID Pelanggan : ' || to_char(pe.customer_id));
  DBMS_OUTPUT.PUT_LINE('Nama        : ' || to_char(pe.nama));
  DBMS_OUTPUT.PUT_LINE('Alamat      : ' || to_char(pe.alamat));
  
  SELECT name, address INTO pe.nama, pe.alamat
  FROM customers
  WHERE customer_id = pe.customer_id;
  
  DBMS_OUTPUT.PUT_LINE('ID Pelanggan : ' || to_char(pe.customer_id));
  DBMS_OUTPUT.PUT_LINE('Nama        : ' || to_char(pe.nama));
  DBMS_OUTPUT.PUT_LINE('Alamat      : ' || to_char(pe.alamat));
END;

--ARRAY DALAM PL/SQL ORACLE
-- contoh array (bisa multiple row)
set serveroutput on
declare
    type pelanggan is record(
        customer_id number,
        nama varchar2(255),
        alamat varchar2(255)
    );
    type ListPelanggan is table of pelanggan index by binary_integer;
    liPe ListPelanggan;
Begin
    select customer_id, name, address bulk collect into liPe from customers;
    dbms_output.put_line('ID Pelanggan : ' || to_char(liPe(1).customer_id));
    dbms_output.put_line('Nama :' || to_char(liPe(1).nama));
    dbms_output.put_line('Alamat    : ' || to_char(liPe(1).alamat));
end;

--PERCABANGAN DALAM PL/SQL ORACLE
--No.1
SET SERVEROUTPUT ON
DECLARE
 BIL INTEGER := 100;
BEGIN
 IF MOD(BIL,2)=0 THEN
 DBMS_OUTPUT.PUT_LINE(TO_CHAR(BIL)|| ' adalah bilangan Genap');
 END IF;
END;
/ 

--No.2 [ubah no.1 jadi percabangan dengan 2 kondisi Kondisi pertama menyatakan bilangan genap dan kondisi kedua menyatakan bilangan ganjil]
SET SERVEROUTPUT ON
DECLARE
 BIL INTEGER := 100;
BEGIN
 IF MOD(BIL,2)=0 THEN
   DBMS_OUTPUT.PUT_LINE(TO_CHAR(BIL)|| ' adalah bilangan Genap');
 ELSE
   DBMS_OUTPUT.PUT_LINE(TO_CHAR(BIL)|| ' adalah bilangan Ganjil');
 END IF;
END;
/

--No.3 [ubah no.1 jadi percabangan dengan percabangan dengan 3 kondisi, 
--   Kondisi pertama menyatakan bilangan genap, 
--   kondisi kedua menyatakan bilangan ganjil dan 
--   kondisi ketiga menyatakan bilangan negative.]
SET SERVEROUTPUT ON
DECLARE
 BIL INTEGER := 100;
BEGIN
 IF BIL < 0 THEN
   DBMS_OUTPUT.PUT_LINE(TO_CHAR(BIL)|| ' adalah bilangan Negatif');
 ELSIF MOD(BIL,2)=0 THEN
   DBMS_OUTPUT.PUT_LINE(TO_CHAR(BIL)|| ' adalah bilangan Genap');
 ELSE
   DBMS_OUTPUT.PUT_LINE(TO_CHAR(BIL)|| ' adalah bilangan Ganjil');
 END IF;
END;
/

--PENGULANGAN DALAM PL/SQL ORACLE 
--No.1
SET SERVEROUTPUT ON
DECLARE
 I integer;
BEGIN
 I := 0;
 LOOP
 I:=I +1;
 DBMS_OUTPUT.PUT_LINE('Sukes dengan Oracle');
EXIT WHEN i=10;
 END LOOP;
END;
/ 

--No.2[while loop]
SET SERVEROUTPUT ON
DECLARE
 I INTEGER := 0;
BEGIN
 WHILE I < 10 LOOP
   I := I + 1;
   DBMS_OUTPUT.PUT_LINE('Sukes dengan Oracle');
 END LOOP;
END;
/
--No.3[for loop]
SET SERVEROUTPUT ON
BEGIN
 FOR I IN 1..10 LOOP
   DBMS_OUTPUT.PUT_LINE('Sukes dengan Oracle');
 END LOOP;
END;
/