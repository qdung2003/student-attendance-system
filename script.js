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

document.getElementById('loginForm').addEventListener('submit', function(e) {
    e.preventDefault();
    const email = document.getElementById('email').value;
    const password = document.getElementById('password').value;

    handleLogin(email, password);
});

async function handleLogin(email, password) {
    try {
        const response = await fetch('http://localhost:3000/layIDvaVaiTro', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ email, password })
        });

        const data = await response.json();
        console.log(data);

        if (data.success) {
            localStorage.removeItem('ID');
            localStorage.removeItem('vaiTro');
            localStorage.setItem('ID', data.ID);
            localStorage.setItem('vaiTro', data.vaiTro);
            window.location.href = 'thoi-khoa-bieu/index.html';
        } else {
            // Show error message if login failed
            alert('Login Failed: ' + data.message);
        }
    } catch (error) {
        // Handle network errors or other issues
        console.error('Error during fetch:', error);
        alert('An error occurred. Please try again.');
    }
}
