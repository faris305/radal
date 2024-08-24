const fs = require('fs');
const readline = require('readline');

// Kode yang diperlukan untuk membuka app.js
const requiredCode = '305202';

// Membuat interface untuk membaca input dari command line
const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

// Meminta kode dari pengguna
rl.question('Masukkan kode untuk membuka app.js: ', (inputCode) => {
    if (inputCode === requiredCode) {
        console.log('Kode benar! Membuka app.js...\n');
        // Membaca dan menampilkan isi dari app.js
        fs.readFile('app.js', 'utf8', (err, data) => {
            if (err) {
                console.error('Gagal membuka app.js:', err);
            } else {
                console.log(data);
            }
            rl.close();
        });
    } else {
        console.log('Kode salah! Tidak bisa membuka app.js.');
        rl.close();
    }
});
