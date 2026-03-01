SET client_encoding TO 'UTF8';

-- PostgreSQL Schema cho hệ thống điểm danh
-- Chạy: psql -U postgres -d diemdanhhocsinhlite -f db/01_schema.sql

CREATE TABLE monHoc (
    monHocID    VARCHAR(20) PRIMARY KEY,
    tenMonHoc   VARCHAR(50),
    soTiet      INT,
    ghiChu      TEXT
);

CREATE TABLE toChucDay (
    soKi     INT,
    nganhID  VARCHAR(50),
    monHocID VARCHAR(20),
    STT_ki   INT
);

CREATE TABLE lop (
    lopID   VARCHAR(20) PRIMARY KEY,
    tenLop  VARCHAR(30),
    siSo    INT,
    nganhID VARCHAR(20),
    nam     INT,
    khoa    INT,
    ghiChu  TEXT
);

CREATE TABLE sinhVien (
    sinhVienID  VARCHAR(20) PRIMARY KEY,
    hoDem       VARCHAR(50),
    ten         VARCHAR(20),
    ngaySinh    DATE,
    nam         INT,
    khoa        INT,
    lopID       VARCHAR(20),
    nganhID     VARCHAR(20),
    email       VARCHAR(50) UNIQUE,
    matKhau     VARCHAR(50),
    soDienThoai VARCHAR(20),
    vaiTro      VARCHAR(30),
    ghiChu      TEXT
);

CREATE TABLE giaoVien (
    giaoVienID  VARCHAR(20) PRIMARY KEY,
    hoDem       VARCHAR(50),
    ten         VARCHAR(20),
    ngaySinh    DATE,
    email       VARCHAR(50) UNIQUE,
    matKhau     VARCHAR(50),
    soDienThoai VARCHAR(20),
    vaiTro      VARCHAR(30),
    monHocID    VARCHAR(20),
    ghiChu      TEXT
);

CREATE TABLE phongHoc (
    phongHocID  VARCHAR(20) PRIMARY KEY,
    tenPhongHoc VARCHAR(50),
    soGhe       INT,
    tang        INT,
    maToaNha    VARCHAR(20),
    tenToaNha   VARCHAR(50),
    maCoSo      VARCHAR(20),
    tenCoSo     VARCHAR(50),
    diaChiCoSo  TEXT,
    ghiChu      TEXT
);

CREATE TABLE buoiHoc (
    buoiHocID   VARCHAR(20) PRIMARY KEY,
    ngay        DATE,
    tietBatDau  INT,
    tietKetThuc INT,
    monHocID    VARCHAR(20),
    phongHocID  VARCHAR(20),
    lopID       VARCHAR(20),
    giaoVienID  VARCHAR(20),
    maDiemDanh  VARCHAR(50),
    ghiChu      TEXT
);

CREATE TABLE luuDiemDanhTam (
    luuDiemDanhID VARCHAR(20) PRIMARY KEY,
    buoiHocID     VARCHAR(20),
    sinhVienID    VARCHAR(20),
    trangThai     VARCHAR(20),
    soTiet        INT,
    ghiChu        TEXT
);

CREATE TABLE luuDiemDanh (
    luuDiemDanhID VARCHAR(20) PRIMARY KEY,
    buoiHocID     VARCHAR(20),
    sinhVienID    VARCHAR(20),
    trangThai     VARCHAR(20),
    soTiet        INT,
    ghiChu        TEXT
);

-- Foreign Keys
ALTER TABLE toChucDay ADD CONSTRAINT FK_toChucDay_monHoc FOREIGN KEY (monHocID) REFERENCES monHoc(monHocID);
ALTER TABLE sinhVien ADD CONSTRAINT FK_sinhVien_lopID FOREIGN KEY (lopID) REFERENCES lop(lopID);
ALTER TABLE giaoVien ADD CONSTRAINT FK_giaoVien_monHocID FOREIGN KEY (monHocID) REFERENCES monHoc(monHocID);

ALTER TABLE buoiHoc ADD CONSTRAINT FK_buoiHoc_monHocID   FOREIGN KEY (monHocID)   REFERENCES monHoc(monHocID);
ALTER TABLE buoiHoc ADD CONSTRAINT FK_buoiHoc_phongHocID FOREIGN KEY (phongHocID) REFERENCES phongHoc(phongHocID);
ALTER TABLE buoiHoc ADD CONSTRAINT FK_buoiHoc_lopID      FOREIGN KEY (lopID)      REFERENCES lop(lopID);
ALTER TABLE buoiHoc ADD CONSTRAINT FK_buoiHoc_giaoVienID FOREIGN KEY (giaoVienID) REFERENCES giaoVien(giaoVienID);

ALTER TABLE luuDiemDanhTam ADD CONSTRAINT FK_luuDiemDanhTam_buoiHocID  FOREIGN KEY (buoiHocID)  REFERENCES buoiHoc(buoiHocID);
ALTER TABLE luuDiemDanhTam ADD CONSTRAINT FK_luuDiemDanhTam_sinhVienID FOREIGN KEY (sinhVienID) REFERENCES sinhVien(sinhVienID);

ALTER TABLE luuDiemDanh ADD CONSTRAINT FK_luuDiemDanh_buoiHocID  FOREIGN KEY (buoiHocID)  REFERENCES buoiHoc(buoiHocID);
ALTER TABLE luuDiemDanh ADD CONSTRAINT FK_luuDiemDanh_sinhVienID FOREIGN KEY (sinhVienID) REFERENCES sinhVien(sinhVienID);
