﻿CREATE DATABASE TEST1

USE TEST1

/*Câu 1*/

CREATE TABLE TACGIA(
	MATG CHAR(5) CONSTRAINT TACGIA_MATG_PK PRIMARY KEY,
	HOTEN VARCHAR(20),
	DIACHI VARCHAR(50),
	NGSINH SMALLDATETIME,
	SODT VARCHAR(15)
)

CREATE TABLE SACH (
	MASACH CHAR(5) CONSTRAINT SACH_MASACH_PK PRIMARY KEY,
	TENSACH VARCHAR(25),
	THELOAI VARCHAR(25)
)

CREATE TABLE TACGIA_SACH(
	MATG CHAR(5),
	MASACH CHAR(5),
	CONSTRAINT TACGIA_SACH_MATG_MASACH_PK PRIMARY KEY(MATG, MASACH)
)

CREATE TABLE PHATHANH(
	MAPH CHAR(5) CONSTRAINT PHATHANH_MAPH_PK PRIMARY KEY,
	MASACH CHAR(5),
	NGAYPH SMALLDATETIME,
	SOLUONG INT,
	NHAXUATBAN VARCHAR(20)
)

ALTER TABLE TACGIA_SACH ADD
		CONSTRAINT TACGIA_SACH_MATG_FK FOREIGN KEY(MATG)
				REFERENCES TACGIA(MATG)

ALTER TABLE TACGIA_SACH ADD
		CONSTRAINT TACGIA_SACH_MASACH_FK FOREIGN KEY(MASACH)
				REFERENCES SACH(MASACH)

ALTER TABLE PHATHANH ADD
		CONSTRAINT PHATHANH_MASACH_FK FOREIGN KEY(MASACH)
				REFERENCES SACH(MASACH)

/*Câu 2*/
/*2.1. Ngày phát hành sách phải lớn hơn ngày sinh của tác giả*/
GO
CREATE TRIGGER THEMSUA_PHATHANH_TACGIA ON PHATHANH
FOR INSERT, UPDATE
AS
BEGIN
		DECLARE @MASACH CHAR(5), @NGAYPH SMALLDATETIME, @
END

/*2.1. Sách thuộc thể loại GK chỉ do NXB Giáo dục phát hành*/
GO
CREATE TRIGGER THEMSUA_PHATHANH_SACH ON PHATHANH
FOR INSERT, UPDATE 
AS 
BEGIN
		DECLARE @THELOAI VARCHAR(25), @MASACH CHAR(5), @NHAXUATBAN VARCHAR(20)
		SELECT @MASACH = MASACH, @NHAXUATBAN = NHAXUATBAN 
		FROM INSERTED 

		SELECT @THELOAI = THELOAI 
		FROM SACH	
		WHERE MASACH = @MASACH 
		
		IF (@THELOAI = 'Giáo khoa' AND @NHAXUATBAN <> 'NXB Giáo dục')
		BEGIN
				PRINT 'THEM THAT BAI! SGK CHI CO THE DO NXB GIAO DUC PHAT HANH'
				ROLLBACK TRANSACTION
		END
		ELSE BEGIN
				PRINT 'THEM THANH CONG!'
		END
END

GO 
CREATE TRIGGER SUA_SACH ON SACHH
FOR UPDATE
AS 
BEGIN
		DECLARE @THELOAI VARCHAR(25), @MASACH CHAR(5), @MAPH CHAR(5)
		SELECT @MASACH = MASACH, @THELOAI = THELOAI 
		FROM INSERTED 

		DECLARE CURSOR_MAPH CURSOR FOR 
				SELECT MAPH 
				FROM PHATHANH 
				WHERE MASACH = @MASACH 

		OPEN CURSOR_MAPH
				FETCH NEXT FROM CURSOR_MAPH INTO @MAPH
				WHILE @@FETCH_STATUS = 0
				BEGIN
						SELECT @NHAXUATBAN = NHAXUATBAN 
						FROM PHATHANH
						WHERE MAPH = @MAPH 

						IF (@THELOAI = 'Giáo khoa' AND @NHAXUATBAN != 'Giáo dục')
						BEGIN
							PRINT 'THEM THAT BAI! SGK CHI DO NXH GIAO DUC PHAT HANH'
							ROLLBACK TRANSACTION
						END
						ELSE BEGIN
								/*Trỏ tới MAPH tiếp theo*/
						FETCH NEXT FROM CURSOR_MAPH INTO @MAPH
			END
						END
				END
END