(async () => {
  const messageHash = "0x719d53ce790b3789dfe60669b14ff18cf8fcd976378367bb1c41ef2c6eb735c3";
  const accounts = await web3.eth.getAccounts();
  const organizer = accounts[0]; // first account in Remix
  const signature = await web3.eth.sign(messageHash, organizer);
  console.log("Signature:", signature);
})();