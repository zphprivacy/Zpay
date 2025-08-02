// Cookies zphprivacy
function generateReceiptHTML(txid, amount, note) {

  const safeTxid = txid || 'N/A';
  const safeAmount = amount || 'N/A';
  const safeNote = note || 'No note provided';
  
  return `
    <div style="font-family: Arial, sans-serif; max-width: 600px; margin: 0 auto; padding: 20px; background-color: #f5f5f5;">
      <div style="background-color: white; padding: 30px; border-radius: 10px; box-shadow: 0 2px 10px rgba(0,0,0,0.1);">
        <div style="text-align: center; color: #0074D9; border-bottom: 2px solid #0074D9; padding-bottom: 20px; margin-bottom: 30px;">
          <h1>Ƶpay Receipt</h1>
        </div>
        <div style="margin-bottom: 15px; padding: 10px; background-color: #f8f9fa; border-radius: 5px;">
          <div style="font-weight: bold; color: #333;">Transaction ID:</div>
          <div style="color: #666; word-break: break-all;">${safeTxid}</div>
        </div>
        <div style="margin-bottom: 15px; padding: 10px; background-color: #f8f9fa; border-radius: 5px;">
          <div style="font-weight: bold; color: #333;">Amount:</div>
          <div style="color: #666;">${safeAmount}</div>
        </div>
        <div style="margin-bottom: 15px; padding: 10px; background-color: #f8f9fa; border-radius: 5px;">
          <div style="font-weight: bold; color: #333;">Note:</div>
          <div style="color: #666;">${safeNote}</div>
        </div>
      </div>
    </div>
  `;
}

module.exports = { generateReceiptHTML };
// Cookies zphprivacy
