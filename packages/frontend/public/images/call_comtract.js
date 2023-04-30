const contractAddress = "0x123456..."; // 合约地址
const abi = [ /* 合约ABI */ ]; // 合约ABI

// 实例化合约
const contract = new web3.eth.Contract(abi, contractAddress);

// 调用合约函数
const newValue = 42;
contract.methods.setVar(newValue).send({ from: myAccount })
    .on('receipt', function(receipt) {
        console.log("Transaction receipt:", receipt);
    })
    .on('error', function(error, receipt) {
        console.error("Error:", error, "\nReceipt:", receipt);
    });