// Cookies zphprivacy
const { app, BrowserWindow, ipcMain } = require('electron');
const path = require('path');

function createWindow () {
  const win = new BrowserWindow({
    width: 1200,
    height: 800,
    webPreferences: {
      preload: path.join(__dirname, 'preload.js'),
      contextIsolation: true
    }
  });

  win.loadFile('renderer/index.html');
}

app.whenReady().then(createWindow);

app.on('window-all-closed', () => {
  if (process.platform !== 'darwin') app.quit();
});

const { getIncomingTxs } = require('./rpc');
const { sendReceiptEmail } = require('./email');
const { generateReceiptHTML } = require('./receipt');

ipcMain.handle('get-incoming-txs', async () => {
  return await getIncomingTxs();
});

ipcMain.handle('send-receipt-email', async (_, data) => {

  const txid = data.tx.txid;
  
  // Determine asset type and format amount
  let asset = 'ZSD';
  if (data.tx.asset) {
    asset = data.tx.asset.toUpperCase();
  } else if (Math.abs(data.tx.amount) < 1e9) {
    asset = 'ZEPH';
  }
  
  const formattedAmount = `${(data.tx.amount / 1e12).toFixed(6)} ${asset}`;
  
  const html = generateReceiptHTML(txid, formattedAmount, data.note);
  await sendReceiptEmail(data.email, 'Your Zephyr Receipt', html);
});
// Cookies zphprivacy
