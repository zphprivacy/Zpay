Donation Address ZEPHYR2xnxWTxh31HcSHeMKEF8gnQ8vvQZAZsLQDshLwTaeXbfBwR29FzpU3NSuLNDTpaJFFioNwpK7euFdYjUpoaaxquNngwec54

<img width="1029" height="579" alt="image" src="https://github.com/user-attachments/assets/eaa00706-de37-479a-bca9-c6da90893534" />
<img width="1029" height="579" alt="image" src="https://github.com/user-attachments/assets/c88d8c1b-3650-4c80-a585-57c71513375c" />
<img width="1029" height="579" alt="image" src="https://github.com/user-attachments/assets/fe915be5-9353-4507-95cd-8a4ca67e3c7b" />





# 🪙 Zpay Setup Guide

> **Privacy-focused cryptocurrency Receipt System using Zephyr Protocol**

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Status](https://img.shields.io/badge/status-active-brightgreen.svg)]()
[![Platform](https://img.shields.io/badge/platform-linux-lightgrey.svg)]()

---

## 📋 Table of Contents

- [Prerequisites](#-prerequisites)
- [Google Account Setup](#-google-account-setup)
- [Zpay Installation](#-zpay-installation)
- [Zephyr Protocol Setup](#-zephyr-protocol-setup)
- [First Launch](#-first-launch)
- [Troubleshooting](#-troubleshooting)

---

## 🔧 Prerequisites  

Before starting, ensure you have:

- ✅ **Google Account** with admin access
- ✅ **2-Step Verification** enabled  
- ✅ **Linux environment** (Ubuntu/Debian recommended)
- ✅ **Terminal access** 

---

## 🔐 Google Account Setup

### Enable 2-Step Verification

1. Navigate to [Google Account Security](https://myaccount.google.com/security)
2. Enable **2-Step Verification**  
3. Choose your method:
   - 🔑 **Passkey** (recommended)
   - 📱 **Google Prompt**
   - 🛡️ **Authenticator App**
   - 📞 **Phone Number**

### Generate App Password

1. Go to [Google App Passwords](https://myaccount.google.com/apppasswords)
2. Create new app password
3. Name it: `zephyr receipt`

> ⚠️ **Important:** Save this password securely - you'll need it for configuration!

---

## 💻 Zpay Installation

### Download & Extract

```bash
# Navigate to your preferred directory
cd ~/Downloads

# Download from GitHub releases
wget https://github.com/zphprivacy/Zpay/releases/download/v1.0/Zpay_v1.0_amd64.zip

# Extract the archive
unzip Zpay_v1.0_amd64.zip
cd Zpay_v1.0_amd64/
```

### Configure Environment

1. **Locate the `.env` file** (enable hidden files if needed)
2. **Edit configuration:**

```env
MAIL_USER="your-email@gmail.com"
MAIL_PASS="your-16-digit-app-password"
```

> ⚠️ **Critical:** No spaces around the `=` sign!

### Install Application

```bash
# Set execute permissions
chmod +x zpay_install_remove.sh

# Run installer
./zpay_install_remove.sh
```

**In the installer menu:**
- Press `1` to install
- Follow the on-screen prompts
- ✅ Creates desktop icon and start menu entry

---

## ⚡ Zephyr Protocol Setup

### Download Zephyr CLI

```bash
# Download latest release
wget https://github.com/ZephyrProtocol/zephyr/releases/download/v2.3.0/zephyr-cli-linux-v2.3.0.zip

# Extract
unzip zephyr-cli-linux-v2.3.0.zip
cd zephyr-cli-linux-v2.3.0/
```

### Initialize Daemon

```bash
# Start the Zephyr daemon
./zephyrd
```

> 💡 **Tip:** Keep this terminal open - the daemon needs to stay running!

### Create Wallet

**Open a new terminal** in the same directory:

```bash
# Launch wallet creation
./zephyr-wallet-cli
```

Follow the interactive setup:
- Choose wallet name
- Set secure password  
- Save your mnemonic seed phrase safely
- Close terminal when setup completes

### Start RPC Service

**Wait for daemon synchronization** (may take 30+ minutes), then:

```bash
./zephyr-wallet-rpc \
  --wallet-file YOUR_WALLET_NAME \
  --password 'YOUR_PASSWORD' \
  --rpc-bind-port 8070 \
  --daemon-address 127.0.0.1:17767 \
  --disable-rpc-login
```

Replace `YOUR_WALLET_NAME` and `YOUR_PASSWORD` with your actual credentials.

---

## 🚀 First Launch

1. **Launch Zpay** from desktop or applications menu
2. **Initial state:** Interface appears blank (this is normal!)
3. **Activate interface:** Send small amount to your wallet address
4. **Full UI loads** once transaction is detected

---

## 🔧 Troubleshooting

| Issue | Solution |
|-------|----------|
| **App shows blank screen** | Send test transaction to wallet address |
| **Connection errors** | Ensure Zephyr daemon is fully synced |
| **Permission denied** | Run `chmod +x` on all `.sh` files |
| **Email not sending** | Verify app password has no spaces |
| **RPC connection failed** | Check daemon is running on port 17767 |

### Common Commands

```bash
# Check if daemon is running
ps aux | grep zephyrd

# Restart daemon
pkill zephyrd
./zephyrd

# Check wallet sync status
./zephyr-wallet-cli --wallet-file YOUR_WALLET refresh
```

---

## 📞 Support

- 🐛 **Issues:** [GitHub Issues](https://github.com/zphprivacy/Zpay/issues)
- 💬 **Discussions:** [GitHub Discussions](https://github.com/zphprivacy/Zpay/discussions)
- 📧 **Email:** Contact through repository

---

## 📄 License

This project is licensed under the GNU GENERAL PUBLIC LICENSE  Version 3,- see the [LICENSE](LICENSE) file for details.

---

<div align="center">

**Made with ❤️ by zphprivacy**

⭐ Star this repo if it helped you!

</div>
