use pbd_9;
-- 1. Hitung jumlah order pada tahun 2004
select count(orderNumber)
from orders
where year(orderDate) = 2004;

-- 2. Hitung jumlah order tiap tahunnya
select year(orderDate) as Tahun_Order, count(orderNumber) as Jumlah_Order
from orders o 
group by year(orderDate)
order by Tahun_Order;

-- 3. Tampilkan 10 produk dengan jumlah paling banyak
select od.productCode, count(od.orderNumber) as 10_Produk_Terbanyak
from orderdetails od
group by od.productCode
order by 10_Produk_Terbanyak desc
limit 10;

-- 4. Tampilkan 10 produk dengan harga paling murah
select p.productCode, p.productName, p.buyPrice
from products p 
order by p.buyPrice asc
limit 10;

-- 5. Tampilkan produk yang paling banyak terjual
select od.productCode, count(od.orderNumber) as Order_Terbanyak
from orderdetails od
group by od.productCode
order by Order_Terbanyak desc
limit 1;

-- 6. Tampilkan transaksi dengan nominal paling banyak
select p.checkNumber, p.paymentDate, p.amount, o.customerNumber
from orders o 
join payments p on o.customerNumber = p.customerNumber
order by p.amount desc
limit 1;

-- 7. Tampilkan jumlah employee tiap office
select o.officeCode, count(e.officeCode) as Jumlah_Employee_Tiap_Office
from offices o 
join employees e on o.officeCode = e.officeCode
group by officeCode
order by Jumlah_Employee_Tiap_Office asc;

-- 8. Tampilkan akumulasi pembayaran tiap bulan
select year(p.paymentDate) as Tahun, month(p.paymentDate) as Bulan, sum(p.amount) as Akumulasi_Pembayaran_Per_Bulan
from payments p 
group by year(p.paymentDate), month(p.paymentDate)
order by Tahun, Bulan;

-- 9. Tampilkan akumulasi pembayaran tiap tahun
select year(p.paymentDate) as Tahun, sum(p.amount) as Akumulasi_Pembayaran_Per_Tahun
from payments p 
group by Tahun
order by Tahun;

-- 10. Tampilkan jumlah order dengan status Shipped pada tahun 2004
select year(o.orderDate), o.status, count(o.orderNumber) as Jumlah_Order
from orders o 
where o.status  = "Shipped" and year(o.orderDate) = 2004
group by o.status;




-- Berikut adalah analisis apakah ada yang tidak sesuai dengan keinginan soal pada query yang diberikan:
-- link : https://grok.com/share/c2hhcmQtMg%3D%3D_d6c5aa45-357a-4969-ad50-50e9740a6133
1. **Query 1: Hitung jumlah order pada tahun 2004**  
   - **Query**: `select count(orderNumber) from orders where year(orderDate) = 2004;`  
   - **Analisis**: Query ini sudah benar. Menggunakan `COUNT(orderNumber)` untuk menghitung jumlah order pada tahun 2004 berdasarkan `orderDate`. Tidak ada masalah.

2. **Query 2: Hitung jumlah order tiap tahunnya**  
   - **Query**: `select year(orderDate) as Tahun_Order, count(orderNumber) as Jumlah_Order from orders o group by year(orderDate) order by Tahun_Order;`  
   - **Analisis**: Query ini juga sudah benar. Mengelompokkan order berdasarkan tahun menggunakan `GROUP BY year(orderDate)` dan menghitung jumlah order dengan `COUNT(orderNumber)`. Tidak ada masalah.

3. **Query 3: Tampilkan 10 produk dengan jumlah paling banyak**  
   - **Query**: `select od.productCode, count(od.orderNumber) as 10_Produk_Terbanyak from orderdetails od group by od.productCode order by od.orderNumber desc limit 10;`  
   - **Analisis**: Ada **kesalahan** di sini:  
     - Kolom yang diurutkan pada `ORDER BY` adalah `od.orderNumber`, tetapi seharusnya mengurutkan berdasarkan **jumlah order** yaitu `count(od.orderNumber)` (alias `10_Produk_Terbanyak`).  
     - **Perbaikan**:  
       ```sql
       select od.productCode, count(od.orderNumber) as 10_Produk_Terbanyak
       from orderdetails od
       group by od.productCode
       order by 10_Produk_Terbanyak desc
       limit 10;
       ```

4. **Query 4: Tampilkan 10 produk dengan harga paling murah**  
   - **Query**: `select p.productCode, p.productName, p.buyPrice from products p order by p.buyPrice asc limit 10;`  
   - **Analisis**: Query ini sudah benar. Mengurutkan produk berdasarkan `buyPrice` secara ascending (`ASC`) dan membatasi hasil ke 10 produk. Tidak ada masalah.

5. **Query 5: Tampilkan produk yang paling banyak terjual**  
   - **Query**: `select od.productCode, count(od.orderNumber) as Order_Terbanyak from orderdetails od group by od.productCode order by od.orderNumber desc limit 1;`  
   - **Analisis**: Sama seperti Query 3, ada **kesalahan**:  
     - Kolom yang diurutkan pada `ORDER BY` adalah `od.orderNumber`, tetapi seharusnya mengurutkan berdasarkan `count(od.orderNumber)` (alias `Order_Terbanyak`).  
     - **Perbaikan**:  
       ```sql
       select od.productCode, count(od.orderNumber) as Order_Terbanyak
       from orderdetails od
       group by od.productCode
       order by Order_Terbanyak desc
       limit 1;
       ```

6. **Query 6: Tampilkan transaksi dengan nominal paling banyak**  
   - **Query**: `select p.amount, o.customerNumber from orders o join payments p on o.customerNumber = p.customerNumber order by p.amount desc limit 1;`  
   - **Analisis**: Query ini secara teknis benar, tetapi mungkin kurang spesifik:  
     - Query hanya menampilkan `p.amount` dan `o.customerNumber`, padahal soal meminta "transaksi" yang bisa diartikan juga menampilkan informasi lain seperti `paymentDate` atau `checkNumber` dari tabel `payments`.  
     - **Saran perbaikan** (opsional, jika soal menginginkan detail lebih):  
       ```sql
       select p.checkNumber, p.paymentDate, p.amount, o.customerNumber
       from orders o 
       join payments p on o.customerNumber = p.customerNumber
       order by p.amount desc
       limit 1;
       ```

7. **Query 7: Tampilkan jumlah employee tiap office**  
   - **Query**: `select o.officeCode, count(e.officeCode) as Jumlah_Employee_Tiap_Office from offices o join employees e on o.officeCode = e.officeCode group by officeCode order by Jumlah_Employee_Tiap_Office asc;`  
   - **Analisis**: Query ini sudah benar. Menggunakan `JOIN` untuk menghubungkan tabel `offices` dan `employees`, mengelompokkan berdasarkan `officeCode`, dan menghitung jumlah employee dengan `COUNT`. Tidak ada masalah.

8. **Query 8: Tampilkan akumulasi pembayaran tiap bulan**  
   - **Query**: `select month(p.paymentDate) as Bulan, sum(p.amount) as Akumulasi_Pembayaran_Per_Bulan from payments p group by Bulan order by Bulan;`  
   - **Analisis**: Query ini benar, tetapi bisa ditingkatkan:  
     - Mengelompokkan hanya berdasarkan `MONTH(paymentDate)` tanpa mempertimbangkan tahun bisa menyebabkan data dari tahun yang berbeda digabungkan (misal, Januari 2003 dan Januari 2004 dianggap sama).  
     - **Saran perbaikan** (jika soal menginginkan pemisahan per tahun):  
       ```sql
       select year(p.paymentDate) as Tahun, month(p.paymentDate) as Bulan, sum(p.amount) as Akumulasi_Pembayaran_Per_Bulan
       from payments p 
       group by year(p.paymentDate), month(p.paymentDate)
       order by Tahun, Bulan;
       ```

9. **Query 9: Tampilkan akumulasi pembayaran tiap tahun**  
   - **Query**: `select year(p.paymentDate) as Tahun, sum(p.amount) as Akumulasi_Pembayaran_Per_Tahun from payments p group by Tahun order by Tahun;`  
   - **Analisis**: Query ini sudah benar. Mengelompokkan berdasarkan tahun dan menghitung total `amount` dengan `SUM`. Tidak ada masalah.

10. **Query 10: Tampilkan jumlah order dengan status Shipped pada tahun 2004**  
    - **Query**: `select year(o.orderDate), o.status, sum(o.orderNumber) as Jumlah_Order from orders o where o.status = "Shipped" and year(o.orderDate) = 2004 group by o.status;`  
    - **Analisis**: Ada **kesalahan**:  
      - Menggunakan `SUM(o.orderNumber)` tidak tepat karena `orderNumber` adalah identifier (bukan kuantitas yang bisa dijumlahkan). Seharusnya menggunakan `COUNT(o.orderNumber)` untuk menghitung jumlah order.  
      - Kolom `year(o.orderDate)` dan `o.status` pada `SELECT` tidak diperlukan dalam hasil akhir karena sudah difilter pada `WHERE`.  
      - **Perbaikan**:  
        ```sql
        select count(o.orderNumber) as Jumlah_Order
        from orders o 
        where o.status = "Shipped" and year(o.orderDate) = 2004;
        ```

### Ringkasan Kesalahan:
- **Query 3**: Salah pada `ORDER BY`, harusnya mengurutkan berdasarkan `count(od.orderNumber)`.  
- **Query 5**: Sama seperti Query 3, salah pada `ORDER BY`.  
- **Query 6**: Secara teknis benar, tetapi bisa lebih spesifik dengan menambahkan kolom seperti `checkNumber` atau `paymentDate`.  
- **Query 8**: Berpotensi menggabungkan data dari tahun berbeda; bisa ditambahkan `YEAR` untuk kejelasan.  
- **Query 10**: Salah menggunakan `SUM` pada `orderNumber`, harusnya `COUNT`.  

Query lainnya (1, 2, 4, 7, 9) sudah sesuai dengan keinginan soal.
