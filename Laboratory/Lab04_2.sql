CREATE DATABASE QLXE

USE QLXE

CREATE TABLE NHANVIEN(
		MaNV CHAR(5) CONSTRAINT NHANVIEN_MaNV_PK PRIMARY KEY,
		HoTen VARCHAR(20),
		NgayVL SMALLDATETIME,
		HSLuong NUMERIC(4, 2),
		MaPhong CHAR(5),
)

CREATE TABLE PHONGBAN(
		MaPhong CHAR(5) CONSTRAINT PHONGBAN_MaPhong_PK PRIMARY KEY,
		TenPhong VARCHAR(25),
		TruongPhong CHAR(5)
)

CREATE TABLE XE(
		MaXe CHAR(5) CONSTRAINT XE_MaXe_PK PRIMARY KEY,
		LoaiXe VARCHAR(20),
		SoChoNgoi INT,
		NamSX INT
)

CREATE TABLE PHANCONG(
		MaPC CHAR(5) CONSTRAINT PHANCONG_MaPC_PK PRIMARY KEY,
		MaNV CHAR(5),
		XaXe CHAR(5),
		NgayDi SMALLDATETIME,
		NgayVe SMALLDATETIME,
		NoiDen VARCHAR(25)
)

ALTER TABLE NHANVIEN ADD
		CONSTRAINT NHANVIEN_MaPhong_FK FOREIGN KEY(MaPhong)
						REFERENCES PHONGBAN(MaPhong)

ALTER TABLE PHANCONG ADD
		CONSTRAINT PHANCONG_MaNV_FK FOREIGN KEY(MaNV)
						REFERENCES NHANVIEN(MaNV)

ALTER TABLE PHANCONG ADD
		CONSTRAINT PHANCONG_MaXe_FK FOREIGN KEY(MaXe)
						REFERENCES XE(MaXe)