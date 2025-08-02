// Cookies zphprivacy
const path = require('path');
const os = require('os');

const homeAppDir = path.join(os.homedir(), 'Ƶpay');
const envPath = path.join(homeAppDir, '.env');


const fs = require('fs');
if (fs.existsSync(envPath)) {
    console.log('Loading .env from home folder:', envPath);
    require('dotenv').config({ path: envPath });
} else {
    console.log('.env not found in home folder, trying app directory');

    require('dotenv').config({ path: path.join(__dirname, '.env') });
}

const nodemailer = require('nodemailer');

const transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
    user: process.env.MAIL_USER,
    pass: process.env.MAIL_PASS
  }
});

async function sendReceiptEmail(to, subject, html) {
  await transporter.sendMail({
    from: `"Ƶpay Receipt" <${process.env.MAIL_USER}>`,
    to,
    subject,
    html
  });
}

module.exports = { sendReceiptEmail };
// Cookies zphprivacy
