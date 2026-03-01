const { Pool } = require('pg');
const express = require('express');
const cors = require('cors');

const app = express();
const port = 3000;

// Cấu hình kết nối PostgreSQL
const pool = new Pool({
  user: 'postgres',
  password: '123456',
  host: 'localhost',
  port: 5432,
  database: 'diemdanhhocsinhlite',
});

// Kiểm tra kết nối
pool.connect()
  .then(client => {
    console.log('Connected to PostgreSQL database.');
    client.release();
  })
  .catch(err => {
    console.error('Error connecting to PostgreSQL:', err);
  });

app.use(express.json());
app.use(cors());


// API đăng nhập
app.post('/layIDvaVaiTro', async (req, res) => {
  const { email, password } = req.body;

  try {
    const result = await pool.query(
      'SELECT "ID", "vaiTro" FROM dangNhap($1, $2)',
      [email, password]
    );

    const row = result.rows[0];

    if (row && row.ID) {
      res.json({ success: true, ID: row.ID, vaiTro: row.vaiTro });
    } else {
      res.status(401).json({ success: false, message: 'Invalid email or password.' });
    }
  } catch (error) {
    console.error('Error executing procedure:', error);
    res.status(500).json({ success: false, message: 'An error occurred. Please try again.' });
  }
});


// API lấy thời khóa biểu
app.post('/layThoiKhoaBieu', async (req, res) => {
  const { ID, vaiTro, date } = req.body;
  try {
    console.log('api lay thoi khoa bieu', ID, vaiTro, date);

    const result = await pool.query(
      'SELECT * FROM layThoiKhoaBieu($1, $2, $3)',
      [ID, vaiTro, date]
    );

    res.json(result.rows);
  } catch (error) {
    console.error('Error executing SQL query:', error);
    res.status(500).json({ message: 'Error retrieving schedule.' });
  }
});


// API lấy danh sách lớp
app.post('/layDanhSachLop', async (req, res) => {
  const { buoiHocID } = req.body;

  try {
    const result = await pool.query(
      'SELECT * FROM layDanhSachLop($1)',
      [buoiHocID]
    );

    res.json(result.rows);
  } catch (error) {
    console.error('Error executing SQL query:', error);
    res.status(500).json({ message: 'Error retrieving class list.' });
  }
});


// API tạo mã điểm danh
app.post('/taoMaDiemDanh', async (req, res) => {
  const { maDiemDanh, buoiHocID } = req.body;

  try {
    await pool.query('CALL taoMaDiemDanh($1, $2)', [maDiemDanh, buoiHocID]);

    res.json({ success: true, message: 'Từ khóa điểm danh đã được lưu.' });
  } catch (error) {
    console.error('Error executing stored procedure:', error);
    res.status(500).json({ success: false, message: 'Đã xảy ra lỗi. Vui lòng thử lại.' });
  }
});


// API nhập mã điểm danh
app.post('/nhapMaDiemDanh', async (req, res) => {
  const { maDiemDanh, sinhVienID, buoiHocID } = req.body;

  try {
    const result = await pool.query(
      'SELECT nhapMaDiemDanh($1, $2, $3) AS "xacThuc"',
      [maDiemDanh, sinhVienID, buoiHocID]
    );

    const xacThuc = result.rows[0].xacThuc;

    res.json({ success: true, trangThaiNhap: xacThuc });
  } catch (error) {
    console.error('Error executing stored procedure:', error);
    res.status(500).json({ success: false, message: 'Đã xảy ra lỗi. Vui lòng thử lại.' });
  }
});


// API lưu điểm danh tự động
app.post('/luuDiemDanhTuDong', async (req, res) => {
  const { buoiHocID } = req.body;

  try {
    const result = await pool.query(
      'SELECT luuDiemDanhTuDong($1) AS "xacNhan"',
      [buoiHocID]
    );

    res.json({ xacNhan: result.rows[0].xacNhan });
  } catch (err) {
    console.error('Error executing stored procedure:', err);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});


// API lưu điểm danh thủ công
app.post('/luuDiemDanhThuCong', async (req, res) => {
  const danhSachDiemDanh = req.body;

  try {
    const countResult = await pool.query('SELECT COUNT(*) AS "numLuuDiemDanh" FROM luuDiemDanh');
    let numLuuDiemDanh = parseInt(countResult.rows[0].numLuuDiemDanh);

    for (const item of danhSachDiemDanh) {
      const { buoiHocID, sinhVienID, trangThai, soTiet } = item;

      const exists = await pool.query(
        'SELECT COUNT(*) AS count FROM luuDiemDanh WHERE buoiHocID = $1 AND sinhVienID = $2',
        [buoiHocID, sinhVienID]
      );

      if (parseInt(exists.rows[0].count) > 0) {
        await pool.query(
          'UPDATE luuDiemDanh SET trangThai = $1, soTiet = $2 WHERE buoiHocID = $3 AND sinhVienID = $4',
          [trangThai, soTiet, buoiHocID, sinhVienID]
        );
      } else {
        numLuuDiemDanh++;
        const luuDiemDanhID = 'luu' + numLuuDiemDanh;

        await pool.query(
          'INSERT INTO luuDiemDanh (luuDiemDanhID, buoiHocID, sinhVienID, trangThai, soTiet, ghiChu) VALUES ($1, $2, $3, $4, $5, NULL)',
          [luuDiemDanhID, buoiHocID, sinhVienID, trangThai, soTiet]
        );
      }
    }

    res.json({ success: true });
  } catch (error) {
    console.error('Error processing request:', error);
    res.status(500).json({ success: false, message: 'Internal Server Error' });
  }
});


// Khởi động server
app.listen(port, () => {
  console.log(`Server is running on http://localhost:${port}`);
});
