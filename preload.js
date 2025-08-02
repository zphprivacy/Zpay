// Cookies zphprivacy
const { contextBridge, ipcRenderer } = require('electron');

contextBridge.exposeInMainWorld('electronAPI', {
  getIncomingTxs: () => ipcRenderer.invoke('get-incoming-txs'),
  sendReceiptEmail: (data) => ipcRenderer.invoke('send-receipt-email', data)
});
// Cookies zphprivacy
