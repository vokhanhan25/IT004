/* Cau 1 */

CREATE DATABASE QLDH

USE QLDH

CREATE TABLE KHOA(
	MAKHOA VARCHAR(4) CONSTRAINT KHOA_MAKHOA_PK PRIMARY KEY(MAKHOA),
	TENKHOA VARCHAR(40),
	NGTLAP SMALLDATETIME,
	TRGKHOA CHAR(4)
)

CREATE TABLE MONHOC(
	MAMH VARCHAR(10) CONSTRAINT MONHOC_MAMH_PK PRIMARY KEY(MAMH),
	TENMH VARCHAR(40),
	TCLT TINYINT,
	TCTH TINYINT,
	MAKHOA VARCHAR(4)
)


CREATE TABLE DIEUKIEN(
	MAMH VARCHAR(10),
	MAMH_TRUOC VARCHAR(10)
	CONSTRAINT DIEUKIEN_MAMH_MAMH_TRUOC_PK PRIMARY KEY(MAMH, MAMH_TRUOC)
)

CREATE TABLE GIAOVIEN(
	MAGV CHAR(4) CONSTRAINT GIAOVIEN_MAGV_PK PRIMARY KEY(MAGV),
	HOTEN VARCHAR(40),
	HOCVI VARCHAR (10),
	HOCHAM VARCHAR(10),
	NGSINH SMALLDATETIME,
	NGVL SMALLDATETIME,
	HESO NUMERIC(4,2),
	MUCLUONG MONEY,
	MAKHOA VARCHAR(4)
)

CREATE TABLE LOP(
	MALOP CHAR(3) CONSTRAINT LOP_MALOP_PK PRIMARY KEY(MALOP),
	TENLOP VARCHAR(40),
	TRGLOP CHAR(5),
	SISO TINYINT,
	MAGVCN CHAR(4)
)

CREATE TABLE HOCVIEN(
	MAHV CHAR(5) CONSTRAINT HOCVIEN_MAHV_PK PRIMARY KEY(MAHV),
	HO VARCHAR(40),
	TEN VARCHAR(10),
	NGSINH SMALLDATETIME,
	GIOITINH VARCHAR(3),
	NOISINH VARCHAR(40),
	MALOP CHAR(3)
)

CREATE TABLE GIANGDAY(
	MALOP CHAR(3),
	MAMH VARCHAR(10),
	MAGV CHAR(4),
	HOCKY TINYINT,
	NAM SMALLINT,
	TUNGAY SMALLDATETIME,
	DENNGAY SMALLDATETIME,
	CONSTRAINT GIANGDAY_MALOP_MAMH_PK PRIMARY KEY(MALOP, MAMH)
)

CREATE TABLE KETQUATHI(
	MAHV CHAR(5),
	MAMH VARCHAR(10),
	LANTHI TINYINT,
	NGTHI SMALLDATETIME,
	DIEM NUMERIC(4, 2),
	KQUA VARCHAR(10),
	CONSTRAINT KETQUATHI_MAHV_MAMH_PK PRIMARY KEY(MAHV, MAMH)
)

ALTER TABLE KHOA ADD
	CONSTRAINT KHOA_TRGKHOA_FK FOREIGN KEY(TRGKHOA)
			REFERENCES GIAOVIEN(MAGV)

ALTER TABLE MONHOC ADD
	CONSTRAINT MONHOC_MAKHOA_FK FOREIGN KEY(MAKHOA)
			REFERENCES KHOA(MAKHOA)

ALTER TABLE DIEUKIEN ADD
	CONSTRAINT DIEUKIEN_MAMH_FK FOREIGN KEY(MAMH)
			REFERENCES MONHOC(MAMH)

ALTER TABLE DIEUKIEN ADD
	CONSTRAINT DIEUKIEN_MAMH_TRUOC_FK FOREIGN KEY(MAMH_TRUOC)
			REFERENCES MONHOC(MAMH)

ALTER TABLE GIAOVIEN ADD
	CONSTRAINT GIAOVIEN_MAKHOA_FK FOREIGN KEY(MAKHOA)
		REFERENCES KHOA(MAKHOA)

ALTER TABLE LOP ADD
	CONSTRAINT LOP_TRGLO_FK FOREIGN KEY(TRGLOP)
		REFERENCES HOCVIEN(MAHV)

ALTER TABLE LOP ADD
	CONSTRAINT LOP_MAGVN_FK FOREIGN KEY(MAGVCN)
		REFERENCES GIAOVIEN(MAGV)
	
ALTER TABLE HOCVIEN ADD
	CONSTRAINT HOCVIEN_MALOP_FK FOREIGN KEY(MALOP)
		REFERENCES LOP(MALOP)

ALTER TABLE GIANGDAY ADD
	CONSTRAINT GIANGDAY_MALOP_FK FOREIGN KEY(MALOP)
		REFERENCES LOP(MALOP)

ALTER TABLE GIANGDAY ADD
	CONSTRAINT GIANGDAY_MAMH_FK FOREIGN KEY(MAMH)
		REFERENCES MONHOC(MAMH)

ALTER TABLE GIANGDAY ADD
	CONSTRAINT GIANGDAY_MAGV_FK FOREIGN KEY(MAGV)
		REFERENCES GIAOVIEN(MAGV)

ALTER TABLE KETQUATHI ADD
	CONSTRAINT KETQUATHI_MAHV_FK FOREIGN KEY(MAHV)
		REFERENCES HOCVIEN(MAHV)

ALTER TABLE KETQUATHI ADD
	CONSTRAINT KETQUATHI_MAMH_FK FOREIGN KEY(MAMH)
		REFERENCES MONHOC(MAMH)

ALTER TABLE HOCVIEN ADD
	GHICHU VARCHAR(20),
	DIEMTB NUMERIC (4, 2),
	XEPLOAI VARCHAR(20)

/* Cau 2 */
ALTER TABLE HOCVIEN ADD
	CHECK(LEFT(MAHV, 3) = MALOP),
	CHECK(ISNUMERIC(RIGHT(MAHV, 2)) = 1) 


/* Cau 3 */
ALTER TABLE HOCVIEN ADD
	CHECK (GIOITINH IN ('Nam', 'Nu'))

/* Cau 4 */
ALTER TABLE KETQUATHI ADD
	CHECK (DIEM >=0 AND DIEM <= 10)

/* Cau 5 */

ALTER TABLE KETQUATHI ADD
	CHECK((DIEM < 5 AND KQUA = 'Khong dat') OR (DIEM >= 5 AND KQUA = 'Dat'))

/* Cau 6 */
ALTER TABLE KETQUATHI ADD
	CHECK (LANTHI <= 3)

/* Cau 7 */
ALTER TABLE GIANGDAY ADD
	CHECK (HOCKY >= 1 AND HOCKY <= 3)

/* Cau 8 */

ALTER TABLE GIAOVIEN ADD
	CHECK (HOCVI IN ('CN', 'KS', 'ThS', 'TS', 'PTS'))


