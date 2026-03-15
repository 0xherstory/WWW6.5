import{_ as L,e as R,o as i,c as d,a as e,w as h,v as w,f as g,b as o,t as a,g as F,d as N,r}from"./index-EE7T8a7d.js";import{K as I,F as P}from"./FullCodeModal-maEzWUm0.js";const U={class:"day-2-content"},T={class:"content-layout"},$={class:"left-column"},E={class:"interaction-area"},X={class:"input-group"},j={class:"input-group"},q={class:"button-group"},z=["disabled"],A={class:"search-section"},G={class:"input-group"},H=["disabled"],J={key:0,class:"search-result-display"},O={key:0,class:"result-success"},Q={class:"result-item"},W={class:"value"},Y={class:"result-item"},Z={class:"value"},ee={class:"match-info"},se={key:1,class:"result-not-found"},te={key:0,class:"result-display"},oe={class:"result-item"},le={class:"value"},ae={class:"result-item"},ne={class:"value"},D=`// SPDX-License-Identifier:MIT

// 声明Solidity版本，要求编译器版本在0.8.0或更高（但低于0.9.0）
pragma solidity ^0.8.0;

// 定义一个名为SaveMyName的合约，用于存储和检索姓名与简介
contract SaveMyName{

  // 声明一个字符串类型的私有状态变量name（默认私有）
  string name;

  // 声明一个字符串类型的私有状态变量bio（默认私有）
  string bio;

  // 定义一个名为add的公共函数，用于设置姓名和简介
  // memory关键字表示参数数据存储在内存中（临时存储）
  // _name 和 _bio 是函数参数（参数名通常用下划线前缀表示）
  function add (string memory _name, string memory _bio )public {
    // 将传入的_name值赋给状态变量name
    name = _name;

    // 将传入的_bio值赋给状态变量bio
    bio = _bio;
  }

  // 定义一个名为retrieve的公共函数，用于获取姓名和简介
  // view关键字表示该函数只读取状态变量，不修改任何状态（不消耗gas）
  // returns声明返回值类型为两个字符串
  function retrieve() public view returns(string memory, string memory){
    // 返回name和bio的值（以元组形式返回多个值）
    return (name,bio);
  }

}`,ie={__name:"SaveMyName",setup(de){const{name:m,bio:p,hasStored:k,hasRetrieved:M,storeData:V,retrieveData:S,unlockedConcepts:x,progressPercentage:K}=R(),y=r(!1),u=r(""),_=r(""),n=r(""),l=r({show:!1,found:!1,keyword:"",matchField:""}),f=()=>{if(!u.value.trim()){alert("请输入姓名");return}V(u.value,_.value),l.value={show:!1,found:!1,keyword:"",matchField:""}},B=()=>{S(),l.value={show:!1,found:!1,keyword:"",matchField:""}},C=()=>{if(!n.value.trim()){alert("请输入搜索关键词");return}const b=n.value.toLowerCase(),s=m.value.toLowerCase(),t=p.value.toLowerCase();let c=!1,v="";s.includes(b)&&(c=!0,v="姓名"),t.includes(b)&&(c=!0,v=v?"姓名和简介":"简介"),l.value={show:!0,found:c,keyword:n.value,matchField:v},c&&S()};return(b,s)=>(i(),d("div",U,[e("div",T,[e("div",$,[e("div",E,[s[14]||(s[14]=e("h3",null,"🎮 交互操作",-1)),e("div",X,[s[5]||(s[5]=e("label",null,"📝 姓名：",-1)),h(e("input",{"onUpdate:modelValue":s[0]||(s[0]=t=>u.value=t),type:"text",placeholder:"输入你的名字",onKeyup:g(f,["enter"])},null,544),[[w,u.value]])]),e("div",j,[s[6]||(s[6]=e("label",null,"📄 简介：",-1)),h(e("textarea",{"onUpdate:modelValue":s[1]||(s[1]=t=>_.value=t),placeholder:"介绍一下你自己",rows:"3",onKeyup:g(f,["enter"])},null,544),[[w,_.value]])]),e("div",q,[e("button",{class:"day-action-btn green",onClick:f}," 💾 保存数据/Store Data "),e("button",{class:"day-action-btn blue",onClick:B,disabled:!o(k)}," 📤 检索数据/Retrieve Data ",8,z)]),e("div",A,[s[10]||(s[10]=e("h4",null,"🔍 搜索数据",-1)),e("div",G,[h(e("input",{"onUpdate:modelValue":s[2]||(s[2]=t=>n.value=t),type:"text",placeholder:"输入姓名或简介关键词",onKeyup:g(C,["enter"])},null,544),[[w,n.value]])]),e("button",{class:"day-action-btn cyan",onClick:C,disabled:!o(k)}," 🔍 搜索/Search ",8,H),l.value.show?(i(),d("div",J,[s[9]||(s[9]=e("h4",null,"🔍 搜索结果：",-1)),l.value.found?(i(),d("div",O,[e("div",Q,[s[7]||(s[7]=e("span",{class:"label"},"姓名：",-1)),e("span",W,a(o(m)),1)]),e("div",Y,[s[8]||(s[8]=e("span",{class:"label"},"简介：",-1)),e("span",Z,a(o(p)),1)]),e("div",ee,"✅ 在"+a(l.value.matchField)+"中找到匹配！",1)])):(i(),d("div",se,' ❌ 未找到包含"'+a(l.value.keyword)+'"的数据 ',1))])):F("",!0)]),o(M)&&!l.value.show?(i(),d("div",te,[s[13]||(s[13]=e("h4",null,"📋 全部数据：",-1)),e("div",oe,[s[11]||(s[11]=e("span",{class:"label"},"姓名：",-1)),e("span",le,a(o(m)),1)]),e("div",ae,[s[12]||(s[12]=e("span",{class:"label"},"简介：",-1)),e("span",ne,a(o(p)),1)])])):F("",!0)])]),N(I,{"current-day":2,"unlocked-concepts":o(x),"progress-percentage":o(K),"full-code":D,onShowFullCode:s[3]||(s[3]=t=>y.value=!0)},null,8,["unlocked-concepts","progress-percentage"])]),N(P,{show:y.value,title:"SaveMyName 完整代码",code:D,onClose:s[4]||(s[4]=t=>y.value=!1)},null,8,["show"])]))}},ce=L(ie,[["__scopeId","data-v-5171dd33"]]);export{ce as default};
