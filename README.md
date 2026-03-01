# Student Attendance System

Hệ thống điểm danh sinh viên với giao diện web, hỗ trợ 2 vai trò: sinh viên và giáo viên.

## Tính năng

- Đăng nhập theo vai trò (sinh viên / giáo viên)
- Xem thời khóa biểu theo tuần
- **Sinh viên:** Nhập mã điểm danh để tự điểm danh
- **Giáo viên:** Tạo mã điểm danh, lưu điểm danh tự động hoặc thủ công
- Xem danh sách lớp và thống kê có mặt / vắng mặt

## Tech Stack

- **Frontend:** HTML, CSS, JavaScript
- **Backend:** Node.js, Express.js
- **Database:** PostgreSQL

## Cài đặt

### Yêu cầu

- [Node.js](https://nodejs.org/)
- [PostgreSQL](https://www.postgresql.org/download/)

### 1. Clone repo

```bash
git clone https://github.com/qdung2003/student-attendance-system.git
cd student-attendance-system
```

### 2. Cài dependencies

```bash
npm install
```

### 3. Tạo database

```bash
psql -U postgres -c "CREATE DATABASE diemdanhhocsinhlite ENCODING 'UTF8' TEMPLATE template0"
```

### 4. Chạy migration

```bash
psql -U postgres -d diemdanhhocsinhlite -f db/01_schema.sql
psql -U postgres -d diemdanhhocsinhlite -f db/02_functions.sql
psql -U postgres -d diemdanhhocsinhlite -f db/03_seed_data.sql
psql -U postgres -d diemdanhhocsinhlite -f db/04_seed_buoihoc.sql
```

### 5. Cấu hình kết nối

Mở `server.js` và chỉnh thông tin kết nối PostgreSQL:

```js
const pool = new Pool({
  user: 'postgres',
  password: 'your_password',
  host: 'localhost',
  port: 5432,
  database: 'diemdanhhocsinhlite',
});
```

### 6. Chạy server

```bash
node server.js
```

Server chạy tại `http://localhost:3000`.

### 7. Mở giao diện

Mở file `index.html` bằng Live Server (VSCode) hoặc trình duyệt.

## Cấu trúc project

```
├── db/
│   ├── 01_schema.sql        # Tạo bảng và foreign keys
│   ├── 02_functions.sql     # Functions và procedures
│   ├── 03_seed_data.sql     # Dữ liệu mẫu (sinh viên, giáo viên, ...)
│   └── 04_seed_buoihoc.sql  # Dữ liệu buổi học
├── thoi-khoa-bieu/
│   ├── index.html
│   ├── script.js
│   └── style.css
├── index.html               # Trang đăng nhập
├── script.js
├── style.css
├── server.js                # Express server
└── package.json
```
