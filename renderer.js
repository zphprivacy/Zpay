// Cookies zphprivacy
window.electronAPI.getIncomingTxs().then(txs => {
  const list = document.getElementById('txList');
  list.innerHTML = '';

  // New2OLD
  txs.sort((a, b) => b.timestamp - a.timestamp);

  txs.forEach(tx => {
    const date = new Date(tx.timestamp * 1000);

    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');
    const year = date.getFullYear();
    const hours = String(date.getHours()).padStart(2, '0');
    const minutes = String(date.getMinutes()).padStart(2, '0');

    const formattedDate = `${month}-${day}-${year}`;
    const formattedTime = `${hours}:${minutes}`;
    const amount = (tx.amount / 1e12).toFixed(6);

    // Detect asset
    let asset = 'ZSD';
    if (tx.asset) {
      asset = tx.asset.toUpperCase();
    } else if (Math.abs(tx.amount) < 1e9) {
      asset = 'ZEPH';
    }

    const li = document.createElement('li');
    li.innerHTML = `
      <div style="display: flex; justify-content: space-between; font-weight: bold;">
        <span>Date: ${formattedDate} ${formattedTime}</span>
        <span>Amount: ${amount} ${asset}</span>
      </div>
      <div style="text-align: center; margin-top: 5px;">
        <strong>TXID:</strong> ${tx.txid}
      </div>
    `;

    li.addEventListener('click', () => {
      sessionStorage.setItem('selectedTx', JSON.stringify(tx));
      window.location.href = 'receipt.html';
    });

    list.appendChild(li);
  });
});
// Cookies zphprivacy
