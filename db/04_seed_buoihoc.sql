SET client_encoding TO 'UTF8';

-- Seed data cho bang buoiHoc
DO $$
DECLARE
    v_t INT;
    v_i INT;
    v_k INT;

    v_buoiHocID    VARCHAR(20);
    v_numBuoiHocID INT := 1;

    v_ngayBuoiHoc  DATE;
    v_ngayKiHoc    DATE;
    v_ngayMonHoc   DATE;

    v_tietBatDau   INT;
    v_tietKetThuc  INT;
    v_monHocID     VARCHAR(20);
    v_phongHocID   VARCHAR(20);
    v_lopID        VARCHAR(20);
    v_giaoVienID   VARCHAR(20);

    v_soMon1Ki     INT;
    v_tongSoTiet   INT;
    v_baseSoTiet   INT;
    v_extraSoTiet  INT;
    v_soTiet       INT;
    v_nganhID      VARCHAR(50);
    v_numDate      INT;
    v_formatted_k  VARCHAR(2);

    rec RECORD;
BEGIN
    v_ngayKiHoc := '2022-06-06';

    FOR v_k IN 1..6 LOOP
        v_formatted_k := LPAD(v_k::TEXT, 2, '0');

        SELECT lopID, nganhID INTO v_lopID, v_nganhID
        FROM lop WHERE lopID = 'L' || v_formatted_k;

        v_phongHocID := 'PH' || v_formatted_k;

        IF v_nganhID = 'CNTT' THEN v_numDate := 0;
        ELSIF v_nganhID = 'KHMT' THEN v_numDate := 1;
        ELSIF v_nganhID = 'QTKD' THEN v_numDate := 2;
        END IF;

        -- Tao bang tam
        CREATE TEMPORARY TABLE IF NOT EXISTS bangTam (
            monHocID VARCHAR(20),
            soTiet INT,
            STT_ki INT
        ) ON COMMIT DROP;
        DELETE FROM bangTam;

        INSERT INTO bangTam (monHocID, soTiet, STT_ki)
        SELECT t.monHocID, m.soTiet, t.STT_ki
        FROM toChucDay t
        JOIN monHoc m ON t.monHocID = m.monHocID
        WHERE t.soKi = 1 AND t.nganhID = v_nganhID;

        SELECT COUNT(*) INTO v_soMon1Ki FROM bangTam;

        FOR v_i IN 1..v_soMon1Ki LOOP
            SELECT monHocID, soTiet INTO v_monHocID, v_tongSoTiet
            FROM bangTam WHERE STT_ki = v_i;

            SELECT giaoVienID INTO v_giaoVienID
            FROM giaoVien WHERE monHocID = v_monHocID
            LIMIT 1;

            -- Logic tinh tiet va ngay (giu nguyen logic goc)
            IF v_k % 2 = 0 THEN
                IF v_i >= 6 - v_numDate THEN
                    v_tietKetThuc := 5;
                    v_ngayMonHoc := v_ngayKiHoc + (v_i - 6 + v_numDate);
                ELSE
                    v_tietBatDau := 6;
                    v_ngayMonHoc := v_ngayKiHoc + (v_i - 1 + v_numDate);
                END IF;
            ELSE
                IF v_i >= 6 - v_numDate THEN
                    v_tietBatDau := 6;
                    v_ngayMonHoc := v_ngayKiHoc + (v_i - 6 + v_numDate);
                ELSE
                    v_tietKetThuc := 5;
                    v_ngayMonHoc := v_ngayKiHoc + (v_i - 1 + v_numDate);
                END IF;
            END IF;

            v_ngayBuoiHoc := v_ngayMonHoc;
            v_baseSoTiet  := FLOOR(v_tongSoTiet / 4);
            v_extraSoTiet := v_tongSoTiet % 4;

            FOR v_t IN 1..v_baseSoTiet LOOP
                v_buoiHocID := 'BH' || LPAD(v_numBuoiHocID::TEXT, 5, '0');
                v_numBuoiHocID := v_numBuoiHocID + 1;

                IF v_t <= v_extraSoTiet THEN
                    v_soTiet := 5;
                ELSE
                    v_soTiet := 4;
                END IF;

                IF v_k % 2 = 0 THEN
                    IF v_i >= 6 - v_numDate THEN
                        v_tietBatDau := v_tietKetThuc - v_soTiet + 1;
                    ELSE
                        v_tietKetThuc := v_tietBatDau + v_soTiet - 1;
                    END IF;
                ELSE
                    IF v_i >= 6 - v_numDate THEN
                        v_tietKetThuc := v_tietBatDau + v_soTiet - 1;
                    ELSE
                        v_tietBatDau := v_tietKetThuc - v_soTiet + 1;
                    END IF;
                END IF;

                INSERT INTO buoiHoc (buoiHocID, ngay, tietBatDau, tietKetThuc, monHocID, phongHocID, lopID, giaoVienID, maDiemDanh, ghiChu)
                VALUES (v_buoiHocID, v_ngayBuoiHoc, v_tietBatDau, v_tietKetThuc, v_monHocID, v_phongHocID, v_lopID, v_giaoVienID, NULL, NULL);

                v_ngayBuoiHoc := v_ngayBuoiHoc + 7;
            END LOOP;
        END LOOP;
    END LOOP;

    DROP TABLE IF EXISTS bangTam;
END;
$$;
