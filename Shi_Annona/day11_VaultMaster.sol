//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;
import "./day11_Ownable.sol";
//this is OpenZeppelin's contract library, I can import it like this:
//import "@openzeppelin/contracts/access/Ownable.sol";

contract VaultMaster is Ownable{
    event depositSuccess (address account, uint256 amount);
    event withdrawSuccess (address recipient, uint256 amount);

    function getBalacne() public view returns(uint256){
        return address(this).balance;
    }

    //beacuse this function has the key word "payable",users once click this function, this contract can get the ETH
    //I don't need a code line to let the contract recieve ETH
    function deposit() public payable{
        require(msg.value > 0,"invalide amount");
        emit depositSuccess(msg.sender, msg.value);
    }

    //
    function withdraw(address _to,uint256 _amount) public onlyOwner{
        require(_amount > 0,"invalide amount");
        require(_amount <= address(this).balance,"Insufficient balance");
        (bool success, ) = payable(_to).call{value:_amount}("");
        require(success,"withdraw failed");
        emit withdrawSuccess(_to, _amount);
    }
}