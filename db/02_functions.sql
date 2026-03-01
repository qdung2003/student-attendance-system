SET client_encoding TO 'UTF8';

-- PostgreSQL Functions & Procedures
-- Chạy: psql -U postgres -d diemdanhhocsinhlite -f db/02_functions.sql

-- ============================================================
-- FUNCTION: dangNhap - Xác thực đăng nhập
-- ============================================================
CREATE OR REPLACE FUNCTION dangNhap(
    p_email    VARCHAR,
    p_matKhau  VARCHAR
)
RETURNS TABLE("ID" VARCHAR, "vaiTro" VARCHAR)
LANGUAGE plpgsql
AS $$
BEGIN
    -- Kiểm tra bảng sinhVien
    IF EXISTS (
        SELECT 1 FROM sinhVien
        WHERE email = p_email AND matKhau = p_matKhau
    ) THEN
        RETURN QUERY
        SELECT sinhVienID::VARCHAR, 'sinh vien'::VARCHAR
        FROM sinhVien
        WHERE email = p_email AND matKhau = p_matKhau
        LIMIT 1;
        RETURN;
    END IF;

    -- Kiểm tra bảng giaoVien
    IF EXISTS (
        SELECT 1 FROM giaoVien
        WHERE email = p_email AND matKhau = p_matKhau
    ) THEN
        RETURN QUERY
        SELECT giaoVienID::VARCHAR, 'giao vien'::VARCHAR
        FROM giaoVien
        WHERE email = p_email AND matKhau = p_matKhau
        LIMIT 1;
        RETURN;
    END IF;

    -- Không tìm thấy -> trả về NULL
    RETURN QUERY SELECT NULL::VARCHAR, NULL::VARCHAR;
END;
$$;

-- ============================================================
-- FUNCTION: layThoiKhoaBieu - Lấy thời khóa biểu theo tuần
-- ============================================================
CREATE OR REPLACE FUNCTION layThoiKhoaBieu(
    p_ID     VARCHAR,
    p_vaiTro VARCHAR,
    p_date   DATE
)
RETURNS TABLE(
    "buoiHocID"   VARCHAR,
    "ngay"        DATE,
    "tietBatDau"  INT,
    "tietKetThuc" INT,
    "maDiemDanh"  VARCHAR,
    "ghiChu"      TEXT,
    "tenMonHoc"   VARCHAR,
    "tenPhongHoc" VARCHAR,
    "maCoSo"      VARCHAR,
    "tenLop"      VARCHAR,
    "hoDem"       VARCHAR,
    "ten"         VARCHAR
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_monday DATE;
    v_friday DATE;
    v_lopID  VARCHAR;
BEGIN
    -- Tính thứ 2 và thứ 6 của tuần chứa p_date
    -- Chủ nhật (DOW=0) thuộc về tuần tiếp theo, giống SQL Server
    v_monday := CASE
        WHEN EXTRACT(DOW FROM p_date) = 0 THEN p_date + 1
        ELSE p_date - (EXTRACT(ISODOW FROM p_date)::INT - 1)
    END;
    v_friday := v_monday + 4;

    IF p_vaiTro = 'sinh vien' THEN
        SELECT sv.lopID INTO v_lopID
        FROM sinhVien sv
        WHERE sv.sinhVienID = p_ID;

        RETURN QUERY
        SELECT bh.buoiHocID, bh.ngay, bh.tietBatDau, bh.tietKetThuc,
               bh.maDiemDanh, bh.ghiChu,
               mh.tenMonHoc, ph.tenPhongHoc, ph.maCoSo,
               l.tenLop, gv.hoDem, gv.ten
        FROM   buoiHoc bh
        JOIN   monHoc mh   ON bh.monHocID   = mh.monHocID
        JOIN   phongHoc ph ON bh.phongHocID  = ph.phongHocID
        JOIN   lop l       ON bh.lopID       = l.lopID
        JOIN   giaoVien gv ON bh.giaoVienID  = gv.giaoVienID
        WHERE  bh.ngay BETWEEN v_monday AND v_friday
        AND    bh.lopID = v_lopID;

    ELSIF p_vaiTro = 'giao vien' THEN
        RETURN QUERY
        SELECT bh.buoiHocID, bh.ngay, bh.tietBatDau, bh.tietKetThuc,
               bh.maDiemDanh, bh.ghiChu,
               mh.tenMonHoc, ph.tenPhongHoc, ph.maCoSo,
               l.tenLop, gv.hoDem, gv.ten
        FROM   buoiHoc bh
        JOIN   monHoc mh   ON bh.monHocID   = mh.monHocID
        JOIN   phongHoc ph ON bh.phongHocID  = ph.phongHocID
        JOIN   lop l       ON bh.lopID       = l.lopID
        JOIN   giaoVien gv ON bh.giaoVienID  = gv.giaoVienID
        WHERE  bh.ngay BETWEEN v_monday AND v_friday
        AND    bh.giaoVienID = p_ID;
    END IF;
END;
$$;

-- ============================================================
-- FUNCTION: layDanhSachLop - Lấy danh sách lớp theo buổi học
-- ============================================================
CREATE OR REPLACE FUNCTION layDanhSachLop(
    p_buoiHocID VARCHAR
)
RETURNS TABLE(
    "tongTietVang" FLOAT,
    "sinhVienID"   VARCHAR,
    "hoDem"        VARCHAR,
    "ten"          VARCHAR,
    "tuDiemDanh"   TEXT,
    "trangThai"    VARCHAR,
    "soTiet"       INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_lopID VARCHAR;
BEGIN
    SELECT bh.lopID INTO v_lopID
    FROM buoiHoc bh
    WHERE bh.buoiHocID = p_buoiHocID;

    RETURN QUERY
    WITH bangTamDiemDanh2 AS (
        SELECT
            sv.sinhVienID,
            COALESCE(ld.trangThai, 'Vắng mặt') AS trangThai,
            COALESCE(ld.soTiet, 0)::FLOAT AS soTiet
        FROM sinhVien sv
        LEFT JOIN luuDiemDanh ld ON sv.sinhVienID = ld.sinhVienID
        WHERE sv.lopID = v_lopID
    ),
    bangTamConverted AS (
        SELECT
            b.sinhVienID,
            CASE WHEN b.trangThai = 'Vắng mặt có phép' THEN 'Vắng mặt' ELSE b.trangThai END AS trangThai,
            CASE WHEN b.trangThai = 'Vắng mặt có phép' THEN ROUND((b.soTiet * 2.0 / 3.0)::NUMERIC, 2)::FLOAT ELSE b.soTiet END AS soTiet
        FROM bangTamDiemDanh2 b
    ),
    bangTietVang AS (
        SELECT bc.sinhVienID, SUM(bc.soTiet) AS tongTietVang
        FROM bangTamConverted bc
        GROUP BY bc.sinhVienID
    )
    SELECT
        btv.tongTietVang,
        sv.sinhVienID,
        sv.hoDem,
        sv.ten,
        COALESCE(ldt.ghiChu, '')::TEXT AS tuDiemDanh,
        ldt.trangThai,
        ldt.soTiet
    FROM sinhVien sv
    INNER JOIN bangTietVang btv ON sv.sinhVienID = btv.sinhVienID
    LEFT JOIN luuDiemDanhTam ldt ON sv.sinhVienID = ldt.sinhVienID
        AND (ldt.buoiHocID IS NULL OR ldt.buoiHocID = p_buoiHocID)
    LEFT JOIN luuDiemDanh ld ON sv.sinhVienID = ld.sinhVienID
        AND (ld.buoiHocID IS NULL OR ld.buoiHocID = p_buoiHocID)
    WHERE sv.lopID = v_lopID;
END;
$$;

-- ============================================================
-- PROCEDURE: taoMaDiemDanh - Tạo mã điểm danh cho buổi học
-- ============================================================
CREATE OR REPLACE PROCEDURE taoMaDiemDanh(
    p_maDiemDanh VARCHAR,
    p_buoiHocID  VARCHAR
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE buoiHoc
    SET maDiemDanh = p_maDiemDanh
    WHERE buoiHocID = p_buoiHocID;
END;
$$;

-- ============================================================
-- FUNCTION: nhapMaDiemDanh - Sinh viên nhập mã điểm danh
-- Trả về 'yes' hoặc 'no'
-- ============================================================
CREATE OR REPLACE FUNCTION nhapMaDiemDanh(
    p_maDiemDanh VARCHAR,
    p_sinhVienID VARCHAR,
    p_buoiHocID  VARCHAR
)
RETURNS VARCHAR
LANGUAGE plpgsql
AS $$
DECLARE
    v_maDiemDanhThuc VARCHAR;
    v_soTiet INT;
    v_count INT;
    v_luuTamID VARCHAR;
BEGIN
    SELECT maDiemDanh INTO v_maDiemDanhThuc
    FROM buoiHoc
    WHERE buoiHocID = p_buoiHocID;

    IF v_maDiemDanhThuc = p_maDiemDanh THEN
        SELECT (tietKetThuc - tietBatDau) INTO v_soTiet
        FROM buoiHoc
        WHERE buoiHocID = p_buoiHocID;

        SELECT COUNT(*) INTO v_count
        FROM luuDiemDanhTam
        WHERE buoiHocID = p_buoiHocID AND sinhVienID = p_sinhVienID;

        IF v_count > 0 THEN
            UPDATE luuDiemDanhTam
            SET trangThai = 'Có mặt', soTiet = v_soTiet
            WHERE buoiHocID = p_buoiHocID AND sinhVienID = p_sinhVienID;
        ELSE
            v_luuTamID := 'luuTam' || (SELECT COUNT(*) + 1 FROM luuDiemDanhTam)::VARCHAR;
            INSERT INTO luuDiemDanhTam (luuDiemDanhID, buoiHocID, sinhVienID, trangThai, soTiet, ghiChu)
            VALUES (v_luuTamID, p_buoiHocID, p_sinhVienID, 'Có mặt', v_soTiet, p_maDiemDanh);
        END IF;

        RETURN 'yes';
    ELSE
        RETURN 'no';
    END IF;
END;
$$;

-- ============================================================
-- FUNCTION: luuDiemDanhTuDong - Lưu điểm danh từ bảng tạm
-- Trả về 'yes' hoặc 'no'
-- ============================================================
CREATE OR REPLACE FUNCTION luuDiemDanhTuDong(
    p_buoiHocID VARCHAR
)
RETURNS VARCHAR
LANGUAGE plpgsql
AS $$
DECLARE
    v_numLuuDiemDanh INT;
BEGIN
    IF EXISTS (SELECT 1 FROM luuDiemDanhTam WHERE buoiHocID = p_buoiHocID) THEN
        SELECT COUNT(*) INTO v_numLuuDiemDanh FROM luuDiemDanh;

        -- Chèn mới từ luuDiemDanhTam vào luuDiemDanh
        INSERT INTO luuDiemDanh (luuDiemDanhID, buoiHocID, sinhVienID, trangThai, soTiet, ghiChu)
        SELECT
            'luu' || (ROW_NUMBER() OVER (ORDER BY ldt.sinhVienID) + v_numLuuDiemDanh)::VARCHAR,
            ldt.buoiHocID,
            ldt.sinhVienID,
            ldt.trangThai,
            ldt.soTiet,
            NULL
        FROM luuDiemDanhTam ldt
        WHERE ldt.buoiHocID = p_buoiHocID
        AND ldt.sinhVienID NOT IN (SELECT sinhVienID FROM luuDiemDanh);

        -- Cập nhật các record đã tồn tại
        UPDATE luuDiemDanh ld
        SET trangThai = ldt.trangThai,
            soTiet    = ldt.soTiet
        FROM luuDiemDanhTam ldt
        WHERE ld.sinhVienID = ldt.sinhVienID
        AND   ld.buoiHocID = p_buoiHocID;

        RETURN 'yes';
    ELSE
        RETURN 'no';
    END IF;
END;
$$;
