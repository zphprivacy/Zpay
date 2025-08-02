// Cookies zphprivacy
const axios = require('axios');

async function getIncomingTxs() {
  console.log('getIncomingTxs called - starting request...');
  
  try {
    console.log('Making axios request to RPC server...');
    const response = await axios.post('http://127.0.0.1:8070/json_rpc', {
      jsonrpc: '2.0',
      id: '0',
      method: 'get_transfers',
      params: {
        in: true,
        pending: false,
        pool: false
      }
    });
    
    console.log('RPC response received:', response.data);
    
    const transfers = response.data.result.in || [];
    console.log('Found transfers:', transfers.length);
    
    const txs = transfers.map(tx => {
      const asset = tx.asset_type || 'ZSD';
      return {
        txid: tx.txid,
        timestamp: tx.timestamp,
        amount: tx.amount,
        asset: asset.toUpperCase()
      };
    });
    
    console.log('Processed transactions:', txs);
    return txs;
    
  } catch (error) {
    console.error('Error fetching transfers:');
    console.error('- Message:', error.message);
    console.error('- Code:', error.code);
    if (error.response) {
      console.error('- Response status:', error.response.status);
      console.error('- Response data:', error.response.data);
    }
    return [];
  }
}

module.exports = { getIncomingTxs };
// Cookies zphprivacy
