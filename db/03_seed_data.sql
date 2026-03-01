SET client_encoding TO 'UTF8';

-- PostgreSQL Seed Data
-- Chạy: psql -U postgres -d diemdanhhocsinhlite -f db/03_seed_data.sql

-- ============================================================
-- Bảng tạm hoVaTen để sinh dữ liệu
-- ============================================================
CREATE TEMPORARY TABLE hoVaTen (
    ID    INT,
    hoDem VARCHAR(50),
    ten   VARCHAR(20)
);

INSERT INTO hoVaTen (ID, hoDem, ten) VALUES
(1, 'Nguyễn Văn', 'An'),
(2, 'Nguyễn Thị', 'Bình'),
(3, 'Trần Minh', 'Cường'),
(4, 'Phạm Hoàng', 'Dũng'),
(5, 'Lê Thị', 'Ela'),
(6, 'Nguyễn Quốc', 'Phong'),
(7, 'Đỗ Minh', 'Quân'),
(8, 'Vũ Huy', 'Quý'),
(9, 'Nguyễn Thế', 'Tuấn'),
(10, 'Trần Kim', 'Vân'),
(11, 'Nguyễn Thanh', 'Lan'),
(12, 'Phạm Hữu', 'Long'),
(13, 'Lê Hồng', 'Nhung'),
(14, 'Trần Đức', 'Nhàn'),
(15, 'Nguyễn Huy', 'Sơn'),
(16, 'Đỗ Quang', 'Thắng'),
(17, 'Vũ Đình', 'Thảo'),
(18, 'Nguyễn Văn', 'Thi'),
(19, 'Phạm Minh', 'Tuấn'),
(20, 'Lê Văn', 'Vinh'),
(21, 'Nguyễn Xuân', 'Yến'),
(22, 'Đinh Khải', 'Hoa'),
(23, 'Nguyễn Hữu', 'Khoa'),
(24, 'Trần Tùng', 'Nhật'),
(25, 'Phạm Quốc', 'Phúc'),
(26, 'Lê Nhật', 'Quyên'),
(27, 'Vũ Ngọc', 'Sang'),
(28, 'Nguyễn Văn', 'Thịnh'),
(29, 'Nguyễn Hồng', 'Tâm'),
(30, 'Nguyễn Thế', 'Tuệ'),
(31, 'Phạm Ngọc', 'Việt'),
(32, 'Lê Tấn', 'Xuân'),
(33, 'Trần Quang', 'Yêu'),
(34, 'Nguyễn Đình', 'An'),
(35, 'Vũ Văn', 'Bình'),
(36, 'Nguyễn Quốc', 'Cường'),
(37, 'Trần Minh', 'Duy'),
(38, 'Phạm Hữu', 'Hà'),
(39, 'Lê Kim', 'Minh'),
(40, 'Nguyễn Tâm', 'Nhân'),
(41, 'Vũ Văn', 'Phát'),
(42, 'Nguyễn Thái', 'Sinh'),
(43, 'Trần Đình', 'Thu'),
(44, 'Phạm Văn', 'Toàn'),
(45, 'Lê Hải', 'Vũ'),
(46, 'Nguyễn Tài', 'Xuân'),
(47, 'Đinh Văn', 'Yên'),
(48, 'Trần Văn', 'Quang'),
(49, 'Nguyễn Đình', 'Thiên'),
(50, 'Phạm Văn', 'Long'),
(51, 'Lê Văn', 'Mai'),
(52, 'Vũ Thị', 'Ngọc'),
(53, 'Nguyễn Văn', 'Quý'),
(54, 'Phạm Thái', 'Quân'),
(55, 'Lê Tường', 'Như'),
(56, 'Nguyễn Thiện', 'Phượng'),
(57, 'Vũ Quang', 'Thuận'),
(58, 'Trần Hùng', 'Thắng'),
(59, 'Nguyễn Khải', 'Tuyết'),
(60, 'Phạm Văn', 'Hà'),
(61, 'Lê Văn', 'Giang'),
(62, 'Nguyễn Đình', 'Tinh'),
(63, 'Đỗ Văn', 'Việt'),
(64, 'Vũ Đình', 'Tâm'),
(65, 'Trần Văn', 'Tuấn'),
(66, 'Phạm Văn', 'Sơn'),
(67, 'Lê Hữu', 'Thành'),
(68, 'Nguyễn Tấn', 'Bảo'),
(69, 'Vũ Huy', 'Hòa'),
(70, 'Nguyễn Thế', 'Hiệp'),
(71, 'Trần Quốc', 'Nhân'),
(72, 'Phạm Minh', 'Quang');

-- ============================================================
-- Insert monHoc
-- ============================================================
INSERT INTO monHoc (monHocID, tenMonHoc, soTiet, ghiChu) VALUES
('MH001', 'Triết học Mác – Lênin', 45, NULL),
('MH002', 'Kinh tế chính trị Mác – Lênin', 45, NULL),
('MH003', 'Chủ nghĩa xã hội khoa học', 45, NULL),
('MH004', 'Lịch sử Đảng Cộng sản Việt Nam', 45, NULL),
('MH005', 'Tư tưởng Hồ Chí Minh', 45, NULL),
('MH006', 'Pháp luật đại cương', 45, NULL),
('MH007', 'Giải tích', 60, NULL),
('MH008', 'Đại số tuyến tính', 60, NULL),
('MH009', 'Xác suất thống kê', 60, NULL),
('MH010', 'Phương pháp tính', 45, NULL),
('MH011', 'Kỹ năng mềm và tư duy khởi nghiệp', 45, NULL),
('MH012', 'Toán rời rạc', 45, NULL),
('MH013', 'Nhập môn Công nghệ thông tin – Truyền thông', 60, NULL),
('MH014', 'Cấu trúc dữ liệu và giải thuật', 60, NULL),
('MH015', 'Cơ sở lập trình', 60, NULL),
('MH016', 'Cơ sở lập trình Web', 60, NULL),
('MH017', 'Lập trình hướng đối tượng', 60, NULL),
('MH018', 'Kiến trúc máy tính', 60, NULL),
('MH019', 'Hệ điều hành', 60, NULL),
('MH020', 'Cơ sở dữ liệu', 60, NULL),
('MH021', 'Công nghệ phần mềm', 60, NULL),
('MH022', 'Vật lý điện – điện tử', 60, NULL),
('MH023', 'Lập trình Python', 60, NULL),
('MH024', 'Pháp lý và Đạo đức nghề nghiệp', 45, NULL),
('MH025', 'Thuật toán ứng dụng', 45, NULL),
('MH026', 'An toàn thông tin', 45, NULL),
('MH027', 'Mạng máy tính và truyền thông', 45, NULL),
('MH028', 'Quản lý dự án CNTT', 45, NULL),
('MH029', 'Phân tích và thiết kế hệ thống', 60, NULL),
('MH030', 'Các hệ quản trị cơ sở dữ liệu', 60, NULL),
('MH031', 'Giao diện và trải nghiệm người dùng', 60, NULL),
('MH032', 'Lập trình C#', 60, NULL),
('MH033', 'Công nghệ và lập trình WEB', 60, NULL),
('MH034', 'Phân tích và thiết kế giải thuật', 60, NULL),
('MH035', 'Đồ họa máy tính', 60, NULL),
('MH036', 'Lập trình Java', 60, NULL),
('MH037', 'Đồ án chuyên ngành', 60, NULL),
('MH038', 'Triển khai phần mềm', 60, NULL),
('MH039', 'Trí tuệ nhân tạo', 60, NULL),
('MH040', 'Học máy và khai phá dữ liệu', 60, NULL),
('MH041', 'Điện toán đám mây', 60, NULL),
('MH042', 'Hệ thống số', 60, NULL),
('MH043', 'Lý thuyết độ phức tạp', 60, NULL),
('MH044', 'Kỹ năng lập trình nâng cao', 60, NULL),
('MH045', 'Chuẩn kỹ năng Công nghệ thông tin Nhật Bản', 60, NULL),
('MH046', 'Chuẩn kỹ năng Công nghệ thông tin Hàn Quốc', 60, NULL),
('MH047', 'Yêu cầu phần mềm', 60, NULL),
('MH048', 'Thiết kế và xây dựng phần mềm', 60, NULL),
('MH049', 'Lập trình game', 60, NULL),
('MH050', 'Quản lý dịch vụ CNTT', 60, NULL),
('MH051', 'Bảo mật điện toán đám mây', 60, NULL),
('MH052', 'Hệ thống máy tính phân tán và đám mây', 60, NULL),
('MH053', 'Quản trị học', 45, NULL),
('MH054', 'Mật mã và Blockchain', 60, NULL),
('MH055', 'Bảo mật ứng dụng', 60, NULL),
('MH056', 'Bảo mật mạng máy tính', 60, NULL),
('MH057', 'An toàn dữ liệu', 60, NULL),
('MH058', 'Cơ sở thiết kế máy tính', 60, NULL),
('MH059', 'Lập trình hệ thống', 60, NULL),
('MH060', 'Thiết kế Hệ thống nhúng', 60, NULL),
('MH061', 'Nhập môn Điện tử số', 60, NULL),
('MH062', 'Thiết kế để kiểm thử', 60, NULL),
('MH063', 'Công cụ EDA cho thiết kế, kiểm chứng và mô phỏng', 60, NULL),
('MH064', 'Học sâu và ứng dụng', 60, NULL),
('MH065', 'Phân tích dữ liệu lớn', 60, NULL),
('MH066', 'Xử lý ngôn ngữ tự nhiên', 60, NULL),
('MH067', 'Thị giác máy tính', 60, NULL),
('MH068', 'Các hệ thống song song và phân tán', 60, NULL),
('MH069', 'Kiểm thử phần mềm', 60, NULL),
('MH070', 'Phát triển ứng dụng di động', 60, NULL),
('MH071', 'Quản lý dịch vụ Công nghệ thông tin', 60, NULL),
('MH072', 'Nhập môn Hệ thống thông tin', 60, NULL),
('MH073', 'Cơ sở dữ liệu đa phương tiện', 60, NULL),
('MH074', 'Quản lý Hệ thống thông tin', 60, NULL),
('MH075', 'An toàn và bảo mật hệ thống thông tin', 60, NULL),
('MH076', 'Luật kinh doanh', 45, NULL),
('MH077', 'Toán kinh tế', 45, NULL),
('MH078', 'Thống kê trong kinh tế và kinh doanh', 45, NULL),
('MH079', 'Phương pháp nghiên cứu khoa học', 45, NULL),
('MH080', 'Quản trị học đại cương', 45, NULL),
('MH081', 'Ứng dụng máy tính dành cho doanh nghiệp', 45, NULL),
('MH082', 'Tâm lý học trong kinh doanh', 45, NULL),
('MH083', 'Đạo đức kinh doanh', 45, NULL),
('MH084', 'Phân tích dữ liệu kinh doanh 1', 45, NULL),
('MH085', 'Văn hóa doanh nghiệp', 45, NULL),
('MH086', 'Hệ thống thông tin trong kinh doanh', 45, NULL),
('MH087', 'Quản trị và lãnh đạo đa văn hóa', 45, NULL),
('MH088', 'Lập trình trong phân tích kinh doanh', 45, NULL),
('MH089', 'Phân tích dữ liệu kinh doanh 2', 45, NULL),
('MH090', 'Giao tiếp trong kinh doanh', 45, NULL),
('MH091', 'Marketing mạng xã hội', 45, NULL),
('MH092', 'Thương mại điện tử', 45, NULL),
('MH093', 'Hành vi tổ chức', 45, NULL),
('MH094', 'Kinh tế học vi mô', 45, NULL),
('MH095', 'Nguyên lý kế toán', 45, NULL),
('MH096', 'Nhập môn tài chính', 45, NULL),
('MH097', 'Nhập môn marketing', 45, NULL),
('MH098', 'Kinh doanh quốc tế', 45, NULL),
('MH099', 'Quản trị vận hành', 45, NULL),
('MH100', 'Quản trị nguồn nhân lực', 45, NULL),
('MH101', 'Quản trị tài chính', 45, NULL),
('MH102', 'Quản trị chiến lược', 45, NULL),
('MH103', 'Quản trị dự án', 45, NULL),
('MH104', 'Phân tích báo cáo tài chính', 45, NULL),
('MH105', 'Chuẩn mực kiểm toán quốc tế', 45, NULL),
('MH106', 'Kỹ thuật tài chính thực hành', 45, NULL),
('MH107', 'Thuế doanh nghiệp', 45, NULL),
('MH108', 'Truyền thông marketing', 45, NULL),
('MH109', 'Hành vi khách hàng', 45, NULL),
('MH110', 'Trực quan hóa dữ liệu thị trường', 45, NULL),
('MH111', 'Thanh toán trong thương mại quốc tế', 45, NULL),
('MH112', 'Nghiệp vụ xuất nhập khẩu', 45, NULL),
('MH113', 'Mô hình tài chính', 45, NULL),
('MH114', 'Kinh tế lượng', 45, NULL),
('MH115', 'Kế toán tài chính', 45, NULL),
('MH116', 'Kế toán quản trị', 45, NULL),
('MH117', 'Kiểm toán căn bản', 45, NULL),
('MH118', 'Tài chính quốc tế', 45, NULL),
('MH119', 'Quản trị rủi ro', 45, NULL),
('MH120', 'Mô hình kinh doanh số', 45, NULL),
('MH121', 'Kho dữ liệu kinh doanh', 45, NULL),
('MH122', 'Hoạch định tài nguyên doanh nghiệp', 45, NULL),
('MH123', 'Quản trị thay đổi và đổi mới', 45, NULL),
('MH124', 'Chuyển đổi số trong kinh doanh', 45, NULL),
('MH125', 'Nhập môn logistics và quản lý chuỗi cung ứng', 45, NULL),
('MH126', 'Vận tải đa phương thức', 45, NULL),
('MH127', 'Quản lý kho hàng và phân phối', 45, NULL),
('MH128', 'Quản trị mua hàng', 45, NULL),
('MH129', 'Phân tích chuỗi cung ứng', 45, NULL),
('MH130', 'Thực tập nghề nghiệp', 45, NULL),
('MH131', 'Khóa luận tốt nghiệp', 45, NULL);

-- ============================================================
-- Insert lop
-- ============================================================
INSERT INTO lop (lopID, tenLop, siSo, nganhID, nam, khoa, ghiChu) VALUES
('L01', 'CNTT11', 40, 'CNTT', 1, 3, NULL),
('L02', 'CNTT12', 40, 'CNTT', 1, 3, NULL),
('L03', 'KHMT11', 40, 'KHMT', 1, 3, NULL),
('L04', 'KHMT12', 40, 'KHMT', 1, 3, NULL),
('L05', 'QTKD11', 40, 'QTKD', 1, 3, NULL),
('L06', 'QTKD12', 40, 'QTKD', 1, 3, NULL),
('L07', 'CNTT21', 40, 'CNTT', 2, 2, NULL),
('L08', 'CNTT22', 40, 'CNTT', 2, 2, NULL),
('L09', 'KHMT21', 40, 'KHMT', 2, 2, NULL),
('L10', 'KHMT22', 40, 'KHMT', 2, 2, NULL),
('L11', 'QTKD21', 40, 'QTKD', 2, 2, NULL),
('L12', 'QTKD22', 40, 'QTKD', 2, 2, NULL),
('L13', 'CNTT_KTPM', 40, 'CNTT', 3, 1, NULL),
('L14', 'CNTT_KTM', 40, 'CNTT', 3, 1, NULL),
('L15', 'CNTT_ATTT', 40, 'CNTT', 3, 1, NULL),
('L16', 'KHMT_PTPSW', 40, 'KHMT', 3, 1, NULL),
('L17', 'KHMT_TTNT', 40, 'KHMT', 3, 1, NULL),
('L18', 'KHMT_HTTT', 40, 'KHMT', 3, 1, NULL),
('L19', 'QTKD_QTKDS', 40, 'QTKD', 3, 1, NULL),
('L20', 'QTKD_TCKT', 40, 'QTKD', 3, 1, NULL),
('L21', 'QTKD_LOG', 40, 'QTKD', 3, 1, NULL);

-- ============================================================
-- Insert phongHoc
-- ============================================================
INSERT INTO phongHoc (phongHocID, tenPhongHoc, soGhe, tang, maToaNha, tenToaNha, maCoSo, tenCoSo, diaChiCoSo, ghiChu) VALUES
('PH01', '101', 45, 1, 'TN01', 'Tòa nhà A', 'CS01', 'Cơ sở A', 'Quận 1, TP.HCM', NULL),
('PH02', '102', 45, 1, 'TN01', 'Tòa nhà A', 'CS01', 'Cơ sở A', 'Quận 1, TP.HCM', NULL),
('PH03', '103', 45, 1, 'TN01', 'Tòa nhà A', 'CS01', 'Cơ sở A', 'Quận 1, TP.HCM', NULL),
('PH04', '104', 45, 1, 'TN01', 'Tòa nhà A', 'CS01', 'Cơ sở A', 'Quận 1, TP.HCM', NULL),
('PH05', '105', 45, 1, 'TN01', 'Tòa nhà A', 'CS01', 'Cơ sở A', 'Quận 1, TP.HCM', NULL),
('PH06', '106', 45, 1, 'TN01', 'Tòa nhà A', 'CS01', 'Cơ sở A', 'Quận 1, TP.HCM', NULL),
('PH07', '107', 45, 1, 'TN01', 'Tòa nhà A', 'CS01', 'Cơ sở A', 'Quận 1, TP.HCM', NULL),
('PH08', '201', 45, 2, 'TN01', 'Tòa nhà A', 'CS01', 'Cơ sở A', 'Quận 1, TP.HCM', NULL),
('PH09', '202', 45, 2, 'TN01', 'Tòa nhà A', 'CS01', 'Cơ sở A', 'Quận 1, TP.HCM', NULL),
('PH10', '203', 45, 2, 'TN01', 'Tòa nhà A', 'CS01', 'Cơ sở A', 'Quận 1, TP.HCM', NULL),
('PH11', '204', 45, 2, 'TN01', 'Tòa nhà A', 'CS01', 'Cơ sở A', 'Quận 1, TP.HCM', NULL),
('PH12', '205', 45, 2, 'TN01', 'Tòa nhà A', 'CS01', 'Cơ sở A', 'Quận 1, TP.HCM', NULL),
('PH13', '206', 45, 2, 'TN01', 'Tòa nhà A', 'CS01', 'Cơ sở A', 'Quận 1, TP.HCM', NULL),
('PH14', '207', 45, 2, 'TN01', 'Tòa nhà A', 'CS01', 'Cơ sở A', 'Quận 1, TP.HCM', NULL),
('PH15', '301', 45, 3, 'TN01', 'Tòa nhà A', 'CS01', 'Cơ sở A', 'Quận 1, TP.HCM', NULL),
('PH16', '302', 45, 3, 'TN01', 'Tòa nhà A', 'CS01', 'Cơ sở A', 'Quận 1, TP.HCM', NULL),
('PH17', '303', 45, 3, 'TN01', 'Tòa nhà A', 'CS01', 'Cơ sở A', 'Quận 1, TP.HCM', NULL),
('PH18', '304', 45, 3, 'TN01', 'Tòa nhà A', 'CS01', 'Cơ sở A', 'Quận 1, TP.HCM', NULL),
('PH19', '305', 45, 3, 'TN01', 'Tòa nhà A', 'CS01', 'Cơ sở A', 'Quận 1, TP.HCM', NULL),
('PH20', '306', 45, 3, 'TN01', 'Tòa nhà A', 'CS01', 'Cơ sở A', 'Quận 1, TP.HCM', NULL),
('PH21', '307', 45, 3, 'TN01', 'Tòa nhà A', 'CS01', 'Cơ sở A', 'Quận 1, TP.HCM', NULL);

-- ============================================================
-- Insert toChucDay
-- ============================================================
INSERT INTO toChucDay (soKi, nganhID, monHocID, STT_ki) VALUES
(1, 'CNTT', 'MH001', 1), (1, 'CNTT', 'MH002', 2), (1, 'CNTT', 'MH003', 3),
(1, 'CNTT', 'MH004', 4), (1, 'CNTT', 'MH005', 5), (1, 'CNTT', 'MH006', 6),
(1, 'CNTT', 'MH007', 7), (2, 'CNTT', 'MH008', 1), (2, 'CNTT', 'MH009', 2),
(2, 'CNTT', 'MH011', 3), (2, 'CNTT', 'MH012', 4), (2, 'CNTT', 'MH013', 5),
(2, 'CNTT', 'MH014', 6), (2, 'CNTT', 'MH015', 7), (3, 'CNTT', 'MH016', 1),
(3, 'CNTT', 'MH017', 2), (3, 'CNTT', 'MH018', 3), (3, 'CNTT', 'MH019', 4),
(3, 'CNTT', 'MH020', 5), (3, 'CNTT', 'MH021', 6), (3, 'CNTT', 'MH022', 7),
(4, 'CNTT', 'MH023', 1), (4, 'CNTT', 'MH024', 2), (4, 'CNTT', 'MH026', 3),
(4, 'CNTT', 'MH027', 4), (4, 'CNTT', 'MH028', 5), (4, 'CNTT', 'MH029', 6),
(4, 'CNTT', 'MH030', 7), (5, 'CNTT', 'MH031', 1), (5, 'CNTT', 'MH032', 2),
(5, 'CNTT', 'MH033', 3), (5, 'CNTT', 'MH070', 4), (5, 'CNTT', 'MH036', 5),
(5, 'CNTT', 'MH037', 6), (5, 'CNTT', 'MH038', 7), (6, 'CNTT', 'MH039', 1),
(6, 'CNTT', 'MH040', 2), (6, 'CNTT', 'MH041', 3), (6, 'CNTT', 'MH044', 4),
(6, 'CNTT', 'MH130', 5), (6, 'CNTT', 'MH131', 6),
(1, 'KHMT', 'MH001', 1), (1, 'KHMT', 'MH002', 2), (1, 'KHMT', 'MH003', 3),
(1, 'KHMT', 'MH004', 4), (1, 'KHMT', 'MH005', 5), (1, 'KHMT', 'MH006', 6),
(1, 'KHMT', 'MH007', 7), (2, 'KHMT', 'MH008', 1), (2, 'KHMT', 'MH009', 2),
(2, 'KHMT', 'MH010', 7), (2, 'KHMT', 'MH011', 3), (2, 'KHMT', 'MH012', 4),
(2, 'KHMT', 'MH013', 5), (2, 'KHMT', 'MH014', 6), (3, 'KHMT', 'MH015', 7),
(3, 'KHMT', 'MH016', 1), (3, 'KHMT', 'MH017', 2), (3, 'KHMT', 'MH018', 3),
(3, 'KHMT', 'MH019', 4), (3, 'KHMT', 'MH020', 5), (3, 'KHMT', 'MH021', 6),
(4, 'KHMT', 'MH022', 6), (4, 'KHMT', 'MH023', 1), (4, 'KHMT', 'MH024', 2),
(4, 'KHMT', 'MH025', 7), (4, 'KHMT', 'MH026', 3), (4, 'KHMT', 'MH027', 4),
(4, 'KHMT', 'MH028', 5), (5, 'KHMT', 'MH029', 4), (5, 'KHMT', 'MH030', 5),
(5, 'KHMT', 'MH031', 1), (5, 'KHMT', 'MH032', 2), (5, 'KHMT', 'MH033', 3),
(5, 'KHMT', 'MH037', 6), (5, 'KHMT', 'MH034', 7), (6, 'KHMT', 'MH035', 4),
(6, 'KHMT', 'MH039', 1), (6, 'KHMT', 'MH040', 2), (6, 'KHMT', 'MH041', 3),
(6, 'KHMT', 'MH130', 5), (6, 'KHMT', 'MH131', 6),
(1, 'QTKD', 'MH001', 1), (1, 'QTKD', 'MH002', 2), (1, 'QTKD', 'MH003', 3),
(1, 'QTKD', 'MH004', 4), (1, 'QTKD', 'MH005', 5), (1, 'QTKD', 'MH076', 6),
(2, 'QTKD', 'MH077', 1), (2, 'QTKD', 'MH078', 2), (2, 'QTKD', 'MH079', 3),
(2, 'QTKD', 'MH080', 4), (2, 'QTKD', 'MH081', 5), (2, 'QTKD', 'MH082', 6),
(3, 'QTKD', 'MH083', 1), (3, 'QTKD', 'MH084', 2), (3, 'QTKD', 'MH085', 3),
(3, 'QTKD', 'MH086', 4), (3, 'QTKD', 'MH090', 5), (3, 'QTKD', 'MH091', 6),
(4, 'QTKD', 'MH011', 1), (4, 'QTKD', 'MH094', 2), (4, 'QTKD', 'MH095', 3),
(4, 'QTKD', 'MH096', 4), (4, 'QTKD', 'MH097', 5), (4, 'QTKD', 'MH098', 6),
(5, 'QTKD', 'MH099', 1), (5, 'QTKD', 'MH100', 2), (5, 'QTKD', 'MH101', 3),
(5, 'QTKD', 'MH102', 4), (5, 'QTKD', 'MH103', 5), (5, 'QTKD', 'MH104', 6),
(6, 'QTKD', 'MH107', 1), (6, 'QTKD', 'MH108', 2), (6, 'QTKD', 'MH109', 3),
(6, 'QTKD', 'MH130', 4), (6, 'QTKD', 'MH131', 5);

-- ============================================================
-- Insert sinhVien (840 sinh viên = 21 lớp × 40)
-- ============================================================
DO $$
DECLARE
    v_k INT;
    v_i INT;
    v_randomName INT := 1;
    v_lopID VARCHAR(20);
    v_tenLop VARCHAR(30);
    v_nganhID VARCHAR(50);
    v_nam INT;
    v_khoa INT;
    v_namSinh INT;
    v_sinhVienID VARCHAR(20);
    v_hoDem VARCHAR(50);
    v_ten VARCHAR(20);
    v_ngaySinh DATE;
    v_email VARCHAR(50);
    v_matKhau VARCHAR(50);
    v_soDienThoai VARCHAR(20);
    v_ngay INT;
    v_thang INT;
    v_formatted_k VARCHAR(2);
BEGIN
    FOR v_k IN 1..21 LOOP
        v_formatted_k := LPAD(v_k::TEXT, 2, '0');
        SELECT lopID, tenLop, nganhID, nam, khoa INTO v_lopID, v_tenLop, v_nganhID, v_nam, v_khoa
        FROM lop WHERE lopID = 'L' || v_formatted_k;

        IF v_nam = 1 THEN v_namSinh := 2005;
        ELSIF v_nam = 2 THEN v_namSinh := 2004;
        ELSE v_namSinh := 2003;
        END IF;

        FOR v_i IN 1..40 LOOP
            v_sinhVienID := 'SV_' || v_tenLop || '_' || LPAD(v_i::TEXT, 2, '0');

            SELECT hoDem, ten INTO v_hoDem, v_ten
            FROM hoVaTen WHERE ID = v_randomName;

            v_randomName := v_randomName + 1;
            IF v_randomName = 73 THEN v_randomName := 1; END IF;

            v_ngay := (random() * 25)::INT + 1;
            v_thang := (random() * 11)::INT + 1;

            v_ngaySinh := (v_namSinh::TEXT || '-' || LPAD(v_thang::TEXT, 2, '0') || '-' || LPAD(v_ngay::TEXT, 2, '0'))::DATE;
            v_email := v_sinhVienID || '@gmail.com';

            -- Random password: 5 chữ cái + 3 số
            v_matKhau := '';
            FOR j IN 1..5 LOOP
                v_matKhau := v_matKhau || chr(97 + (random() * 25)::INT);
            END LOOP;
            FOR j IN 1..3 LOOP
                v_matKhau := v_matKhau || (random() * 9)::INT::TEXT;
            END LOOP;

            -- Random phone
            v_soDienThoai := '0';
            FOR j IN 1..9 LOOP
                v_soDienThoai := v_soDienThoai || ((random() * 8)::INT + 1)::TEXT;
            END LOOP;

            INSERT INTO sinhVien (sinhVienID, hoDem, ten, ngaySinh, nam, khoa, lopID, nganhID, email, matKhau, soDienThoai, vaiTro, ghiChu)
            VALUES (v_sinhVienID, v_hoDem, v_ten, v_ngaySinh, v_nam, v_khoa, v_lopID, v_nganhID, v_email, v_matKhau, v_soDienThoai, 'sinh viên', NULL);
        END LOOP;
    END LOOP;
END;
$$;

-- ============================================================
-- Insert giaoVien (131 giáo viên, mỗi người 1 môn)
-- ============================================================
DO $$
DECLARE
    v_i INT;
    v_randomName INT := 1;
    v_giaoVienID VARCHAR(20);
    v_hoDem VARCHAR(50);
    v_ten VARCHAR(20);
    v_ngaySinh DATE;
    v_email VARCHAR(50);
    v_matKhau VARCHAR(50);
    v_soDienThoai VARCHAR(20);
    v_monHocID VARCHAR(20);
    v_ngay INT;
    v_thang INT;
    v_namSinh INT;
BEGIN
    FOR v_i IN 1..131 LOOP
        v_giaoVienID := 'GV' || LPAD(v_i::TEXT, 3, '0');

        SELECT hoDem, ten INTO v_hoDem, v_ten
        FROM hoVaTen WHERE ID = v_randomName;

        v_randomName := v_randomName + 1;
        IF v_randomName = 73 THEN v_randomName := 1; END IF;

        v_ngay := (random() * 25)::INT + 1;
        v_thang := (random() * 11)::INT + 1;
        v_namSinh := 2024 - ((random() * 30)::INT + 25);

        v_ngaySinh := (v_namSinh::TEXT || '-' || LPAD(v_thang::TEXT, 2, '0') || '-' || LPAD(v_ngay::TEXT, 2, '0'))::DATE;
        v_email := v_giaoVienID || '@gmail.com';

        v_matKhau := '';
        FOR j IN 1..5 LOOP
            v_matKhau := v_matKhau || chr(97 + (random() * 25)::INT);
        END LOOP;
        FOR j IN 1..3 LOOP
            v_matKhau := v_matKhau || (random() * 9)::INT::TEXT;
        END LOOP;

        v_soDienThoai := '0';
        FOR j IN 1..9 LOOP
            v_soDienThoai := v_soDienThoai || ((random() * 8)::INT + 1)::TEXT;
        END LOOP;

        v_monHocID := 'MH' || LPAD(v_i::TEXT, 3, '0');

        INSERT INTO giaoVien (giaoVienID, hoDem, ten, ngaySinh, email, matKhau, soDienThoai, vaiTro, monHocID, ghiChu)
        VALUES (v_giaoVienID, v_hoDem, v_ten, v_ngaySinh, v_email, v_matKhau, v_soDienThoai, 'giáo viên', v_monHocID, NULL);
    END LOOP;
END;
$$;

-- Dọn bảng tạm
DROP TABLE IF EXISTS hoVaTen;
