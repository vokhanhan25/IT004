CREATE DATABASE QLythuexe

USE Qlythuexe

/*1.1*/
CREATE TABLE Loaixe(
		maloaixe char(4) CONSTRAINT Loaixe_maloixe_PK PRIMARY KEY,
		tenloaixe varchar(20)
)

CREATE TABLE Xe(
		bienso char(10) CONSTRAINT Xe_maloaixe_PK PRIMARY KEY,
		maloaixe char(4)
)

CREATE TABLE Khachhang(
		makh char(4) CONSTRAINT Khachhan_makh_PK PRIMARY KEY,
		hoten varchar(20),
		sdt varchar(10),
		ngsinh smalldatetime,
		gioitinh varchar(3)
)

CREATE TABLE Trangthaidatcho(
		matrangthai char(4) CONSTRAINT Trangthaidatcho_matrangthai_PK PRIMARY KEY,
		tentrangthai varchar(50)
)

CREATE TABLE Datxe(
		madatxe char(10) CONSTRAINT Datxe_madatxe_PK PRIMARY KEY,
		makh char(4),
		bienso char(10),
		tungay smalldatetime,
		denngay smalldatetime,
		matrangthai char(4),
		ghichu varchar(50),
		ngaydat smalldatetime
)

ALTER TABLE Xe ADD
		CONSTRAINT Xe_maloaixe_FK FOREIGN KEY(maloaixe)
				REFERENCES Loaixe(maloaixe)

ALTER TABLE Datxe ADD
		CONSTRAINT Datxe_makh_FK FOREIGN KEY(makh)
				REFERENCES Khachhang(makh)

ALTER TABLE Datxe ADD
		CONSTRAINT Datxe_matrangthai_FK FOREIGN KEY(matrangthai)
				REFERENCES Trangthaidatcho(matrangthai)

/*1.2*/
ALTER TABLE Loaixe ADD
		ghichu varchar(100)

/*1.3*/
ALTER TABLE Loaixe DROP COLUMN
		ghichu

/*2.1*/
ALTER TABLE Trangthaidatcho ADD
		CONSTRAINT Trangthaidatcho_tentrangthai_CHECK
				CHECK(tentrangthai IN ('hoan tat', 'khong thanh cong'))

/*2.2*/
GO
CREATE TRIGGER THEM_Khachhang ON Datxe
FOR INSERT
AS
BEGIN
	DECLARE @tungay SMALLDATETIME, @makh char(4), @ngsinh smalldatetime, @madatxe char(10)
	SELECT @tungay = tungay, @makh = makh, @madatxe = madatxe 
	FROM INSERTED 

	SELECT @ngsinh = ngsinh 
	FROM Khachhang
	WHERE makh = @makh 

	IF (@ngsinh = @tungay)
	BEGIN
		UPDATE Datxe
		SET ghichu = 'sinh nhat cua khach hang'
		WHERE madatxe = @madatxe
	END
END

/*3.1*/
SELECT bienso, tenloaixe 
FROM Xe, Loaixe
WHERE Xe.maloaixe = Loaixe.maloaixe

/*3.2*/
SELECT Khachhang.makh, hoten, COUNT(madatxe) AS 'so lan dat xe' 
FROM Khachhang, Datxe
WHERE Khachhang.makh = Datxe.makh AND MONTH(ngsinh) = 6 AND YEAR(ngsinh) = 1975
GROUP BY Khachhang.makh, hoten

/*3.3*/
SELECT Xe.bienso
FROM  Xe, Datxe  
WHERE Xe.bienso = Datxe.bienso AND MONTH(ngaydat) = 9 AND YEAR(ngaydat) = 2020
GROUP BY Xe.bienso
HAVING COUNT (madatxe) = (SELECT TOP 1 WITH TIES COUNT(madatxe)
								FROM Xe, Datxe
								WHERE Xe.bienso = Datxe.bienso AND MONTH(ngaydat) = 9 AND YEAR(ngaydat) = 2020
								GROUP BY Xe.bienso
								ORDER BY COUNT(madatxe) DESC
						)

/*3.4*/
SELECT Xe.bienso, maloaixe 
FROM Xe, Datxe
WHERE Xe.bienso = Datxe.bienso AND MONTH(ngaydat) = 6 AND YEAR(ngaydat) = 2020
INTERSECT
SELECT Xe.bienso, maloaixe 
FROM Xe, Datxe
WHERE Xe.bienso = Datxe.bienso AND MONTH(ngaydat) = 7 AND YEAR(ngaydat) = 2020 

/*3.5*/
SELECT makh, hoten 
FROM Khachhang 
WHERE NOT EXISTS(
		SELECT *
		FROM Datxe
		WHERE ngaydat >= '4/4/2019' AND ngaydat <= '6/4/2020'
		AND NOT EXISTS(
				SELECT *
				FROM Datxe
				WHERE Khachhang.makh = Datxe.makh
		)
)