CREATE DATABASE DE2

USE DE2

CREATE TABLE PHONGBAN (
	MaPhong CHAR(5) CONSTRAINT PHONGBAN_MaPhong_PK PRIMARY KEY(MaPhong),
	TenPhong VARCHAR(25),
	TruongPhong CHAR(5)
) 

CREATE TABLE NHANVIEN (
	MaNV CHAR(5) CONSTRAINT NHANVIEN_MaNV_PK PRIMARY KEY(MaNV),
	HoTen VARCHAR(20),
	NgayVL SMALLDATETIME,
	HSLuong NUMERIC(4, 2),
	MaPhong CHAR(5) CONSTRAINT NHANVIEN_MaPhong_FK FOREIGN KEY(MaPhong)
						REFERENCES PHONGBAN(MaPhong)
)

CREATE TABLE XE (
	MaXe CHAR(5) CONSTRAINT XE_MaXE_PK PRIMARY KEY(MaXe),
	LoaiXe VARCHAR(20),
	SoChoNgoi INT,
	NamSX INT
)

CREATE TABLE PHANCONG(
	MaPC CHAR(5) CONSTRAINT PHANCONG_MaPC_PK PRIMARY KEY(MaPC),
	MaNV CHAR(5),
	MaXe CHAR(5),
	NgayDi SMALLDATETIME,
	NgayVe SMALLDATETIME,
	NoiDen VARCHAR(25),
	CONSTRAINT PHANCONG_MaNV_FK FOREIGN KEY(MaNV)
			REFERENCES NHANVIEN(MaNV),
	CONSTRAINT PHANCONG_MaXe_FK FOREIGN KEY(MaXe)
			REFERENCES XE(MaXe)
)