// Lấy ID và vaiTro từ localStorage
const id = localStorage.getItem('ID');
const vaiTro = localStorage.getItem('vaiTro');

// Kiểm tra và in ra console
if (id && vaiTro) {
    console.log('ID:', id);
    console.log('Vai trò:', vaiTro);
} else {
    console.log('Không tìm thấy ID hoặc vai trò trong localStorage.');
}

const schedules = {
    1: { start: "07:00", end: "07:50" },
    2: { start: "07:55", end: "08:45" },
    3: { start: "08:50", end: "09:40" },
    4: { start: "09:45", end: "10:35" },
    5: { start: "10:40", end: "11:30" },
    6: { start: "13:00", end: "13:50" },
    7: { start: "13:55", end: "14:45" },
    8: { start: "14:50", end: "15:40" },
    9: { start: "15:45", end: "16:35" },
    10: { start: "16:40", end: "17:30" }
};

// Thêm 26 ô vào <div id="gioHoc">
const gioHoc = document.getElementById("gioHoc");
const times = ["7:00", "8:00", "9:00", "10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00", "17:00", "18:00", "19:00"];

// Thêm thời gian và ô vào <div id="gioHoc">
for (let i = 1; i <= 26; i++) {
    const timeSlot = document.createElement("div");
    timeSlot.className = "gio";
    // Chèn thời gian vào giữa các ô
    if (i % 2 !== 0) {
        const timeLabel = document.createElement("div");
        timeLabel.className = "time-label";
        timeLabel.textContent = times[Math.floor(i / 2)]; // Lấy thời gian tương ứng
        timeSlot.appendChild(timeLabel);
    }
    gioHoc.appendChild(timeSlot);
}

// Thêm 26 ô vào mỗi thẻ <div class="buoi-hoc" id="2"> đến <div class="buoi-hoc" id="8">
for (let day = 2; day <= 8; day++) {
    const buoiHoc = document.getElementById(`thu${day}`);
    for (let i = 1; i <= 26; i++) {
        const lessonSlot = document.createElement("div");
        lessonSlot.className = "buoi";
        lessonSlot.textContent = ""; // Bạn có thể thêm tên môn học hoặc nội dung khác
        buoiHoc.appendChild(lessonSlot);
    }
}

function searchDate() {
    try {
        // Lấy giá trị từ các trường nhập liệu
        const day = parseInt(document.getElementById('day').value, 10);
        const month = parseInt(document.getElementById('month').value, 10);
        const year = parseInt(document.getElementById('year').value, 10);

        // Kiểm tra xem các giá trị có phải là số hợp lệ không
        if (isNaN(day) || isNaN(month) || isNaN(year)) {
            throw new Error("Vui lòng nhập đầy đủ các trường và đảm bảo chúng là số hợp lệ.");
        }

        // Tạo đối tượng ngày tháng năm
        const date = new Date(year, month - 1, day);

        console.log(day);
        console.log(month);
        console.log(year);
        console.log(date);

        // Kiểm tra nếu ngày tháng năm là hợp lệ
        if (
            date.getFullYear() === year &&
            date.getMonth() === month - 1 &&
            date.getDate() === day
        ) {
            // Gọi hàm layThoiKhoaBieu với các tham số
            const formatted = year + '-' + String(month).padStart(2, '0') + '-' + String(day).padStart(2, '0');
            layThoiKhoaBieu(id, vaiTro, formatted);
        } else {
            throw new Error('Ngày, tháng, năm không hợp lệ. Vui lòng nhập lại.');
        }
    } catch (error) {
        alert(error.message);
    }
}

async function layThoiKhoaBieu(ID, vaiTro, date) {
    try {
        const response = await fetch('http://localhost:3000/layThoiKhoaBieu', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ ID, vaiTro, date })
        });

        if (!response.ok) {
            throw new Error('Network response was not ok');
        }

        const data = await response.json();
        localStorage.removeItem('thoiKhoaBieu');
        localStorage.setItem('thoiKhoaBieu', JSON.stringify(data));

        hienThoiKhoaBieu(data);
    } catch (error) {
        console.error('Error fetching schedule:', error);
    }
}

function hienThoiKhoaBieu(data) {
    const tietHeight = 63.45; // px, chiều cao của một tiết học

    // Lặp qua từng phần tử trong mảng data
    for (let i = 0; i < data.length; i++) {
        let item = data[i];
        let thuSai2 = new Date(item.ngay).getDay(); // Lấy thứ trong tuần (0-6)
        let thuSai1 = thuSai2 === 0 ? 7 : thuSai2;  // Chuyển Chủ nhật (0) thành 7
        let thu = thuSai1 + 1; // Chuyển từ 1-7 thành 2-8

        // Tạo nút bấm cho thông tin buổi học
        let thongTinBuoiHocBtn = document.createElement('button');
        thongTinBuoiHocBtn.className = 'schedule-item';
        thongTinBuoiHocBtn.id = item.buoiHocID;

        let top;
        if (item.tietBatDau >= 6) {
            top = 34.61 * 13 + (item.tietBatDau - 6) * tietHeight;  
        } else {
            top = 34.61 + (item.tietBatDau - 1) * tietHeight;
        }

        let height = (item.tietKetThuc - item.tietBatDau + 1) * tietHeight;

        // Thêm CSS trực tiếp bằng JavaScript
        thongTinBuoiHocBtn.style.position = 'absolute';
        thongTinBuoiHocBtn.style.top = `${top}px`;
        thongTinBuoiHocBtn.style.height = `${height}px`;

        // Tạo nội dung cho nút bấm
        thongTinBuoiHocBtn.innerHTML = `
            <div><strong>Môn học:</strong> ${item.tenMonHoc}</div>
            <div>${schedules[item.tietBatDau].start} - ${schedules[item.tietKetThuc].end}</div>
            <div><strong>Tiết:</strong> ${item.tietBatDau} - ${item.tietKetThuc}</div>
        `;

        // Thêm sự kiện onclick cho nút bấm
        thongTinBuoiHocBtn.onclick = function() {
            hienThiBuoiHoc(item.buoiHocID, vaiTro);
        };

        // Thêm nút bấm vào thẻ cha tương ứng
        const ngayHocDiv = document.querySelector(`#thu${thu}`);
        if (ngayHocDiv) {
            ngayHocDiv.style.position = 'relative'; // Đặt cha có position để con có thể absolute
            ngayHocDiv.appendChild(thongTinBuoiHocBtn);
        }
    }
}

function convertDate(dateString) {
    // Tạo đối tượng Date từ chuỗi ngày đầu vào
    const date = new Date(dateString);

    // Lấy các phần ngày, tháng, năm
    const day = String(date.getUTCDate()).padStart(2, '0'); // Đảm bảo ngày có 2 chữ số
    const month = String(date.getUTCMonth() + 1).padStart(2, '0'); // Tháng được tính từ 0, cần +1
    const year = date.getUTCFullYear();

    // Kết hợp lại thành chuỗi định dạng dd-mm-yyyy
    return `${day}-${month}-${year}`;
}

function hideContainer2() {
    document.querySelector('.overlay').style.display = 'none';
    document.querySelector('.container2').style.display = 'none';
}

function hienThiBuoiHoc(buoiHocID, vaiTro) {
    document.querySelector('.overlay').style.display = 'block';
    document.querySelector('.container2').style.display = 'block';
    const thoiKhoaBieuFromLocal = JSON.parse(localStorage.getItem('thoiKhoaBieu'));
    console.log(thoiKhoaBieuFromLocal);

    // Tìm đối tượng có buoiHocID bằng buoiHocID truyền vào
    const buoiHoc = thoiKhoaBieuFromLocal.find(item => item.buoiHocID === buoiHocID);
    
    if (buoiHoc) {
        console.log("Buổi học tìm thấy:", buoiHoc);
        document.querySelector('.hang-1-1').innerHTML =`Học phần: ${buoiHoc.tenMonHoc}`;
        document.querySelector('.hang-1-2').innerHTML =
        `- ${schedules[buoiHoc.tietBatDau].start} - ${schedules[buoiHoc.tietKetThuc].start} (Tiết: ${buoiHoc.tietBatDau} - ${buoiHoc.tietKetThuc}) - (Phòng học: ${buoiHoc.maCoSo}-${buoiHoc.tenPhongHoc}) `;
        document.querySelector('.hang-1-3').innerHTML =`Ngày: ${convertDate(buoiHoc.ngay)} Lớp: ${buoiHoc.tenLop}`;
    } else {
        console.log("Không tìm thấy buổi học với ID:", buoiHocID);
    }

    if (vaiTro == 'sinh vien') {
        document.querySelector('.sinh-vien').style.display = 'block';
        document.querySelector('.giao-vien').style.display = 'none';

        var inputKeyWordSV = document.getElementById("keyword-sv");
        var buttonKeyWordSV = document.getElementById("save-keyword-sv");

        // Thêm sự kiện onclick cho nút bấm
        buttonKeyWordSV.onclick = async function() {
            var maDiemDanhSV = inputKeyWordSV.value;
            var trangThaiNhap = await nhapMaDiemDanh(maDiemDanhSV, id, buoiHocID);

            // Kiểm tra trạng thái và hiện cảnh báo phù hợp
            if (trangThaiNhap === 'yes') {
                alert('Đã lưu mã điểm danh');
            } else if (trangThaiNhap === 'no') {
                alert('Nhập mã điểm danh không đúng');
            } else {
                alert('Có lỗi xảy ra, vui lòng thử lại.');
            }
        };
    }

    else if (vaiTro == 'giao vien') {
        document.querySelector('.sinh-vien').style.display = 'none';
        document.querySelector('.giao-vien').style.display = 'block';

        var inputKeyWordGV = document.getElementById("keyword-gv");
        var buttonKeyWordGV = document.getElementById("save-keyword-gv");
        var luuTuDong = document.querySelector('button.hang-2-5-gv');

        var luuThuCong = document.querySelector('button.hang-3-6-gv');
        // Thêm sự kiện onclick cho nút bấm
        buttonKeyWordGV.onclick = function() {
            var maDiemDanhGV = inputKeyWordGV.value;
            taoMaDiemDanh(maDiemDanhGV, buoiHocID);
        };

        luuTuDong.onclick = function() {
            luuDiemDanhTuDong(buoiHocID);
        }

        let soTiet = buoiHoc.tietKetThuc - buoiHoc.tietBatDau + 1;
        localStorage.removeItem('soTiet');
        localStorage.setItem('soTiet', soTiet);
        luuThuCong.onclick = function() {
            luuDiemDanhThuCong(buoiHocID, soTiet);
        }
    }

    else {
        console.log('Vai trò không hợp lệ.');
    }

    layDanhSachLop(buoiHocID, vaiTro);
}



async function layDanhSachLop(buoiHocID, vaiTro) {
    try {
        const response = await fetch('http://localhost:3000/layDanhSachLop', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ buoiHocID })
        });

        if (!response.ok) {
            throw new Error('Network response was not ok');
        }

        const danhSachLop = await response.json(); // Lấy dữ liệu từ response JSON
        console.log('Danh sách lớp:', danhSachLop);

       

        hienThiDanhSachLop(danhSachLop, vaiTro); // Gọi hàm để hiển thị danh sách lớp

        const siSo = document.querySelector('.hang-3-2-gv');
        const coMat = document.querySelector('.hang-3-3-gv');
        const vangMat = document.querySelector('.hang-3-4-gv');
        const coPhep = document.querySelector('.hang-3-5-gv');
        siSo.innerHTML = `Sĩ số: ${danhSachLop.length}`;
        coMat.innerHTML = `Có mặt: ${convertNumber0( danhSachLop.filter(sv => sv.trangThai === 'Có mặt').length)}`;
        vangMat.innerHTML = `Vắng mặt: ${convertNumber0(danhSachLop.filter(sv => sv.trangThai === 'Vắng mặt').length)}`;
        coPhep.innerHTML = `Vắng mặt có phép: ${convertNumber0(danhSachLop.filter(sv => sv.trangThai === 'Vắng mặt có phép').length)}`;
    } catch (error) {
        console.error('Error fetching class list:', error);
    }
}

function convertNumber0(number) {
    if (number == 0) {
        return '';
    }

    else {
        return number;
    }
}

// Hàm hiển thị danh sách lớp
function hienThiDanhSachLop(danhSachLop, vaiTro) {
    if (vaiTro == 'sinh vien') {
        const danhSachLopSinhVien = document.getElementById("student-list-sv");  
        danhSachLopSinhVien.innerHTML = ''; // Xóa nội dung cũ nếu có

        let i = 1;
        // Duyệt qua từng sinh viên trong danh sách và thêm vào giao diện
        danhSachLop.forEach(sinhVien => {
            const sinhVienElement = document.createElement('tr');
            sinhVienElement.className = 'sinh-vien-item';
            sinhVienElement.innerHTML = `
                <td>${i}</td>
                <td>${sinhVien.sinhVienID}</td>
                <td>${sinhVien.hoDem}</td>
                <td>${sinhVien.ten}</td>
            `;
            danhSachLopSinhVien.appendChild(sinhVienElement);
            i++;
        });
    } else if (vaiTro == 'giao vien') {
        const danhSachLopGiaoVien = document.getElementById("student-list-gv");  
        danhSachLopGiaoVien.innerHTML = ''; // Xóa nội dung cũ nếu có

        let i = 1;
        // Duyệt qua từng sinh viên trong danh sách và thêm vào giao diện
        danhSachLop.forEach(sinhVien => {
            const sinhVienElement = document.createElement('tr');
            sinhVienElement.className = 'sinh-vien-item-2';
            sinhVienElement.innerHTML = `
                <td>${i}</td>
                <td>${sinhVien.tongTietVang}</td>
                <td>${sinhVien.sinhVienID}  </td>
                <td>${sinhVien.hoDem}       </td>
                <td>${sinhVien.ten}         </td>
                <td>${sinhVien.tuDiemDanh}  </td>
                ${laydiemDanh(sinhVien.trangThai, sinhVien.soTiet, sinhVien.sinhVienID)} 
            `;
            danhSachLopGiaoVien.appendChild(sinhVienElement);
            i++;
        });
    } else {
        console.log('Vai trò không hợp lệ.');
    }
}
function laydiemDanh(trangThai, soTiet, sinhVienID) {
    let soTietDaLuu = localStorage.getItem('soTiet');
    let inputs = [
        `<input type="checkbox" class="${sinhVienID}" onchange="clearOthers(this, '${sinhVienID}')"><input type="number" class="${sinhVienID}" min="0" max="${soTietDaLuu}" step="1" oninput="clearOthers(this, '${sinhVienID}')">`,
        `<input type="checkbox" class="${sinhVienID}" onchange="clearOthers(this, '${sinhVienID}')"><input type="number" class="${sinhVienID}" min="0" max="${soTietDaLuu}" step="1" oninput="clearOthers(this, '${sinhVienID}')">`,
        `<input type="checkbox" class="${sinhVienID}" onchange="clearOthers(this, '${sinhVienID}')"><input type="number" class="${sinhVienID}" min="0" max="${soTietDaLuu}" step="1" oninput="clearOthers(this, '${sinhVienID}')">`
    ];

    if (trangThai != null && soTiet != null) {
        let index;
        if (trangThai == 'Vắng mặt') index = 0;
        else if (trangThai == 'Vắng mặt có phép') index = 1;
        else if (trangThai == 'Có mặt') index = 2;

        if (index !== undefined) {
            inputs[index] = `<input type="checkbox" class="${sinhVienID}" onchange="clearOthers(this, '${sinhVienID}')"><input type="number" class="${sinhVienID}" min="0" max="5" step="1" value="${soTiet}" oninput="clearOthers(this, '${sinhVienID}')">`;
        } else {
            console.log("Trạng thái không hợp lệ");
        }
    } else if (trangThai != null || soTiet != null) {
        console.log("Trạng thái không hợp lệ");
    }

    return `
        <td>${inputs[0]}</td>
        <td>${inputs[1]}</td>
        <td>${inputs[2]}</td>
    `;
}

function clearOthers(current, sinhVienID) {
    // Tìm tất cả các input có cùng class sinhVienID
    const allInputs = document.querySelectorAll(`input.${sinhVienID}`);
    
    // Duyệt qua tất cả các input và xóa giá trị nếu không phải là phần tử hiện tại
    allInputs.forEach(input => {
        if (input !== current) {
            if (input.type === "checkbox") {
                input.checked = false; // Xóa tích
            } else if (input.type === "number") {
                input.value = ''; // Xóa giá trị
            }
        }
    });
}



async function taoMaDiemDanh(maDiemDanh, buoiHocID) {
    try {
        const response = await fetch('http://localhost:3000/taoMaDiemDanh', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ maDiemDanh, buoiHocID })
        });

        const result = await response.json();
        if (result.success) {
            alert(result.message);
        } else {
            alert(result.message);
        }
    } catch (error) {
        console.error('Error:', error);
        alert('Có lỗi xảy ra khi lưu từ khóa điểm danh.');
    }
}

async function nhapMaDiemDanh(maDiemDanh, sinhVienID, buoiHocID) {
    try {
        const response = await fetch('http://localhost:3000/nhapMaDiemDanh', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ maDiemDanh, sinhVienID, buoiHocID })
        });

        const result = await response.json();

        if (result.success) {
            return result.trangThaiNhap; // Trả về trạng thái nhập
        } else {
            console.error('Lỗi từ server:', result.message);
            return null; // Hoặc trả về một giá trị mặc định khi lỗi
        }
    } catch (error) {
        console.error('Error:', error);
        return null; // Hoặc trả về một giá trị mặc định khi xảy ra lỗi
    }
}

async function luuDiemDanhTuDong(buoiHocID) {
    try {
        const response = await fetch('http://localhost:3000/luuDiemDanhTuDong', {
            method: 'POST',
            headers: {
            'Content-Type': 'application/json',
            },
            body: JSON.stringify({ buoiHocID }),
        });
  
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
  
        const data = await response.json();
        
        // Xử lý kết quả từ API
        if (data.xacNhan === 'yes') {
            alert('Lưu điểm danh thành công!');
        } else {
            alert('Không có dữ liệu để lưu điểm danh.');
        }
    } catch (error) {
        console.error('Error:', error);
        alert('Có lỗi xảy ra khi gọi API.');
    }
}

function luuDiemDanhThuCong(buoiHocID, soTiet) {
    const danhSachLopGiaoVien = document.getElementById("student-list-gv");
    const danhSachDiemDanh = [];

    danhSachLopGiaoVien.querySelectorAll('.sinh-vien-item-2').forEach(row => {
        const sinhVienID = row.querySelector('td:nth-child(3)').textContent.trim();
        const checkboxes = row.querySelectorAll('input[type="checkbox"]');
        const soTietInputs = row.querySelectorAll('input[type="number"]');

        let trangThai = null;
        let soTietValue = null;

        // Kiểm tra tất cả các checkbox để xác định trạng thái
        for (let i = 0; i < checkboxes.length; i++) {
            const checkbox = checkboxes[i];
            if (checkbox.checked) {
                switch (i) {
                    case 0:
                        trangThai = 'Vắng mặt';
                        soTietValue = soTiet; // Sử dụng soTiet từ hàm
                        break;
                    case 1:
                        trangThai = 'Vắng mặt có phép';
                        soTietValue = soTiet; // Sử dụng soTiet từ hàm
                        break;
                    case 2:
                        trangThai = 'Có mặt';
                        soTietValue = soTiet; // Sử dụng soTiet từ hàm
                        break;
                    default:
                        // Nếu có nhiều hơn 3 checkbox, chúng ta có thể xử lý theo yêu cầu khác nếu cần
                        break;
                }
                break; // Dừng vòng lặp khi tìm thấy checkbox được chọn
            }
        }

        // Nếu không có checkbox nào được chọn, kiểm tra các ô nhập số để xác định trạng thái và số tiết
        if (!trangThai) {
            for (let i = 0; i < soTietInputs.length; i++) {
                const input = soTietInputs[i];
                if (input.value) {
                    switch (i) {
                        case 0:
                            trangThai = 'Vắng mặt';
                            soTietValue = input.value;
                            break;
                        case 1:
                            trangThai = 'Vắng mặt có phép';
                            soTietValue = input.value;
                            break;
                        case 2:
                            trangThai = 'Có mặt';
                            soTietValue = input.value;
                            break;
                        default:
                            // Nếu có nhiều hơn 3 input số, chúng ta có thể xử lý theo yêu cầu khác nếu cần
                            break;
                    }
                    break; // Dừng vòng lặp khi tìm thấy input số có giá trị
                }
            }
        }

        // Nếu không có trạng thái và số tiết, mặc định trạng thái là 'Vắng mặt' và số tiết từ hàm
        if (!trangThai) {
            trangThai = 'Vắng mặt';
            soTietValue = soTiet;
        }

        // Nếu có trạng thái và số tiết hợp lệ, thêm vào danh sách điểm danh
        if (trangThai && soTietValue != null) {
            danhSachDiemDanh.push({
                buoiHocID: buoiHocID,
                sinhVienID: sinhVienID,
                trangThai: trangThai,
                soTiet: soTietValue
            });
        }
    });

    // Log danh sách điểm danh
    console.log('Danh sách điểm danh:', danhSachDiemDanh);

    guiDanhSachDiemDanh(danhSachDiemDanh);
}

async function guiDanhSachDiemDanh(danhSachDiemDanh) {
    try {
        const response = await fetch('http://localhost:3000/luuDiemDanhThuCong', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify(danhSachDiemDanh),
        });
  
        if (!response.ok) {
            throw new Error('Network response was not ok');
        }
  
        const data = await response.json();
        
        // Xử lý kết quả từ API
        if (data.success) {
            alert('Danh sách điểm danh đã được lưu thành công!');
        } else {
            alert('Không có dữ liệu để lưu điểm danh.');
        }
    } catch (error) {
        console.error('Error:', error);
        alert('Có lỗi xảy ra khi gọi API.');
    }
}

