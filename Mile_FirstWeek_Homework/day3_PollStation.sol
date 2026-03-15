//SPDX-License-Identifier:MIT
pragma solidity ^0.8.0;

contract SimpleStorage{
    //存储一个数字
    uint256 private _data;

    //存储写入：任何人都可以存入数字
    function setData(uint256 data_)public{
        _data=data_;
    }

    //存储读取：任何人都可以查看
    function getData()public view returns(uint256){
        return _data;
    }

    //作业1:增加存储的数字
    function increment()public{
        _data=_data+1;
    }

    //作业2：减少存储的数字(安全防负数)
    function decrement()public{
        if(_data>0){
            _data=_data-1;
        }
    }

    //作业3:清空存储的数字
    function clear()public{
        _data=0;
    }

}