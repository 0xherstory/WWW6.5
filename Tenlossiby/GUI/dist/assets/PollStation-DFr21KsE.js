import{_ as h,h as b,o as s,c as i,a as t,w as k,v as w,f as S,b as o,F as P,i as V,t as u,g as F,d as m,r as p}from"./index-EE7T8a7d.js";import{K as x,F as D}from"./FullCodeModal-maEzWUm0.js";const K={class:"day-3-content"},B={class:"content-layout"},I={class:"left-column"},M={class:"interaction-area"},$={class:"interaction-controls"},A={class:"input-group"},L={key:0,class:"candidates-list"},T={class:"candidate-info"},E={class:"candidate-name"},U={class:"vote-count"},X=["onClick"],v=`// SPDX-License-Identifier: MIT

// 声明Solidity版本，要求编译器版本在0.8.0或更高（但低于0.9.0）
pragma solidity ^0.8.0;

// 定义一个名为PollStation的合约，用于投票站功能
contract PollStation{

    // 声明一个公共的字符串数组，用于存储所有候选人的姓名
    // [] 表示这是一个数组类型
    // public 关键字会自动生成getter函数
    string[] public candidateNames;

    // 声明一个映射（mapping），用于存储每个候选人获得的票数
    // 映射结构：mapping(键类型 => 值类型)
    // 这里用候选人的姓名（字符串）作为键，对应的票数（uint256）作为值
    mapping(string => uint256) voteCount;

    // 定义一个函数，用于添加候选人到投票站
    function addCandidateNames(string memory _candidateNames) public{
        // 将候选人姓名添加到数组末尾（push方法）
        candidateNames.push(_candidateNames);

        // 在映射中初始化该候选人的票数为0
        voteCount[_candidateNames] = 0;
    }

    // 定义一个函数，用于获取所有候选人的姓名列表
    function getcandidateNames() public view returns (string[] memory){
        // 返回候选人姓名数组
        return candidateNames;
    }

    // 定义一个函数，用于给指定候选人投票
    function vote(string memory _candidateNames) public{
        // 将指定候选人的票数加1
        // += 是复合赋值运算符，等同于 voteCount[_candidateNames] = voteCount[_candidateNames] + 1
        voteCount[_candidateNames] += 1;
    }

    // 定义一个函数，用于获取指定候选人获得的票数
    function getVote(string memory _candidateNames) public view returns (uint256){
        // 返回指定候选人的票数
        return voteCount[_candidateNames];
    }

}`,j={__name:"PollStation",setup(q){const{candidates:l,voteCount:_,addCandidate:g,voteCandidate:C,unlockedConcepts:f,progressPercentage:y}=b(),d=p(!1),a=p(""),c=()=>{if(!a.value.trim()){alert("请输入候选人姓名");return}g(a.value.trim()),a.value=""},N=r=>{C(r)};return(r,e)=>(s(),i("div",K,[t("div",B,[t("div",I,[t("div",M,[e[4]||(e[4]=t("h3",null,"🎮 交互操作",-1)),t("div",$,[t("div",A,[e[3]||(e[3]=t("label",null,"🗳️ 候选人姓名：",-1)),k(t("input",{"onUpdate:modelValue":e[0]||(e[0]=n=>a.value=n),type:"text",placeholder:"请输入候选人姓名",onKeyup:S(c,["enter"])},null,544),[[w,a.value]])]),t("button",{class:"day-action-btn cyan",onClick:c}," ➕ 添加候选人/AddCandidate ")])]),o(l).length>0?(s(),i("div",L,[e[5]||(e[5]=t("h4",null,"🗳️ 候选人列表/Candidates",-1)),(s(!0),i(P,null,V(o(l),n=>(s(),i("div",{key:n,class:"candidate-item"},[t("div",T,[t("span",E,u(n),1),t("span",U,u(o(_)[n]||0)+" 票",1)]),t("button",{onClick:z=>N(n),class:"day-action-btn green small"}," 🗳️ 投票/Vote ",8,X)]))),128))])):F("",!0)]),m(x,{"current-day":3,"unlocked-concepts":o(f),"progress-percentage":o(y),"full-code":v,onShowFullCode:e[1]||(e[1]=n=>d.value=!0)},null,8,["unlocked-concepts","progress-percentage"])]),m(D,{show:d.value,title:"PollStation 完整代码",code:v,onClose:e[2]||(e[2]=n=>d.value=!1)},null,8,["show"])]))}},J=h(j,[["__scopeId","data-v-c86bc5a8"]]);export{J as default};
