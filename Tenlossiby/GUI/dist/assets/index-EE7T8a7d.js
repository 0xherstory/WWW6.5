const __vite__mapDeps=(i,m=__vite__mapDeps,d=(m.f||(m.f=["./ClickCounter-ByHVgGIb.js","./FullCodeModal-maEzWUm0.js","./FullCodeModal-B7BAeoX3.css","./ClickCounter-c1-KyAmG.css","./SaveMyName-DKg1l27q.js","./SaveMyName-DIvcArAd.css","./PollStation-DFr21KsE.js","./PollStation-B8PduqE_.css","./AuctionHouse-CU1ybdQf.js","./AuctionHouse-D-r8cdkD.css","./AdminOnly-DcDj9NxX.js","./AdminOnly-D5Uu9v6N.css","./EtherPiggyBank-BTcVEW4I.js","./EtherPiggyBank-lQPSCv6L.css","./SimpleIOUApp-CeUzZQlc.js","./SimpleIOUApp-vmsF7ri8.css","./TipJar-ChoGMgzV.js","./TipJar-B6wlQUUl.css","./SmartCalculator-BeVTgbqz.js","./SmartCalculator-5qVR7J2T.css","./ActivityTracker-C2XAcw2b.js","./ActivityTracker-CdvB4Xdt.css","./MasterkeyContract-BzusUv6C.js","./MasterkeyContract-CGqpzN6H.css","./ERC20Token-Clww1RmP.js","./ERC20Token-rH_IFlLO.css"])))=>i.map(i=>d[i]);
(function(){const t=document.createElement("link").relList;if(t&&t.supports&&t.supports("modulepreload"))return;for(const r of document.querySelectorAll('link[rel="modulepreload"]'))n(r);new MutationObserver(r=>{for(const o of r)if(o.type==="childList")for(const i of o.addedNodes)i.tagName==="LINK"&&i.rel==="modulepreload"&&n(i)}).observe(document,{childList:!0,subtree:!0});function s(r){const o={};return r.integrity&&(o.integrity=r.integrity),r.referrerPolicy&&(o.referrerPolicy=r.referrerPolicy),r.crossOrigin==="use-credentials"?o.credentials="include":r.crossOrigin==="anonymous"?o.credentials="omit":o.credentials="same-origin",o}function n(r){if(r.ep)return;r.ep=!0;const o=s(r);fetch(r.href,o)}})();/**
* @vue/shared v3.5.29
* (c) 2018-present Yuxi (Evan) You and Vue contributors
* @license MIT
**/function hs(e){const t=Object.create(null);for(const s of e.split(","))t[s]=1;return s=>s in t}const re={},Ct=[],Ge=()=>{},Pr=()=>!1,Dn=e=>e.charCodeAt(0)===111&&e.charCodeAt(1)===110&&(e.charCodeAt(2)>122||e.charCodeAt(2)<97),_s=e=>e.startsWith("onUpdate:"),ge=Object.assign,bs=(e,t)=>{const s=e.indexOf(t);s>-1&&e.splice(s,1)},Vo=Object.prototype.hasOwnProperty,ee=(e,t)=>Vo.call(e,t),K=Array.isArray,At=e=>Qt(e)==="[object Map]",On=e=>Qt(e)==="[object Set]",Ns=e=>Qt(e)==="[object Date]",J=e=>typeof e=="function",ue=e=>typeof e=="string",ze=e=>typeof e=="symbol",se=e=>e!==null&&typeof e=="object",Mr=e=>(se(e)||J(e))&&J(e.then)&&J(e.catch),Rr=Object.prototype.toString,Qt=e=>Rr.call(e),Ko=e=>Qt(e).slice(8,-1),$r=e=>Qt(e)==="[object Object]",Pn=e=>ue(e)&&e!=="NaN"&&e[0]!=="-"&&""+parseInt(e,10)===e,It=hs(",key,ref,ref_for,ref_key,onVnodeBeforeMount,onVnodeMounted,onVnodeBeforeUpdate,onVnodeUpdated,onVnodeBeforeUnmount,onVnodeUnmounted"),Mn=e=>{const t=Object.create(null);return s=>t[s]||(t[s]=e(s))},Go=/-\w/g,Le=Mn(e=>e.replace(Go,t=>t.slice(1).toUpperCase())),zo=/\B([A-Z])/g,dt=Mn(e=>e.replace(zo,"-$1").toLowerCase()),Rn=Mn(e=>e.charAt(0).toUpperCase()+e.slice(1)),Kn=Mn(e=>e?`on${Rn(e)}`:""),lt=(e,t)=>!Object.is(e,t),fn=(e,...t)=>{for(let s=0;s<e.length;s++)e[s](...t)},Lr=(e,t,s,n=!1)=>{Object.defineProperty(e,t,{configurable:!0,enumerable:!1,writable:n,value:s})},$n=e=>{const t=parseFloat(e);return isNaN(t)?e:t};let Bs;const Ln=()=>Bs||(Bs=typeof globalThis<"u"?globalThis:typeof self<"u"?self:typeof window<"u"?window:typeof global<"u"?global:{});function In(e){if(K(e)){const t={};for(let s=0;s<e.length;s++){const n=e[s],r=ue(n)?Qo(n):In(n);if(r)for(const o in r)t[o]=r[o]}return t}else if(ue(e)||se(e))return e}const Jo=/;(?![^(]*\))/g,Xo=/:([^]+)/,Yo=/\/\*[^]*?\*\//g;function Qo(e){const t={};return e.replace(Yo,"").split(Jo).forEach(s=>{if(s){const n=s.split(Xo);n.length>1&&(t[n[0].trim()]=n[1].trim())}}),t}function Fe(e){let t="";if(ue(e))t=e;else if(K(e))for(let s=0;s<e.length;s++){const n=Fe(e[s]);n&&(t+=n+" ")}else if(se(e))for(const s in e)e[s]&&(t+=s+" ");return t.trim()}const Zo="itemscope,allowfullscreen,formnovalidate,ismap,nomodule,novalidate,readonly",ei=hs(Zo);function Ir(e){return!!e||e===""}function ti(e,t){if(e.length!==t.length)return!1;let s=!0;for(let n=0;s&&n<e.length;n++)s=Zt(e[n],t[n]);return s}function Zt(e,t){if(e===t)return!0;let s=Ns(e),n=Ns(t);if(s||n)return s&&n?e.getTime()===t.getTime():!1;if(s=ze(e),n=ze(t),s||n)return e===t;if(s=K(e),n=K(t),s||n)return s&&n?ti(e,t):!1;if(s=se(e),n=se(t),s||n){if(!s||!n)return!1;const r=Object.keys(e).length,o=Object.keys(t).length;if(r!==o)return!1;for(const i in e){const a=e.hasOwnProperty(i),c=t.hasOwnProperty(i);if(a&&!c||!a&&c||!Zt(e[i],t[i]))return!1}}return String(e)===String(t)}function ni(e,t){return e.findIndex(s=>Zt(s,t))}const Fr=e=>!!(e&&e.__v_isRef===!0),de=e=>ue(e)?e:e==null?"":K(e)||se(e)&&(e.toString===Rr||!J(e.toString))?Fr(e)?de(e.value):JSON.stringify(e,Ur,2):String(e),Ur=(e,t)=>Fr(t)?Ur(e,t.value):At(t)?{[`Map(${t.size})`]:[...t.entries()].reduce((s,[n,r],o)=>(s[Gn(n,o)+" =>"]=r,s),{})}:On(t)?{[`Set(${t.size})`]:[...t.values()].map(s=>Gn(s))}:ze(t)?Gn(t):se(t)&&!K(t)&&!$r(t)?String(t):t,Gn=(e,t="")=>{var s;return ze(e)?`Symbol(${(s=e.description)!=null?s:t})`:e};/**
* @vue/reactivity v3.5.29
* (c) 2018-present Yuxi (Evan) You and Vue contributors
* @license MIT
**/let _e;class Hr{constructor(t=!1){this.detached=t,this._active=!0,this._on=0,this.effects=[],this.cleanups=[],this._isPaused=!1,this.__v_skip=!0,this.parent=_e,!t&&_e&&(this.index=(_e.scopes||(_e.scopes=[])).push(this)-1)}get active(){return this._active}pause(){if(this._active){this._isPaused=!0;let t,s;if(this.scopes)for(t=0,s=this.scopes.length;t<s;t++)this.scopes[t].pause();for(t=0,s=this.effects.length;t<s;t++)this.effects[t].pause()}}resume(){if(this._active&&this._isPaused){this._isPaused=!1;let t,s;if(this.scopes)for(t=0,s=this.scopes.length;t<s;t++)this.scopes[t].resume();for(t=0,s=this.effects.length;t<s;t++)this.effects[t].resume()}}run(t){if(this._active){const s=_e;try{return _e=this,t()}finally{_e=s}}}on(){++this._on===1&&(this.prevScope=_e,_e=this)}off(){this._on>0&&--this._on===0&&(_e=this.prevScope,this.prevScope=void 0)}stop(t){if(this._active){this._active=!1;let s,n;for(s=0,n=this.effects.length;s<n;s++)this.effects[s].stop();for(this.effects.length=0,s=0,n=this.cleanups.length;s<n;s++)this.cleanups[s]();if(this.cleanups.length=0,this.scopes){for(s=0,n=this.scopes.length;s<n;s++)this.scopes[s].stop(!0);this.scopes.length=0}if(!this.detached&&this.parent&&!t){const r=this.parent.scopes.pop();r&&r!==this&&(this.parent.scopes[this.index]=r,r.index=this.index)}this.parent=void 0}}}function Wr(e){return new Hr(e)}function qr(){return _e}function si(e,t=!1){_e&&_e.cleanups.push(e)}let ie;const zn=new WeakSet;class Nr{constructor(t){this.fn=t,this.deps=void 0,this.depsTail=void 0,this.flags=5,this.next=void 0,this.cleanup=void 0,this.scheduler=void 0,_e&&_e.active&&_e.effects.push(this)}pause(){this.flags|=64}resume(){this.flags&64&&(this.flags&=-65,zn.has(this)&&(zn.delete(this),this.trigger()))}notify(){this.flags&2&&!(this.flags&32)||this.flags&8||jr(this)}run(){if(!(this.flags&1))return this.fn();this.flags|=2,js(this),Vr(this);const t=ie,s=Ue;ie=this,Ue=!0;try{return this.fn()}finally{Kr(this),ie=t,Ue=s,this.flags&=-3}}stop(){if(this.flags&1){for(let t=this.deps;t;t=t.nextDep)ws(t);this.deps=this.depsTail=void 0,js(this),this.onStop&&this.onStop(),this.flags&=-2}}trigger(){this.flags&64?zn.add(this):this.scheduler?this.scheduler():this.runIfDirty()}runIfDirty(){ns(this)&&this.run()}get dirty(){return ns(this)}}let Br=0,Ft,Ut;function jr(e,t=!1){if(e.flags|=8,t){e.next=Ut,Ut=e;return}e.next=Ft,Ft=e}function ys(){Br++}function vs(){if(--Br>0)return;if(Ut){let t=Ut;for(Ut=void 0;t;){const s=t.next;t.next=void 0,t.flags&=-9,t=s}}let e;for(;Ft;){let t=Ft;for(Ft=void 0;t;){const s=t.next;if(t.next=void 0,t.flags&=-9,t.flags&1)try{t.trigger()}catch(n){e||(e=n)}t=s}}if(e)throw e}function Vr(e){for(let t=e.deps;t;t=t.nextDep)t.version=-1,t.prevActiveLink=t.dep.activeLink,t.dep.activeLink=t}function Kr(e){let t,s=e.depsTail,n=s;for(;n;){const r=n.prevDep;n.version===-1?(n===s&&(s=r),ws(n),ri(n)):t=n,n.dep.activeLink=n.prevActiveLink,n.prevActiveLink=void 0,n=r}e.deps=t,e.depsTail=s}function ns(e){for(let t=e.deps;t;t=t.nextDep)if(t.dep.version!==t.version||t.dep.computed&&(Gr(t.dep.computed)||t.dep.version!==t.version))return!0;return!!e._dirty}function Gr(e){if(e.flags&4&&!(e.flags&16)||(e.flags&=-17,e.globalVersion===Gt)||(e.globalVersion=Gt,!e.isSSR&&e.flags&128&&(!e.deps&&!e._dirty||!ns(e))))return;e.flags|=2;const t=e.dep,s=ie,n=Ue;ie=e,Ue=!0;try{Vr(e);const r=e.fn(e._value);(t.version===0||lt(r,e._value))&&(e.flags|=128,e._value=r,t.version++)}catch(r){throw t.version++,r}finally{ie=s,Ue=n,Kr(e),e.flags&=-3}}function ws(e,t=!1){const{dep:s,prevSub:n,nextSub:r}=e;if(n&&(n.nextSub=r,e.prevSub=void 0),r&&(r.prevSub=n,e.nextSub=void 0),s.subs===e&&(s.subs=n,!n&&s.computed)){s.computed.flags&=-5;for(let o=s.computed.deps;o;o=o.nextDep)ws(o,!0)}!t&&!--s.sc&&s.map&&s.map.delete(s.key)}function ri(e){const{prevDep:t,nextDep:s}=e;t&&(t.nextDep=s,e.prevDep=void 0),s&&(s.prevDep=t,e.nextDep=void 0)}let Ue=!0;const zr=[];function nt(){zr.push(Ue),Ue=!1}function st(){const e=zr.pop();Ue=e===void 0?!0:e}function js(e){const{cleanup:t}=e;if(e.cleanup=void 0,t){const s=ie;ie=void 0;try{t()}finally{ie=s}}}let Gt=0;class oi{constructor(t,s){this.sub=t,this.dep=s,this.version=s.version,this.nextDep=this.prevDep=this.nextSub=this.prevSub=this.prevActiveLink=void 0}}class Cs{constructor(t){this.computed=t,this.version=0,this.activeLink=void 0,this.subs=void 0,this.map=void 0,this.key=void 0,this.sc=0,this.__v_skip=!0}track(t){if(!ie||!Ue||ie===this.computed)return;let s=this.activeLink;if(s===void 0||s.sub!==ie)s=this.activeLink=new oi(ie,this),ie.deps?(s.prevDep=ie.depsTail,ie.depsTail.nextDep=s,ie.depsTail=s):ie.deps=ie.depsTail=s,Jr(s);else if(s.version===-1&&(s.version=this.version,s.nextDep)){const n=s.nextDep;n.prevDep=s.prevDep,s.prevDep&&(s.prevDep.nextDep=n),s.prevDep=ie.depsTail,s.nextDep=void 0,ie.depsTail.nextDep=s,ie.depsTail=s,ie.deps===s&&(ie.deps=n)}return s}trigger(t){this.version++,Gt++,this.notify(t)}notify(t){ys();try{for(let s=this.subs;s;s=s.prevSub)s.sub.notify()&&s.sub.dep.notify()}finally{vs()}}}function Jr(e){if(e.dep.sc++,e.sub.flags&4){const t=e.dep.computed;if(t&&!e.dep.subs){t.flags|=20;for(let n=t.deps;n;n=n.nextDep)Jr(n)}const s=e.dep.subs;s!==e&&(e.prevSub=s,s&&(s.nextSub=e)),e.dep.subs=e}}const yn=new WeakMap,ht=Symbol(""),ss=Symbol(""),zt=Symbol("");function be(e,t,s){if(Ue&&ie){let n=yn.get(e);n||yn.set(e,n=new Map);let r=n.get(s);r||(n.set(s,r=new Cs),r.map=n,r.key=s),r.track()}}function Ze(e,t,s,n,r,o){const i=yn.get(e);if(!i){Gt++;return}const a=c=>{c&&c.trigger()};if(ys(),t==="clear")i.forEach(a);else{const c=K(e),u=c&&Pn(s);if(c&&s==="length"){const l=Number(n);i.forEach((p,g)=>{(g==="length"||g===zt||!ze(g)&&g>=l)&&a(p)})}else switch((s!==void 0||i.has(void 0))&&a(i.get(s)),u&&a(i.get(zt)),t){case"add":c?u&&a(i.get("length")):(a(i.get(ht)),At(e)&&a(i.get(ss)));break;case"delete":c||(a(i.get(ht)),At(e)&&a(i.get(ss)));break;case"set":At(e)&&a(i.get(ht));break}}vs()}function ii(e,t){const s=yn.get(e);return s&&s.get(t)}function yt(e){const t=Q(e);return t===e?t:(be(t,"iterate",zt),Pe(e)?t:t.map(He))}function Fn(e){return be(e=Q(e),"iterate",zt),e}function at(e,t){return rt(e)?Tt(tt(e)?He(t):t):He(t)}const ai={__proto__:null,[Symbol.iterator](){return Jn(this,Symbol.iterator,e=>at(this,e))},concat(...e){return yt(this).concat(...e.map(t=>K(t)?yt(t):t))},entries(){return Jn(this,"entries",e=>(e[1]=at(this,e[1]),e))},every(e,t){return Xe(this,"every",e,t,void 0,arguments)},filter(e,t){return Xe(this,"filter",e,t,s=>s.map(n=>at(this,n)),arguments)},find(e,t){return Xe(this,"find",e,t,s=>at(this,s),arguments)},findIndex(e,t){return Xe(this,"findIndex",e,t,void 0,arguments)},findLast(e,t){return Xe(this,"findLast",e,t,s=>at(this,s),arguments)},findLastIndex(e,t){return Xe(this,"findLastIndex",e,t,void 0,arguments)},forEach(e,t){return Xe(this,"forEach",e,t,void 0,arguments)},includes(...e){return Xn(this,"includes",e)},indexOf(...e){return Xn(this,"indexOf",e)},join(e){return yt(this).join(e)},lastIndexOf(...e){return Xn(this,"lastIndexOf",e)},map(e,t){return Xe(this,"map",e,t,void 0,arguments)},pop(){return Rt(this,"pop")},push(...e){return Rt(this,"push",e)},reduce(e,...t){return Vs(this,"reduce",e,t)},reduceRight(e,...t){return Vs(this,"reduceRight",e,t)},shift(){return Rt(this,"shift")},some(e,t){return Xe(this,"some",e,t,void 0,arguments)},splice(...e){return Rt(this,"splice",e)},toReversed(){return yt(this).toReversed()},toSorted(e){return yt(this).toSorted(e)},toSpliced(...e){return yt(this).toSpliced(...e)},unshift(...e){return Rt(this,"unshift",e)},values(){return Jn(this,"values",e=>at(this,e))}};function Jn(e,t,s){const n=Fn(e),r=n[t]();return n!==e&&!Pe(e)&&(r._next=r.next,r.next=()=>{const o=r._next();return o.done||(o.value=s(o.value)),o}),r}const ci=Array.prototype;function Xe(e,t,s,n,r,o){const i=Fn(e),a=i!==e&&!Pe(e),c=i[t];if(c!==ci[t]){const p=c.apply(e,o);return a?He(p):p}let u=s;i!==e&&(a?u=function(p,g){return s.call(this,at(e,p),g,e)}:s.length>2&&(u=function(p,g){return s.call(this,p,g,e)}));const l=c.call(i,u,n);return a&&r?r(l):l}function Vs(e,t,s,n){const r=Fn(e);let o=s;return r!==e&&(Pe(e)?s.length>3&&(o=function(i,a,c){return s.call(this,i,a,c,e)}):o=function(i,a,c){return s.call(this,i,at(e,a),c,e)}),r[t](o,...n)}function Xn(e,t,s){const n=Q(e);be(n,"iterate",zt);const r=n[t](...s);return(r===-1||r===!1)&&Hn(s[0])?(s[0]=Q(s[0]),n[t](...s)):r}function Rt(e,t,s=[]){nt(),ys();const n=Q(e)[t].apply(e,s);return vs(),st(),n}const li=hs("__proto__,__v_isRef,__isVue"),Xr=new Set(Object.getOwnPropertyNames(Symbol).filter(e=>e!=="arguments"&&e!=="caller").map(e=>Symbol[e]).filter(ze));function ui(e){ze(e)||(e=String(e));const t=Q(this);return be(t,"has",e),t.hasOwnProperty(e)}class Yr{constructor(t=!1,s=!1){this._isReadonly=t,this._isShallow=s}get(t,s,n){if(s==="__v_skip")return t.__v_skip;const r=this._isReadonly,o=this._isShallow;if(s==="__v_isReactive")return!r;if(s==="__v_isReadonly")return r;if(s==="__v_isShallow")return o;if(s==="__v_raw")return n===(r?o?vi:to:o?eo:Zr).get(t)||Object.getPrototypeOf(t)===Object.getPrototypeOf(n)?t:void 0;const i=K(t);if(!r){let c;if(i&&(c=ai[s]))return c;if(s==="hasOwnProperty")return ui}const a=Reflect.get(t,s,le(t)?t:n);if((ze(s)?Xr.has(s):li(s))||(r||be(t,"get",s),o))return a;if(le(a)){const c=i&&Pn(s)?a:a.value;return r&&se(c)?os(c):c}return se(a)?r?os(a):Un(a):a}}class Qr extends Yr{constructor(t=!1){super(!1,t)}set(t,s,n,r){let o=t[s];const i=K(t)&&Pn(s);if(!this._isShallow){const u=rt(o);if(!Pe(n)&&!rt(n)&&(o=Q(o),n=Q(n)),!i&&le(o)&&!le(n))return u||(o.value=n),!0}const a=i?Number(s)<t.length:ee(t,s),c=Reflect.set(t,s,n,le(t)?t:r);return t===Q(r)&&(a?lt(n,o)&&Ze(t,"set",s,n):Ze(t,"add",s,n)),c}deleteProperty(t,s){const n=ee(t,s);t[s];const r=Reflect.deleteProperty(t,s);return r&&n&&Ze(t,"delete",s,void 0),r}has(t,s){const n=Reflect.has(t,s);return(!ze(s)||!Xr.has(s))&&be(t,"has",s),n}ownKeys(t){return be(t,"iterate",K(t)?"length":ht),Reflect.ownKeys(t)}}class di extends Yr{constructor(t=!1){super(!0,t)}set(t,s){return!0}deleteProperty(t,s){return!0}}const fi=new Qr,pi=new di,gi=new Qr(!0);const rs=e=>e,an=e=>Reflect.getPrototypeOf(e);function mi(e,t,s){return function(...n){const r=this.__v_raw,o=Q(r),i=At(o),a=e==="entries"||e===Symbol.iterator&&i,c=e==="keys"&&i,u=r[e](...n),l=s?rs:t?Tt:He;return!t&&be(o,"iterate",c?ss:ht),ge(Object.create(u),{next(){const{value:p,done:g}=u.next();return g?{value:p,done:g}:{value:a?[l(p[0]),l(p[1])]:l(p),done:g}}})}}function cn(e){return function(...t){return e==="delete"?!1:e==="clear"?void 0:this}}function hi(e,t){const s={get(r){const o=this.__v_raw,i=Q(o),a=Q(r);e||(lt(r,a)&&be(i,"get",r),be(i,"get",a));const{has:c}=an(i),u=t?rs:e?Tt:He;if(c.call(i,r))return u(o.get(r));if(c.call(i,a))return u(o.get(a));o!==i&&o.get(r)},get size(){const r=this.__v_raw;return!e&&be(Q(r),"iterate",ht),r.size},has(r){const o=this.__v_raw,i=Q(o),a=Q(r);return e||(lt(r,a)&&be(i,"has",r),be(i,"has",a)),r===a?o.has(r):o.has(r)||o.has(a)},forEach(r,o){const i=this,a=i.__v_raw,c=Q(a),u=t?rs:e?Tt:He;return!e&&be(c,"iterate",ht),a.forEach((l,p)=>r.call(o,u(l),u(p),i))}};return ge(s,e?{add:cn("add"),set:cn("set"),delete:cn("delete"),clear:cn("clear")}:{add(r){!t&&!Pe(r)&&!rt(r)&&(r=Q(r));const o=Q(this);return an(o).has.call(o,r)||(o.add(r),Ze(o,"add",r,r)),this},set(r,o){!t&&!Pe(o)&&!rt(o)&&(o=Q(o));const i=Q(this),{has:a,get:c}=an(i);let u=a.call(i,r);u||(r=Q(r),u=a.call(i,r));const l=c.call(i,r);return i.set(r,o),u?lt(o,l)&&Ze(i,"set",r,o):Ze(i,"add",r,o),this},delete(r){const o=Q(this),{has:i,get:a}=an(o);let c=i.call(o,r);c||(r=Q(r),c=i.call(o,r)),a&&a.call(o,r);const u=o.delete(r);return c&&Ze(o,"delete",r,void 0),u},clear(){const r=Q(this),o=r.size!==0,i=r.clear();return o&&Ze(r,"clear",void 0,void 0),i}}),["keys","values","entries",Symbol.iterator].forEach(r=>{s[r]=mi(r,e,t)}),s}function As(e,t){const s=hi(e,t);return(n,r,o)=>r==="__v_isReactive"?!e:r==="__v_isReadonly"?e:r==="__v_raw"?n:Reflect.get(ee(s,r)&&r in n?s:n,r,o)}const _i={get:As(!1,!1)},bi={get:As(!1,!0)},yi={get:As(!0,!1)};const Zr=new WeakMap,eo=new WeakMap,to=new WeakMap,vi=new WeakMap;function wi(e){switch(e){case"Object":case"Array":return 1;case"Map":case"Set":case"WeakMap":case"WeakSet":return 2;default:return 0}}function Ci(e){return e.__v_skip||!Object.isExtensible(e)?0:wi(Ko(e))}function Un(e){return rt(e)?e:Ss(e,!1,fi,_i,Zr)}function Ai(e){return Ss(e,!1,gi,bi,eo)}function os(e){return Ss(e,!0,pi,yi,to)}function Ss(e,t,s,n,r){if(!se(e)||e.__v_raw&&!(t&&e.__v_isReactive))return e;const o=Ci(e);if(o===0)return e;const i=r.get(e);if(i)return i;const a=new Proxy(e,o===2?n:s);return r.set(e,a),a}function tt(e){return rt(e)?tt(e.__v_raw):!!(e&&e.__v_isReactive)}function rt(e){return!!(e&&e.__v_isReadonly)}function Pe(e){return!!(e&&e.__v_isShallow)}function Hn(e){return e?!!e.__v_raw:!1}function Q(e){const t=e&&e.__v_raw;return t?Q(t):e}function ks(e){return!ee(e,"__v_skip")&&Object.isExtensible(e)&&Lr(e,"__v_skip",!0),e}const He=e=>se(e)?Un(e):e,Tt=e=>se(e)?os(e):e;function le(e){return e?e.__v_isRef===!0:!1}function Z(e){return Si(e,!1)}function Si(e,t){return le(e)?e:new ki(e,t)}class ki{constructor(t,s){this.dep=new Cs,this.__v_isRef=!0,this.__v_isShallow=!1,this._rawValue=s?t:Q(t),this._value=s?t:He(t),this.__v_isShallow=s}get value(){return this.dep.track(),this._value}set value(t){const s=this._rawValue,n=this.__v_isShallow||Pe(t)||rt(t);t=n?t:Q(t),lt(t,s)&&(this._rawValue=t,this._value=n?t:He(t),this.dep.trigger())}}function Jt(e){return le(e)?e.value:e}const Ti={get:(e,t,s)=>t==="__v_raw"?e:Jt(Reflect.get(e,t,s)),set:(e,t,s,n)=>{const r=e[t];return le(r)&&!le(s)?(r.value=s,!0):Reflect.set(e,t,s,n)}};function no(e){return tt(e)?e:new Proxy(e,Ti)}function xi(e){const t=K(e)?new Array(e.length):{};for(const s in e)t[s]=Di(e,s);return t}class Ei{constructor(t,s,n){this._object=t,this._key=s,this._defaultValue=n,this.__v_isRef=!0,this._value=void 0,this._raw=Q(t);let r=!0,o=t;if(!K(t)||!Pn(String(s)))do r=!Hn(o)||Pe(o);while(r&&(o=o.__v_raw));this._shallow=r}get value(){let t=this._object[this._key];return this._shallow&&(t=Jt(t)),this._value=t===void 0?this._defaultValue:t}set value(t){if(this._shallow&&le(this._raw[this._key])){const s=this._object[this._key];if(le(s)){s.value=t;return}}this._object[this._key]=t}get dep(){return ii(this._raw,this._key)}}function Di(e,t,s){return new Ei(e,t,s)}class Oi{constructor(t,s,n){this.fn=t,this.setter=s,this._value=void 0,this.dep=new Cs(this),this.__v_isRef=!0,this.deps=void 0,this.depsTail=void 0,this.flags=16,this.globalVersion=Gt-1,this.next=void 0,this.effect=this,this.__v_isReadonly=!s,this.isSSR=n}notify(){if(this.flags|=16,!(this.flags&8)&&ie!==this)return jr(this,!0),!0}get value(){const t=this.dep.track();return Gr(this),t&&(t.version=this.dep.version),this._value}set value(t){this.setter&&this.setter(t)}}function Pi(e,t,s=!1){let n,r;return J(e)?n=e:(n=e.get,r=e.set),new Oi(n,r,s)}const ln={},vn=new WeakMap;let gt;function Mi(e,t=!1,s=gt){if(s){let n=vn.get(s);n||vn.set(s,n=[]),n.push(e)}}function Ri(e,t,s=re){const{immediate:n,deep:r,once:o,scheduler:i,augmentJob:a,call:c}=s,u=k=>r?k:Pe(k)||r===!1||r===0?et(k,1):et(k);let l,p,g,m,w=!1,A=!1;if(le(e)?(p=()=>e.value,w=Pe(e)):tt(e)?(p=()=>u(e),w=!0):K(e)?(A=!0,w=e.some(k=>tt(k)||Pe(k)),p=()=>e.map(k=>{if(le(k))return k.value;if(tt(k))return u(k);if(J(k))return c?c(k,2):k()})):J(e)?t?p=c?()=>c(e,2):e:p=()=>{if(g){nt();try{g()}finally{st()}}const k=gt;gt=l;try{return c?c(e,3,[m]):e(m)}finally{gt=k}}:p=Ge,t&&r){const k=p,C=r===!0?1/0:r;p=()=>et(k(),C)}const U=qr(),F=()=>{l.stop(),U&&U.active&&bs(U.effects,l)};if(o&&t){const k=t;t=(...C)=>{k(...C),F()}}let v=A?new Array(e.length).fill(ln):ln;const D=k=>{if(!(!(l.flags&1)||!l.dirty&&!k))if(t){const C=l.run();if(r||w||(A?C.some((E,$)=>lt(E,v[$])):lt(C,v))){g&&g();const E=gt;gt=l;try{const $=[C,v===ln?void 0:A&&v[0]===ln?[]:v,m];v=C,c?c(t,3,$):t(...$)}finally{gt=E}}}else l.run()};return a&&a(D),l=new Nr(p),l.scheduler=i?()=>i(D,!1):D,m=k=>Mi(k,!1,l),g=l.onStop=()=>{const k=vn.get(l);if(k){if(c)c(k,4);else for(const C of k)C();vn.delete(l)}},t?n?D(!0):v=l.run():i?i(D.bind(null,!0),!0):l.run(),F.pause=l.pause.bind(l),F.resume=l.resume.bind(l),F.stop=F,F}function et(e,t=1/0,s){if(t<=0||!se(e)||e.__v_skip||(s=s||new Map,(s.get(e)||0)>=t))return e;if(s.set(e,t),t--,le(e))et(e.value,t,s);else if(K(e))for(let n=0;n<e.length;n++)et(e[n],t,s);else if(On(e)||At(e))e.forEach(n=>{et(n,t,s)});else if($r(e)){for(const n in e)et(e[n],t,s);for(const n of Object.getOwnPropertySymbols(e))Object.prototype.propertyIsEnumerable.call(e,n)&&et(e[n],t,s)}return e}/**
* @vue/runtime-core v3.5.29
* (c) 2018-present Yuxi (Evan) You and Vue contributors
* @license MIT
**/function en(e,t,s,n){try{return n?e(...n):e()}catch(r){tn(r,t,s)}}function Je(e,t,s,n){if(J(e)){const r=en(e,t,s,n);return r&&Mr(r)&&r.catch(o=>{tn(o,t,s)}),r}if(K(e)){const r=[];for(let o=0;o<e.length;o++)r.push(Je(e[o],t,s,n));return r}}function tn(e,t,s,n=!0){const r=t?t.vnode:null,{errorHandler:o,throwUnhandledErrorInProduction:i}=t&&t.appContext.config||re;if(t){let a=t.parent;const c=t.proxy,u=`https://vuejs.org/error-reference/#runtime-${s}`;for(;a;){const l=a.ec;if(l){for(let p=0;p<l.length;p++)if(l[p](e,c,u)===!1)return}a=a.parent}if(o){nt(),en(o,null,10,[e,c,u]),st();return}}$i(e,s,r,n,i)}function $i(e,t,s,n=!0,r=!1){if(r)throw e;console.error(e)}const ve=[];let Ve=-1;const St=[];let ct=null,wt=0;const so=Promise.resolve();let wn=null;function Ts(e){const t=wn||so;return e?t.then(this?e.bind(this):e):t}function Li(e){let t=Ve+1,s=ve.length;for(;t<s;){const n=t+s>>>1,r=ve[n],o=Xt(r);o<e||o===e&&r.flags&2?t=n+1:s=n}return t}function xs(e){if(!(e.flags&1)){const t=Xt(e),s=ve[ve.length-1];!s||!(e.flags&2)&&t>=Xt(s)?ve.push(e):ve.splice(Li(t),0,e),e.flags|=1,ro()}}function ro(){wn||(wn=so.then(io))}function Ii(e){K(e)?St.push(...e):ct&&e.id===-1?ct.splice(wt+1,0,e):e.flags&1||(St.push(e),e.flags|=1),ro()}function Ks(e,t,s=Ve+1){for(;s<ve.length;s++){const n=ve[s];if(n&&n.flags&2){if(e&&n.id!==e.uid)continue;ve.splice(s,1),s--,n.flags&4&&(n.flags&=-2),n(),n.flags&4||(n.flags&=-2)}}}function oo(e){if(St.length){const t=[...new Set(St)].sort((s,n)=>Xt(s)-Xt(n));if(St.length=0,ct){ct.push(...t);return}for(ct=t,wt=0;wt<ct.length;wt++){const s=ct[wt];s.flags&4&&(s.flags&=-2),s.flags&8||s(),s.flags&=-2}ct=null,wt=0}}const Xt=e=>e.id==null?e.flags&2?-1:1/0:e.id;function io(e){try{for(Ve=0;Ve<ve.length;Ve++){const t=ve[Ve];t&&!(t.flags&8)&&(t.flags&4&&(t.flags&=-2),en(t,t.i,t.i?15:14),t.flags&4||(t.flags&=-2))}}finally{for(;Ve<ve.length;Ve++){const t=ve[Ve];t&&(t.flags&=-2)}Ve=-1,ve.length=0,oo(),wn=null,(ve.length||St.length)&&io()}}let De=null,ao=null;function Cn(e){const t=De;return De=e,ao=e&&e.type.__scopeId||null,t}function Fi(e,t=De,s){if(!t||e._n)return e;const n=(...r)=>{n._d&&cr(-1);const o=Cn(t);let i;try{i=e(...r)}finally{Cn(o),n._d&&cr(1)}return i};return n._n=!0,n._c=!0,n._d=!0,n}function eu(e,t){if(De===null)return e;const s=Bn(De),n=e.dirs||(e.dirs=[]);for(let r=0;r<t.length;r++){let[o,i,a,c=re]=t[r];o&&(J(o)&&(o={mounted:o,updated:o}),o.deep&&et(i),n.push({dir:o,instance:s,value:i,oldValue:void 0,arg:a,modifiers:c}))}return e}function ft(e,t,s,n){const r=e.dirs,o=t&&t.dirs;for(let i=0;i<r.length;i++){const a=r[i];o&&(a.oldValue=o[i].value);let c=a.dir[n];c&&(nt(),Je(c,s,8,[e.el,a,e,t]),st())}}function Ui(e,t){if(fe){let s=fe.provides;const n=fe.parent&&fe.parent.provides;n===s&&(s=fe.provides=Object.create(n)),s[e]=t}}function Ht(e,t,s=!1){const n=Lo();if(n||_t){let r=_t?_t._context.provides:n?n.parent==null||n.ce?n.vnode.appContext&&n.vnode.appContext.provides:n.parent.provides:void 0;if(r&&e in r)return r[e];if(arguments.length>1)return s&&J(t)?t.call(n&&n.proxy):t}}function Hi(){return!!(Lo()||_t)}const Wi=Symbol.for("v-scx"),qi=()=>Ht(Wi);function pn(e,t,s){return co(e,t,s)}function co(e,t,s=re){const{immediate:n,deep:r,flush:o,once:i}=s,a=ge({},s),c=t&&n||!t&&o!=="post";let u;if(Et){if(o==="sync"){const m=qi();u=m.__watcherHandles||(m.__watcherHandles=[])}else if(!c){const m=()=>{};return m.stop=Ge,m.resume=Ge,m.pause=Ge,m}}const l=fe;a.call=(m,w,A)=>Je(m,l,w,A);let p=!1;o==="post"?a.scheduler=m=>{he(m,l&&l.suspense)}:o!=="sync"&&(p=!0,a.scheduler=(m,w)=>{w?m():xs(m)}),a.augmentJob=m=>{t&&(m.flags|=4),p&&(m.flags|=2,l&&(m.id=l.uid,m.i=l))};const g=Ri(e,t,a);return Et&&(u?u.push(g):c&&g()),g}function Ni(e,t,s){const n=this.proxy,r=ue(e)?e.includes(".")?lo(n,e):()=>n[e]:e.bind(n,n);let o;J(t)?o=t:(o=t.handler,s=t);const i=nn(this),a=co(r,o.bind(n),s);return i(),a}function lo(e,t){const s=t.split(".");return()=>{let n=e;for(let r=0;r<s.length&&n;r++)n=n[s[r]];return n}}const uo=Symbol("_vte"),Bi=e=>e.__isTeleport,Wt=e=>e&&(e.disabled||e.disabled===""),Gs=e=>e&&(e.defer||e.defer===""),zs=e=>typeof SVGElement<"u"&&e instanceof SVGElement,Js=e=>typeof MathMLElement=="function"&&e instanceof MathMLElement,is=(e,t)=>{const s=e&&e.to;return ue(s)?t?t(s):null:s},fo={name:"Teleport",__isTeleport:!0,process(e,t,s,n,r,o,i,a,c,u){const{mc:l,pc:p,pbc:g,o:{insert:m,querySelector:w,createText:A,createComment:U}}=u,F=Wt(t.props);let{shapeFlag:v,children:D,dynamicChildren:k}=t;if(e==null){const C=t.el=A(""),E=t.anchor=A("");m(C,s,n),m(E,s,n);const $=(h,L)=>{v&16&&l(D,h,L,r,o,i,a,c)},b=()=>{const h=t.target=is(t.props,w),L=as(h,t,A,m);h&&(i!=="svg"&&zs(h)?i="svg":i!=="mathml"&&Js(h)&&(i="mathml"),r&&r.isCE&&(r.ce._teleportTargets||(r.ce._teleportTargets=new Set)).add(h),F||($(h,L),gn(t,!1)))};F&&($(s,E),gn(t,!0)),Gs(t.props)?(t.el.__isMounted=!1,he(()=>{b(),delete t.el.__isMounted},o)):b()}else{if(Gs(t.props)&&e.el.__isMounted===!1){he(()=>{fo.process(e,t,s,n,r,o,i,a,c,u)},o);return}t.el=e.el,t.targetStart=e.targetStart;const C=t.anchor=e.anchor,E=t.target=e.target,$=t.targetAnchor=e.targetAnchor,b=Wt(e.props),h=b?s:E,L=b?C:$;if(i==="svg"||zs(E)?i="svg":(i==="mathml"||Js(E))&&(i="mathml"),k?(g(e.dynamicChildren,k,h,r,o,i,a),Ls(e,t,!0)):c||p(e,t,h,L,r,o,i,a,!1),F)b?t.props&&e.props&&t.props.to!==e.props.to&&(t.props.to=e.props.to):un(t,s,C,u,1);else if((t.props&&t.props.to)!==(e.props&&e.props.to)){const P=t.target=is(t.props,w);P&&un(t,P,null,u,0)}else b&&un(t,E,$,u,1);gn(t,F)}},remove(e,t,s,{um:n,o:{remove:r}},o){const{shapeFlag:i,children:a,anchor:c,targetStart:u,targetAnchor:l,target:p,props:g}=e;if(p&&(r(u),r(l)),o&&r(c),i&16){const m=o||!Wt(g);for(let w=0;w<a.length;w++){const A=a[w];n(A,t,s,m,!!A.dynamicChildren)}}},move:un,hydrate:ji};function un(e,t,s,{o:{insert:n},m:r},o=2){o===0&&n(e.targetAnchor,t,s);const{el:i,anchor:a,shapeFlag:c,children:u,props:l}=e,p=o===2;if(p&&n(i,t,s),(!p||Wt(l))&&c&16)for(let g=0;g<u.length;g++)r(u[g],t,s,2);p&&n(a,t,s)}function ji(e,t,s,n,r,o,{o:{nextSibling:i,parentNode:a,querySelector:c,insert:u,createText:l}},p){function g(U,F){let v=F;for(;v;){if(v&&v.nodeType===8){if(v.data==="teleport start anchor")t.targetStart=v;else if(v.data==="teleport anchor"){t.targetAnchor=v,U._lpa=t.targetAnchor&&i(t.targetAnchor);break}}v=i(v)}}function m(U,F){F.anchor=p(i(U),F,a(U),s,n,r,o)}const w=t.target=is(t.props,c),A=Wt(t.props);if(w){const U=w._lpa||w.firstChild;t.shapeFlag&16&&(A?(m(e,t),g(w,U),t.targetAnchor||as(w,t,l,u,a(e)===w?e:null)):(t.anchor=i(e),g(w,U),t.targetAnchor||as(w,t,l,u),p(U&&i(U),t,w,s,n,r,o))),gn(t,A)}else A&&t.shapeFlag&16&&(m(e,t),t.targetStart=e,t.targetAnchor=i(e));return t.anchor&&i(t.anchor)}const tu=fo;function gn(e,t){const s=e.ctx;if(s&&s.ut){let n,r;for(t?(n=e.el,r=e.anchor):(n=e.targetStart,r=e.targetAnchor);n&&n!==r;)n.nodeType===1&&n.setAttribute("data-v-owner",s.uid),n=n.nextSibling;s.ut()}}function as(e,t,s,n,r=null){const o=t.targetStart=s(""),i=t.targetAnchor=s("");return o[uo]=i,e&&(n(o,e,r),n(i,e,r)),i}const Vi=Symbol("_leaveCb");function Es(e,t){e.shapeFlag&6&&e.component?(e.transition=t,Es(e.component.subTree,t)):e.shapeFlag&128?(e.ssContent.transition=t.clone(e.ssContent),e.ssFallback.transition=t.clone(e.ssFallback)):e.transition=t}function Ki(e,t){return J(e)?ge({name:e.name},t,{setup:e}):e}function Ds(e){e.ids=[e.ids[0]+e.ids[2]+++"-",0,0]}function Xs(e,t){let s;return!!((s=Object.getOwnPropertyDescriptor(e,t))&&!s.configurable)}const An=new WeakMap;function qt(e,t,s,n,r=!1){if(K(e)){e.forEach((A,U)=>qt(A,t&&(K(t)?t[U]:t),s,n,r));return}if(Nt(n)&&!r){n.shapeFlag&512&&n.type.__asyncResolved&&n.component.subTree.component&&qt(e,t,s,n.component.subTree);return}const o=n.shapeFlag&4?Bn(n.component):n.el,i=r?null:o,{i:a,r:c}=e,u=t&&t.r,l=a.refs===re?a.refs={}:a.refs,p=a.setupState,g=Q(p),m=p===re?Pr:A=>Xs(l,A)?!1:ee(g,A),w=(A,U)=>!(U&&Xs(l,U));if(u!=null&&u!==c){if(Ys(t),ue(u))l[u]=null,m(u)&&(p[u]=null);else if(le(u)){const A=t;w(u,A.k)&&(u.value=null),A.k&&(l[A.k]=null)}}if(J(c))en(c,a,12,[i,l]);else{const A=ue(c),U=le(c);if(A||U){const F=()=>{if(e.f){const v=A?m(c)?p[c]:l[c]:w()||!e.k?c.value:l[e.k];if(r)K(v)&&bs(v,o);else if(K(v))v.includes(o)||v.push(o);else if(A)l[c]=[o],m(c)&&(p[c]=l[c]);else{const D=[o];w(c,e.k)&&(c.value=D),e.k&&(l[e.k]=D)}}else A?(l[c]=i,m(c)&&(p[c]=i)):U&&(w(c,e.k)&&(c.value=i),e.k&&(l[e.k]=i))};if(i){const v=()=>{F(),An.delete(e)};v.id=-1,An.set(e,v),he(v,s)}else Ys(e),F()}}}function Ys(e){const t=An.get(e);t&&(t.flags|=8,An.delete(e))}const Qs=e=>e.nodeType===8;Ln().requestIdleCallback;Ln().cancelIdleCallback;function Gi(e,t){if(Qs(e)&&e.data==="["){let s=1,n=e.nextSibling;for(;n;){if(n.nodeType===1){if(t(n)===!1)break}else if(Qs(n))if(n.data==="]"){if(--s===0)break}else n.data==="["&&s++;n=n.nextSibling}}else t(e)}const Nt=e=>!!e.type.__asyncLoader;function Re(e){J(e)&&(e={loader:e});const{loader:t,loadingComponent:s,errorComponent:n,delay:r=200,hydrate:o,timeout:i,suspensible:a=!0,onError:c}=e;let u=null,l,p=0;const g=()=>(p++,u=null,m()),m=()=>{let w;return u||(w=u=t().catch(A=>{if(A=A instanceof Error?A:new Error(String(A)),c)return new Promise((U,F)=>{c(A,()=>U(g()),()=>F(A),p+1)});throw A}).then(A=>w!==u&&u?u:(A&&(A.__esModule||A[Symbol.toStringTag]==="Module")&&(A=A.default),l=A,A)))};return Ki({name:"AsyncComponentWrapper",__asyncLoader:m,__asyncHydrate(w,A,U){let F=!1;(A.bu||(A.bu=[])).push(()=>F=!0);const v=()=>{F||U()},D=o?()=>{const k=o(v,C=>Gi(w,C));k&&(A.bum||(A.bum=[])).push(k)}:v;l?D():m().then(()=>!A.isUnmounted&&D())},get __asyncResolved(){return l},setup(){const w=fe;if(Ds(w),l)return()=>dn(l,w);const A=D=>{u=null,tn(D,w,13,!n)};if(a&&w.suspense||Et)return m().then(D=>()=>dn(D,w)).catch(D=>(A(D),()=>n?pe(n,{error:D}):null));const U=Z(!1),F=Z(),v=Z(!!r);return r&&setTimeout(()=>{v.value=!1},r),i!=null&&setTimeout(()=>{if(!U.value&&!F.value){const D=new Error(`Async component timed out after ${i}ms.`);A(D),F.value=D}},i),m().then(()=>{U.value=!0,w.parent&&Os(w.parent.vnode)&&w.parent.update()}).catch(D=>{A(D),F.value=D}),()=>{if(U.value&&l)return dn(l,w);if(F.value&&n)return pe(n,{error:F.value});if(s&&!v.value)return dn(s,w)}}})}function dn(e,t){const{ref:s,props:n,children:r,ce:o}=t.vnode,i=pe(e,n,r);return i.ref=s,i.ce=o,delete t.vnode.ce,i}const Os=e=>e.type.__isKeepAlive;function zi(e,t){po(e,"a",t)}function Ji(e,t){po(e,"da",t)}function po(e,t,s=fe){const n=e.__wdc||(e.__wdc=()=>{let r=s;for(;r;){if(r.isDeactivated)return;r=r.parent}return e()});if(Wn(t,n,s),s){let r=s.parent;for(;r&&r.parent;)Os(r.parent.vnode)&&Xi(n,t,s,r),r=r.parent}}function Xi(e,t,s,n){const r=Wn(t,e,n,!0);Ms(()=>{bs(n[t],r)},s)}function Wn(e,t,s=fe,n=!1){if(s){const r=s[e]||(s[e]=[]),o=t.__weh||(t.__weh=(...i)=>{nt();const a=nn(s),c=Je(t,s,e,i);return a(),st(),c});return n?r.unshift(o):r.push(o),o}}const ot=e=>(t,s=fe)=>{(!Et||e==="sp")&&Wn(e,(...n)=>t(...n),s)},Yi=ot("bm"),Ps=ot("m"),Qi=ot("bu"),Zi=ot("u"),ea=ot("bum"),Ms=ot("um"),ta=ot("sp"),na=ot("rtg"),sa=ot("rtc");function ra(e,t=fe){Wn("ec",e,t)}const oa="components",go=Symbol.for("v-ndc");function ia(e){return ue(e)?aa(oa,e,!1)||e:e||go}function aa(e,t,s=!0,n=!1){const r=De||fe;if(r){const o=r.type;{const a=Va(o,!1);if(a&&(a===t||a===Le(t)||a===Rn(Le(t))))return o}const i=Zs(r[e]||o[e],t)||Zs(r.appContext[e],t);return!i&&n?o:i}}function Zs(e,t){return e&&(e[t]||e[Le(t)]||e[Rn(Le(t))])}function Sn(e,t,s,n){let r;const o=s,i=K(e);if(i||ue(e)){const a=i&&tt(e);let c=!1,u=!1;a&&(c=!Pe(e),u=rt(e),e=Fn(e)),r=new Array(e.length);for(let l=0,p=e.length;l<p;l++)r[l]=t(c?u?Tt(He(e[l])):He(e[l]):e[l],l,void 0,o)}else if(typeof e=="number"){r=new Array(e);for(let a=0;a<e;a++)r[a]=t(a+1,a,void 0,o)}else if(se(e))if(e[Symbol.iterator])r=Array.from(e,(a,c)=>t(a,c,void 0,o));else{const a=Object.keys(e);r=new Array(a.length);for(let c=0,u=a.length;c<u;c++){const l=a[c];r[c]=t(e[l],l,c,o)}}else r=[];return r}const cs=e=>e?Io(e)?Bn(e):cs(e.parent):null,Bt=ge(Object.create(null),{$:e=>e,$el:e=>e.vnode.el,$data:e=>e.data,$props:e=>e.props,$attrs:e=>e.attrs,$slots:e=>e.slots,$refs:e=>e.refs,$parent:e=>cs(e.parent),$root:e=>cs(e.root),$host:e=>e.ce,$emit:e=>e.emit,$options:e=>ho(e),$forceUpdate:e=>e.f||(e.f=()=>{xs(e.update)}),$nextTick:e=>e.n||(e.n=Ts.bind(e.proxy)),$watch:e=>Ni.bind(e)}),Yn=(e,t)=>e!==re&&!e.__isScriptSetup&&ee(e,t),ca={get({_:e},t){if(t==="__v_skip")return!0;const{ctx:s,setupState:n,data:r,props:o,accessCache:i,type:a,appContext:c}=e;if(t[0]!=="$"){const g=i[t];if(g!==void 0)switch(g){case 1:return n[t];case 2:return r[t];case 4:return s[t];case 3:return o[t]}else{if(Yn(n,t))return i[t]=1,n[t];if(r!==re&&ee(r,t))return i[t]=2,r[t];if(ee(o,t))return i[t]=3,o[t];if(s!==re&&ee(s,t))return i[t]=4,s[t];ls&&(i[t]=0)}}const u=Bt[t];let l,p;if(u)return t==="$attrs"&&be(e.attrs,"get",""),u(e);if((l=a.__cssModules)&&(l=l[t]))return l;if(s!==re&&ee(s,t))return i[t]=4,s[t];if(p=c.config.globalProperties,ee(p,t))return p[t]},set({_:e},t,s){const{data:n,setupState:r,ctx:o}=e;return Yn(r,t)?(r[t]=s,!0):n!==re&&ee(n,t)?(n[t]=s,!0):ee(e.props,t)||t[0]==="$"&&t.slice(1)in e?!1:(o[t]=s,!0)},has({_:{data:e,setupState:t,accessCache:s,ctx:n,appContext:r,props:o,type:i}},a){let c;return!!(s[a]||e!==re&&a[0]!=="$"&&ee(e,a)||Yn(t,a)||ee(o,a)||ee(n,a)||ee(Bt,a)||ee(r.config.globalProperties,a)||(c=i.__cssModules)&&c[a])},defineProperty(e,t,s){return s.get!=null?e._.accessCache[t]=0:ee(s,"value")&&this.set(e,t,s.value,null),Reflect.defineProperty(e,t,s)}};function er(e){return K(e)?e.reduce((t,s)=>(t[s]=null,t),{}):e}let ls=!0;function la(e){const t=ho(e),s=e.proxy,n=e.ctx;ls=!1,t.beforeCreate&&tr(t.beforeCreate,e,"bc");const{data:r,computed:o,methods:i,watch:a,provide:c,inject:u,created:l,beforeMount:p,mounted:g,beforeUpdate:m,updated:w,activated:A,deactivated:U,beforeDestroy:F,beforeUnmount:v,destroyed:D,unmounted:k,render:C,renderTracked:E,renderTriggered:$,errorCaptured:b,serverPrefetch:h,expose:L,inheritAttrs:P,components:B,directives:Y,filters:te}=t;if(u&&ua(u,n,null),i)for(const q in i){const z=i[q];J(z)&&(n[q]=z.bind(s))}if(r){const q=r.call(s,s);se(q)&&(e.data=Un(q))}if(ls=!0,o)for(const q in o){const z=o[q],Se=J(z)?z.bind(s,s):J(z.get)?z.get.bind(s,s):Ge,ke=!J(z)&&J(z.set)?z.set.bind(s):Ge,we=y({get:Se,set:ke});Object.defineProperty(n,q,{enumerable:!0,configurable:!0,get:()=>we.value,set:Te=>we.value=Te})}if(a)for(const q in a)mo(a[q],n,s,q);if(c){const q=J(c)?c.call(s):c;Reflect.ownKeys(q).forEach(z=>{Ui(z,q[z])})}l&&tr(l,e,"c");function W(q,z){K(z)?z.forEach(Se=>q(Se.bind(s))):z&&q(z.bind(s))}if(W(Yi,p),W(Ps,g),W(Qi,m),W(Zi,w),W(zi,A),W(Ji,U),W(ra,b),W(sa,E),W(na,$),W(ea,v),W(Ms,k),W(ta,h),K(L))if(L.length){const q=e.exposed||(e.exposed={});L.forEach(z=>{Object.defineProperty(q,z,{get:()=>s[z],set:Se=>s[z]=Se,enumerable:!0})})}else e.exposed||(e.exposed={});C&&e.render===Ge&&(e.render=C),P!=null&&(e.inheritAttrs=P),B&&(e.components=B),Y&&(e.directives=Y),h&&Ds(e)}function ua(e,t,s=Ge){K(e)&&(e=us(e));for(const n in e){const r=e[n];let o;se(r)?"default"in r?o=Ht(r.from||n,r.default,!0):o=Ht(r.from||n):o=Ht(r),le(o)?Object.defineProperty(t,n,{enumerable:!0,configurable:!0,get:()=>o.value,set:i=>o.value=i}):t[n]=o}}function tr(e,t,s){Je(K(e)?e.map(n=>n.bind(t.proxy)):e.bind(t.proxy),t,s)}function mo(e,t,s,n){let r=n.includes(".")?lo(s,n):()=>s[n];if(ue(e)){const o=t[e];J(o)&&pn(r,o)}else if(J(e))pn(r,e.bind(s));else if(se(e))if(K(e))e.forEach(o=>mo(o,t,s,n));else{const o=J(e.handler)?e.handler.bind(s):t[e.handler];J(o)&&pn(r,o,e)}}function ho(e){const t=e.type,{mixins:s,extends:n}=t,{mixins:r,optionsCache:o,config:{optionMergeStrategies:i}}=e.appContext,a=o.get(t);let c;return a?c=a:!r.length&&!s&&!n?c=t:(c={},r.length&&r.forEach(u=>kn(c,u,i,!0)),kn(c,t,i)),se(t)&&o.set(t,c),c}function kn(e,t,s,n=!1){const{mixins:r,extends:o}=t;o&&kn(e,o,s,!0),r&&r.forEach(i=>kn(e,i,s,!0));for(const i in t)if(!(n&&i==="expose")){const a=da[i]||s&&s[i];e[i]=a?a(e[i],t[i]):t[i]}return e}const da={data:nr,props:sr,emits:sr,methods:Lt,computed:Lt,beforeCreate:ye,created:ye,beforeMount:ye,mounted:ye,beforeUpdate:ye,updated:ye,beforeDestroy:ye,beforeUnmount:ye,destroyed:ye,unmounted:ye,activated:ye,deactivated:ye,errorCaptured:ye,serverPrefetch:ye,components:Lt,directives:Lt,watch:pa,provide:nr,inject:fa};function nr(e,t){return t?e?function(){return ge(J(e)?e.call(this,this):e,J(t)?t.call(this,this):t)}:t:e}function fa(e,t){return Lt(us(e),us(t))}function us(e){if(K(e)){const t={};for(let s=0;s<e.length;s++)t[e[s]]=e[s];return t}return e}function ye(e,t){return e?[...new Set([].concat(e,t))]:t}function Lt(e,t){return e?ge(Object.create(null),e,t):t}function sr(e,t){return e?K(e)&&K(t)?[...new Set([...e,...t])]:ge(Object.create(null),er(e),er(t??{})):t}function pa(e,t){if(!e)return t;if(!t)return e;const s=ge(Object.create(null),e);for(const n in t)s[n]=ye(e[n],t[n]);return s}function _o(){return{app:null,config:{isNativeTag:Pr,performance:!1,globalProperties:{},optionMergeStrategies:{},errorHandler:void 0,warnHandler:void 0,compilerOptions:{}},mixins:[],components:{},directives:{},provides:Object.create(null),optionsCache:new WeakMap,propsCache:new WeakMap,emitsCache:new WeakMap}}let ga=0;function ma(e,t){return function(n,r=null){J(n)||(n=ge({},n)),r!=null&&!se(r)&&(r=null);const o=_o(),i=new WeakSet,a=[];let c=!1;const u=o.app={_uid:ga++,_component:n,_props:r,_container:null,_context:o,_instance:null,version:Ga,get config(){return o.config},set config(l){},use(l,...p){return i.has(l)||(l&&J(l.install)?(i.add(l),l.install(u,...p)):J(l)&&(i.add(l),l(u,...p))),u},mixin(l){return o.mixins.includes(l)||o.mixins.push(l),u},component(l,p){return p?(o.components[l]=p,u):o.components[l]},directive(l,p){return p?(o.directives[l]=p,u):o.directives[l]},mount(l,p,g){if(!c){const m=u._ceVNode||pe(n,r);return m.appContext=o,g===!0?g="svg":g===!1&&(g=void 0),e(m,l,g),c=!0,u._container=l,l.__vue_app__=u,Bn(m.component)}},onUnmount(l){a.push(l)},unmount(){c&&(Je(a,u._instance,16),e(null,u._container),delete u._container.__vue_app__)},provide(l,p){return o.provides[l]=p,u},runWithContext(l){const p=_t;_t=u;try{return l()}finally{_t=p}}};return u}}let _t=null;const ha=(e,t)=>t==="modelValue"||t==="model-value"?e.modelModifiers:e[`${t}Modifiers`]||e[`${Le(t)}Modifiers`]||e[`${dt(t)}Modifiers`];function _a(e,t,...s){if(e.isUnmounted)return;const n=e.vnode.props||re;let r=s;const o=t.startsWith("update:"),i=o&&ha(n,t.slice(7));i&&(i.trim&&(r=s.map(l=>ue(l)?l.trim():l)),i.number&&(r=s.map($n)));let a,c=n[a=Kn(t)]||n[a=Kn(Le(t))];!c&&o&&(c=n[a=Kn(dt(t))]),c&&Je(c,e,6,r);const u=n[a+"Once"];if(u){if(!e.emitted)e.emitted={};else if(e.emitted[a])return;e.emitted[a]=!0,Je(u,e,6,r)}}const ba=new WeakMap;function bo(e,t,s=!1){const n=s?ba:t.emitsCache,r=n.get(e);if(r!==void 0)return r;const o=e.emits;let i={},a=!1;if(!J(e)){const c=u=>{const l=bo(u,t,!0);l&&(a=!0,ge(i,l))};!s&&t.mixins.length&&t.mixins.forEach(c),e.extends&&c(e.extends),e.mixins&&e.mixins.forEach(c)}return!o&&!a?(se(e)&&n.set(e,null),null):(K(o)?o.forEach(c=>i[c]=null):ge(i,o),se(e)&&n.set(e,i),i)}function qn(e,t){return!e||!Dn(t)?!1:(t=t.slice(2).replace(/Once$/,""),ee(e,t[0].toLowerCase()+t.slice(1))||ee(e,dt(t))||ee(e,t))}function rr(e){const{type:t,vnode:s,proxy:n,withProxy:r,propsOptions:[o],slots:i,attrs:a,emit:c,render:u,renderCache:l,props:p,data:g,setupState:m,ctx:w,inheritAttrs:A}=e,U=Cn(e);let F,v;try{if(s.shapeFlag&4){const k=r||n,C=k;F=Ke(u.call(C,k,l,p,m,g,w)),v=a}else{const k=t;F=Ke(k.length>1?k(p,{attrs:a,slots:i,emit:c}):k(p,null)),v=t.props?a:ya(a)}}catch(k){jt.length=0,tn(k,e,1),F=pe(ut)}let D=F;if(v&&A!==!1){const k=Object.keys(v),{shapeFlag:C}=D;k.length&&C&7&&(o&&k.some(_s)&&(v=va(v,o)),D=xt(D,v,!1,!0))}return s.dirs&&(D=xt(D,null,!1,!0),D.dirs=D.dirs?D.dirs.concat(s.dirs):s.dirs),s.transition&&Es(D,s.transition),F=D,Cn(U),F}const ya=e=>{let t;for(const s in e)(s==="class"||s==="style"||Dn(s))&&((t||(t={}))[s]=e[s]);return t},va=(e,t)=>{const s={};for(const n in e)(!_s(n)||!(n.slice(9)in t))&&(s[n]=e[n]);return s};function wa(e,t,s){const{props:n,children:r,component:o}=e,{props:i,children:a,patchFlag:c}=t,u=o.emitsOptions;if(t.dirs||t.transition)return!0;if(s&&c>=0){if(c&1024)return!0;if(c&16)return n?or(n,i,u):!!i;if(c&8){const l=t.dynamicProps;for(let p=0;p<l.length;p++){const g=l[p];if(yo(i,n,g)&&!qn(u,g))return!0}}}else return(r||a)&&(!a||!a.$stable)?!0:n===i?!1:n?i?or(n,i,u):!0:!!i;return!1}function or(e,t,s){const n=Object.keys(t);if(n.length!==Object.keys(e).length)return!0;for(let r=0;r<n.length;r++){const o=n[r];if(yo(t,e,o)&&!qn(s,o))return!0}return!1}function yo(e,t,s){const n=e[s],r=t[s];return s==="style"&&se(n)&&se(r)?!Zt(n,r):n!==r}function Ca({vnode:e,parent:t},s){for(;t;){const n=t.subTree;if(n.suspense&&n.suspense.activeBranch===e&&(n.el=e.el),n===e)(e=t.vnode).el=s,t=t.parent;else break}}const vo={},wo=()=>Object.create(vo),Co=e=>Object.getPrototypeOf(e)===vo;function Aa(e,t,s,n=!1){const r={},o=wo();e.propsDefaults=Object.create(null),Ao(e,t,r,o);for(const i in e.propsOptions[0])i in r||(r[i]=void 0);s?e.props=n?r:Ai(r):e.type.props?e.props=r:e.props=o,e.attrs=o}function Sa(e,t,s,n){const{props:r,attrs:o,vnode:{patchFlag:i}}=e,a=Q(r),[c]=e.propsOptions;let u=!1;if((n||i>0)&&!(i&16)){if(i&8){const l=e.vnode.dynamicProps;for(let p=0;p<l.length;p++){let g=l[p];if(qn(e.emitsOptions,g))continue;const m=t[g];if(c)if(ee(o,g))m!==o[g]&&(o[g]=m,u=!0);else{const w=Le(g);r[w]=ds(c,a,w,m,e,!1)}else m!==o[g]&&(o[g]=m,u=!0)}}}else{Ao(e,t,r,o)&&(u=!0);let l;for(const p in a)(!t||!ee(t,p)&&((l=dt(p))===p||!ee(t,l)))&&(c?s&&(s[p]!==void 0||s[l]!==void 0)&&(r[p]=ds(c,a,p,void 0,e,!0)):delete r[p]);if(o!==a)for(const p in o)(!t||!ee(t,p))&&(delete o[p],u=!0)}u&&Ze(e.attrs,"set","")}function Ao(e,t,s,n){const[r,o]=e.propsOptions;let i=!1,a;if(t)for(let c in t){if(It(c))continue;const u=t[c];let l;r&&ee(r,l=Le(c))?!o||!o.includes(l)?s[l]=u:(a||(a={}))[l]=u:qn(e.emitsOptions,c)||(!(c in n)||u!==n[c])&&(n[c]=u,i=!0)}if(o){const c=Q(s),u=a||re;for(let l=0;l<o.length;l++){const p=o[l];s[p]=ds(r,c,p,u[p],e,!ee(u,p))}}return i}function ds(e,t,s,n,r,o){const i=e[s];if(i!=null){const a=ee(i,"default");if(a&&n===void 0){const c=i.default;if(i.type!==Function&&!i.skipFactory&&J(c)){const{propsDefaults:u}=r;if(s in u)n=u[s];else{const l=nn(r);n=u[s]=c.call(null,t),l()}}else n=c;r.ce&&r.ce._setProp(s,n)}i[0]&&(o&&!a?n=!1:i[1]&&(n===""||n===dt(s))&&(n=!0))}return n}const ka=new WeakMap;function So(e,t,s=!1){const n=s?ka:t.propsCache,r=n.get(e);if(r)return r;const o=e.props,i={},a=[];let c=!1;if(!J(e)){const l=p=>{c=!0;const[g,m]=So(p,t,!0);ge(i,g),m&&a.push(...m)};!s&&t.mixins.length&&t.mixins.forEach(l),e.extends&&l(e.extends),e.mixins&&e.mixins.forEach(l)}if(!o&&!c)return se(e)&&n.set(e,Ct),Ct;if(K(o))for(let l=0;l<o.length;l++){const p=Le(o[l]);ir(p)&&(i[p]=re)}else if(o)for(const l in o){const p=Le(l);if(ir(p)){const g=o[l],m=i[p]=K(g)||J(g)?{type:g}:ge({},g),w=m.type;let A=!1,U=!0;if(K(w))for(let F=0;F<w.length;++F){const v=w[F],D=J(v)&&v.name;if(D==="Boolean"){A=!0;break}else D==="String"&&(U=!1)}else A=J(w)&&w.name==="Boolean";m[0]=A,m[1]=U,(A||ee(m,"default"))&&a.push(p)}}const u=[i,a];return se(e)&&n.set(e,u),u}function ir(e){return e[0]!=="$"&&!It(e)}const Rs=e=>e==="_"||e==="_ctx"||e==="$stable",$s=e=>K(e)?e.map(Ke):[Ke(e)],Ta=(e,t,s)=>{if(t._n)return t;const n=Fi((...r)=>$s(t(...r)),s);return n._c=!1,n},ko=(e,t,s)=>{const n=e._ctx;for(const r in e){if(Rs(r))continue;const o=e[r];if(J(o))t[r]=Ta(r,o,n);else if(o!=null){const i=$s(o);t[r]=()=>i}}},To=(e,t)=>{const s=$s(t);e.slots.default=()=>s},xo=(e,t,s)=>{for(const n in t)(s||!Rs(n))&&(e[n]=t[n])},xa=(e,t,s)=>{const n=e.slots=wo();if(e.vnode.shapeFlag&32){const r=t._;r?(xo(n,t,s),s&&Lr(n,"_",r,!0)):ko(t,n)}else t&&To(e,t)},Ea=(e,t,s)=>{const{vnode:n,slots:r}=e;let o=!0,i=re;if(n.shapeFlag&32){const a=t._;a?s&&a===1?o=!1:xo(r,t,s):(o=!t.$stable,ko(t,r)),i=t}else t&&(To(e,t),i={default:1});if(o)for(const a in r)!Rs(a)&&i[a]==null&&delete r[a]},he=Ra;function Da(e){return Oa(e)}function Oa(e,t){const s=Ln();s.__VUE__=!0;const{insert:n,remove:r,patchProp:o,createElement:i,createText:a,createComment:c,setText:u,setElementText:l,parentNode:p,nextSibling:g,setScopeId:m=Ge,insertStaticContent:w}=e,A=(d,f,_,O=null,S=null,T=null,I=void 0,R=null,M=!!f.dynamicChildren)=>{if(d===f)return;d&&!$t(d,f)&&(O=on(d),Te(d,S,T,!0),d=null),f.patchFlag===-2&&(M=!1,f.dynamicChildren=null);const{type:x,ref:V,shapeFlag:H}=f;switch(x){case Nn:U(d,f,_,O);break;case ut:F(d,f,_,O);break;case mn:d==null&&v(f,_,O,I);break;case Ee:B(d,f,_,O,S,T,I,R,M);break;default:H&1?C(d,f,_,O,S,T,I,R,M):H&6?Y(d,f,_,O,S,T,I,R,M):(H&64||H&128)&&x.process(d,f,_,O,S,T,I,R,M,Pt)}V!=null&&S?qt(V,d&&d.ref,T,f||d,!f):V==null&&d&&d.ref!=null&&qt(d.ref,null,T,d,!0)},U=(d,f,_,O)=>{if(d==null)n(f.el=a(f.children),_,O);else{const S=f.el=d.el;f.children!==d.children&&u(S,f.children)}},F=(d,f,_,O)=>{d==null?n(f.el=c(f.children||""),_,O):f.el=d.el},v=(d,f,_,O)=>{[d.el,d.anchor]=w(d.children,f,_,O,d.el,d.anchor)},D=({el:d,anchor:f},_,O)=>{let S;for(;d&&d!==f;)S=g(d),n(d,_,O),d=S;n(f,_,O)},k=({el:d,anchor:f})=>{let _;for(;d&&d!==f;)_=g(d),r(d),d=_;r(f)},C=(d,f,_,O,S,T,I,R,M)=>{if(f.type==="svg"?I="svg":f.type==="math"&&(I="mathml"),d==null)E(f,_,O,S,T,I,R,M);else{const x=d.el&&d.el._isVueCE?d.el:null;try{x&&x._beginPatch(),h(d,f,S,T,I,R,M)}finally{x&&x._endPatch()}}},E=(d,f,_,O,S,T,I,R)=>{let M,x;const{props:V,shapeFlag:H,transition:j,dirs:G}=d;if(M=d.el=i(d.type,T,V&&V.is,V),H&8?l(M,d.children):H&16&&b(d.children,M,null,O,S,Qn(d,T),I,R),G&&ft(d,null,O,"created"),$(M,d,d.scopeId,I,O),V){for(const oe in V)oe!=="value"&&!It(oe)&&o(M,oe,null,V[oe],T,O);"value"in V&&o(M,"value",null,V.value,T),(x=V.onVnodeBeforeMount)&&je(x,O,d)}G&&ft(d,null,O,"beforeMount");const X=Pa(S,j);X&&j.beforeEnter(M),n(M,f,_),((x=V&&V.onVnodeMounted)||X||G)&&he(()=>{x&&je(x,O,d),X&&j.enter(M),G&&ft(d,null,O,"mounted")},S)},$=(d,f,_,O,S)=>{if(_&&m(d,_),O)for(let T=0;T<O.length;T++)m(d,O[T]);if(S){let T=S.subTree;if(f===T||Oo(T.type)&&(T.ssContent===f||T.ssFallback===f)){const I=S.vnode;$(d,I,I.scopeId,I.slotScopeIds,S.parent)}}},b=(d,f,_,O,S,T,I,R,M=0)=>{for(let x=M;x<d.length;x++){const V=d[x]=R?Qe(d[x]):Ke(d[x]);A(null,V,f,_,O,S,T,I,R)}},h=(d,f,_,O,S,T,I)=>{const R=f.el=d.el;let{patchFlag:M,dynamicChildren:x,dirs:V}=f;M|=d.patchFlag&16;const H=d.props||re,j=f.props||re;let G;if(_&&pt(_,!1),(G=j.onVnodeBeforeUpdate)&&je(G,_,f,d),V&&ft(f,d,_,"beforeUpdate"),_&&pt(_,!0),(H.innerHTML&&j.innerHTML==null||H.textContent&&j.textContent==null)&&l(R,""),x?L(d.dynamicChildren,x,R,_,O,Qn(f,S),T):I||z(d,f,R,null,_,O,Qn(f,S),T,!1),M>0){if(M&16)P(R,H,j,_,S);else if(M&2&&H.class!==j.class&&o(R,"class",null,j.class,S),M&4&&o(R,"style",H.style,j.style,S),M&8){const X=f.dynamicProps;for(let oe=0;oe<X.length;oe++){const ne=X[oe],Ce=H[ne],Ae=j[ne];(Ae!==Ce||ne==="value")&&o(R,ne,Ce,Ae,S,_)}}M&1&&d.children!==f.children&&l(R,f.children)}else!I&&x==null&&P(R,H,j,_,S);((G=j.onVnodeUpdated)||V)&&he(()=>{G&&je(G,_,f,d),V&&ft(f,d,_,"updated")},O)},L=(d,f,_,O,S,T,I)=>{for(let R=0;R<f.length;R++){const M=d[R],x=f[R],V=M.el&&(M.type===Ee||!$t(M,x)||M.shapeFlag&198)?p(M.el):_;A(M,x,V,null,O,S,T,I,!0)}},P=(d,f,_,O,S)=>{if(f!==_){if(f!==re)for(const T in f)!It(T)&&!(T in _)&&o(d,T,f[T],null,S,O);for(const T in _){if(It(T))continue;const I=_[T],R=f[T];I!==R&&T!=="value"&&o(d,T,R,I,S,O)}"value"in _&&o(d,"value",f.value,_.value,S)}},B=(d,f,_,O,S,T,I,R,M)=>{const x=f.el=d?d.el:a(""),V=f.anchor=d?d.anchor:a("");let{patchFlag:H,dynamicChildren:j,slotScopeIds:G}=f;G&&(R=R?R.concat(G):G),d==null?(n(x,_,O),n(V,_,O),b(f.children||[],_,V,S,T,I,R,M)):H>0&&H&64&&j&&d.dynamicChildren&&d.dynamicChildren.length===j.length?(L(d.dynamicChildren,j,_,S,T,I,R),(f.key!=null||S&&f===S.subTree)&&Ls(d,f,!0)):z(d,f,_,V,S,T,I,R,M)},Y=(d,f,_,O,S,T,I,R,M)=>{f.slotScopeIds=R,d==null?f.shapeFlag&512?S.ctx.activate(f,_,O,I,M):te(f,_,O,S,T,I,M):me(d,f,M)},te=(d,f,_,O,S,T,I)=>{const R=d.component=Wa(d,O,S);if(Os(d)&&(R.ctx.renderer=Pt),qa(R,!1,I),R.asyncDep){if(S&&S.registerDep(R,W,I),!d.el){const M=R.subTree=pe(ut);F(null,M,f,_),d.placeholder=M.el}}else W(R,d,f,_,S,T,I)},me=(d,f,_)=>{const O=f.component=d.component;if(wa(d,f,_))if(O.asyncDep&&!O.asyncResolved){q(O,f,_);return}else O.next=f,O.update();else f.el=d.el,O.vnode=f},W=(d,f,_,O,S,T,I)=>{const R=()=>{if(d.isMounted){let{next:H,bu:j,u:G,parent:X,vnode:oe}=d;{const Ne=Eo(d);if(Ne){H&&(H.el=oe.el,q(d,H,I)),Ne.asyncDep.then(()=>{he(()=>{d.isUnmounted||x()},S)});return}}let ne=H,Ce;pt(d,!1),H?(H.el=oe.el,q(d,H,I)):H=oe,j&&fn(j),(Ce=H.props&&H.props.onVnodeBeforeUpdate)&&je(Ce,X,H,oe),pt(d,!0);const Ae=rr(d),qe=d.subTree;d.subTree=Ae,A(qe,Ae,p(qe.el),on(qe),d,S,T),H.el=Ae.el,ne===null&&Ca(d,Ae.el),G&&he(G,S),(Ce=H.props&&H.props.onVnodeUpdated)&&he(()=>je(Ce,X,H,oe),S)}else{let H;const{el:j,props:G}=f,{bm:X,m:oe,parent:ne,root:Ce,type:Ae}=d,qe=Nt(f);pt(d,!1),X&&fn(X),!qe&&(H=G&&G.onVnodeBeforeMount)&&je(H,ne,f),pt(d,!0);{Ce.ce&&Ce.ce._hasShadowRoot()&&Ce.ce._injectChildStyle(Ae);const Ne=d.subTree=rr(d);A(null,Ne,_,O,d,S,T),f.el=Ne.el}if(oe&&he(oe,S),!qe&&(H=G&&G.onVnodeMounted)){const Ne=f;he(()=>je(H,ne,Ne),S)}(f.shapeFlag&256||ne&&Nt(ne.vnode)&&ne.vnode.shapeFlag&256)&&d.a&&he(d.a,S),d.isMounted=!0,f=_=O=null}};d.scope.on();const M=d.effect=new Nr(R);d.scope.off();const x=d.update=M.run.bind(M),V=d.job=M.runIfDirty.bind(M);V.i=d,V.id=d.uid,M.scheduler=()=>xs(V),pt(d,!0),x()},q=(d,f,_)=>{f.component=d;const O=d.vnode.props;d.vnode=f,d.next=null,Sa(d,f.props,O,_),Ea(d,f.children,_),nt(),Ks(d),st()},z=(d,f,_,O,S,T,I,R,M=!1)=>{const x=d&&d.children,V=d?d.shapeFlag:0,H=f.children,{patchFlag:j,shapeFlag:G}=f;if(j>0){if(j&128){ke(x,H,_,O,S,T,I,R,M);return}else if(j&256){Se(x,H,_,O,S,T,I,R,M);return}}G&8?(V&16&&Ot(x,S,T),H!==x&&l(_,H)):V&16?G&16?ke(x,H,_,O,S,T,I,R,M):Ot(x,S,T,!0):(V&8&&l(_,""),G&16&&b(H,_,O,S,T,I,R,M))},Se=(d,f,_,O,S,T,I,R,M)=>{d=d||Ct,f=f||Ct;const x=d.length,V=f.length,H=Math.min(x,V);let j;for(j=0;j<H;j++){const G=f[j]=M?Qe(f[j]):Ke(f[j]);A(d[j],G,_,null,S,T,I,R,M)}x>V?Ot(d,S,T,!0,!1,H):b(f,_,O,S,T,I,R,M,H)},ke=(d,f,_,O,S,T,I,R,M)=>{let x=0;const V=f.length;let H=d.length-1,j=V-1;for(;x<=H&&x<=j;){const G=d[x],X=f[x]=M?Qe(f[x]):Ke(f[x]);if($t(G,X))A(G,X,_,null,S,T,I,R,M);else break;x++}for(;x<=H&&x<=j;){const G=d[H],X=f[j]=M?Qe(f[j]):Ke(f[j]);if($t(G,X))A(G,X,_,null,S,T,I,R,M);else break;H--,j--}if(x>H){if(x<=j){const G=j+1,X=G<V?f[G].el:O;for(;x<=j;)A(null,f[x]=M?Qe(f[x]):Ke(f[x]),_,X,S,T,I,R,M),x++}}else if(x>j)for(;x<=H;)Te(d[x],S,T,!0),x++;else{const G=x,X=x,oe=new Map;for(x=X;x<=j;x++){const xe=f[x]=M?Qe(f[x]):Ke(f[x]);xe.key!=null&&oe.set(xe.key,x)}let ne,Ce=0;const Ae=j-X+1;let qe=!1,Ne=0;const Mt=new Array(Ae);for(x=0;x<Ae;x++)Mt[x]=0;for(x=G;x<=H;x++){const xe=d[x];if(Ce>=Ae){Te(xe,S,T,!0);continue}let Be;if(xe.key!=null)Be=oe.get(xe.key);else for(ne=X;ne<=j;ne++)if(Mt[ne-X]===0&&$t(xe,f[ne])){Be=ne;break}Be===void 0?Te(xe,S,T,!0):(Mt[Be-X]=x+1,Be>=Ne?Ne=Be:qe=!0,A(xe,f[Be],_,null,S,T,I,R,M),Ce++)}const Hs=qe?Ma(Mt):Ct;for(ne=Hs.length-1,x=Ae-1;x>=0;x--){const xe=X+x,Be=f[xe],Ws=f[xe+1],qs=xe+1<V?Ws.el||Do(Ws):O;Mt[x]===0?A(null,Be,_,qs,S,T,I,R,M):qe&&(ne<0||x!==Hs[ne]?we(Be,_,qs,2):ne--)}}},we=(d,f,_,O,S=null)=>{const{el:T,type:I,transition:R,children:M,shapeFlag:x}=d;if(x&6){we(d.component.subTree,f,_,O);return}if(x&128){d.suspense.move(f,_,O);return}if(x&64){I.move(d,f,_,Pt);return}if(I===Ee){n(T,f,_);for(let H=0;H<M.length;H++)we(M[H],f,_,O);n(d.anchor,f,_);return}if(I===mn){D(d,f,_);return}if(O!==2&&x&1&&R)if(O===0)R.beforeEnter(T),n(T,f,_),he(()=>R.enter(T),S);else{const{leave:H,delayLeave:j,afterLeave:G}=R,X=()=>{d.ctx.isUnmounted?r(T):n(T,f,_)},oe=()=>{T._isLeaving&&T[Vi](!0),H(T,()=>{X(),G&&G()})};j?j(T,X,oe):oe()}else n(T,f,_)},Te=(d,f,_,O=!1,S=!1)=>{const{type:T,props:I,ref:R,children:M,dynamicChildren:x,shapeFlag:V,patchFlag:H,dirs:j,cacheIndex:G}=d;if(H===-2&&(S=!1),R!=null&&(nt(),qt(R,null,_,d,!0),st()),G!=null&&(f.renderCache[G]=void 0),V&256){f.ctx.deactivate(d);return}const X=V&1&&j,oe=!Nt(d);let ne;if(oe&&(ne=I&&I.onVnodeBeforeUnmount)&&je(ne,f,d),V&6)jo(d.component,_,O);else{if(V&128){d.suspense.unmount(_,O);return}X&&ft(d,null,f,"beforeUnmount"),V&64?d.type.remove(d,f,_,Pt,O):x&&!x.hasOnce&&(T!==Ee||H>0&&H&64)?Ot(x,f,_,!1,!0):(T===Ee&&H&384||!S&&V&16)&&Ot(M,f,_),O&&rn(d)}(oe&&(ne=I&&I.onVnodeUnmounted)||X)&&he(()=>{ne&&je(ne,f,d),X&&ft(d,null,f,"unmounted")},_)},rn=d=>{const{type:f,el:_,anchor:O,transition:S}=d;if(f===Ee){bt(_,O);return}if(f===mn){k(d);return}const T=()=>{r(_),S&&!S.persisted&&S.afterLeave&&S.afterLeave()};if(d.shapeFlag&1&&S&&!S.persisted){const{leave:I,delayLeave:R}=S,M=()=>I(_,T);R?R(d.el,T,M):M()}else T()},bt=(d,f)=>{let _;for(;d!==f;)_=g(d),r(d),d=_;r(f)},jo=(d,f,_)=>{const{bum:O,scope:S,job:T,subTree:I,um:R,m:M,a:x}=d;ar(M),ar(x),O&&fn(O),S.stop(),T&&(T.flags|=8,Te(I,d,f,_)),R&&he(R,f),he(()=>{d.isUnmounted=!0},f)},Ot=(d,f,_,O=!1,S=!1,T=0)=>{for(let I=T;I<d.length;I++)Te(d[I],f,_,O,S)},on=d=>{if(d.shapeFlag&6)return on(d.component.subTree);if(d.shapeFlag&128)return d.suspense.next();const f=g(d.anchor||d.el),_=f&&f[uo];return _?g(_):f};let Vn=!1;const Us=(d,f,_)=>{let O;d==null?f._vnode&&(Te(f._vnode,null,null,!0),O=f._vnode.component):A(f._vnode||null,d,f,null,null,null,_),f._vnode=d,Vn||(Vn=!0,Ks(O),oo(),Vn=!1)},Pt={p:A,um:Te,m:we,r:rn,mt:te,mc:b,pc:z,pbc:L,n:on,o:e};return{render:Us,hydrate:void 0,createApp:ma(Us)}}function Qn({type:e,props:t},s){return s==="svg"&&e==="foreignObject"||s==="mathml"&&e==="annotation-xml"&&t&&t.encoding&&t.encoding.includes("html")?void 0:s}function pt({effect:e,job:t},s){s?(e.flags|=32,t.flags|=4):(e.flags&=-33,t.flags&=-5)}function Pa(e,t){return(!e||e&&!e.pendingBranch)&&t&&!t.persisted}function Ls(e,t,s=!1){const n=e.children,r=t.children;if(K(n)&&K(r))for(let o=0;o<n.length;o++){const i=n[o];let a=r[o];a.shapeFlag&1&&!a.dynamicChildren&&((a.patchFlag<=0||a.patchFlag===32)&&(a=r[o]=Qe(r[o]),a.el=i.el),!s&&a.patchFlag!==-2&&Ls(i,a)),a.type===Nn&&(a.patchFlag===-1&&(a=r[o]=Qe(a)),a.el=i.el),a.type===ut&&!a.el&&(a.el=i.el)}}function Ma(e){const t=e.slice(),s=[0];let n,r,o,i,a;const c=e.length;for(n=0;n<c;n++){const u=e[n];if(u!==0){if(r=s[s.length-1],e[r]<u){t[n]=r,s.push(n);continue}for(o=0,i=s.length-1;o<i;)a=o+i>>1,e[s[a]]<u?o=a+1:i=a;u<e[s[o]]&&(o>0&&(t[n]=s[o-1]),s[o]=n)}}for(o=s.length,i=s[o-1];o-- >0;)s[o]=i,i=t[i];return s}function Eo(e){const t=e.subTree.component;if(t)return t.asyncDep&&!t.asyncResolved?t:Eo(t)}function ar(e){if(e)for(let t=0;t<e.length;t++)e[t].flags|=8}function Do(e){if(e.placeholder)return e.placeholder;const t=e.component;return t?Do(t.subTree):null}const Oo=e=>e.__isSuspense;function Ra(e,t){t&&t.pendingBranch?K(e)?t.effects.push(...e):t.effects.push(e):Ii(e)}const Ee=Symbol.for("v-fgt"),Nn=Symbol.for("v-txt"),ut=Symbol.for("v-cmt"),mn=Symbol.for("v-stc"),jt=[];let Oe=null;function ae(e=!1){jt.push(Oe=e?null:[])}function $a(){jt.pop(),Oe=jt[jt.length-1]||null}let Yt=1;function cr(e,t=!1){Yt+=e,e<0&&Oe&&t&&(Oe.hasOnce=!0)}function Po(e){return e.dynamicChildren=Yt>0?Oe||Ct:null,$a(),Yt>0&&Oe&&Oe.push(e),e}function ce(e,t,s,n,r,o){return Po(N(e,t,s,n,r,o,!0))}function Mo(e,t,s,n,r){return Po(pe(e,t,s,n,r,!0))}function Ro(e){return e?e.__v_isVNode===!0:!1}function $t(e,t){return e.type===t.type&&e.key===t.key}const $o=({key:e})=>e??null,hn=({ref:e,ref_key:t,ref_for:s})=>(typeof e=="number"&&(e=""+e),e!=null?ue(e)||le(e)||J(e)?{i:De,r:e,k:t,f:!!s}:e:null);function N(e,t=null,s=null,n=0,r=null,o=e===Ee?0:1,i=!1,a=!1){const c={__v_isVNode:!0,__v_skip:!0,type:e,props:t,key:t&&$o(t),ref:t&&hn(t),scopeId:ao,slotScopeIds:null,children:s,component:null,suspense:null,ssContent:null,ssFallback:null,dirs:null,transition:null,el:null,anchor:null,target:null,targetStart:null,targetAnchor:null,staticCount:0,shapeFlag:o,patchFlag:n,dynamicProps:r,dynamicChildren:null,appContext:null,ctx:De};return a?(Is(c,s),o&128&&e.normalize(c)):s&&(c.shapeFlag|=ue(s)?8:16),Yt>0&&!i&&Oe&&(c.patchFlag>0||o&6)&&c.patchFlag!==32&&Oe.push(c),c}const pe=La;function La(e,t=null,s=null,n=0,r=null,o=!1){if((!e||e===go)&&(e=ut),Ro(e)){const a=xt(e,t,!0);return s&&Is(a,s),Yt>0&&!o&&Oe&&(a.shapeFlag&6?Oe[Oe.indexOf(e)]=a:Oe.push(a)),a.patchFlag=-2,a}if(Ka(e)&&(e=e.__vccOpts),t){t=Ia(t);let{class:a,style:c}=t;a&&!ue(a)&&(t.class=Fe(a)),se(c)&&(Hn(c)&&!K(c)&&(c=ge({},c)),t.style=In(c))}const i=ue(e)?1:Oo(e)?128:Bi(e)?64:se(e)?4:J(e)?2:0;return N(e,t,s,n,r,i,o,!0)}function Ia(e){return e?Hn(e)||Co(e)?ge({},e):e:null}function xt(e,t,s=!1,n=!1){const{props:r,ref:o,patchFlag:i,children:a,transition:c}=e,u=t?Fa(r||{},t):r,l={__v_isVNode:!0,__v_skip:!0,type:e.type,props:u,key:u&&$o(u),ref:t&&t.ref?s&&o?K(o)?o.concat(hn(t)):[o,hn(t)]:hn(t):o,scopeId:e.scopeId,slotScopeIds:e.slotScopeIds,children:a,target:e.target,targetStart:e.targetStart,targetAnchor:e.targetAnchor,staticCount:e.staticCount,shapeFlag:e.shapeFlag,patchFlag:t&&e.type!==Ee?i===-1?16:i|16:i,dynamicProps:e.dynamicProps,dynamicChildren:e.dynamicChildren,appContext:e.appContext,dirs:e.dirs,transition:c,component:e.component,suspense:e.suspense,ssContent:e.ssContent&&xt(e.ssContent),ssFallback:e.ssFallback&&xt(e.ssFallback),placeholder:e.placeholder,el:e.el,anchor:e.anchor,ctx:e.ctx,ce:e.ce};return c&&n&&Es(l,c.clone(l)),l}function Vt(e=" ",t=0){return pe(Nn,null,e,t)}function nu(e,t){const s=pe(mn,null,e);return s.staticCount=t,s}function _n(e="",t=!1){return t?(ae(),Mo(ut,null,e)):pe(ut,null,e)}function Ke(e){return e==null||typeof e=="boolean"?pe(ut):K(e)?pe(Ee,null,e.slice()):Ro(e)?Qe(e):pe(Nn,null,String(e))}function Qe(e){return e.el===null&&e.patchFlag!==-1||e.memo?e:xt(e)}function Is(e,t){let s=0;const{shapeFlag:n}=e;if(t==null)t=null;else if(K(t))s=16;else if(typeof t=="object")if(n&65){const r=t.default;r&&(r._c&&(r._d=!1),Is(e,r()),r._c&&(r._d=!0));return}else{s=32;const r=t._;!r&&!Co(t)?t._ctx=De:r===3&&De&&(De.slots._===1?t._=1:(t._=2,e.patchFlag|=1024))}else J(t)?(t={default:t,_ctx:De},s=32):(t=String(t),n&64?(s=16,t=[Vt(t)]):s=8);e.children=t,e.shapeFlag|=s}function Fa(...e){const t={};for(let s=0;s<e.length;s++){const n=e[s];for(const r in n)if(r==="class")t.class!==n.class&&(t.class=Fe([t.class,n.class]));else if(r==="style")t.style=In([t.style,n.style]);else if(Dn(r)){const o=t[r],i=n[r];i&&o!==i&&!(K(o)&&o.includes(i))&&(t[r]=o?[].concat(o,i):i)}else r!==""&&(t[r]=n[r])}return t}function je(e,t,s,n=null){Je(e,t,7,[s,n])}const Ua=_o();let Ha=0;function Wa(e,t,s){const n=e.type,r=(t?t.appContext:e.appContext)||Ua,o={uid:Ha++,vnode:e,type:n,parent:t,appContext:r,root:null,next:null,subTree:null,effect:null,update:null,job:null,scope:new Hr(!0),render:null,proxy:null,exposed:null,exposeProxy:null,withProxy:null,provides:t?t.provides:Object.create(r.provides),ids:t?t.ids:["",0,0],accessCache:null,renderCache:[],components:null,directives:null,propsOptions:So(n,r),emitsOptions:bo(n,r),emit:null,emitted:null,propsDefaults:re,inheritAttrs:n.inheritAttrs,ctx:re,data:re,props:re,attrs:re,slots:re,refs:re,setupState:re,setupContext:null,suspense:s,suspenseId:s?s.pendingId:0,asyncDep:null,asyncResolved:!1,isMounted:!1,isUnmounted:!1,isDeactivated:!1,bc:null,c:null,bm:null,m:null,bu:null,u:null,um:null,bum:null,da:null,a:null,rtg:null,rtc:null,ec:null,sp:null};return o.ctx={_:o},o.root=t?t.root:o,o.emit=_a.bind(null,o),e.ce&&e.ce(o),o}let fe=null;const Lo=()=>fe||De;let Tn,fs;{const e=Ln(),t=(s,n)=>{let r;return(r=e[s])||(r=e[s]=[]),r.push(n),o=>{r.length>1?r.forEach(i=>i(o)):r[0](o)}};Tn=t("__VUE_INSTANCE_SETTERS__",s=>fe=s),fs=t("__VUE_SSR_SETTERS__",s=>Et=s)}const nn=e=>{const t=fe;return Tn(e),e.scope.on(),()=>{e.scope.off(),Tn(t)}},lr=()=>{fe&&fe.scope.off(),Tn(null)};function Io(e){return e.vnode.shapeFlag&4}let Et=!1;function qa(e,t=!1,s=!1){t&&fs(t);const{props:n,children:r}=e.vnode,o=Io(e);Aa(e,n,o,t),xa(e,r,s||t);const i=o?Na(e,t):void 0;return t&&fs(!1),i}function Na(e,t){const s=e.type;e.accessCache=Object.create(null),e.proxy=new Proxy(e.ctx,ca);const{setup:n}=s;if(n){nt();const r=e.setupContext=n.length>1?ja(e):null,o=nn(e),i=en(n,e,0,[e.props,r]),a=Mr(i);if(st(),o(),(a||e.sp)&&!Nt(e)&&Ds(e),a){if(i.then(lr,lr),t)return i.then(c=>{ur(e,c)}).catch(c=>{tn(c,e,0)});e.asyncDep=i}else ur(e,i)}else Fo(e)}function ur(e,t,s){J(t)?e.type.__ssrInlineRender?e.ssrRender=t:e.render=t:se(t)&&(e.setupState=no(t)),Fo(e)}function Fo(e,t,s){const n=e.type;e.render||(e.render=n.render||Ge);{const r=nn(e);nt();try{la(e)}finally{st(),r()}}}const Ba={get(e,t){return be(e,"get",""),e[t]}};function ja(e){const t=s=>{e.exposed=s||{}};return{attrs:new Proxy(e.attrs,Ba),slots:e.slots,emit:e.emit,expose:t}}function Bn(e){return e.exposed?e.exposeProxy||(e.exposeProxy=new Proxy(no(ks(e.exposed)),{get(t,s){if(s in t)return t[s];if(s in Bt)return Bt[s](e)},has(t,s){return s in t||s in Bt}})):e.proxy}function Va(e,t=!0){return J(e)?e.displayName||e.name:e.name||t&&e.__name}function Ka(e){return J(e)&&"__vccOpts"in e}const y=(e,t)=>Pi(e,t,Et),Ga="3.5.29";/**
* @vue/runtime-dom v3.5.29
* (c) 2018-present Yuxi (Evan) You and Vue contributors
* @license MIT
**/let ps;const dr=typeof window<"u"&&window.trustedTypes;if(dr)try{ps=dr.createPolicy("vue",{createHTML:e=>e})}catch{}const Uo=ps?e=>ps.createHTML(e):e=>e,za="http://www.w3.org/2000/svg",Ja="http://www.w3.org/1998/Math/MathML",Ye=typeof document<"u"?document:null,fr=Ye&&Ye.createElement("template"),Xa={insert:(e,t,s)=>{t.insertBefore(e,s||null)},remove:e=>{const t=e.parentNode;t&&t.removeChild(e)},createElement:(e,t,s,n)=>{const r=t==="svg"?Ye.createElementNS(za,e):t==="mathml"?Ye.createElementNS(Ja,e):s?Ye.createElement(e,{is:s}):Ye.createElement(e);return e==="select"&&n&&n.multiple!=null&&r.setAttribute("multiple",n.multiple),r},createText:e=>Ye.createTextNode(e),createComment:e=>Ye.createComment(e),setText:(e,t)=>{e.nodeValue=t},setElementText:(e,t)=>{e.textContent=t},parentNode:e=>e.parentNode,nextSibling:e=>e.nextSibling,querySelector:e=>Ye.querySelector(e),setScopeId(e,t){e.setAttribute(t,"")},insertStaticContent(e,t,s,n,r,o){const i=s?s.previousSibling:t.lastChild;if(r&&(r===o||r.nextSibling))for(;t.insertBefore(r.cloneNode(!0),s),!(r===o||!(r=r.nextSibling)););else{fr.innerHTML=Uo(n==="svg"?`<svg>${e}</svg>`:n==="mathml"?`<math>${e}</math>`:e);const a=fr.content;if(n==="svg"||n==="mathml"){const c=a.firstChild;for(;c.firstChild;)a.appendChild(c.firstChild);a.removeChild(c)}t.insertBefore(a,s)}return[i?i.nextSibling:t.firstChild,s?s.previousSibling:t.lastChild]}},Ya=Symbol("_vtc");function Qa(e,t,s){const n=e[Ya];n&&(t=(t?[t,...n]:[...n]).join(" ")),t==null?e.removeAttribute("class"):s?e.setAttribute("class",t):e.className=t}const pr=Symbol("_vod"),Za=Symbol("_vsh"),ec=Symbol(""),tc=/(?:^|;)\s*display\s*:/;function nc(e,t,s){const n=e.style,r=ue(s);let o=!1;if(s&&!r){if(t)if(ue(t))for(const i of t.split(";")){const a=i.slice(0,i.indexOf(":")).trim();s[a]==null&&bn(n,a,"")}else for(const i in t)s[i]==null&&bn(n,i,"");for(const i in s)i==="display"&&(o=!0),bn(n,i,s[i])}else if(r){if(t!==s){const i=n[ec];i&&(s+=";"+i),n.cssText=s,o=tc.test(s)}}else t&&e.removeAttribute("style");pr in e&&(e[pr]=o?n.display:"",e[Za]&&(n.display="none"))}const gr=/\s*!important$/;function bn(e,t,s){if(K(s))s.forEach(n=>bn(e,t,n));else if(s==null&&(s=""),t.startsWith("--"))e.setProperty(t,s);else{const n=sc(e,t);gr.test(s)?e.setProperty(dt(n),s.replace(gr,""),"important"):e[n]=s}}const mr=["Webkit","Moz","ms"],Zn={};function sc(e,t){const s=Zn[t];if(s)return s;let n=Le(t);if(n!=="filter"&&n in e)return Zn[t]=n;n=Rn(n);for(let r=0;r<mr.length;r++){const o=mr[r]+n;if(o in e)return Zn[t]=o}return t}const hr="http://www.w3.org/1999/xlink";function _r(e,t,s,n,r,o=ei(t)){n&&t.startsWith("xlink:")?s==null?e.removeAttributeNS(hr,t.slice(6,t.length)):e.setAttributeNS(hr,t,s):s==null||o&&!Ir(s)?e.removeAttribute(t):e.setAttribute(t,o?"":ze(s)?String(s):s)}function br(e,t,s,n,r){if(t==="innerHTML"||t==="textContent"){s!=null&&(e[t]=t==="innerHTML"?Uo(s):s);return}const o=e.tagName;if(t==="value"&&o!=="PROGRESS"&&!o.includes("-")){const a=o==="OPTION"?e.getAttribute("value")||"":e.value,c=s==null?e.type==="checkbox"?"on":"":String(s);(a!==c||!("_value"in e))&&(e.value=c),s==null&&e.removeAttribute(t),e._value=s;return}let i=!1;if(s===""||s==null){const a=typeof e[t];a==="boolean"?s=Ir(s):s==null&&a==="string"?(s="",i=!0):a==="number"&&(s=0,i=!0)}try{e[t]=s}catch{}i&&e.removeAttribute(r||t)}function mt(e,t,s,n){e.addEventListener(t,s,n)}function rc(e,t,s,n){e.removeEventListener(t,s,n)}const yr=Symbol("_vei");function oc(e,t,s,n,r=null){const o=e[yr]||(e[yr]={}),i=o[t];if(n&&i)i.value=n;else{const[a,c]=ic(t);if(n){const u=o[t]=lc(n,r);mt(e,a,u,c)}else i&&(rc(e,a,i,c),o[t]=void 0)}}const vr=/(?:Once|Passive|Capture)$/;function ic(e){let t;if(vr.test(e)){t={};let n;for(;n=e.match(vr);)e=e.slice(0,e.length-n[0].length),t[n[0].toLowerCase()]=!0}return[e[2]===":"?e.slice(3):dt(e.slice(2)),t]}let es=0;const ac=Promise.resolve(),cc=()=>es||(ac.then(()=>es=0),es=Date.now());function lc(e,t){const s=n=>{if(!n._vts)n._vts=Date.now();else if(n._vts<=s.attached)return;Je(uc(n,s.value),t,5,[n])};return s.value=e,s.attached=cc(),s}function uc(e,t){if(K(t)){const s=e.stopImmediatePropagation;return e.stopImmediatePropagation=()=>{s.call(e),e._stopped=!0},t.map(n=>r=>!r._stopped&&n&&n(r))}else return t}const wr=e=>e.charCodeAt(0)===111&&e.charCodeAt(1)===110&&e.charCodeAt(2)>96&&e.charCodeAt(2)<123,dc=(e,t,s,n,r,o)=>{const i=r==="svg";t==="class"?Qa(e,n,i):t==="style"?nc(e,s,n):Dn(t)?_s(t)||oc(e,t,s,n,o):(t[0]==="."?(t=t.slice(1),!0):t[0]==="^"?(t=t.slice(1),!1):fc(e,t,n,i))?(br(e,t,n),!e.tagName.includes("-")&&(t==="value"||t==="checked"||t==="selected")&&_r(e,t,n,i,o,t!=="value")):e._isVueCE&&(/[A-Z]/.test(t)||!ue(n))?br(e,Le(t),n,o,t):(t==="true-value"?e._trueValue=n:t==="false-value"&&(e._falseValue=n),_r(e,t,n,i))};function fc(e,t,s,n){if(n)return!!(t==="innerHTML"||t==="textContent"||t in e&&wr(t)&&J(s));if(t==="spellcheck"||t==="draggable"||t==="translate"||t==="autocorrect"||t==="sandbox"&&e.tagName==="IFRAME"||t==="form"||t==="list"&&e.tagName==="INPUT"||t==="type"&&e.tagName==="TEXTAREA")return!1;if(t==="width"||t==="height"){const r=e.tagName;if(r==="IMG"||r==="VIDEO"||r==="CANVAS"||r==="SOURCE")return!1}return wr(t)&&ue(s)?!1:t in e}const xn=e=>{const t=e.props["onUpdate:modelValue"]||!1;return K(t)?s=>fn(t,s):t};function pc(e){e.target.composing=!0}function Cr(e){const t=e.target;t.composing&&(t.composing=!1,t.dispatchEvent(new Event("input")))}const kt=Symbol("_assign");function Ar(e,t,s){return t&&(e=e.trim()),s&&(e=$n(e)),e}const su={created(e,{modifiers:{lazy:t,trim:s,number:n}},r){e[kt]=xn(r);const o=n||r.props&&r.props.type==="number";mt(e,t?"change":"input",i=>{i.target.composing||e[kt](Ar(e.value,s,o))}),(s||o)&&mt(e,"change",()=>{e.value=Ar(e.value,s,o)}),t||(mt(e,"compositionstart",pc),mt(e,"compositionend",Cr),mt(e,"change",Cr))},mounted(e,{value:t}){e.value=t??""},beforeUpdate(e,{value:t,oldValue:s,modifiers:{lazy:n,trim:r,number:o}},i){if(e[kt]=xn(i),e.composing)return;const a=(o||e.type==="number")&&!/^0\d/.test(e.value)?$n(e.value):e.value,c=t??"";a!==c&&(document.activeElement===e&&e.type!=="range"&&(n&&t===s||r&&e.value.trim()===c)||(e.value=c))}},ru={deep:!0,created(e,{value:t,modifiers:{number:s}},n){const r=On(t);mt(e,"change",()=>{const o=Array.prototype.filter.call(e.options,i=>i.selected).map(i=>s?$n(En(i)):En(i));e[kt](e.multiple?r?new Set(o):o:o[0]),e._assigning=!0,Ts(()=>{e._assigning=!1})}),e[kt]=xn(n)},mounted(e,{value:t}){Sr(e,t)},beforeUpdate(e,t,s){e[kt]=xn(s)},updated(e,{value:t}){e._assigning||Sr(e,t)}};function Sr(e,t){const s=e.multiple,n=K(t);if(!(s&&!n&&!On(t))){for(let r=0,o=e.options.length;r<o;r++){const i=e.options[r],a=En(i);if(s)if(n){const c=typeof a;c==="string"||c==="number"?i.selected=t.some(u=>String(u)===String(a)):i.selected=ni(t,a)>-1}else i.selected=t.has(a);else if(Zt(En(i),t)){e.selectedIndex!==r&&(e.selectedIndex=r);return}}!s&&e.selectedIndex!==-1&&(e.selectedIndex=-1)}}function En(e){return"_value"in e?e._value:e.value}const gc=["ctrl","shift","alt","meta"],mc={stop:e=>e.stopPropagation(),prevent:e=>e.preventDefault(),self:e=>e.target!==e.currentTarget,ctrl:e=>!e.ctrlKey,shift:e=>!e.shiftKey,alt:e=>!e.altKey,meta:e=>!e.metaKey,left:e=>"button"in e&&e.button!==0,middle:e=>"button"in e&&e.button!==1,right:e=>"button"in e&&e.button!==2,exact:(e,t)=>gc.some(s=>e[`${s}Key`]&&!t.includes(s))},hc=(e,t)=>{if(!e)return e;const s=e._withMods||(e._withMods={}),n=t.join(".");return s[n]||(s[n]=(r,...o)=>{for(let i=0;i<t.length;i++){const a=mc[t[i]];if(a&&a(r,t))return}return e(r,...o)})},_c={esc:"escape",space:" ",up:"arrow-up",left:"arrow-left",right:"arrow-right",down:"arrow-down",delete:"backspace"},ou=(e,t)=>{const s=e._withKeys||(e._withKeys={}),n=t.join(".");return s[n]||(s[n]=r=>{if(!("key"in r))return;const o=dt(r.key);if(t.some(i=>i===o||_c[i]===o))return e(r)})},bc=ge({patchProp:dc},Xa);let kr;function yc(){return kr||(kr=Da(bc))}const vc=(...e)=>{const t=yc().createApp(...e),{mount:s}=t;return t.mount=n=>{const r=Cc(n);if(!r)return;const o=t._component;!J(o)&&!o.render&&!o.template&&(o.template=r.innerHTML),r.nodeType===1&&(r.textContent="");const i=s(r,!1,wc(r));return r instanceof Element&&(r.removeAttribute("v-cloak"),r.setAttribute("data-v-app","")),i},t};function wc(e){if(e instanceof SVGElement)return"svg";if(typeof MathMLElement=="function"&&e instanceof MathMLElement)return"mathml"}function Cc(e){return ue(e)?document.querySelector(e):e}/*!
 * pinia v3.0.4
 * (c) 2025 Eduardo San Martin Morote
 * @license MIT
 */let Ho;const jn=e=>Ho=e,Wo=Symbol();function gs(e){return e&&typeof e=="object"&&Object.prototype.toString.call(e)==="[object Object]"&&typeof e.toJSON!="function"}var Kt;(function(e){e.direct="direct",e.patchObject="patch object",e.patchFunction="patch function"})(Kt||(Kt={}));function Ac(){const e=Wr(!0),t=e.run(()=>Z({}));let s=[],n=[];const r=ks({install(o){jn(r),r._a=o,o.provide(Wo,r),o.config.globalProperties.$pinia=r,n.forEach(i=>s.push(i)),n=[]},use(o){return this._a?s.push(o):n.push(o),this},_p:s,_a:null,_e:e,_s:new Map,state:t});return r}const qo=()=>{};function Tr(e,t,s,n=qo){e.add(t);const r=()=>{e.delete(t)&&n()};return!s&&qr()&&si(r),r}function vt(e,...t){e.forEach(s=>{s(...t)})}const Sc=e=>e(),xr=Symbol(),ts=Symbol();function ms(e,t){e instanceof Map&&t instanceof Map?t.forEach((s,n)=>e.set(n,s)):e instanceof Set&&t instanceof Set&&t.forEach(e.add,e);for(const s in t){if(!t.hasOwnProperty(s))continue;const n=t[s],r=e[s];gs(r)&&gs(n)&&e.hasOwnProperty(s)&&!le(n)&&!tt(n)?e[s]=ms(r,n):e[s]=n}return e}const kc=Symbol();function Tc(e){return!gs(e)||!Object.prototype.hasOwnProperty.call(e,kc)}const{assign:it}=Object;function xc(e){return!!(le(e)&&e.effect)}function Ec(e,t,s,n){const{state:r,actions:o,getters:i}=t,a=s.state.value[e];let c;function u(){a||(s.state.value[e]=r?r():{});const l=xi(s.state.value[e]);return it(l,o,Object.keys(i||{}).reduce((p,g)=>(p[g]=ks(y(()=>{jn(s);const m=s._s.get(e);return i[g].call(m,m)})),p),{}))}return c=No(e,u,t,s,n,!0),c}function No(e,t,s={},n,r,o){let i;const a=it({actions:{}},s),c={deep:!0};let u,l,p=new Set,g=new Set,m;const w=n.state.value[e];!o&&!w&&(n.state.value[e]={});let A;function U(b){let h;u=l=!1,typeof b=="function"?(b(n.state.value[e]),h={type:Kt.patchFunction,storeId:e,events:m}):(ms(n.state.value[e],b),h={type:Kt.patchObject,payload:b,storeId:e,events:m});const L=A=Symbol();Ts().then(()=>{A===L&&(u=!0)}),l=!0,vt(p,h,n.state.value[e])}const F=o?function(){const{state:h}=s,L=h?h():{};this.$patch(P=>{it(P,L)})}:qo;function v(){i.stop(),p.clear(),g.clear(),n._s.delete(e)}const D=(b,h="")=>{if(xr in b)return b[ts]=h,b;const L=function(){jn(n);const P=Array.from(arguments),B=new Set,Y=new Set;function te(q){B.add(q)}function me(q){Y.add(q)}vt(g,{args:P,name:L[ts],store:C,after:te,onError:me});let W;try{W=b.apply(this&&this.$id===e?this:C,P)}catch(q){throw vt(Y,q),q}return W instanceof Promise?W.then(q=>(vt(B,q),q)).catch(q=>(vt(Y,q),Promise.reject(q))):(vt(B,W),W)};return L[xr]=!0,L[ts]=h,L},k={_p:n,$id:e,$onAction:Tr.bind(null,g),$patch:U,$reset:F,$subscribe(b,h={}){const L=Tr(p,b,h.detached,()=>P()),P=i.run(()=>pn(()=>n.state.value[e],B=>{(h.flush==="sync"?l:u)&&b({storeId:e,type:Kt.direct,events:m},B)},it({},c,h)));return L},$dispose:v},C=Un(k);n._s.set(e,C);const $=(n._a&&n._a.runWithContext||Sc)(()=>n._e.run(()=>(i=Wr()).run(()=>t({action:D}))));for(const b in $){const h=$[b];if(le(h)&&!xc(h)||tt(h))o||(w&&Tc(h)&&(le(h)?h.value=w[b]:ms(h,w[b])),n.state.value[e][b]=h);else if(typeof h=="function"){const L=D(h,b);$[b]=L,a.actions[b]=h}}return it(C,$),it(Q(C),$),Object.defineProperty(C,"$state",{get:()=>n.state.value[e],set:b=>{U(h=>{it(h,b)})}}),n._p.forEach(b=>{it(C,i.run(()=>b({store:C,app:n._a,pinia:n,options:a})))}),w&&o&&s.hydrate&&s.hydrate(C.$state,w),u=!0,l=!0,C}/*! #__NO_SIDE_EFFECTS__ */function Fs(e,t,s){let n;const r=typeof t=="function";n=r?s:t;function o(i,a){const c=Hi();return i=i||(c?Ht(Wo,null):null),i&&jn(i),i=Ho,i._s.has(e)||(r?No(e,t,n,i):Ec(e,n,i)),i._s.get(e)}return o.$id=e,o}const Dt={1:{title:"Day 1 - 点击计数器",subtitle:"点击计数器/ClickCounter",concepts:["function","increment","uint256","contract"]},2:{title:"Day 2 - 保存名字",subtitle:"保存名字/SaveMyName",concepts:["string","private","memory","view","parameters","returns"]},3:{title:"Day 3 - 投票站",subtitle:"投票站/PollStation",concepts:["array","mapping","push","compound_assignment"]},4:{title:"Day 4 - 拍卖行",subtitle:"拍卖行/AuctionHouse",concepts:["constructor","msg_sender","block_timestamp","require","external","address_type","bool_type"]},5:{title:"Day 5 - 管理员权限",subtitle:"管理员权限/AdminOnly",concepts:["modifier","zero_address","return_statement"]},6:{title:"Day 6 - 以太坊银行",subtitle:"以太坊银行/EtherPiggyBank",concepts:["address_mapping_balance","payable","msg_value","wei_unit","ether_deposit_withdraw"]},7:{title:"Day 7 - 朋友借条",subtitle:"朋友借条/SimpleIOU",concepts:["nested_mapping","address_payable","debt_tracking","internal_transfer","transfer_method","call_method","withdraw_pattern"]},8:{title:"Day 8 - 打赏罐",subtitle:"打赏罐/TipJar",concepts:["modifier_onlyOwner","payable_tip","msg_value_tip","address_balance","call_withdraw","mapping_rates"]},9:{title:"Day 9 - 跨合约调用",subtitle:"跨合约调用/InterContract",concepts:["pure_function","view_function","cross_contract_call","interface_call","low_level_call","modifier_onlyOwner","newton_iteration","contract_composition"]},10:{title:"Day 10 - 健身追踪器",subtitle:"健身追踪器/ActivityTracker",concepts:["struct_definition","array_in_mapping","multiple_mappings","storage_keyword","event_logging","milestone_detection","timestamp_usage","onlyRegistered_modifier"]},11:{title:"Day 11 - 主密钥保险库",subtitle:"合约继承与所有权/MasterkeyVault",concepts:["inheritance","import_statement","constructor","private_visibility","event_logging","indexed_parameter","transfer_ownership","onlyOwner_modifier"]},12:{title:"Day 12 - ERC20 代币标准",subtitle:"ERC20代币/Web3Compass",concepts:["erc20_standard","mapping_nested","event","transfer","approve","allowance","transferFrom"]}},iu=e=>e===1?`//SPDx-License-Identifier:MIT

// 声明Solidity版本，要求编译器版本在0.8.0或更高（但低于0.9.0）
pragma solidity ^0.8.0;

// 定义一个名为clickcounter的合约（相当于其他语言中的类）
contract clickcounter {
    // 声明一个无符号256位整数类型的状态变量counter
    // public关键字表示这个变量可以被外部访问，编译器会自动生成getter函数
    uint256 public counter;

    // 定义一个名为click的公共函数
    // public表示任何人都可以调用这个函数
    function click() public {
        // 将counter的值加1（自增操作）
        counter++;
    }
}`:e===2?`// SPDX-License-Identifier:MIT

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

}`:e===3?`// SPDX-License-Identifier:MIT

// 声明Solidity版本，要求编译器版本在0.8.0或更高（但低于0.9.0）
pragma solidity ^0.8.0;

// 定义一个名为PollStation的合约，用于管理投票
contract PollStation{
    // 声明一个公共字符串数组，用于存储候选人姓名
    // public关键字表示外部可以访问，编译器会自动生成getter函数
    string[] public candidateNames;
    
    // 声明一个映射，用于存储每个候选人的得票数
    // 映射类型：键是字符串（候选人姓名），值是uint256（票数）
    mapping(string => uint256) voteCount;

    // 定义一个名为addCandidateNames的公共函数，用于添加候选人
    // memory关键字表示参数数据存储在内存中（临时存储）
    function addCandidateNames(string memory _candidateNames) public{
        // 使用push方法将候选人姓名添加到数组末尾
        candidateNames.push(_candidateNames);
        
        // 初始化该候选人的票数为0
        voteCount[_candidateNames] = 0;
    }

    // 定义一个名为vote的公共函数，用于投票
    function vote(string memory _candidateNames) public{
        // 使用复合赋值运算符+=，将指定候选人的票数加1
        // 等同于：voteCount[_candidateNames] = voteCount[_candidateNames] + 1;
        voteCount[_candidateNames] += 1;
    }

    // 定义一个名为getVoteCount的公共视图函数，用于获取候选人的票数
    // view关键字表示该函数只读取状态变量，不修改任何状态（不消耗gas）
    function getVoteCount(string memory _candidateNames) public view returns (uint256){
        // 返回指定候选人的票数
        return voteCount[_candidateNames];
    }
}`:e===4?`// SPDX-License-Identifier: MIT
// 声明Solidity版本，要求编译器版本在0.8.0或更高（但低于0.9.0）
pragma solidity ^0.8.0;

// 定义一个名为AuctionHouse的合约，用于拍卖行功能
contract AuctionHouse {
    // 声明公共地址变量，存储拍卖行的所有者地址
    address public owner;
    
    // 声明公共字符串变量，存储拍卖物品的名称
    string public item;
    
    // 声明公共无符号整数，存储拍卖结束时间戳
    uint public auctionEndTime;
    
    // 声明私有地址变量，存储最高出价者的地址
    // private 表示只能在这个合约内部访问，外部无法直接读取
    address private highestBidder; // 获胜者是私有的，可以通过getWinner函数访问
    
    // 声明私有无符号整数，存储最高出价金额
    uint private highestBid;       // 最高出价是私有的，可以通过getWinner函数访问
    
    // 声明公共布尔变量，标记拍卖是否已结束
    bool public ended;

    // 声明映射，存储每个地址（竞拍者）的出价金额
    // 键是地址类型，值是无符号整数
    mapping(address => uint) public bids;
    
    // 声明地址数组，存储所有参与竞拍的地址
    address[] public bidders;

    // 构造函数：在合约部署时执行一次，用于初始化合约状态
    // 参数：_item是拍卖物品名称，_biddingTime是拍卖持续时间（秒）
    constructor(string memory _item, uint _biddingTime) {
        // 将部署合约的地址（发送者）设置为所有者
        owner = msg.sender;
        
        // 设置拍卖物品名称
        item = _item;
        
        // 设置拍卖结束时间：当前区块时间戳 + 拍卖持续时间
        // block.timestamp 是当前区块的时间戳（Unix时间，秒）
        auctionEndTime = block.timestamp + _biddingTime;
    }

    // 允许用户出价的函数
    // external 表示函数只能从合约外部调用（比public更省gas）
    function bid(uint amount) external {
        // require是条件检查函数，如果条件为false则回滚交易并显示错误信息
        // 检查当前时间是否早于拍卖结束时间，确保拍卖未结束
        require(block.timestamp < auctionEndTime, "Auction has already ended.");
        
        // 检查出价金额是否大于0
        require(amount > 0, "Bid amount must be greater than zero.");
        
        // 检查新出价是否高于该竞拍者当前的出价
        require(amount > bids[msg.sender], "New bid must be higher than your current bid.");

        // 如果该竞拍者之前没有出价（出价为0），则将其添加到竞拍者数组
        if (bids[msg.sender] == 0) {
            bidders.push(msg.sender);
        }

        // 更新该竞拍者的出价金额
        bids[msg.sender] = amount;

        // 如果新出价高于当前最高出价，则更新最高出价和最高出价者
        if (amount > highestBid) {
            highestBid = amount;
            highestBidder = msg.sender;
        }
    }

    // 结束拍卖的函数（只能在拍卖时间结束后调用）
    function endAuction() external {
        // 检查当前时间是否已达到或超过拍卖结束时间
        require(block.timestamp >= auctionEndTime, "Auction hasn't ended yet.");
        
        // 检查拍卖是否已经结束（防止重复调用）
        require(!ended, "Auction end already called.");

        // 将ended标记设置为true，表示拍卖已结束
        ended = true;
    }

    // 获取所有竞拍者列表的函数
    function getAllBidders() external view returns (address[] memory) {
        // 返回竞拍者地址数组
        return bidders;
    }

    // 获取拍卖获胜者和其出价的函数（仅在拍卖结束后可调用）
    function getWinner() external view returns (address, uint) {
        // 检查拍卖是否已结束
        require(ended, "Auction has not ended yet.");
        
        // 返回最高出价者的地址和最高出价金额
        return (highestBidder, highestBid);
    }
}`:e===5?`// SPDX-License-Identifier: MIT
// 声明Solidity版本，要求编译器版本在0.8.0或更高（但低于0.9.0）
pragma solidity ^0.8.0;

// 定义一个名为AdminOnly的合约，用于管理员权限控制的宝库管理
contract AdminOnly {
    // 状态变量区域
    
    // 声明公共地址变量，存储合约所有者的地址
    address public owner;
    
    // 声明公共无符号整数，存储宝库中的宝藏数量
    uint256 public treasureAmount;
    
    // 声明映射，存储每个地址的提款额度
    // 键是地址，值是该地址允许提取的宝藏数量
    mapping(address => uint256) public withdrawalAllowance;
    
    // 声明映射，记录每个地址是否已经提取过宝藏
    // 键是地址，值是布尔值（true表示已提取，false表示未提取）
    mapping(address => bool) public hasWithdrawn;
    
    // 构造函数：合约部署时执行一次，将部署者设置为所有者
    constructor() {
        owner = msg.sender;
    }
    
    // 修饰符：用于限制只有所有者才能调用某些函数
    // modifier 可以理解为函数的"前置条件检查"
    modifier onlyOwner() {
        // 检查调用者是否为所有者，如果不是则回滚交易并显示错误信息
        require(msg.sender == owner, "Access denied: Only the owner can perform this action");
        
        // _; 表示执行修饰符后的函数体
        // 这是修饰符的语法，表示"通过检查后，继续执行被修饰的函数"
        _;
    }
    
    // 添加宝藏函数：只有所有者可以调用
    // onlyOwner 修饰符确保只有所有者能执行此函数
    function addTreasure(uint256 amount) public onlyOwner {
        // 将指定数量的宝藏添加到宝库中
        treasureAmount += amount;
    }
    
    // 批准提款函数：只有所有者可以调用，用于给用户分配提款额度
    function approveWithdrawal(address recipient, uint256 amount) public onlyOwner {
        // 检查批准的额度是否不超过宝库中现有的宝藏数量
        require(amount <= treasureAmount, "Not enough treasure available");
        
        // 为指定地址设置提款额度
        withdrawalAllowance[recipient] = amount;
    }
    
    
    // 提取宝藏函数：任何人都可以调用，但只有有额度且未提取过的用户才能成功
    function withdrawTreasure(uint256 amount) public {

        // 如果调用者是所有者，允许直接提取任意数量（在宝库范围内）
        if(msg.sender == owner){
            // 检查提取数量是否不超过宝库现有数量
            require(amount <= treasureAmount, "Not enough treasury available for this action.");
            
            // 从宝库中扣除指定数量的宝藏
            treasureAmount-= amount;

            // 直接返回，不执行后面的普通用户提款逻辑
            return;
        }
        
        // 获取调用者的提款额度
        uint256 allowance = withdrawalAllowance[msg.sender];
        
        // 检查用户是否有提款额度（额度必须大于0）
        require(allowance > 0, "You don't have any treasure allowance");
        
        // 检查用户是否已经提取过宝藏（不能重复提取）
        require(!hasWithdrawn[msg.sender], "You have already withdrawn your treasure");
        
        // 检查宝库中是否有足够的宝藏
        require(allowance <= treasureAmount, "Not enough treasure in the chest");
        
        // 检查用户尝试提取的数量是否不超过其允许的额度
        require(allowance >= amount, "Cannot withdraw more than you are allowed");
        
        // 标记该用户已经提取过宝藏
        hasWithdrawn[msg.sender] = true;
        
        // 从宝库中扣除用户额度对应的宝藏数量
        treasureAmount -= allowance;
        
        // 将用户的提款额度清零
        withdrawalAllowance[msg.sender] = 0;
        
    }
    
    // 重置提款状态函数：只有所有者可以调用，用于重置某个用户的提款状态
    function resetWithdrawalStatus(address user) public onlyOwner {
        // 将指定用户的提款状态重置为false（允许再次提取）
        hasWithdrawn[user] = false;
    }
    
    // 转移所有权函数：只有所有者可以调用，用于将合约所有权转移给新所有者
    function transferOwnership(address newOwner) public onlyOwner {
        // 检查新所有者地址是否有效（不能是零地址）
        // address(0) 表示零地址，是一个无效的地址
        require(newOwner != address(0), "Invalid address");
        
        // 将所有者更新为新地址
        owner = newOwner;
    }
    
    // 获取宝藏详情函数：只有所有者可以调用，查看宝库中的宝藏数量
    function getTreasureDetails() public view onlyOwner returns (uint256) {
        // 返回宝库中的宝藏数量
        return treasureAmount;
    }
}`:e===6?`// SPDX-License-Identifier: MIT

// 声明Solidity版本，要求编译器版本在0.8.0或更高（但低于0.9.0）
pragma solidity ^0.8.0;

// 定义一个名为EtherPiggyBank的合约，用于以太坊存钱罐银行功能
contract EtherPiggyBank{

    // 状态变量区域
    
    // 声明银行管理员的地址
    // 银行管理员具有特殊权限，可以添加新成员
    address public bankManager;
    
    // 声明地址数组，存储所有已注册的会员地址
    address[] members;
    
    // 声明映射，记录每个地址是否已注册为会员
    // 键是地址，值是布尔值（true表示已注册，false表示未注册）
    mapping(address => bool) public registeredMembers;
    
    // 声明映射，记录每个地址的账户余额
    // 键是地址，值是该地址的余额（以wei为单位）
    mapping(address => uint256) balance;

    // 构造函数：合约部署时执行一次，初始化银行管理员
    constructor(){
        // 将部署合约的地址设置为银行管理员
        bankManager = msg.sender;
        
        // 将银行管理员添加到会员数组中（管理员默认是会员）
        members.push(msg.sender);
    }

    // 修饰符：限制只有银行管理员才能调用某些函数
    modifier onlyBankManager(){
        // 检查调用者是否为银行管理员，如果不是则回滚交易
        require(msg.sender == bankManager, "Only bank manager can perform this action");
        
        // 继续执行被修饰的函数
        _;
    }

    // 修饰符：限制只有已注册的会员才能调用某些函数
    modifier onlyRegisteredMember() {
        // 检查调用者是否为已注册的会员，如果不是则回滚交易
        require(registeredMembers[msg.sender], "Member not registered");
        
        // 继续执行被修饰的函数
        _;
    }
  
    // 添加会员函数：只有银行管理员可以调用，用于添加新会员
    function addMembers(address _member)public onlyBankManager{
        // 检查新会员地址是否有效（不能是零地址）
        require(_member != address(0), "Invalid address");
        
        // 检查是否尝试添加银行管理员本人（管理员已经是会员）
        require(_member != msg.sender, "Bank Manager is already a member");
        
        // 检查该地址是否已经是注册会员
        require(!registeredMembers[_member], "Member already registered");
        
        // 将该地址标记为已注册会员
        registeredMembers[_member] = true;
        
        // 将该地址添加到会员数组中
        members.push(_member);
    }

    // 获取会员列表函数：任何人都可以调用，返回所有会员地址
    function getMembers() public view returns(address[] memory){
        // 返回会员地址数组
        return members;
    }
    
    // 存入以太币函数：只有已注册会员可以调用
    // payable 关键字表示该函数可以接收以太币
    function depositAmountEther() public payable onlyRegisteredMember{  
        // 检查发送的以太币数量是否大于0
        // msg.value 是调用函数时发送的以太币数量（以wei为单位）
        require(msg.value > 0, "Invalid amount");
        
        // 将发送的以太币数量累加到调用者的余额中
        balance[msg.sender] = balance[msg.sender]+msg.value;
   
    }
    
    // 提取金额函数：只有已注册会员可以调用，用于提取余额
    function withdrawAmount(uint256 _amount) public onlyRegisteredMember{
        // 检查提取金额是否大于0
        require(_amount > 0, "Invalid amount");
        
        // 检查调用者的余额是否足够
        require(balance[msg.sender] >= _amount, "Insufficient balance");
        
        // 从调用者的余额中扣除提取的金额
        balance[msg.sender] = balance[msg.sender]-_amount;
   
    }

    // 获取余额函数：任何人都可以调用，查询指定会员的余额
    function getBalance(address _member) public view returns (uint256){
        // 检查查询的地址是否有效
        require(_member != address(0), "Invalid address");
        
        // 返回指定会员的余额
        return balance[_member];
    } 
}`:e===7?`//SPDX-License-Identifier: MIT

// 声明Solidity版本，要求编译器版本在0.8.0或更高（但低于0.9.0）
pragma solidity ^0.8.0;

// 定义一个名为SimpleIOU的合约，用于朋友间的借条（IOU）管理
contract SimpleIOU{
    // 声明合约所有者的地址
    address public owner;
    
    // 跟踪已注册的朋友
    // 映射：地址 -> 是否已注册（布尔值）
    mapping(address => bool) public registeredFriends;
    
    // 地址数组：存储所有已注册朋友的地址列表
    address[] public friendList;
    
    // 跟踪每个朋友的余额
    // 映射：地址 -> 余额（以太币数量）
    mapping(address => uint256) public balances;
    
    // 简单的债务跟踪系统
    // 嵌套映射：债务人地址 -> 债权人地址 -> 欠款金额
    // 映射结构：mapping(键1 => mapping(键2 => 值))
    mapping(address => mapping(address => uint256)) public debts; // 债务人 -> 债权人 -> 金额
    
    // 构造函数：合约部署时执行一次，初始化合约
    constructor() {
        // 将部署合约的地址设置为所有者
        owner = msg.sender;
        
        // 将所有者注册为朋友（所有者默认是已注册用户）
        registeredFriends[msg.sender] = true;
        
        // 将所有者添加到朋友列表中
        friendList.push(msg.sender);
    }
    
    // 修饰符：限制只有所有者才能调用某些函数
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }
    
    // 修饰符：限制只有已注册的朋友才能调用某些函数
    modifier onlyRegistered() {
        require(registeredFriends[msg.sender], "You are not registered");
        _;
    }
    
    // 添加新朋友函数：只有所有者可以调用，用于注册新朋友
    function addFriend(address _friend) public onlyOwner {
        // 检查朋友地址是否有效（不能是零地址）
        require(_friend != address(0), "Invalid address");
        
        // 检查该朋友是否已经注册
        require(!registeredFriends[_friend], "Friend already registered");
        
        // 将该地址标记为已注册朋友
        registeredFriends[_friend] = true;
        
        // 将该地址添加到朋友列表中
        friendList.push(_friend);
    }
    
    // 存款函数：将以太币存入你的钱包余额
    // payable 关键字表示该函数可以接收以太币
    function depositIntoWallet() public payable onlyRegistered {
        // 检查是否发送了以太币
        require(msg.value > 0, "Must send ETH");
        
        // 将发送的以太币数量累加到调用者的余额中
        balances[msg.sender] += msg.value;
    }
    
    // 记录债务函数：记录某人欠你钱
    function recordDebt(address _debtor, uint256 _amount) public onlyRegistered {
        // 检查债务人地址是否有效
        require(_debtor != address(0), "Invalid address");
        
        // 检查债务人是否已注册
        require(registeredFriends[_debtor], "Address not registered");
        
        // 检查金额是否大于0
        require(_amount > 0, "Amount must be greater than 0");
        
        // 记录债务：在嵌套映射中增加债务金额
        // 结构：debts[债务人][债权人] += 金额
        debts[_debtor][msg.sender] += _amount;
    }
    
    // 使用内部余额转账偿还债务
    function payFromWallet(address _creditor, uint256 _amount) public onlyRegistered {
        // 检查债权人地址是否有效
        require(_creditor != address(0), "Invalid address");
        
        // 检查债权人是否已注册
        require(registeredFriends[_creditor], "Creditor not registered");
        
        // 检查金额是否大于0
        require(_amount > 0, "Amount must be greater than 0");
        
        // 检查债务金额是否足够
        require(debts[msg.sender][_creditor] >= _amount, "Debt amount incorrect");
        
        // 检查余额是否足够
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        
        // 更新余额和债务
        // 从债务人的余额中扣除金额
        balances[msg.sender] -= _amount;
        
        // 将金额添加到债权人的余额中
        balances[_creditor] += _amount;
        
        // 从债务记录中减少债务金额
        debts[msg.sender][_creditor] -= _amount;
    }
    
    // 直接转账方法：使用 transfer() 方法进行以太币转账
    function transferEther(address payable _to, uint256 _amount) public onlyRegistered {
        // 检查接收者地址是否有效
        require(_to != address(0), "Invalid address");
        
        // 检查接收者是否已注册
        require(registeredFriends[_to], "Recipient not registered");
        
        // 检查余额是否足够
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        
        // 从发送者的余额中扣除金额
        balances[msg.sender] -= _amount;
        
        // 使用 transfer() 方法将以太币转账给接收者
        // transfer() 是一个安全的转账方法，会自动转发2300 gas
        _to.transfer(_amount);
        
        // 将金额添加到接收者的余额中
        balances[_to]+=_amount;
    }
    
    // 替代转账方法：使用 call() 方法进行以太币转账
    function transferEtherViaCall(address payable _to, uint256 _amount) public onlyRegistered {
        // 检查接收者地址是否有效
        require(_to != address(0), "Invalid address");
        
        // 检查接收者是否已注册
        require(registeredFriends[_to], "Recipient not registered");
        
        // 检查余额是否足够
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        
        // 从发送者的余额中扣除金额
        balances[msg.sender] -= _amount;
        
        // 使用 call() 方法进行低级调用
        // call() 方法更灵活，可以设置 gas 限制
        // 返回值：success (bool) 表示调用是否成功
        // 第二个返回值是返回数据（这里不需要，用 _ 忽略）
        (bool success, ) = _to.call{value: _amount}("");
        
        // 将金额添加到接收者的余额中
        balances[_to]+=_amount;
        
        // 检查转账是否成功
        require(success, "Transfer failed");
    }
    
    // 提取函数：提取你的余额到外部钱包
    function withdraw(uint256 _amount) public onlyRegistered {
        // 检查余额是否足够
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        
        // 从余额中扣除金额
        balances[msg.sender] -= _amount;
        
        // 使用 call() 方法将以太币转回给调用者
        // payable(msg.sender) 将地址转换为可支付地址
        (bool success, ) = payable(msg.sender).call{value: _amount}("");
        
        // 检查提取是否成功
        require(success, "Withdrawal failed");
    }
    
    // 查询余额函数：查看你的余额
    function checkBalance() public view onlyRegistered returns (uint256) {
        // 返回调用者的余额
        return balances[msg.sender];
    }
}`:e===8?`//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TipJar {
    // 合约的拥有者（管理员）地址
    address public owner;
    
    // 记录收到的打赏总金额
    uint256 public totalTipsReceived;
    
    // 汇率映射表：记录法币（如USD）到ETH的汇率
    mapping(string => uint256) public conversionRates;

    // 记录每个地址（人）打赏的金额
    mapping(address => uint256) public tipPerPerson;
    
    // 当前支持的代币/货币列表
    string[] public supportedCurrencies;
    
    // 记录每种货币收到的打赏总数
    mapping(string => uint256) public tipsPerCurrency;
    
    // 构造函数：初始化所有者和预设汇率
    constructor() {
        owner = msg.sender;
        addCurrency("USD", 5 * 10**14);  // 1 USD = 0.0005 ETH
        addCurrency("EUR", 6 * 10**14);
        addCurrency("JPY", 4 * 10**12);
        addCurrency("INR", 7 * 10**12);
    }
    
    // 自定义修饰符：限制只有管理员才能使用
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;
    }
    
    // 增加或更新支持的币种以及对等汇率
    function addCurrency(string memory _currencyCode, uint256 _rateToEth) public onlyOwner {
        require(_rateToEth > 0, "Conversion rate must be greater than 0");
        bool currencyExists = false;
        for (uint i = 0; i < supportedCurrencies.length; i++) {
            if (keccak256(bytes(supportedCurrencies[i])) == keccak256(bytes(_currencyCode))) {
                currencyExists = true;
                break;
            }
        }
        if (!currencyExists) {
            supportedCurrencies.push(_currencyCode);
        }
        conversionRates[_currencyCode] = _rateToEth;
    }
    
    // 核心换算模块：计算法币金额对应的 ETH (wei)
    function convertToEth(string memory _currencyCode, uint256 _amount) public view returns (uint256) {
        require(conversionRates[_currencyCode] > 0, "Currency not supported");
        return _amount * conversionRates[_currencyCode];
    }
    
    // 直接发送 ETH 打赏
    function tipInEth() public payable {
        require(msg.value > 0, "Tip amount must be greater than 0");
        tipPerPerson[msg.sender] += msg.value;
        totalTipsReceived += msg.value;
        tipsPerCurrency["ETH"] += msg.value;
    }
    
    // 指定货法币进行打赏
    function tipInCurrency(string memory _currencyCode, uint256 _amount) public payable {
        require(conversionRates[_currencyCode] > 0, "Currency not supported");
        require(_amount > 0, "Amount must be greater than 0");
        
        uint256 ethAmount = convertToEth(_currencyCode, _amount);
        require(msg.value == ethAmount, "Sent ETH doesn't match the converted amount");
        
        tipPerPerson[msg.sender] += msg.value;
        totalTipsReceived += msg.value;
        tipsPerCurrency[_currencyCode] += _amount;
    }

    // 提现函数：管理员提取合约内的全部资金
    function withdrawTips() public onlyOwner {
        uint256 contractBalance = address(this).balance;
        require(contractBalance > 0, "No tips to withdraw");
        
        (bool success, ) = payable(owner).call{value: contractBalance}("");
        require(success, "Transfer failed");
        
        totalTipsReceived = 0;
    }
  
    // 权限转移
    function transferOwnership(address _newOwner) public onlyOwner {
        require(_newOwner != address(0), "Invalid address");
        owner = _newOwner;
    }

    function getSupportedCurrencies() public view returns (string[] memory) {
        return supportedCurrencies;
    }

    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }
}`:e===9?`// ==================== 文件 1: day9-Calculator.sol ====================

//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "./day9-ScientificCalculator.sol";

contract Calculator{

    address public owner; // 当前合约的创建者
    address public scientificCalculatorAddress; // 外部高级科学计算器(ScientificCalculator)合约所在的地址

    constructor(){
        owner = msg.sender; // 赋予创建者这所合约的主人权限
    }

    // 限定操作者必须是 owner 的修饰符
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can do this action");
         _;  // 指代原本应用此修改器的接下来的执行流
    }

    // 让系统知晓高级计算器究竟被部署在哪个地址。只要知道了对方合约的地址，才能对其进行外部通信调用
    function setScientificCalculator(address _address)public onlyOwner{
        scientificCalculatorAddress = _address;
        }

    // 基础的加法，pure的意思是说它是"纯"函数，既不消耗或修改区块链状态，又跟外界毫无联动。这类型的函数不仅执行快速而且不收Gas燃料费(本地查看时)
    function add(uint256 a, uint256 b)public pure returns(uint256){
        uint256 result = a+b;
        return result;
    }

    function subtract(uint256 a, uint256 b)public pure returns(uint256){
        uint256 result = a-b;
        return result;
    }

    function multiply(uint256 a, uint256 b)public pure returns(uint256){
        uint256 result = a*b;
        return result;
    }

    function divide(uint256 a, uint256 b)public pure returns(uint256){
        require(b!= 0, "Cannot divide by zero");
        uint256 result = a/b;
        return result;
    }

    // 计算指数功能：这是一个高级计算功能所以我们利用跨合约互调。这体现了区块链合约的组合式应用（所谓乐高积木）
    function calculatePower(uint256 base, uint256 exponent)public view returns(uint256){

    // 方法一（常规方法）：将外部合约视作对象进行实例对象的创建，然后按接口标准来调用
    ScientificCalculator scientificCalc = ScientificCalculator(scientificCalculatorAddress);

    // external call （对外发起合约调用）
    // 当前合约（Calculator）在背后会去请求被指定地址的（ScientificCalculator）完成这项计算
    uint256 result = scientificCalc.power(base, exponent);

    return result;

}

    // 获取平方运算的操作：这里演示了另外一种更基层的跨合约联调操作手段：底层 call 方法
    function calculateSquareRoot(uint256 number)public returns (uint256){
        require(number >= 0 , "Cannot calculate square root of negative nmber");

        // 使用 abi.encodeWithSignature 来明确编码函数名称和附带的具体传参变量
        // 这个生成的16进制短字符数据就是待发送请求的方法执行代号，(注意函数的签名内不准出现空格：squareRoot(int256))
        bytes memory data = abi.encodeWithSignature("squareRoot(int256)", number);
        
        // 对另外一个以太坊地址使用底层的 .call() 将参数打入进去尝试引动相应的执行功能
        // .call() 会始终返还两个值：调用情况的状态(布尔) 和如果它顺利返回带出的数据字节(returnData)
        (bool success, bytes memory returnData) = scientificCalculatorAddress.call(data);
        require(success, "External call failed"); // 安全编程习惯之一，处理它底层执行没有回弹失败并致使出错的情况
        
        // 最后通过利用 abi.decode 把取回的一串原始数据（returnData）解密成我们需要能阅读懂的具体数字 (uint256类型)
        uint256 result = abi.decode(returnData, (uint256));
        return result;
    }

    
}


// ==================== 文件 2: day9-ScientificCalculator.sol ====================

//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

contract ScientificCalculator{

    // 求基数(base) 的给定指次数 (exponent) 的结果。pure同样表明只是本地的简单输出纯逻辑计算。
    function power(uint256 base, uint256 exponent)public pure returns(uint256){
        if(exponent == 0)return 1; // 零次方均为 1
        else return (base ** exponent); // '**' 在Solidity等价于指数的意思
    }

    // 以牛顿法逼近求取输入数的平方根 （Solidity 因为不具备浮点数运算支持这使这种开箱式求近似正变得常用）
    function squareRoot(int256 number)public pure returns(int256){
        require(number >= 0, "Cannot calculate square root of negative number"); // 数学要求被开方根必须不是负的
        if(number == 0)return 0;

        int256 result = number/2; // 原始预估近似值
        // 为保证它不仅消耗光所有的手续费且死锁(Gas exhausted), 人为限制让逼近只能进行 10 轮
        // 虽然轮次限制代表得不到精确数字，但足够反映逼近的过程
        for(uint256 i = 0; i<10; i++){
            result = (result + number / result)/2; // 牛顿迭代法的基础公约公式
        }

        return result; // 反馈出求取之后的收敛值
    }
}`:e===10?`//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ActivityTracker {
    // 合约所有者地址，用于权限管理
    address public owner;
    
    // 用户资料结构体：存储用户的基本信息
    struct UserProfile {
        string name;        // 用户姓名
        uint256 weight;     // 用户体重
        bool isRegistered;  // 是否已注册标记
    }
    
    // 运动活动结构体：存储单次运动的详细信息
    struct WorkoutActivity {
        string activityType; // 运动类型（如：跑步、游泳、骑行等）
        uint256 duration;    // in seconds / 运动时长（单位：秒）
        uint256 distance;    // in meters / 运动距离（单位：米）
        uint256 timestamp;   // 运动记录时间戳
    }
    
    // 用户地址 => 用户资料的映射，用于存储每个注册用户的基本信息
    mapping(address => UserProfile) public userProfiles;
    
    // 用户地址 => 运动历史数组的映射，存储每个用户的所有运动记录
    mapping(address => WorkoutActivity[]) private workoutHistory;
    
    // 用户地址 => 总运动次数的映射
    mapping(address => uint256) public totalWorkouts;
    
    // 用户地址 => 总运动距离的映射
    mapping(address => uint256) public totalDistance;
    
    // 事件定义：用于记录重要的合约操作，方便前端监听和日志查询
    event UserRegistered(address indexed userAddress, string name, uint256 timestamp);
    event ProfileUpdated(address indexed userAddress, uint256 newWeight, uint256 timestamp);
    event WorkoutLogged(
        address indexed userAddress, 
        string activityType, 
        uint256 duration, 
        uint256 distance, 
        uint256 timestamp
    );
    event MilestoneAchieved(address indexed userAddress, string milestone, uint256 timestamp);
    
    // 构造函数：在合约部署时执行，设置合约部署者为所有者
    constructor() {
        owner = msg.sender;
    }
    
    // 仅限已注册用户修饰器：确保调用函数的用户已经完成注册
    modifier onlyRegistered() {
        require(userProfiles[msg.sender].isRegistered, "User not registered");
        _;
    }
    
    // 用户注册函数：允许新用户注册到系统中
    function registerUser(string memory _name, uint256 _weight) public {
        // 检查用户是否已注册，防止重复注册
        require(!userProfiles[msg.sender].isRegistered, "User already registered");
        
        // 创建新的用户资料并存储
        userProfiles[msg.sender] = UserProfile({
            name: _name,
            weight: _weight,
            isRegistered: true
        });
        
        // 触发用户注册事件
        emit UserRegistered(msg.sender, _name, block.timestamp);
    }
    
    // 更新体重函数：允许已注册用户更新体重，并检测是否达成减重目标
    function updateWeight(uint256 _newWeight) public onlyRegistered {
        // 使用storage关键字获取存储引用，直接修改原数据
        UserProfile storage profile = userProfiles[msg.sender];
        
        // 检查是否达成显著减重目标（减重5%或以上）
        if (_newWeight < profile.weight && (profile.weight - _newWeight) * 100 / profile.weight >= 5) {
            emit MilestoneAchieved(msg.sender, "Weight Goal Reached", block.timestamp);
        }
        
        // 更新体重
        profile.weight = _newWeight;
        
        // 触发资料更新事件
        emit ProfileUpdated(msg.sender, _newWeight, block.timestamp);
    }
    
    // 记录运动函数：允许已注册用户记录新的运动活动
    function logWorkout(
        string memory _activityType,
        uint256 _duration,
        uint256 _distance
    ) public onlyRegistered {
        // 创建新的运动活动记录
        WorkoutActivity memory newWorkout = WorkoutActivity({
            activityType: _activityType,
            duration: _duration,
            distance: _distance,
            timestamp: block.timestamp
        });
        
        // 将新记录添加到用户的运动历史中
        workoutHistory[msg.sender].push(newWorkout);
        
        // 更新用户的统计数据
        totalWorkouts[msg.sender]++;
        totalDistance[msg.sender] += _distance;
        
        // 触发运动记录事件
        emit WorkoutLogged(
            msg.sender,
            _activityType,
            _duration,
            _distance,
            block.timestamp
        );
        
        // 检查运动次数里程碑（10次、50次）
        if (totalWorkouts[msg.sender] == 10) {
            emit MilestoneAchieved(msg.sender, "10 Workouts Completed", block.timestamp);
        } else if (totalWorkouts[msg.sender] == 50) {
            emit MilestoneAchieved(msg.sender, "50 Workouts Completed", block.timestamp);
        }
        
        // 检查距离里程碑（100公里 = 100000米）
        if (totalDistance[msg.sender] >= 100000 && totalDistance[msg.sender] - _distance < 100000) {
            emit MilestoneAchieved(msg.sender, "100K Total Distance", block.timestamp);
        }
    }
    
    // 获取用户运动次数函数：返回当前登录用户的运动记录数量
    function getUserWorkoutCount() public view onlyRegistered returns (uint256) {
        return workoutHistory[msg.sender].length;
    }
}`:e===11?`// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// ==================== 父合约：Ownable.sol ====================
// 基础所有权管理合约，可被其他合约继承复用

contract Ownable {
    // private 可见性：只能在当前合约内部访问
    address private owner;
    
    // 构造函数：合约部署时执行一次，初始化所有者
    constructor() {
        owner = msg.sender;
    }
    
    // 事件日志：indexed 参数可以被过滤查询
    event OwnershipTransferred(
        address indexed previousOwner,  // indexed 允许按地址搜索事件
        address indexed newOwner
    );
    
    // 修饰符：限制只有所有者才能调用某些函数
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can perform this action");
        _;  // 继续执行被修饰的函数
    }
    
    // 查看当前所有者
    function ownerAddress() public view returns (address) {
        return owner;
    }
    
    // 转移所有权（只有所有者可以调用）
    function transferOwnership(address newOwner) public onlyOwner {
        require(newOwner != address(0), "Invalid address: cannot be zero address");
        address oldOwner = owner;
        owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}

// ==================== 子合约：VaultMaster.sol ====================
// 资金保险库合约，继承 Ownable 的所有权管理功能

import "./Ownable.sol";

contract VaultMaster is Ownable {
    // 合约余额（实际上使用 address(this).balance）
    
    // 事件：记录成功的存款
    event DepositSuccessful(
        address indexed depositor,
        uint256 amount,
        uint256 timestamp
    );
    
    // 事件：记录成功的提款
    event WithdrawSuccessful(
        address indexed recipient,
        uint256 amount,
        uint256 timestamp
    );
    
    // 存款函数：任何人都可以存入 ETH
    function deposit() public payable {
        require(msg.value > 0, "Must send ETH to deposit");
        emit DepositSuccessful(msg.sender, msg.value, block.timestamp);
    }
    
    // 提款函数：只有所有者可以提取（继承的 onlyOwner 修饰符）
    function withdraw(address payable recipient, uint256 amount) public onlyOwner {
        require(recipient != address(0), "Invalid recipient address");
        require(amount > 0, "Amount must be greater than 0");
        require(address(this).balance >= amount, "Insufficient contract balance");
        
        // 转账到指定地址
        (bool success, ) = recipient.call{value: amount}("");
        require(success, "Transfer failed");
        
        emit WithdrawSuccessful(recipient, amount, block.timestamp);
    }
    
    // 查询合约余额
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}`:e===12?`// SPDX-License-Identifier: MIT
// SPDX许可证标识符，指定代码使用MIT开源许可证
pragma solidity ^0.8.20;
// 指定Solidity编译器版本为0.8.20及以上，但小于0.9.0

// 简化版ERC20代币合约：ERC20是以太坊上最常用的代币标准，功能包括转账、授权、查询余额等
contract SimpleERC20 {
    // 代币基本信息
    string public name = "Web3 Compass";  // 代币全称
    string public symbol = "COM";          // 代币符号（交易时使用）
    uint8 public decimals = 18;            // 小数位数（18是标准值，1代币 = 10^18最小单位）
    uint256 public totalSupply;            // 代币总供应量

    // 余额映射：记录每个地址持有的代币数量，address => uint256: 地址 => 余额
    mapping(address => uint256) public balanceOf;
    // 授权额度映射（双重映射）：记录每个地址授权给其他地址可以使用的代币数量
    // address => address => uint256: 代币持有者 => 被授权者 => 授权额度
    // 例如：allowance[A][B] = 100 表示A授权B可以使用A的100个代币
    mapping(address => mapping(address => uint256)) public allowance;

    // 转账事件：当代币从一个地址转移到另一个地址时触发
    event Transfer(address indexed from, address indexed to, uint256 value);
    // 授权事件：当代币持有者授权他人使用自己的代币时触发
    event Approval(address indexed owner, address indexed spender, uint256 value);

    // 构造函数：在合约部署时创建所有代币并分配给部署者
    // _initialSupply 是用户输入的值（不含小数位）
    constructor(uint256 _initialSupply) {
        // 计算实际总供应量：用户输入值 × 10^decimals
        // 例如：输入1000，decimals为18，则实际创建 1000 * 10^18 个最小单位
        totalSupply = _initialSupply * (10 ** uint256(decimals));
        // 将所有代币分配给合约部署者
        balanceOf[msg.sender] = totalSupply;
        // 触发转账事件，表示从0地址（代表铸币）转账给部署者
        emit Transfer(address(0), msg.sender, totalSupply);
    }

    // 转账函数：调用者将自己的代币转给他人
    function transfer(address _to, uint256 _value) public returns (bool) {
        // 检查调用者余额是否足够
        require(balanceOf[msg.sender] >= _value, "Not enough balance");
        // 执行转账（内部函数）
        _transfer(msg.sender, _to, _value);
        return true;
    }

    // 授权函数：允许_spender从调用者账户中转走_value数量的代币
    function approve(address _spender, uint256 _value) public returns (bool) {
        // 设置授权额度
        allowance[msg.sender][_spender] = _value;
        // 触发授权事件
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    // 代转账函数（从他人账户转账）：调用者使用被授权的额度从_from地址向_to地址转账
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {
        // 检查_from地址的余额是否足够
        require(balanceOf[_from] >= _value, "Not enough balance");
        // 检查调用者被授权的额度是否足够
        require(allowance[_from][msg.sender] >= _value, "Allowance too low");

        // 减少授权额度（已使用的部分）
        allowance[_from][msg.sender] -= _value;
        // 执行转账
        _transfer(_from, _to, _value);
        return true;
    }

    // 内部转账函数：internal修饰符表示只能在合约内部调用，这是实际执行转账逻辑的核心函数
    function _transfer(address _from, address _to, uint256 _value) internal {
        // 检查收款地址是否有效（不能是零地址）
        require(_to != address(0), "Invalid address");
        // 减少转出地址的余额
        balanceOf[_from] -= _value;
        // 增加转入地址的余额
        balanceOf[_to] += _value;
        // 触发转账事件
        emit Transfer(_from, _to, _value);
    }
}`:"",Dc=()=>Object.keys(Dt).reduce((e,t)=>(e[t]={unlockedConcepts:[],totalConcepts:Dt[t].concepts.length,interactionCount:0},e),{}),Ie=Fs("progress",()=>{const e=Z(Dc()),t=c=>String(c),s=(c,u)=>{const l=t(c),p=e.value[l];p&&!p.unlockedConcepts.includes(u)&&p.unlockedConcepts.push(u)},n=c=>{const u=t(c),l=e.value[u];l&&l.interactionCount++},r=c=>{const u=t(c);return e.value[u]},o=c=>{var l;const u=t(c);return((l=e.value[u])==null?void 0:l.unlockedConcepts)||[]};return{dayProgress:e,unlockConcept:s,incrementInteraction:n,getDayProgress:r,getUnlockedConcepts:o,isConceptUnlocked:(c,u)=>o(c).includes(u),getProgressPercentage:c=>{const u=t(c),l=e.value[u];return!l||l.totalConcepts===0?0:Math.floor(l.unlockedConcepts.length/l.totalConcepts*100)}}}),We=Fs("contract",()=>{const e=Z({day1:{count:0,interactionCount:0},day2:{name:"",bio:"",interactionCount:0,hasStored:!1,hasRetrieved:!1},day3:{candidates:[],voteCount:{},interactionCount:0},day4:{owner:"",item:"",auctionEndTime:0,highestBidder:"",highestBid:0,ended:!1,bids:{},bidders:[],interactionCount:0},day5:{owner:"",treasureAmount:0,withdrawalAllowance:{},hasWithdrawn:{},userAddress:"0x"+Math.random().toString(16).substr(2,40),userAllowance:0,interactionCount:0},day6:{bankManager:"",members:[],registeredMembers:{},balance:{},userAddress:"0x"+Math.random().toString(16).substr(2,40),interactionCount:0,depositCount:0,withdrawCount:0},day7:{owner:"",userAddress:"",registeredFriends:{},friendList:[],balances:{},debts:{},interactionCount:0},day8:{owner:"",userAddress:"",isUserAdmin:!1,totalTipsReceived:0,tipPerPerson:{},tipsPerCurrency:{},supportedCurrencies:["USD","EUR","JPY","INR"],conversionRates:{USD:5e14,EUR:6e14,JPY:4e12,INR:7e12},interactionCount:0},day9:{owner:"",userAddress:"",isUserAdmin:!1,scientificCalculatorAddress:"",isAddressSet:!1,operationCount:0,operationHistory:[],interactionCount:0,challengeTasks:{setAddress:!1,powerCalc:!1,sqrtCalc:!1,permissionCheck:!1}},day10:{owner:"",userAddress:"",userProfile:{name:"",weight:0,isRegistered:!1},workoutHistory:[],totalWorkouts:0,totalDistance:0,milestones:{weightGoal:{achieved:!1,timestamp:0,title:"减重目标达成",icon:"⚖️"},workouts10:{achieved:!1,timestamp:0,title:"10次运动",icon:"🏃"},workouts50:{achieved:!1,timestamp:0,title:"50次运动大师",icon:"🏆"},distance100K:{achieved:!1,timestamp:0,title:"100公里里程碑",icon:"🌍"}},interactionCount:0},day11:{owner:"",userAddress:"",contractBalance:0,eventLog:[],interactionCount:0}}),t=()=>"0x"+Math.random().toString(16).substr(2,40),s=o=>{const i=`day${o}`,a=e.value[i];if(!a){console.warn(`Contract for day ${o} not found`);return}switch(o){case 5:a.owner||(a.owner=t()),a.userAddress||(a.userAddress=t());break;case 6:a.bankManager===""&&(a.bankManager=t(),a.members=[a.bankManager],a.registeredMembers={[a.bankManager]:!0,[a.userAddress]:!0},a.balance={[a.bankManager]:0,[a.userAddress]:0},a.members.push(a.userAddress));break;case 7:if(a.owner===""){const c=t();a.owner=c,a.userAddress=c,a.registeredFriends[c]=!0,a.friendList.push(c)}break;case 8:a.owner===""&&(a.owner=t(),a.userAddress=t());break;case 9:a.owner===""&&(a.owner=t(),a.userAddress=t(),a.isUserAdmin=!1);break;case 10:a.owner===""&&(a.owner=t(),a.userAddress=t());break;case 11:if(a.owner===""){const c=t();a.owner=c,a.userAddress=c,a.contractBalance=0,a.eventLog=[]}break}},n=o=>e.value[`day${o}`];return{contracts:e,initializeContract:s,getContract:n,updateContract:(o,i)=>{const a=n(o);a&&Object.assign(a,i)},generateAddress:t}}),Er={increment:21e3,reset:21e3,addData:4e4,retrieveData:0,addCandidate:5e4,vote:35e3,placeBid:45e3,endAuction:25e3,addTreasure:3e4,approveWithdrawal:4e4,withdrawTreasure:5e4,resetWithdrawalStatus:25e3,transferOwnership:35e3,getTreasureDetails:0,addMembers:45e3,depositAmountEther:35e3,withdrawAmount:4e4,getMembers:0,addFriend:45e3,depositIntoWallet:35e3,recordDebt:45e3,payFromWallet:5e4,transferEther:35e3,transferEtherViaCall:4e4,withdraw:35e3,checkBalance:0,addCurrency:45e3,tipInEth:4e4,tipInCurrency:5e4,withdrawTips:35e3,transferOwnership8:35e3},Dr=4e-8,Oc={function:{name:"函数交互",icon:"🎯",unlockAt:1,message:"你刚刚调用了 Solidity 中的第一个函数！在区块链上，用户与合约的所有交互都是通过函数完成的。",code:`function click() public {
    // 你的点击在这里触发
}`},increment:{name:"自增操作",icon:"➕",unlockAt:2,message:'你发现了 `++` 这个操作符的作用！它的意思是"在原来的基础上加 1"。',code:"count++;  // 等同于 count = count + 1;"},uint256:{name:"uint256 变量",icon:"🔢",unlockAt:3,message:"你刚刚修改了一个 `uint256` 类型的变量。`uint` = 无符号整数（只能存正数），`256` = 能存超级大的数字。",code:"uint256 public count;  // 能存储超大数字"},contract:{name:"contract 结构",icon:"🏗️",unlockAt:4,message:'欢迎来到你的第一个 `contract`！你现在看到的交互界面，就是这个"合约"的前端。没有它，就没有智能合约世界！',code:`contract ClickCounter {
    uint256 public count;
    
    function click() public {
        count++;
    }
}`},string:{name:"string 类型",icon:"📝",unlockAt:1,message:"你刚刚使用了 `string` 类型！它可以存储文本数据，比如名字、描述等信息。",code:`string name;  // 存储文本数据
string bio;   // 存储简介`},private:{name:"private 变量",icon:"🔒",unlockAt:2,message:"你发现了 `private` 关键字！表示这个变量只能在合约内部访问，外部无法直接读取。",code:"string private name;  // 只能在合约内部访问"},memory:{name:"memory 存储",icon:"💾",unlockAt:3,message:"你使用了 `memory` 关键字！表示数据存储在内存中，只在函数执行期间存在，执行完毕后自动清除。",code:`function add(string memory _name) public {
    // _name 存储在内存中，临时使用
}`},view:{name:"view 函数",icon:"👁️",unlockAt:4,message:"你调用了 `view` 函数！它只读取数据不修改状态，因此不消耗 Gas，这是优化合约的重要方法。",code:`function retrieve() public view returns (string memory) {
    return name;  // 只读取，不修改
}`},parameters:{name:"函数参数",icon:"📥",unlockAt:5,message:"你使用了函数参数！参数让函数能够接收外部传入的数据，使函数更加灵活。",code:`function add(string memory _name, string memory _bio) public {
    // _name 和 _bio 是参数
}`},returns:{name:"返回值",icon:"📤",unlockAt:6,message:"你使用了 `returns` 关键字！它定义了函数返回的数据类型，让函数能够向调用者返回结果。",code:`function retrieve() public view returns (string memory, string memory) {
    return (name, bio);  // 返回多个值
}`},array:{name:"数组类型",icon:"📋",unlockAt:1,message:"你刚刚创建了数组！`candidateNames` 数组用来存储所有候选人的姓名。",code:`string[] public candidateNames;  // 声明字符串数组
candidateNames.push("Alice");  // 添加第一个候选人`},push:{name:"push 方法",icon:"➕",unlockAt:2,message:"你使用了 `push` 方法！它在数组末尾添加新元素，每次添加候选人都会用到它。",code:`candidateNames.push("Alice");  // 添加 Alice 到数组末尾
candidateNames.push("Bob");    // 添加 Bob 到数组末尾`},mapping:{name:"映射类型",icon:"🗺️",unlockAt:3,message:"你发现了 `mapping` 映射！它用候选人姓名作为键，票数作为值，存储投票结果。",code:`mapping(string => uint256) voteCount;  // 声明映射
voteCount["Alice"] = 0;  // 初始化票数为0`},compound_assignment:{name:"复合赋值",icon:"⚡",unlockAt:4,message:"你使用了 `+=` 复合赋值运算符！每次投票都会将候选人的票数加1。",code:'voteCount["Alice"] += 1;  // 票数加1，等同于 voteCount["Alice"] = voteCount["Alice"] + 1;'},constructor:{name:"构造函数",icon:"🏗️",unlockAt:1,message:"你刚刚调用了构造函数！它只在合约部署时执行一次，用于初始化合约的状态变量。",code:`constructor(string memory _item, uint _biddingTime) {
    owner = msg.sender;
    item = _item;
    auctionEndTime = block.timestamp + _biddingTime;
}`},msg_sender:{name:"msg.sender",icon:"📧",unlockAt:2,message:"你使用了 `msg.sender`！它表示当前调用合约的地址，可以是用户钱包或其他合约。",code:`address public owner = msg.sender;  // 部署者成为所有者
function bid() external {
    bids[msg.sender] = amount;  // 记录竞拍者出价
}`},block_timestamp:{name:"block.timestamp",icon:"⏰",unlockAt:3,message:"你使用了 `block.timestamp`！它返回当前区块的时间戳（Unix时间，秒），常用于时间相关的逻辑。",code:`uint public auctionEndTime = block.timestamp + _biddingTime;  // 设置拍卖结束时间
require(block.timestamp < auctionEndTime, "Auction has ended.");  // 检查时间`},require:{name:"条件检查",icon:"✅",unlockAt:4,message:"你使用了 `require` 语句！它在条件不满足时回滚交易，是合约安全的重要机制。",code:`require(amount > 0, "Bid amount must be greater than zero.");
require(block.timestamp < auctionEndTime, "Auction has already ended.");`},external:{name:"external 函数",icon:"🌐",unlockAt:5,message:"你使用了 `external` 函数！它只能从合约外部调用，比 `public` 更节省 Gas。",code:`function bid(uint amount) external {
    // 只能从外部调用，不能在合约内部调用
}`},address_type:{name:"地址类型",icon:"🏠",unlockAt:6,message:"你使用了 `address` 类型！它存储以太坊地址（钱包地址或合约地址），是区块链交互的核心。",code:`address public owner;  // 所有者地址
address private highestBidder;  // 最高出价者地址
mapping(address => uint) public bids;  // 地址到出价的映射`},bool_type:{name:"布尔类型",icon:"🔘",unlockAt:7,message:"你使用了 `bool` 类型！它只有 `true` 或 `false` 两个值，用于标记状态。",code:`bool public ended;  // 拍卖是否已结束
ended = true;  // 标记拍卖结束
require(!ended, "Auction already ended.");  // 检查状态`},modifier:{name:"修饰符",icon:"🛡️",unlockAt:1,message:"你使用了 `modifier`！它用于为函数添加前置条件检查，确保只有满足条件的调用者才能执行函数。",code:`modifier onlyOwner() {
    require(msg.sender == owner, "Only owner");
    _;  // 继续执行被修饰的函数
}`},zero_address:{name:"零地址检查",icon:"⚠️",unlockAt:2,message:"你检查了 `address(0)` 零地址！它表示一个无效的地址，通常用于检查地址参数是否有效。",code:`require(newOwner != address(0), "Invalid address");  // 确保不是零地址
address(0)  // 零地址，表示无效地址`},return_statement:{name:"返回语句",icon:"↩️",unlockAt:3,message:"你了解了返回语句的用法！继续解锁更多概念吧！",code:`function withdrawTreasure(uint256 amount) public {
    if (msg.sender == owner) {
        return;  // 所有者提前退出，不执行后续逻辑
    }
    
    require(allowance > 0, "No allowance");
    treasureAmount -= allowance;
}`},address_mapping_balance:{name:"地址映射余额",icon:"💰",unlockAt:1,message:"你刚刚使用了地址映射来存储每个用户的余额！mapping(address => uint256) 是存储用户资产的核心数据结构。",code:`mapping(address => uint256) balance;

balance[0x123...] = 1000000;  // 存储余额
uint256 amount = balance[msg.sender];  // 读取余额`},payable:{name:"可支付函数",icon:"💵",unlockAt:2,message:"你使用了 `payable` 关键字！它让函数能够接收以太币，这是处理资金交易的关键。",code:`function deposit() public payable {
    // 这个函数可以接收以太币
    require(msg.value > 0, "Must send ETH");
    balance[msg.sender] += msg.value;
}`},msg_value:{name:"发送金额",icon:"💳",unlockAt:3,message:"你使用了 `msg.value`！它表示调用函数时发送的以太币数量（以wei为单位），是获取转账金额的标准方式。",code:`function deposit() public payable {
    uint256 amount = msg.value;  // 获取发送的ETH数量
    balance[msg.sender] += amount;
}`},wei_unit:{name:"Wei 单位",icon:"⚖️",unlockAt:4,message:"你了解了以太币的最小单位 wei！1 ETH = 10^18 wei，这是以太坊计价的基础单位。",code:`// 以太币单位
1 wei = 0.000000000000000001 ETH
1 gwei = 0.000000001 ETH
1 ETH = 1000000000000000000 wei

balance[msg.sender] += 1000000000000000000;  // 增加 1 ETH`},ether_deposit_withdraw:{name:"存取逻辑",icon:"🏦",unlockAt:5,message:"你掌握了以太币的存取核心逻辑！检查余额、增减余额、验证输入，这是任何金融合约的基础。",code:`function deposit() public payable {
    require(msg.value > 0, "Invalid amount");
    balance[msg.sender] += msg.value;
}

function withdraw(uint256 amount) public {
    require(amount > 0, "Invalid amount");
    require(balance[msg.sender] >= amount, "Insufficient balance");
    balance[msg.sender] -= amount;
}`},withdraw_pattern:{name:"提现模式 (Withdraw)",icon:"🏧",unlockAt:7,message:"你掌握了提现模式！与其主动将资金发送给用户（易受攻击），不如让用户自己来提取他们的资金，这是智能合约安全的核心原则之一。",code:`function withdraw(uint256 _amount) public {
    require(balances[msg.sender] >= _amount);
    balances[msg.sender] -= _amount;
    (bool success, ) = payable(msg.sender).call{value: _amount}("");
    require(success);
}`},nested_mapping:{name:"嵌套映射",icon:"🗂️",unlockAt:1,message:"你掌握了如何使用嵌套映射 (mapping in mapping)！这是处理复杂关系（如“谁欠谁多少钱”）的终极武器。",code:"mapping(address => mapping(address => uint256)) public debts;"},address_payable:{name:"Payable 地址",icon:"💸",unlockAt:2,message:"你使用了 address payable！只有标记为 payable 的地址才能接收 Ether，否则编译器会报错保护资金安全。",code:"address payable user = payable(msg.sender);"},debt_tracking:{name:"债务追踪",icon:"📊",unlockAt:3,message:"区块链就是一本账本！你刚刚在链上永久记录了一笔债权关系，且任何人无法抵赖。",code:"debts[debtor][msg.sender] += amount;"},internal_transfer:{name:"内部记账转账",icon:"🔄",unlockAt:4,message:"你完成了一次“内部转账”！这并没有发生真实的链上交易，只是在合约账本里扣减了一个人的余额并增加给另一个人，非常省 Gas。",code:`balances[msg.sender] -= amount;
balances[creditor] += amount;`},transfer_method:{name:"transfer() 转账",icon:"📤",unlockAt:5,message:"你使用了经典的 .transfer() 方法。它会自动在转账失败时触发 revert，是最简单安全的转账方式。",code:"payable(to).transfer(amount);"},call_method:{name:"call() 转账",icon:"📡",unlockAt:6,message:"你使用了更强大的 .call() 方法！它是目前以太坊开发中最推荐的转账方式，因为它允许你灵活处理 Gas 限制和错误结果。",code:`(bool success, ) = to.call{value: amount}("");
require(success, "Transfer failed");`},modifier_onlyOwner:{name:"onlyOwner 修饰符",icon:"🛡️",unlockAt:1,message:"你发现了 `onlyOwner`！这是一个自定义修饰符，专门用来限制只有管理员（合约拥有者）才能执行特定的函数（如提现、改汇率）。",code:`modifier onlyOwner() {
    require(msg.sender == owner, "Only owner can perform this action");
    _;
}`},payable_tip:{name:"payable 支付关键字",icon:"💰",unlockAt:2,message:"你成功进行了一次带钱的交互！在 Solidity 中，只有标记为 `payable` 的函数才能接收随交易发送的以太币。",code:`function tipInEth() public payable {
    // 带有 payable 才能收钱
}`},msg_value_tip:{name:"msg.value 发送金额",icon:"💸",unlockAt:3,message:"你发送了 ETH！`msg.value` 是一个全局变量，代表了你在调用这个函数时额外付出的金钱（单位是 wei）。",code:`tipPerPerson[msg.sender] += msg.value;
totalTipsReceived += msg.value;`},address_balance:{name:"合约余额查询",icon:"🏦",unlockAt:4,message:"想要知道存钱柜里有多少钱？`address(this).balance` 会返回当前智能合约在链上的全部实时余额。",code:`uint256 contractBalance = address(this).balance;
require(contractBalance > 0, "No tips to withdraw");`},call_withdraw:{name:"底层 call 转账",icon:"📡",unlockAt:5,message:'管理员提现成功！使用 `.call{value: ...}("")` 是目前以太坊开发中推荐的由合约向外部地址转账的最灵活方式。',code:`(bool success, ) = payable(owner).call{value: contractBalance}("");
require(success, "Transfer failed");`},mapping_rates:{name:"法币汇率映射",icon:"💹",unlockAt:6,message:"智能合约也能换钱！这里使用了 `mapping(string => uint256)` 来存储不同法币（字符串）对应的 ETH 汇率（数字）。",code:`mapping(string => uint256) public conversionRates;

conversionRates["USD"] = 5 * 10**14;`},pure_function:{name:"Pure 纯函数",icon:"⚡",unlockAt:1,message:"你使用了 `pure` 函数！pure函数不读取也不修改区块链状态，执行快速且不消耗Gas，适合简单的数学计算。",code:`function add(uint256 a, uint256 b) public pure returns(uint256) {
    return a + b;  // 纯计算，不访问状态
}`},view_function:{name:"View 视图函数",icon:"👁️",unlockAt:2,message:"你使用了 `view` 函数！view函数可以读取状态变量但不修改它们，适合查询操作，不消耗Gas。",code:`function calculatePower(uint256 base, uint256 exponent) public view returns(uint256) {
    // 读取 scientificCalculatorAddress 状态变量
    ScientificCalculator calc = ScientificCalculator(scientificCalculatorAddress);
    return calc.power(base, exponent);
}`},cross_contract_call:{name:"跨合约调用",icon:"📡",unlockAt:3,message:"你完成了跨合约调用！一个合约可以通过地址调用另一个合约的函数，实现合约间的组合与协作。",code:`// Calculator合约调用ScientificCalculator合约
ScientificCalculator scientificCalc = 
    ScientificCalculator(scientificCalculatorAddress);
uint256 result = scientificCalc.power(base, exponent);`},interface_call:{name:"接口方式调用",icon:"🔌",unlockAt:4,message:"你使用了接口方式调用外部合约！通过创建接口实例，可以像调用本地函数一样调用外部合约。",code:`// 创建外部合约接口实例
ScientificCalculator scientificCalc = 
    ScientificCalculator(scientificCalculatorAddress);

// 调用外部合约函数
uint256 result = scientificCalc.power(base, exponent);`},low_level_call:{name:"底层 Call 调用",icon:"🔧",unlockAt:5,message:"你使用了底层 `call` 方法！这是最灵活的跨合约调用方式，通过 `abi.encodeWithSignature` 编码函数调用。",code:`// 编码函数签名
bytes memory data = abi.encodeWithSignature(
    "squareRoot(int256)", number
);

// 发起底层call调用
(bool success, bytes memory returnData) = 
    scientificCalculatorAddress.call(data);

// 解码返回数据
uint256 result = abi.decode(returnData, (uint256));`},newton_iteration:{name:"牛顿迭代法",icon:"📐",unlockAt:7,message:"你了解了牛顿迭代法！Solidity不支持浮点数，通过迭代逼近真实值是常用的数学算法实现方式。",code:`function squareRoot(int256 number) public pure returns(int256) {
    int256 result = number / 2;
    // 限制10轮，防止Gas耗尽
    for(uint256 i = 0; i < 10; i++) {
        result = (result + number / result) / 2;
    }
    return result;
}`},contract_composition:{name:"合约组合",icon:"🧩",unlockAt:8,message:"恭喜你掌握了合约组合！合约可以像乐高积木一样组合复用，构建复杂的去中心化应用。",code:`// Calculator合约组合了ScientificCalculator合约
contract Calculator {
    address public scientificCalculatorAddress;
    
    // 通过接口调用外部合约功能
    function calculatePower(uint256 base, uint256 exponent) 
        public view returns(uint256) {
        ScientificCalculator calc = 
            ScientificCalculator(scientificCalculatorAddress);
        return calc.power(base, exponent);
    }
}`},struct_definition:{name:"结构体定义",icon:"📦",unlockAt:1,message:"你刚刚使用了 `struct` 结构体！它可以打包多个不同类型的变量，创建自定义数据类型。",code:`struct UserProfile {
    string name;       // 用户姓名
    uint256 weight;    // 用户体重
    bool isRegistered; // 是否已注册
}

// 创建结构体实例
UserProfile memory newUser = UserProfile({
    name: "张三",
    weight: 70,
    isRegistered: true
});`},array_in_mapping:{name:"映射中的数组",icon:"🗂️",unlockAt:2,message:"你发现了 mapping 到数组的用法！这可以为每个用户存储一个运动记录列表。",code:`// mapping 到数组
mapping(address => WorkoutActivity[]) private workoutHistory;

// 添加新记录
workoutHistory[msg.sender].push(newWorkout);

// 获取记录数量
uint256 count = workoutHistory[msg.sender].length;`},multiple_mappings:{name:"多个映射组合",icon:"🗺️",unlockAt:3,message:"你看到了多个映射如何协同工作！userProfiles、totalWorkouts、totalDistance 分别存储不同维度的数据。",code:`// 多个映射协同工作
mapping(address => UserProfile) public userProfiles;        // 用户资料
mapping(address => WorkoutActivity[]) private workoutHistory;  // 运动历史
mapping(address => uint256) public totalWorkouts;            // 运动次数
mapping(address => uint256) public totalDistance;            // 总距离

// 它们共同构建了完整的数据视图`},storage_keyword:{name:"storage 关键字",icon:"💾",unlockAt:4,message:"你使用了 `storage` 关键字！它创建状态变量的引用，直接修改原数据而不是创建副本，非常节省 Gas。",code:`function updateWeight(uint256 _newWeight) public {
    // storage 关键字创建引用
    UserProfile storage profile = userProfiles[msg.sender];
    
    // 直接修改原数据，不创建副本
    profile.weight = _newWeight;
    
    // ❌ 如果用 memory，会创建副本，修改不会生效
    // UserProfile memory profile = userProfiles[msg.sender];
}`},event_logging:{name:"事件日志",icon:"📋",unlockAt:1,message:"你触发了事件！事件记录在区块链日志中，前端可以监听事件来获取实时通知。",code:`// 定义事件
event UserRegistered(address indexed userAddress, string name, uint256 timestamp);
event WorkoutLogged(address indexed user, string activityType, uint256 duration);

// 触发事件
emit UserRegistered(msg.sender, "张三", block.timestamp);
emit WorkoutLogged(msg.sender, "跑步", 1800);`},milestone_detection:{name:"里程碑检测",icon:"🏆",unlockAt:5,message:"你完成了里程碑检测！通过条件判断检测用户是否达成特定目标，并触发相应奖励。",code:`// 运动次数里程碑
if (totalWorkouts == 10) {
    emit MilestoneAchieved(msg.sender, "10次运动达成！");
} else if (totalWorkouts == 50) {
    emit MilestoneAchieved(msg.sender, "50次运动大师！");
}

// 距离里程碑（跨越检测）
if (totalDistance >= 100000 && totalDistance - distance < 100000) {
    emit MilestoneAchieved(msg.sender, "100公里里程碑！");
}`},timestamp_usage:{name:"时间戳使用",icon:"⏰",unlockAt:2,message:"你使用了 `block.timestamp`！它记录当前区块的时间戳，用于标记运动记录的时间。",code:`WorkoutActivity memory newWorkout = WorkoutActivity({
    activityType: "跑步",
    duration: 1800,
    distance: 5000,
    timestamp: block.timestamp  // 记录运动时间
});`},onlyRegistered_modifier:{name:"onlyRegistered 修饰符",icon:"🛡️",unlockAt:1,message:"你使用了 `onlyRegistered` 修饰符！它确保只有注册用户才能调用特定函数，保护合约安全。",code:`// 定义修饰符
modifier onlyRegistered() {
    require(userProfiles[msg.sender].isRegistered, "User not registered");
    _;  // 继续执行函数
}

// 使用修饰符
function logWorkout(...) public onlyRegistered {
    // 只有注册用户才能执行
}`}},Pc={inheritance:{name:"合约继承",icon:"🧬",unlockAt:1,message:"你刚刚体验了合约继承！VaultMaster 通过 `is Ownable` 继承了父合约的所有功能，这是代码复用的核心机制。",code:`// 父合约
contract Ownable {
    address private owner;
    // ...
}

// 子合约继承父合约
contract VaultMaster is Ownable {
    // 自动拥有 Ownable 的所有功能
    function withdraw() public onlyOwner {
        // 可以使用继承的 onlyOwner 修饰符
    }
}`},import_statement:{name:"导入语句",icon:"📥",unlockAt:2,message:"你了解了 `import` 语句！它允许合约引用其他文件中的合约定义，是模块化开发的基础。",code:`// 导入外部合约
import "./Ownable.sol";

// 现在可以使用 Ownable 合约了
contract VaultMaster is Ownable {
    // ...
}`},constructor:{name:"构造函数",icon:"🏗️",unlockAt:1,message:"你刚刚了解了构造函数！它在合约部署时自动执行一次，用于初始化关键状态变量。",code:`contract Ownable {
    address private owner;
    
    // 构造函数：部署时自动执行
    constructor() {
        owner = msg.sender;  // 设置部署者为所有者
    }
}`},private_visibility:{name:"私有可见性",icon:"🔒",unlockAt:2,message:"你了解了 `private` 可见性！它确保变量只能在当前合约内部访问，提供最强的封装保护。",code:`contract Ownable {
    // private：只有当前合约可以访问
    address private owner;
    
    // public：任何人都可以访问
    function ownerAddress() public view returns (address) {
        return owner;  // 通过函数间接访问
    }
}`},event_logging:{name:"事件日志",icon:"📋",unlockAt:1,message:"你触发了事件！事件是合约与前端通信的重要机制，记录关键操作到区块链日志中。",code:`// 定义事件
event DepositSuccessful(
    address indexed depositor,
    uint256 amount
);

// 触发事件
function deposit() public payable {
    emit DepositSuccessful(msg.sender, msg.value);
}`},indexed_parameter:{name:"索引参数",icon:"🏷️",unlockAt:2,message:"你了解了 `indexed` 关键字！它允许前端按特定参数过滤事件日志，提高查询效率。",code:`// indexed 参数可以被过滤查询
event OwnershipTransferred(
    address indexed previousOwner,
    address indexed newOwner
);

// 前端可以按地址过滤事件
// 例如：查找特定用户的所有转账记录`},transfer_ownership:{name:"所有权转移",icon:"🔑",unlockAt:1,message:"你刚刚完成了所有权转移！这是合约管理的核心功能，确保合约可以安全地更换管理者。",code:`function transferOwnership(address newOwner) public onlyOwner {
    require(newOwner != address(0), "Invalid address");
    
    address oldOwner = owner;
    owner = newOwner;
    
    emit OwnershipTransferred(oldOwner, newOwner);
}`},onlyOwner_modifier:{name:"onlyOwner 修饰符",icon:"🛡️",unlockAt:1,message:"你体验了 `onlyOwner` 修饰符的权限控制！它确保只有合约所有者才能执行敏感操作。",code:`// 定义修饰符
modifier onlyOwner() {
    require(msg.sender == owner, "Only owner");
    _;  // 继续执行被修饰的函数
}

// 使用修饰符保护函数
function withdraw() public onlyOwner {
    // 只有所有者可以执行
}`}},au=e=>({function:"📖 这是函数的基本概念，它是智能合约的基本构建模块。",increment:"📖 自增操作是编程中常见的操作，用于快速增加数值。",uint256:"📖 uint256 是 Solidity 中最常用的整数类型，了解它很重要。",contract:"📖 智能合约是区块链上的自动执行代码，理解它的结构很关键。",string:"📖 string 类型用于存储文本数据，是智能合约中常用的数据类型之一。",private:"📖 private 关键字限制变量的访问范围，提高合约的安全性。",memory:"📖 memory 数据位置用于临时存储，只在函数执行期间存在。",view:"📖 view 函数不修改状态，不消耗 Gas，是优化合约性能的重要方法。",parameters:"📖 函数参数让函数能够接收外部数据，使函数更加灵活和可复用。",returns:"📖 returns 关键字定义函数返回值，让函数能够向调用者返回结果。",array:"📖 数组是存储多个相同类型数据的容器，在 Solidity 中广泛使用。",mapping:"📖 映射是 Solidity 中的键值对存储结构，通过键快速查找对应的值。",push:"📖 push 方法是数组的常用操作，可以在数组末尾动态添加元素。",compound_assignment:"📖 复合赋值运算符将运算和赋值结合在一起，使代码更加简洁。",constructor:"📖 构造函数只在合约部署时执行一次，用于初始化合约的状态变量。",msg_sender:"📖 msg.sender 表示当前调用合约的地址，是区块链交互的核心。",block_timestamp:"📖 block.timestamp 返回当前区块的时间戳，常用于时间相关的逻辑。",require:"📖 require 语句在条件不满足时回滚交易，是保证合约安全的重要机制。",external:"📖 external 函数只能从合约外部调用，比 public 更节省 Gas。",address_type:"📖 address 类型存储以太坊地址，是区块链交互的核心数据类型。",bool_type:"📖 bool 类型只有 true 或 false 两个值，用于标记状态。",modifier:"📖 修饰符用于为函数添加前置条件检查，是权限控制的重要机制。",zero_address:"📖 零地址 address(0) 表示一个无效的地址，通常用于检查地址参数是否有效。",return_statement:"📖 return 语句让函数返回指定的值给调用者，是函数输出结果的方式。",address_mapping_balance:"📖 地址映射 mapping(address => uint256) 是存储用户资产的核心数据结构，通过地址快速查找对应的余额。",payable:"📖 payable 关键字让函数能够接收以太币，这是处理资金交易的关键特性。",msg_value:"📖 msg.value 表示调用函数时发送的以太币数量（以wei为单位），是获取转账金额的标准方式。",wei_unit:"📖 wei 是以太币的最小单位，1 ETH = 10^18 wei，这是以太坊计价的基础单位。",ether_deposit_withdraw:"📖 存取逻辑包括检查余额、增减余额、验证输入，这是任何金融合约的基础。",nested_mapping:"📖 嵌套映射 mapping(A => mapping(B => C)) 允许你在 Solidity 中创建像多维数组或字典中嵌套字典的复杂数据结构。",address_payable:"📖 payable 地址类型拥有 transfer 和 call 方法来发送 Ether。没有 fallback 且非 payable 的地址无法接收以太币。",debt_tracking:"📖 债务追踪展示了区块链账本的不变性和透明性，确保每一笔债权和债务都在链上清晰可查的特性。",internal_transfer:"📖 内部账本系统(Internal Accounting)只改变合约内存的数字而不进行链上交易转账，是处理多高频微支付的最佳实操。",transfer_method:"📖 .transfer() 将转账可用 gas 固定为 2300 防止重入，但当目标接收方智能合约的 fallback 逻辑超过一定 gas 时会导致资金卡死。",call_method:"📖 .call() 提供低级别的外部调用功能，转账时能够转发所有剩余 gas 或自定义数量的 gas 以保证外部操作能顺利执行并返回回调状态。",withdraw_pattern:"📖 提现优于发送。要求用户主动调用 withdraw()，避免了遍历用户数组发钱（可能超出 block gas 限制）以及转账失败阻塞整个合约的风险。",modifier_onlyOwner:"📖 修饰符（Modifier）允许你在不重复编写核心检查逻辑的情况下，重用访问控制代码。`_` 符号代表了目标函数体的执行位置。",payable_tip:"📖 `payable` 是一个函数可见性/状态修饰符。如果没有它，任何尝试向该函数发送 Ether 的交易都会被以太坊虚拟机拒绝并回滚。",msg_value_tip:"📖 `msg.value` 是当前交易附带的以太币数量，以 wei 为单位。它是智能合约处理实时支付的桥梁。",address_balance:"📖 合约不仅可以操作别人的钱，还可以管理属于它自己的钱。`address(this).balance` 让你能实时掌控合约金库的‘水位’。",call_withdraw:"📖 `.call()` 是一个底层原语。在转账时，它能够处理复杂的 Fallback 逻辑，并明确返回一个成功/失败的布尔值，比旧的 `transfer` 更具鲁活性。",mapping_rates:"📖 虽然以太坊没有内置汇率，但我们可以通过合约内部的映射来手动维护一组兑换比例，从而实现'打赏 1 美元 = 支付 X 数量 ETH'的功能。",pure_function:"📖 pure 函数承诺不读取也不修改区块链的状态变量。这意味着它的执行结果完全取决于输入参数，可以在本地快速计算，不需要消耗 Gas。",view_function:"📖 view 函数可以读取状态变量但不修改它们。由于不修改状态，view 函数也可以在本地执行，不消耗 Gas，适合用于查询操作。",cross_contract_call:"📖 跨合约调用是 Solidity 的核心特性之一。通过合约地址，一个合约可以调用另一个合约的函数，实现功能的组合和复用，就像乐高积木一样。",interface_call:"📖 接口方式调用是最常用的跨合约调用方法。通过创建外部合约的接口实例，可以像调用本地函数一样调用外部合约，代码清晰易读。",low_level_call:"📖 底层 call 方法提供了最大的灵活性。它通过 abi.encodeWithSignature 编码函数调用，可以调用任何函数，即使接口未知。但使用起来更复杂，需要手动处理返回值。",newton_iteration:"📖 牛顿迭代法是一种快速逼近方程根的算法。在 Solidity 中，由于不支持浮点数运算，我们使用整数运算通过多次迭代来逼近真实值。限制迭代次数可以防止 Gas 耗尽。",contract_composition:"📖 合约组合是 Solidity 的重要设计理念。通过将功能拆分到多个合约，可以实现代码复用、降低复杂度、提高可维护性。这是构建复杂 DApp 的基础。",struct_definition:"📖 `struct` 结构体允许你定义自定义的数据类型，将多个不同类型的变量打包在一起。这是组织复杂数据的有效方式，让代码更加清晰和易于维护。",array_in_mapping:"📖 Solidity 允许将映射指向数组，如 `mapping(address => WorkoutActivity[])`。这样每个地址都有一个动态数组，非常适合存储用户的历史记录、交易列表等一对多的数据关系。",multiple_mappings:"📖 在实际应用中，经常使用多个 mapping 来存储不同维度的数据。比如一个 mapping 存用户资料，另一个存用户余额。通过同一个 key（如用户地址）可以关联访问多个数据结构。",storage_keyword:"📖 `storage` 和 `memory` 是 Solidity 中两个重要的数据位置关键字。`storage` 变量永久存储在区块链状态中，而 `memory` 变量只在函数执行期间临时存在。使用 `storage` 引用可以直接修改状态变量，节省 Gas。",event_logging:"📖 事件（Event）是 Solidity 的日志机制。通过 `emit` 触发事件，数据会被记录在区块链的交易日志中。前端可以监听事件来实现实时通知、记录历史等功能，事件是 DApp 前后端通信的重要桥梁。",milestone_detection:"📖 里程碑检测是游戏化应用的核心机制。通过条件判断（如 `if (count == 10)`）检测用户是否达成特定目标，并触发相应奖励或通知。这能激励用户持续使用产品。",timestamp_usage:"📖 `block.timestamp` 是当前区块的时间戳（Unix 时间，秒）。它常用于记录事件发生时间、设置时间限制、计算时间差等。注意它由矿工设置，存在约15秒的误差，不应用于精确计时。",onlyRegistered_modifier:"📖 修饰符（Modifier）是 Solidity 的复用机制，用于在函数执行前添加前置条件检查。`onlyRegistered` 确保只有满足条件的用户（已注册）才能调用函数。这简化了代码，避免了在每个函数中重复写检查逻辑。"})[e]||"📖 点击其他概念标签查看更多详细解释。",cu=e=>({inheritance:"📖 合约继承是 Solidity 的核心特性之一。通过 `contract VaultMaster is Ownable`，子合约可以继承父合约的所有状态变量和函数，实现代码复用和模块化设计。",import_statement:"📖 `import` 语句用于导入其他合约文件，让你可以在当前合约中使用外部定义的合约。这是实现合约组合和代码复用的基础。",constructor:"📖 构造函数 `constructor()` 在合约部署时自动执行一次，用于初始化合约的状态变量。在 Ownable 中，它将合约部署者设置为初始所有者。",private_visibility:"📖 `private` 可见性修饰符表示变量只能在当前合约内部访问，即使是子合约也无法直接访问。这提供了最强的封装性，保护敏感数据。",event_logging:"📖 事件（Event）用于记录重要的合约操作到区块链日志中。前端可以监听事件来实现实时通知。`DepositSuccessful` 和 `WithdrawSuccessful` 记录了资金流动。",indexed_parameter:"📖 `indexed` 关键字标记事件参数，允许前端按该参数过滤和搜索事件日志。这在处理大量事件时非常有用，可以快速找到特定地址相关的事件。",transfer_ownership:"📖 `transferOwnership()` 函数实现了合约所有权的转移。只有当前所有者可以调用此函数，并且通常会检查新地址是否有效（非零地址）。",onlyOwner_modifier:"📖 `onlyOwner` 修饰符是权限控制的核心机制。它检查 `msg.sender` 是否等于 `owner`，如果不是则回滚交易。这是保护敏感操作（如提款）的标准做法。"})[e]||"📖 点击其他概念标签查看更多详细解释。",Mc={erc20_standard:{name:"ERC20 标准",icon:"🪙",unlockAt:1,message:"你了解了 ERC20 代币标准！它是以太坊上最通用的代币规范，定义了代币的基本功能接口。",code:`// ERC20 标准接口
interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address to, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address from, address to, uint256 amount) external returns (bool);
    
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}`},mapping_nested:{name:"嵌套映射",icon:"🗂️",unlockAt:2,message:"你发现了嵌套映射 mapping(address => mapping(address => uint256))！这是存储授权额度的核心数据结构。",code:`// 嵌套映射：记录每个地址授权给其他地址的额度
mapping(address => mapping(address => uint256)) public allowance;

// 示例：Alice 授权 Carol 使用 500 COM
allowance[Alice][Carol] = 500;  // Carol 可以使用 Alice 的 500 COM`},event:{name:"事件日志",icon:"📋",unlockAt:3,message:"你触发了事件！Transfer 和 Approval 事件记录了代币的转移和授权操作，前端可以监听这些事件。",code:`// 定义事件
event Transfer(address indexed from, address indexed to, uint256 value);
event Approval(address indexed owner, address indexed spender, uint256 value);

// 触发事件
emit Transfer(msg.sender, _to, _value);
emit Approval(msg.sender, _spender, _value);`},transfer:{name:"转账函数",icon:"💸",unlockAt:4,message:"你使用了 transfer 函数！它是 ERC20 最核心的功能，允许用户将自己的代币转给他人。",code:`// 转账函数：调用者将自己的代币转给他人
function transfer(address _to, uint256 _value) public returns (bool) {
    require(balanceOf[msg.sender] >= _value, "Not enough balance");
    _transfer(msg.sender, _to, _value);
    return true;
}`},approve:{name:"授权函数",icon:"✅",unlockAt:5,message:"你使用了 approve 函数！它允许你授权他人使用你的代币，这是 DeFi 应用的基础机制。",code:`// 授权函数：允许 spender 使用调用者的代币
function approve(address _spender, uint256 _value) public returns (bool) {
    allowance[msg.sender][_spender] = _value;
    emit Approval(msg.sender, _spender, _value);
    return true;
}`},allowance:{name:"授权额度",icon:"🔍",unlockAt:6,message:"你查询了 allowance！它返回被授权者可以使用的代币数量，是授权机制的重要组成部分。",code:`// 查询授权额度
function allowance(address _owner, address _spender) 
    public view returns (uint256) {
    return allowance[_owner][_spender];
}

// 使用场景：检查 Carol 还能使用 Alice 多少代币
uint256 remaining = allowance(Alice, Carol);  // 返回剩余额度`},transferFrom:{name:"代转账函数",icon:"🔄",unlockAt:7,message:"你使用了 transferFrom 函数！它允许被授权者代替他人转账，实现了'第三方代付'功能。",code:`// 代转账函数：被授权者从他人账户转账
function transferFrom(address _from, address _to, uint256 _value) 
    public returns (bool) {
    require(balanceOf[_from] >= _value, "Not enough balance");
    require(allowance[_from][msg.sender] >= _value, "Allowance too low");
    
    allowance[_from][msg.sender] -= _value;  // 减少授权额度
    _transfer(_from, _to, _value);
    return true;
}`}},lu=e=>({erc20_standard:"🪙 太棒了！你了解了 ERC20 代币标准！这是以太坊上最通用的代币规范。👉 查询 Alice 余额来学习 mapping 存储机制！",mapping_nested:"🗂️ 优秀！你了解了嵌套映射！这是 ERC20 授权机制的核心数据结构。👉 转账给 Bob 来学习事件和转账函数！",event:"📋 很好！你触发了事件日志！👉 继续探索更多功能！",transfer:"💸 太棒了！你使用了 transfer 函数！👉 授权给 Carol 来学习授权机制！",approve:"✅ 很好！你使用了 approve 函数！👉 查询 allowance 来学习授权额度查询！",allowance:"🔍 优秀！你了解了授权额度查询！👉 切换到 Carol 执行代转账来学习 transferFrom！",transferFrom:"🔄 太棒了！你使用了 transferFrom 函数！🎉 你已掌握 ERC20 全部核心功能！"})[e]||"📖 点击其他概念标签查看更多详细解释。",uu=e=>({erc20_standard:"📖 ERC20 是以太坊上最常用的代币标准，定义了代币的基本功能接口，包括转账、授权、查询余额等。所有符合 ERC20 标准的代币都可以在支持该标准的钱包和交易所中使用。",mapping_nested:"📖 嵌套映射 mapping(address => mapping(address => uint256)) 是 ERC20 中存储授权额度的核心数据结构。外层映射的 key 是代币持有者，内层映射的 key 是被授权者，value 是授权额度。",event:"📖 事件（Event）是 Solidity 的日志机制。ERC20 定义了 Transfer 和 Approval 两个标准事件，分别记录代币转移和授权操作。前端可以监听这些事件来实时更新界面。",transfer:"📖 transfer 函数是 ERC20 最核心的功能，允许代币持有者将自己的代币转给他人。函数会检查余额是否充足，然后更新双方余额并触发 Transfer 事件。",approve:"📖 approve 函数实现了授权机制，允许代币持有者授权他人使用自己的代币。这在 DeFi 应用中非常重要，比如授权 DEX 使用你的代币进行交易。",allowance:"📖 allowance 函数用于查询授权额度，返回被授权者还可以使用持有者的代币数量。在执行 transferFrom 之前，通常需要先检查 allowance 是否充足。",transferFrom:"📖 transferFrom 函数实现了代转账功能，允许被授权者代替持有者转账。这是 ERC20 的高级功能，常用于需要第三方代为执行转账的场景，如自动扣款、代理交易等。"})[e]||"📖 点击其他概念标签查看更多详细解释。",Me=Fs("operationLog",()=>{const e=Z([]),t=Z({}),s=Z({}),n=(p,g,m,w=null)=>{const A=new Date().toLocaleTimeString("zh-CN",{hour12:!1});let U=0,F=0;w&&Er[w]&&(U=Er[w],F=U*Dr,t.value[p]||(t.value[p]=0),t.value[p]+=U),s.value[p]||(s.value[p]=0),s.value[p]++;const v={id:`${p}-${Date.now()}-${Math.random()}`,day:p,timestamp:A,operation:g,details:m,gasUsed:U,ethCost:F};return e.value.unshift(v),v},r=p=>{e.value=e.value.filter(g=>g.day!==p)},o=()=>{e.value=[],t.value={},s.value={}},i=p=>e.value.filter(g=>g.day===p).slice(0,10),a=p=>t.value[p]||0,c=p=>(t.value[p]||0)*Dr,u=p=>s.value[p]||0,l=y(()=>e.value.slice(0,20));return{logs:e,dayGasUsage:t,dayOperationCounts:s,recentLogs:l,addLog:n,clearDayLogs:r,clearAllLogs:o,getDayLogs:i,getDayGasUsage:a,getDayEthCost:c,getDayOperationCount:u}});function Rc(){const e=We(),t=Ie(),s=Me(),n=e.contracts.day1,r=y(()=>n.count),o=y(()=>n.interactionCount),i=()=>{n.count++,n.interactionCount++,s.addLog(1,"点击计数器","Counter +1","increment"),t.incrementInteraction(1);const g=n.count;g===1?t.unlockConcept(1,"function"):g===2?t.unlockConcept(1,"increment"):g===3?t.unlockConcept(1,"uint256"):g===4&&t.unlockConcept(1,"contract")},a=()=>{n.count=0,s.addLog(1,"重置计数器","Counter reset to 0","reset")},c=y(()=>t.dayProgress[1]),u=y(()=>t.getProgressPercentage(1)),l=y(()=>t.dayProgress[1].unlockedConcepts),p=y(()=>({gasUsage:s.getDayGasUsage(1),ethCost:s.getDayEthCost(1),operationCount:s.getDayOperationCount(1)}));return{counter:r,interactionCount:o,progress:c,progressPercentage:u,unlockedConcepts:l,realtimeData:p,clickCounter:i,resetCounter:a}}function $c(){const e=We(),t=Ie(),s=Me(),n=e.contracts.day2,r=t.dayProgress[2],o=y(()=>n.name),i=y(()=>n.bio),a=y(()=>n.hasStored),c=y(()=>n.hasRetrieved),u=y(()=>n.interactionCount),l=(U,F)=>{n.name=U,n.bio=F,n.hasStored=!0,n.interactionCount++,r.interactionCount++,s.addLog(2,"存储数据",`存储: ${U}`,"addData"),["string","private","memory"].forEach(D=>{t.unlockConcept(2,D)})},p=()=>(n.hasRetrieved=!0,n.interactionCount++,r.interactionCount++,s.addLog(2,"检索数据",`查询: ${o.value}`),["view","parameters","returns"].forEach(F=>{t.unlockConcept(2,F)}),{name:o.value,bio:i.value}),g=y(()=>r),m=y(()=>!r||r.totalConcepts===0?0:Math.floor(r.unlockedConcepts.length/r.totalConcepts*100)),w=y(()=>r.unlockedConcepts),A=y(()=>({gasUsage:s.getDayGasUsage(2),ethCost:s.getDayEthCost(2),operationCount:s.getDayOperationCount(2)}));return{name:o,bio:i,hasStored:a,hasRetrieved:c,interactionCount:u,progress:g,progressPercentage:m,unlockedConcepts:w,realtimeData:A,storeData:l,retrieveData:p}}function Lc(){const e=We(),t=Ie(),s=Me(),n=e.contracts.day3,r=y(()=>n.candidates),o=y(()=>n.voteCount),i=y(()=>n.interactionCount),a=m=>{if(!m||m.trim()==="")return;n.candidates.push(m),n.voteCount[m]=0,n.interactionCount++,t.incrementInteraction(3),s.addLog(3,"添加候选人",`候选人: ${m}`,"addCandidate");const w=n.candidates.length;w===1?t.unlockConcept(3,"array"):w===2?t.unlockConcept(3,"push"):w===3&&t.unlockConcept(3,"mapping")},c=m=>{n.voteCount[m]!==void 0&&(n.voteCount[m]++,n.interactionCount++,t.incrementInteraction(3),s.addLog(3,"投票",`投给 ${m}`,"vote"),t.unlockConcept(3,"compound_assignment"))},u=y(()=>t.dayProgress[3]),l=y(()=>t.getProgressPercentage(3)),p=y(()=>t.dayProgress[3].unlockedConcepts),g=y(()=>({gasUsage:s.getDayGasUsage(3),ethCost:s.getDayEthCost(3),operationCount:s.getDayOperationCount(3)}));return{candidates:r,voteCount:o,interactionCount:i,progress:u,progressPercentage:l,unlockedConcepts:p,realtimeData:g,addCandidate:a,voteCandidate:c}}function Ic(){const e=We(),t=Ie(),s=Me(),n=e.contracts.day4,r=t.dayProgress[4],o=Z(null),i=y(()=>n.owner),a=y(()=>n.item),c=y(()=>n.auctionEndTime),u=y(()=>n.highestBidder),l=y(()=>n.highestBid),p=y(()=>n.ended),g=y(()=>n.bids),m=y(()=>n.bidders),w=y(()=>n.interactionCount),A=(h,L)=>{n.owner=e.generateAddress(),n.item=h,n.auctionEndTime=Math.floor(Date.now()/1e3)+L,n.interactionCount++,r.interactionCount++,s.addLog(4,"初始化拍卖",`物品: ${h}, 时长: ${L}秒`),t.unlockConcept(4,"constructor"),t.unlockConcept(4,"block_timestamp")},U=(h,L)=>{if(n.ended||Math.floor(Date.now()/1e3)>=n.auctionEndTime||h<=0)return!1;const B=n.bids[L]||0;return h<=B?!1:(n.bids[L]=h,n.interactionCount++,r.interactionCount++,B===0&&n.bidders.push(L),h>n.highestBid&&(n.highestBid=h,n.highestBidder=L),s.addLog(4,"出价",`出价 ${h}`,"placeBid"),t.unlockConcept(4,"require"),n.bidders.length>=1&&t.unlockConcept(4,"msg_sender"),(n.bidders.length>=2||n.interactionCount>=2)&&t.unlockConcept(4,"external"),!0)},F=()=>Math.floor(Date.now()/1e3)<n.auctionEndTime||n.ended?!1:(n.ended=!0,n.interactionCount++,r.interactionCount++,s.addLog(4,"结束拍卖","拍卖已结束","endAuction"),t.unlockConcept(4,"bool_type"),!0),v=()=>n.ended?(n.interactionCount++,r.interactionCount++,s.addLog(4,"查看获胜者",`获胜者: ${n.highestBidder}`),t.unlockConcept(4,"address_type"),o.value={winner:n.highestBidder,bid:n.highestBid},o.value):null,D=h=>h?new Date(h*1e3).toLocaleString("zh-CN"):"未设置",k=()=>Math.floor(Date.now()/1e3)>=n.auctionEndTime,C=y(()=>r),E=y(()=>!r||r.totalConcepts===0?0:Math.floor(r.unlockedConcepts.length/r.totalConcepts*100)),$=y(()=>r.unlockedConcepts),b=y(()=>({gasUsage:s.getDayGasUsage(4),ethCost:s.getDayEthCost(4),operationCount:s.getDayOperationCount(4)}));return{owner:i,item:a,auctionEndTime:c,highestBidder:u,highestBid:l,ended:p,bids:g,bidders:m,interactionCount:w,winner:o,progress:C,progressPercentage:E,unlockedConcepts:$,realtimeData:b,initializeAuction:A,placeBid:U,endAuction:F,getWinner:v,formatTime:D,checkAuctionEnded:k}}function Fc(){const e=We(),t=Ie(),s=Me(),n=Z(""),r=Z(""),o=Z(""),i=Z(""),a=Z(""),c=y(()=>(e.initializeContract(5),e.getContract(5))),u=y(()=>{var b;return((b=c.value)==null?void 0:b.owner)||""}),l=y(()=>{var b;return((b=c.value)==null?void 0:b.treasureAmount)||0}),p=y(()=>{var b;return((b=c.value)==null?void 0:b.userAddress)||""}),g=y(()=>{var b;return((b=c.value)==null?void 0:b.userAllowance)||0}),m=y(()=>{var b;return(b=c.value)!=null&&b.hasWithdrawn?!!c.value.hasWithdrawn[p.value]:!1}),w=b=>!b||b<=0?!1:(c.value.treasureAmount+=b,c.value.interactionCount++,t.incrementInteraction(5),s.addLog(5,"添加宝藏",`数量: ${b}`,"addTreasure"),t.unlockConcept(5,"modifier"),!0),A=(b,h)=>!b||!h||h<=0?!1:(h<=c.value.treasureAmount&&(c.value.withdrawalAllowance[b]=h,b===c.value.userAddress&&(c.value.userAllowance=h)),c.value.interactionCount++,t.incrementInteraction(5),s.addLog(5,"批准提款",`批准 ${b}: ${h}`,"approveWithdrawal"),t.unlockConcept(5,"return_statement"),!0),U=(b,h)=>{if(!b||!h||h<=0)return!1;const L=!1;if(b===c.value.owner)h<=c.value.treasureAmount&&(c.value.treasureAmount-=h,L=!0);else{const P=c.value.withdrawalAllowance[b];P>0&&!c.value.hasWithdrawn[b]&&P<=c.value.treasureAmount&&P>=h&&(c.value.hasWithdrawn[b]=!0,c.value.treasureAmount-=P,c.value.withdrawalAllowance[b]=0,b===c.value.userAddress&&(c.value.userAllowance=0),L=!0)}return c.value.interactionCount++,t.incrementInteraction(5),L&&s.addLog(5,"提取宝藏",`提取: ${h}`,"withdrawTreasure"),!0},F=b=>(b||(b=c.value.userAddress),c.value.hasWithdrawn[b]=!1,c.value.interactionCount++,t.incrementInteraction(5),s.addLog(5,"重置提款状态",`重置: ${b}`),!0),v=b=>!b||b==="0x0000000000000000000000000000000000000000"?!1:(c.value.owner=b,c.value.interactionCount++,t.incrementInteraction(5),s.addLog(5,"转移所有权",`新所有者: ${b}`,"transferOwnership"),t.unlockConcept(5,"zero_address"),!0),D=()=>(c.value.interactionCount++,t.incrementInteraction(5),s.addLog(5,"查询宝藏",`宝藏数量: ${c.value.treasureAmount}`),t.unlockConcept(5,"return_statement"),c.value.treasureAmount),k=y(()=>t.dayProgress[5]),C=y(()=>{const b=t.dayProgress[5];return!b||b.totalConcepts===0?0:Math.floor(b.unlockedConcepts.length/b.totalConcepts*100)}),E=y(()=>t.dayProgress[5].unlockedConcepts),$=y(()=>({gasUsage:s.getDayGasUsage(5),ethCost:s.getDayEthCost(5),operationCount:s.getDayOperationCount(5)}));return{inputTreasureAmount:n,inputRecipient:r,inputAllowance:o,inputWithdrawAmount:i,inputNewOwner:a,owner:u,treasureAmount:l,userAddress:p,userAllowance:g,hasWithdrawn:m,progress:k,progressPercentage:C,unlockedConcepts:E,realtimeData:$,addTreasure:w,approveWithdrawal:A,withdrawTreasure:U,resetWithdrawalStatus:F,transferOwnership:v,getTreasureDetails:D}}function Uc(){const e=We(),t=Ie(),s=Me(),n=e.contracts.day6,r=t.dayProgress[6],o=Z(null),i=Z([]),a=y(()=>n.bankManager),c=y(()=>n.members),u=y(()=>n.userAddress),l=y(()=>n.balance[n.userAddress]||0),p=y(()=>n.interactionCount),g=E=>(e.initializeContract(6),E==="0x0000000000000000000000000000000000000000"||E===n.bankManager||n.registeredMembers[E]?!1:(n.registeredMembers[E]=!0,n.members.push(E),n.balance[E]=0,n.interactionCount++,r.interactionCount++,s.addLog(6,"添加会员",`会员: ${E}`,"addMembers"),t.unlockConcept(6,"address_mapping_balance"),!0)),m=E=>{e.initializeContract(6);const $=n.userAddress;if(!n.registeredMembers[$])return!1;const b=E*1e18;return n.balance[$]+=b,n.interactionCount++,r.interactionCount++,s.addLog(6,"存入ETH",`存入 ${E} ETH`,"depositAmountEther"),t.unlockConcept(6,"payable"),t.unlockConcept(6,"msg_value"),!0},w=E=>{e.initializeContract(6);const $=n.userAddress;if(!n.registeredMembers[$])return!1;const b=E*1e18;return n.balance[$]<b?!1:(n.balance[$]-=b,n.interactionCount++,r.interactionCount++,s.addLog(6,"提取ETH",`提取 ${E} ETH`,"withdrawAmount"),t.unlockConcept(6,"wei_unit"),t.unlockConcept(6,"ether_deposit_withdraw"),!0)},A=E=>(e.initializeContract(6),n.interactionCount++,r.interactionCount++,o.value=n.balance[E]||0,s.addLog(6,"查询余额",`查询: ${E}`),o.value),U=()=>(e.initializeContract(6),n.interactionCount++,r.interactionCount++,i.value=[...n.members],i.value),F=E=>(E/1e18).toFixed(4)+" ETH",v=y(()=>r),D=y(()=>!r||r.totalConcepts===0?0:Math.floor(r.unlockedConcepts.length/r.totalConcepts*100)),k=y(()=>r.unlockedConcepts),C=y(()=>({gasUsage:s.getDayGasUsage(6),ethCost:s.getDayEthCost(6),operationCount:s.getDayOperationCount(6)}));return{bankManager:a,members:c,userAddress:u,userBalance:l,interactionCount:p,queryBalance:o,membersList:i,progress:v,progressPercentage:D,unlockedConcepts:k,realtimeData:C,addMembers:g,depositEther:m,withdrawEth:w,getBalance:A,getMembers:U,formatBalance:F}}function Hc(){const e=We(),t=Ie(),s=Me(),n=e.contracts.day7,r=t.dayProgress[7],o=Z(null),i=y(()=>n.owner),a=y(()=>n.userAddress),c=y(()=>n.friendList),u=y(()=>n.balances[n.userAddress]||0),l=y(()=>n.debts),p=y(()=>n.interactionCount),g=h=>(e.initializeContract(7),n.registeredFriends[h]?!1:(n.registeredFriends[h]=!0,n.friendList.push(h),n.balances[h]=0,n.interactionCount++,r.interactionCount++,s.addLog(7,"添加好友",`好友: ${h}`,"addFriend"),t.unlockConcept(7,"nested_mapping"),!0)),m=h=>{e.initializeContract(7);const L=n.userAddress;if(!n.registeredFriends[L])return!1;const P=h*1e18;return n.balances[L]=(n.balances[L]||0)+P,n.interactionCount++,r.interactionCount++,s.addLog(7,"存款",`存入 ${h} ETH`,"depositIntoWallet"),t.unlockConcept(7,"address_payable"),!0},w=(h,L)=>{e.initializeContract(7);const P=n.userAddress,B=L*1e18;return n.debts[h]||(n.debts[h]={}),n.debts[h][P]=(n.debts[h][P]||0)+B,n.interactionCount++,r.interactionCount++,s.addLog(7,"记录债务",`债务人: ${h}, 金额: ${L} ETH`,"recordDebt"),t.unlockConcept(7,"debt_tracking"),!0},A=(h,L)=>{e.initializeContract(7);const P=n.userAddress,B=L*1e18;return(n.balances[P]||0)<B?"余额不足：你的钱包可用余额小于还款金额！":(n.balances[P]-=B,n.balances[h]=(n.balances[h]||0)+B,n.debts[P]&&n.debts[P][h]&&(n.debts[P][h]-=B,n.debts[P][h]<0&&(n.debts[P][h]=0)),n.interactionCount++,r.interactionCount++,s.addLog(7,"还款",`债权人: ${h}, 金额: ${L} ETH`,"payFromWallet"),t.unlockConcept(7,"internal_transfer"),!0)},U=(h,L)=>{e.initializeContract(7);const P=n.userAddress,B=L*1e18;return(n.balances[P]||0)<B?"余额不足：试图转账的金额超过了你拥有的钱包余额！":(n.balances[P]-=B,n.balances[h]=(n.balances[h]||0)+B,n.interactionCount++,r.interactionCount++,s.addLog(7,"转账(transfer)",`收款方: ${h}, 金额: ${L} ETH`,"transferEther"),t.unlockConcept(7,"transfer_method"),!0)},F=(h,L)=>{e.initializeContract(7);const P=n.userAddress,B=L*1e18;return(n.balances[P]||0)<B?"余额不足：低级调用失败，因为你的钱包没有足够的以太币！":(n.balances[P]-=B,n.balances[h]=(n.balances[h]||0)+B,n.interactionCount++,r.interactionCount++,s.addLog(7,"转账call",`收款方: ${h}, 金额: ${L} ETH`,"transferEtherViaCall"),t.unlockConcept(7,"call_method"),!0)},v=h=>{e.initializeContract(7);const L=n.userAddress,P=h*1e18;return(n.balances[L]||0)<P?"余额不足：你无法提取超过拥有额度的资金！":(n.balances[L]-=P,n.interactionCount++,r.interactionCount++,s.addLog(7,"提款",`提取 ${h} ETH`,"withdraw"),t.unlockConcept(7,"withdraw_pattern"),!0)},D=()=>{e.initializeContract(7);const h=n.userAddress;return o.value=n.balances[h]||0,n.interactionCount++,r.interactionCount++,s.addLog(7,"查询余额",`余额: ${(o.value/1e18).toFixed(4)} ETH`),t.unlockConcept(7,"withdraw_pattern"),o.value},k=h=>(h/1e18).toFixed(4)+" ETH",C=y(()=>r),E=y(()=>!r||r.totalConcepts===0?0:Math.floor(r.unlockedConcepts.length/r.totalConcepts*100)),$=y(()=>r.unlockedConcepts),b=y(()=>({gasUsage:s.getDayGasUsage(7),ethCost:s.getDayEthCost(7),operationCount:s.getDayOperationCount(7)}));return{owner:i,userAddress:a,friendsList:c,userBalance:u,debts:l,interactionCount:p,checkedBalance:o,progress:C,progressPercentage:E,unlockedConcepts:$,realtimeData:b,iouAddFriend:g,iouDeposit:m,iouRecordDebt:w,iouPayDebt:A,iouTransferMethod:U,iouCallMethod:F,iouWithdraw:v,iouCheckBalance:D,formatBalance:k}}function Wc(){const e=We(),t=Ie(),s=Me(),n=e.contracts.day8,r=t.dayProgress[8],o=y(()=>n.owner),i=y(()=>n.userAddress),a=y(()=>n.isUserAdmin),c=y(()=>n.totalTipsReceived),u=y(()=>n.supportedCurrencies),l=y(()=>n.conversionRates),p=y(()=>n.interactionCount),g=()=>{e.initializeContract(8),n.isUserAdmin=!n.isUserAdmin,n.interactionCount++,r.interactionCount++,s.addLog(8,"切换管理员模式",n.isUserAdmin?"开启管理员模式":"关闭管理员模式"),t.unlockConcept(8,"modifier_onlyOwner")},m=E=>{e.initializeContract(8);const $=E*1e18;n.totalTipsReceived+=$;const b=n.userAddress;n.tipPerPerson[b]=(n.tipPerPerson[b]||0)+$,n.interactionCount++,r.interactionCount++,s.addLog(8,"打赏ETH",`打赏 ${E} ETH`,"tipInEth"),t.unlockConcept(8,"payable_tip")},w=(E,$)=>{e.initializeContract(8);const b=n.conversionRates[E];if(!b)return!1;const h=$*b;n.totalTipsReceived+=h;const L=n.userAddress;return n.tipPerPerson[L]=(n.tipPerPerson[L]||0)+h,n.tipsPerCurrency[E]||(n.tipsPerCurrency[E]=0),n.tipsPerCurrency[E]+=$,n.interactionCount++,r.interactionCount++,s.addLog(8,"打赏货币",`打赏 ${$} ${E}`,"tipInCurrency"),t.unlockConcept(8,"msg_value_tip"),t.unlockConcept(8,"mapping_rates"),!0},A=()=>(e.initializeContract(8),n.isUserAdmin?n.totalTipsReceived===0?"revert: No tips to withdraw":(n.totalTipsReceived=0,n.interactionCount++,r.interactionCount++,s.addLog(8,"提取小费","提取所有小费","withdrawTips"),t.unlockConcept(8,"address_balance"),t.unlockConcept(8,"call_withdraw"),!0):"revert: Only owner can perform this action"),U=()=>{const E=n.userAddress,$=n.tipPerPerson[E]||0;return s.addLog(8,"查询打赏",`累计打赏: ${($/1e18).toFixed(4)} ETH`),$},F=E=>(E/1e18).toFixed(4)+" ETH",v=y(()=>r),D=y(()=>!r||r.totalConcepts===0?0:Math.floor(r.unlockedConcepts.length/r.totalConcepts*100)),k=y(()=>r.unlockedConcepts),C=y(()=>({gasUsage:s.getDayGasUsage(8),ethCost:s.getDayEthCost(8),operationCount:s.getDayOperationCount(8)}));return{owner:o,userAddress:i,isAdmin:a,totalTips:c,supportedCurrencies:u,conversionRates:l,interactionCount:p,progress:v,progressPercentage:D,unlockedConcepts:k,realtimeData:C,tipJarToggleAdmin:g,tipJarTipInEth:m,tipJarTipInCurrency:w,tipJarWithdraw:A,getUserTips:U,formatBalance:F}}function qc(){const e=We(),t=Ie(),s=Me(),n=e.contracts.day9,r=t.dayProgress[9],o=y(()=>n.owner),i=y(()=>n.userAddress),a=y(()=>n.isUserAdmin),c=y(()=>n.scientificCalculatorAddress),u=y(()=>n.isAddressSet),l=y(()=>n.operationCount),p=y(()=>n.operationHistory),g=y(()=>n.interactionCount),m=y(()=>n.challengeTasks||{setAddress:!1,powerCalc:!1,sqrtCalc:!1,permissionCheck:!1}),w=()=>{e.initializeContract(9),n.isUserAdmin=!n.isUserAdmin,s.addLog(9,"切换身份",n.isUserAdmin?"切换为管理员":"切换为用户")},A=(P,B,Y)=>{if(e.initializeContract(9),isNaN(B)||isNaN(Y))throw new Error("请输入有效的数字");let te;switch(P){case"add":te=B+Y;break;case"subtract":te=B-Y;break;case"multiply":te=B*Y;break;case"divide":if(Y===0)throw new Error("不能除以零");te=B/Y;break;default:throw new Error("未知运算符")}n.operationCount++,n.operationHistory.push({operator:P,a:B,b:Y,result:te,timestamp:Date.now()}),n.interactionCount++,r.interactionCount++;const me={add:"加法",subtract:"减法",multiply:"乘法",divide:"除法"};return s.addLog(9,"基础运算",`${me[P]}: ${B} ${P==="add"?"+":P==="subtract"?"-":P==="multiply"?"×":"÷"} ${Y} = ${te}`),n.operationCount>=3&&t.unlockConcept(9,"pure_function"),te},U=P=>{if(e.initializeContract(9),!n.isUserAdmin)throw new Error("Only owner can do this action");if(!P||P.length<3)throw new Error("请输入合约地址");if(!P.startsWith("0x"))throw new Error("合约地址必须以 0x 开头");return n.scientificCalculatorAddress=P,n.isAddressSet=!0,n.interactionCount++,r.interactionCount++,s.addLog(9,"设置合约地址",`科学计算器地址: ${P}`),n.challengeTasks||(n.challengeTasks={setAddress:!1,powerCalc:!1,sqrtCalc:!1,permissionCheck:!1}),n.challengeTasks.setAddress=!0,t.unlockConcept(9,"modifier_onlyOwner"),!0},F=(P,B)=>{if(e.initializeContract(9),!n.isAddressSet)throw new Error("请先设置ScientificCalculator合约地址");if(isNaN(P)||isNaN(B))throw new Error("请输入有效的数字");let Y=1;for(let te=0;te<B;te++)Y*=P;return n.interactionCount++,r.interactionCount++,s.addLog(9,"指数运算",`${P}^${B} = ${Y}`),n.challengeTasks||(n.challengeTasks={setAddress:!1,powerCalc:!1,sqrtCalc:!1,permissionCheck:!1}),n.challengeTasks.powerCalc=!0,t.unlockConcept(9,"view_function"),t.unlockConcept(9,"cross_contract_call"),t.unlockConcept(9,"interface_call"),Y},v=P=>{if(e.initializeContract(9),!n.isAddressSet)throw new Error("请先设置ScientificCalculator合约地址");if(isNaN(P)||P<0)throw new Error("请输入有效的非负数字");let B=P/2;const Y=[];for(let te=0;te<10;te++){const me=B;B=(B+P/B)/2,Y.push({round:te+1,value:B,prevValue:me,formula:`(${me.toFixed(4)} + ${P}/${me.toFixed(4)}) / 2 = ${B.toFixed(4)}`})}return n.interactionCount++,r.interactionCount++,s.addLog(9,"平方根计算",`√${P} ≈ ${Math.floor(B)}`),n.challengeTasks||(n.challengeTasks={setAddress:!1,powerCalc:!1,sqrtCalc:!1,permissionCheck:!1}),n.challengeTasks.sqrtCalc=!0,t.unlockConcept(9,"low_level_call"),{result:Math.floor(B),steps:Y}},D=async(P,B=!1)=>{if(e.initializeContract(9),isNaN(P)||P<0)throw new Error("请输入有效的非负数字");const Y=[];let te=P/2;for(let me=0;me<10;me++){const W=te;te=(te+P/te)/2,Y.push({round:me+1,value:te,prevValue:W,formula:`(${W.toFixed(4)} + ${P}/${W.toFixed(4)}) / 2 = ${te.toFixed(4)}`}),B&&await new Promise(q=>setTimeout(q,500))}return n.interactionCount++,r.interactionCount++,s.addLog(9,"牛顿迭代",`计算 √${P} 的迭代过程`),t.unlockConcept(9,"newton_iteration"),Y},k=P=>(e.initializeContract(9),s.addLog(9,"权限验证",P?"以管理员身份验证":"以用户身份验证"),P?(n.challengeTasks||(n.challengeTasks={setAddress:!1,powerCalc:!1,sqrtCalc:!1,permissionCheck:!1}),n.challengeTasks.permissionCheck=!0,{success:!0,message:"验证通过：Owner权限确认"}):{success:!1,message:"验证失败：Only owner can do this action"}),C=()=>{e.initializeContract(9);const P=n.challengeTasks||{setAddress:!1,powerCalc:!1,sqrtCalc:!1,permissionCheck:!1},B=Object.values(P).filter(Y=>Y).length;return B===4?(t.unlockConcept(9,"contract_composition"),{success:!0,message:"🎉 恭喜！你已完成所有挑战任务！"}):{success:!1,message:`还有 ${4-B} 个任务未完成`}},E=y(()=>r),$=y(()=>t.getProgressPercentage(9)),b=y(()=>t.getUnlockedConcepts(9)),h=y(()=>{const P=n.challengeTasks||{setAddress:!1,powerCalc:!1,sqrtCalc:!1,permissionCheck:!1};return Object.values(P).filter(B=>B).length}),L=y(()=>({gasUsage:s.getDayGasUsage(9),ethCost:s.getDayEthCost(9),operationCount:s.getDayOperationCount(9)}));return{owner:o,userAddress:i,isOwner:a,scientificCalculatorAddress:c,isAddressSet:u,operationCount:l,operationHistory:p,interactionCount:g,challengeTasks:m,progress:E,progressPercentage:$,unlockedConcepts:b,completedChallengeCount:h,realtimeData:L,toggleIdentity:w,calculate:A,setScientificCalculator:U,calculatePower:F,calculateSquareRoot:v,runNewtonIteration:D,checkPermission:k,completeChallenge:C}}function Nc(){const e=We(),t=Ie(),s=Me(),n=e.contracts.day10,r=t.dayProgress[10],o=y(()=>n.owner),i=y(()=>n.userAddress),a=y(()=>n.userProfile),c=y(()=>n.workoutHistory),u=y(()=>n.totalWorkouts),l=y(()=>n.totalDistance),p=y(()=>n.milestones),g=y(()=>n.userProfile.isRegistered),m=()=>{e.initializeContract(10)},w=W=>({struct_definition:"📦 太棒了！你学会了使用结构体打包数据！👉 记录一次运动来看看时间戳如何工作！",event_logging:"📋 不错！你触发了事件日志！👉 记录运动来查看运动历史如何存储！",onlyRegistered_modifier:"🛡️ 太棒了！你了解了修饰符如何保护函数！👉 记录运动来解锁更多概念！",timestamp_usage:"⏰ 很好！你学会了记录时间戳！👉 查看运动历史来解锁 array_in_mapping！",array_in_mapping:"🗂️ 很好！你看到了映射到数组的用法！👉 查看统计数据来解锁 multiple_mappings！",multiple_mappings:"🗺️ 优秀！你了解了多个映射如何协同工作！👉 更新体重来解锁 storage_keyword！",storage_keyword:"💾 太棒了！你了解了 storage 的威力！👉 继续记录运动，达成里程碑来解锁 milestone_detection！",milestone_detection:"🏆 恭喜！你达成了里程碑！👉 查看完整代码来复习所有知识！"})[W]||"",A=(W,q)=>{if(m(),n.userProfile.isRegistered)return{success:!1,error:"User already registered"};n.userProfile={name:W,weight:q,isRegistered:!0},n.interactionCount++,r.interactionCount++,s.addLog(10,"注册用户",`用户: ${W}, 体重: ${q}kg`);const z=[];return t.unlockConcept(10,"struct_definition"),z.push(w("struct_definition")),t.unlockConcept(10,"event_logging"),z.push(w("event_logging")),t.unlockConcept(10,"onlyRegistered_modifier"),z.push(w("onlyRegistered_modifier")),{success:!0,unlockedHints:z}},U=(W,q,z)=>{if(m(),!n.userProfile.isRegistered)return{success:!1,error:"User not registered"};const Se={activityType:W,duration:q,distance:z,timestamp:Date.now()};n.workoutHistory.unshift(Se);const ke=n.totalDistance;n.totalWorkouts++,n.totalDistance+=z,n.interactionCount++,r.interactionCount++,s.addLog(10,"记录运动",`${W} ${z}米 ${E(q)}`);const we=!t.isConceptUnlocked(10,"timestamp_usage"),Te=!t.isConceptUnlocked(10,"array_in_mapping");t.unlockConcept(10,"timestamp_usage"),t.unlockConcept(10,"array_in_mapping");const rn=v(ke),bt=[];return we&&bt.push(w("timestamp_usage")),Te&&bt.push(w("array_in_mapping")),rn&&bt.push(w("milestone_detection")),{success:!0,unlockedHints:bt}},F=W=>{if(m(),!n.userProfile.isRegistered)return{success:!1,error:"User not registered"};const q=n.userProfile.weight;let z=!1;W<q&&q>0&&(q-W)*100/q>=5&&(D("weightGoal"),z=!0),n.userProfile.weight=W,n.interactionCount++,r.interactionCount++,s.addLog(10,"更新体重",`${q}kg → ${W}kg`);const Se=!t.isConceptUnlocked(10,"storage_keyword"),ke=!t.isConceptUnlocked(10,"multiple_mappings");t.unlockConcept(10,"storage_keyword"),t.unlockConcept(10,"multiple_mappings");const we=[];return Se&&we.push(w("storage_keyword")),ke&&we.push(w("multiple_mappings")),z&&we.push(w("milestone_detection")),{success:!0,unlockedHints:we}},v=(W,q)=>{const z=n.totalWorkouts,Se=n.totalDistance;let ke=!1;return z===10?(D("workouts10"),ke=!0):z===50&&(D("workouts50"),ke=!0),Se>=1e5&&W<1e5&&(D("distance100K"),ke=!0),ke},D=W=>{const q=n.milestones[W];q&&!q.achieved&&(q.achieved=!0,q.timestamp=Date.now(),t.unlockConcept(10,"milestone_detection"))},k=(W,q)=>q==="minutes"?W*60:q==="hours"?W*3600:W,C=(W,q)=>q==="kilometers"?W*1e3:W,E=W=>{if(W<60)return`${W}秒`;if(W<3600)return`${Math.floor(W/60)}分钟`;{const q=Math.floor(W/3600),z=Math.floor(W%3600/60);return z>0?`${q}小时${z}分钟`:`${q}小时`}},$=W=>W<1e3?`${W}米`:`${(W/1e3).toFixed(2)}公里`,b=W=>new Date(W).toLocaleString("zh-CN",{year:"numeric",month:"2-digit",day:"2-digit",hour:"2-digit",minute:"2-digit"}),h=W=>({跑步:"🏃",Running:"🏃",骑行:"🚴",Cycling:"🚴",游泳:"🏊",Swimming:"🏊",步行:"🚶",Walking:"🚶",瑜伽:"🧘",Yoga:"🧘",篮球:"⛹️",Basketball:"⛹️"})[W]||"💪",L=()=>{const W=!t.isConceptUnlocked(10,"array_in_mapping");return t.unlockConcept(10,"array_in_mapping"),s.addLog(10,"查看运动历史",`共 ${n.workoutHistory.length} 条记录`),W?w("array_in_mapping"):null},P=()=>{const W=!t.isConceptUnlocked(10,"multiple_mappings");return t.unlockConcept(10,"multiple_mappings"),s.addLog(10,"查看统计",`总运动: ${n.totalWorkouts}次, 总距离: ${$(n.totalDistance)}`),W?w("multiple_mappings"):null},B=y(()=>r),Y=y(()=>!r||r.totalConcepts===0?0:Math.floor(r.unlockedConcepts.length/r.totalConcepts*100)),te=y(()=>r.unlockedConcepts),me=y(()=>({gasUsage:s.getDayGasUsage(10),ethCost:s.getDayEthCost(10),operationCount:s.getDayOperationCount(10)}));return{owner:o,userAddress:i,userProfile:a,workoutHistory:c,totalWorkouts:u,totalDistance:l,milestones:p,isRegistered:g,progress:B,progressPercentage:Y,unlockedConcepts:te,realtimeData:me,registerUser:A,logWorkout:U,updateWeight:F,convertToSeconds:k,convertToMeters:C,formatDuration:E,formatDistance:$,formatTimestamp:b,getActivityIcon:h,viewWorkoutHistory:L,viewStatistics:P,initializeContract:m}}function Bc(){const e=We(),t=Ie(),s=Me(),n=y(()=>(e.initializeContract(11),e.getContract(11))),r=y(()=>{var C;return((C=n.value)==null?void 0:C.owner)||""}),o=y(()=>{var C;return((C=n.value)==null?void 0:C.contractBalance)||0}),i=y(()=>{var C;return((C=n.value)==null?void 0:C.userAddress)||""}),a=y(()=>i.value===r.value),c=y(()=>{var C;return((C=n.value)==null?void 0:C.eventLog)||[]}),u=C=>({inheritance:"📦 太棒了！你看到 VaultMaster 继承了 Ownable 的功能！👉 存入 ETH 来学习 import 机制！",constructor:"🏗️ 太棒了！你了解了构造函数！👉 存入 ETH 来学习导入语句和私有变量！",import_statement:"📥 不错！你了解了导入语句！👉 继续存入 ETH 来学习事件日志！",event_logging:"📋 很好！你触发了事件日志！👉 尝试转移所有权来解锁更多概念！",private_visibility:"🔒 优秀！你学会了 private 变量的使用！合约余额等敏感数据都使用 private 保护！",transfer_ownership:"🔑 很好！你了解了所有权转移！👉 尝试以用户身份提取来学习修饰符！",indexed_parameter:"🏷️ 不错！你了解了索引参数！👉 切换到用户身份体验权限控制！",onlyOwner_modifier:"🛡️ 太棒了！你了解了 onlyOwner 修饰符！👉 查看完整代码来学习更多！"})[C]||"",l=C=>{var b;const E=t.dayProgress[11];return((b=E==null?void 0:E.unlockedConcepts)==null?void 0:b.includes(C))?null:(t.unlockConcept(11,C),u(C))},p=()=>"0x"+Array(40).fill(0).map(()=>Math.floor(Math.random()*16).toString(16)).join(""),g=()=>n.value?(n.value.userAddress=n.value.owner,t.incrementInteraction(11),s.addLog(11,"切换身份","切换为所有者身份"),{hint:"✅ 已切换到所有者身份！👉 现在可以转移所有权和提取资金了！"}):null,m=()=>{if(n.value){const C=p();return n.value.userAddress=C,t.incrementInteraction(11),s.addLog(11,"切换身份",`切换为用户身份: ${C.slice(0,10)}...`),{hint:"👤 已切换到用户身份！👉 现在尝试提取资金来体验权限控制！"}}return null},w=()=>{t.incrementInteraction(11),s.addLog(11,"查询所有者",`所有者: ${r.value.slice(0,10)}...`);const C=[],E=l("inheritance");E&&C.push(E);const $=l("constructor");return $&&C.push($),{address:r.value,hint:C.length>0?C.join(`
`):null}},A=()=>(t.incrementInteraction(11),s.addLog(11,"查询余额",`合约余额: ${(o.value/1e18).toFixed(4)} ETH`),o.value),U=C=>{if(!C||C<=0)return{success:!1,error:"金额无效"};const E=Math.floor(C*1e18);n.value.contractBalance+=E,n.value.eventLog.push({name:"DepositSuccessful",icon:"💰",details:`存入 ${C} ETH (${E} wei)`,timestamp:Date.now()}),n.value.interactionCount++,t.incrementInteraction(11),s.addLog(11,"存款",`存入 ${C} ETH`);const $=[],b=l("import_statement");b&&$.push(b);const h=l("event_logging");h&&$.push(h);const L=l("private_visibility");return L&&$.push(L),{success:!0,hints:$}},F=(C,E)=>{if(!C||!E||E<=0)return{success:!1,error:"参数无效"};if(!a.value)return l("onlyOwner_modifier"),t.incrementInteraction(11),s.addLog(11,"提取失败","权限不足：非所有者尝试提取"),{success:!1,error:"❌ 权限不足：只有所有者才能提取资金 🛡️ 解锁知识点：onlyOwner 修饰符！"};const $=Math.floor(E*1e18);return $>o.value?{success:!1,error:"余额不足"}:(n.value.contractBalance-=$,n.value.eventLog.push({name:"WithdrawSuccessful",icon:"💸",details:`提取 ${E} ETH 到 ${C.slice(0,6)}...${C.slice(-4)}`,timestamp:Date.now()}),n.value.interactionCount++,t.incrementInteraction(11),s.addLog(11,"提取资金",`提取 ${E} ETH 到 ${C.slice(0,10)}...`),{success:!0})},v=C=>{var P;if(!C||C==="0x0000000000000000000000000000000000000000")return{success:!1,error:"无效地址"};if(!a.value)return{success:!1,error:"权限不足"};const E=n.value.owner;n.value.owner=C,n.value.userAddress===E&&(n.value.userAddress=C),n.value.eventLog.push({name:"OwnershipTransferred",icon:"🔑",details:`所有权从 ${E.slice(0,6)}... 转移到 ${C.slice(0,6)}...`,timestamp:Date.now()}),n.value.interactionCount++,t.incrementInteraction(11),s.addLog(11,"转移所有权",`${E.slice(0,10)}... → ${C.slice(0,10)}...`);const $=[],b=l("transfer_ownership");b&&$.push(b);const h=l("indexed_parameter");h&&$.push(h);const L=t.dayProgress[11];return(P=L==null?void 0:L.unlockedConcepts)!=null&&P.includes("onlyOwner_modifier")||$.push('🛡️ 想体验权限控制吗？👉 切换到"用户"身份，尝试提取资金！'),{success:!0,hints:$}},D=()=>(t.incrementInteraction(11),s.addLog(11,"查看代码","查看完整合约代码"),{hints:["📖 你已了解所有核心概念！查看完整代码来巩固知识吧！"]}),k=y(()=>({gasUsage:s.getDayGasUsage(11),ethCost:s.getDayEthCost(11),operationCount:s.getDayOperationCount(11)}));return{owner:r,contractBalance:o,userAddress:i,isOwner:a,eventLog:c,realtimeData:k,getOwner:w,getBalance:A,deposit:U,withdraw:F,transferOwnership:v,setOwnerMode:g,setUserMode:m,viewFullCode:D,unlockConceptWithHint:l,getUnlockHint:u}}function jc(){const e=Me(),t=Z({name:"Web3 Compass",symbol:"COM",decimals:18,totalSupply:1e6}),s={alice:"0xAlice7429aC95B2cF0e4b5F1F4E4e8e7D6c5B4A3210",bob:"0xBob8F3a2B1c0D9e8F7A6B5C4D3E2F1A0B9C8D7E6F",carol:"0xCarol5A6B7C8D9E0F1A2B3C4D5E6F7A8B9C0D1E2F"},n=Z({[s.alice]:1e6,[s.bob]:0,[s.carol]:0}),r=Z({[s.alice]:{[s.carol]:0},[s.bob]:{},[s.carol]:{}}),o=Z("alice"),i=Z([{icon:"🟢",name:"Transfer",details:"从: 0x0000...0000 到: Alice 数量: 1,000,000 COM (铸币)",timestamp:Date.now()}]),a=y(()=>s[o.value]),c=v=>v===s.alice?"Alice":v===s.bob?"Bob":v===s.carol?"Carol":v.slice(0,6)+"..."+v.slice(-4),u=v=>v?v===s.alice?"Alice (0xAlice...3210)":v===s.bob?"Bob (0xBob...7E6F)":v===s.carol?"Carol (0xCarol...E2F)":v.slice(0,10)+"..."+v.slice(-8):"",l=v=>{o.value=v;const D={alice:"👑 已切换到 Alice（代币持有者）",bob:"👤 已切换到 Bob（普通用户）",carol:"🔑 已切换到 Carol（可被授权者）"};return e.addLog(12,"切换角色",D[v]),{success:!0,message:D[v],hints:[],nextStep:""}},p=v=>{const D=n.value[v]||0,k=c(v);return e.addLog(12,"查询余额",`${k}: ${D.toLocaleString()} COM`),{success:!0,balance:D,message:`📊 查询成功！${k} 余额: ${D.toLocaleString()} COM`,hints:[],nextStep:"💡 余额使用 mapping(address => uint256) 存储！👉 转账给 Bob 来学习事件机制！"}},g=(v,D)=>{const k=a.value,C=c(k),E=c(v);return n.value[k]<D?(e.addLog(12,"转账失败",`余额不足: ${C} → ${E}`),{success:!1,message:`❌ 转账失败！余额不足。当前余额: ${n.value[k].toLocaleString()} COM，尝试转账: ${D.toLocaleString()} COM`,hints:[],nextStep:""}):v==="0x0000000000000000000000000000000000000000"?(e.addLog(12,"转账失败","接收地址不能是零地址"),{success:!1,message:"❌ 转账失败！接收地址不能是零地址。",hints:[],nextStep:""}):k===v?(e.addLog(12,"转账失败","不能转账给自己"),{success:!1,message:"❌ 转账失败！不能转账给自己。",hints:[],nextStep:""}):(n.value[k]-=D,n.value[v]=(n.value[v]||0)+D,i.value.push({icon:"🟢",name:"Transfer",details:`从: ${C} 到: ${E} 数量: ${D.toLocaleString()} COM`,timestamp:Date.now()}),e.addLog(12,"转账",`${C} → ${E}: ${D.toLocaleString()} COM`),{success:!0,message:`✅ 转账成功！${C} 向 ${E} 转账 ${D.toLocaleString()} COM 📋 恭喜解锁：事件日志！💸 恭喜解锁：转账函数！`,hints:["event","transfer"],nextStep:"👉 授权给 Carol 来学习授权机制！"})},m=(v,D)=>{const k=a.value,C=c(k),E=c(v);return o.value!=="alice"?(e.addLog(12,"授权失败","只有 Alice 才能授权"),{success:!1,message:"❌ 授权失败！只有代币持有者 Alice 才能授权。请切换到 Alice。",hints:[],nextStep:""}):k===v?(e.addLog(12,"授权失败","不能授权给自己"),{success:!1,message:"❌ 授权失败！不能授权给自己。",hints:[],nextStep:""}):(r.value[k]||(r.value[k]={}),r.value[k][v]=D,i.value.push({icon:"🟡",name:"Approval",details:`持有者: ${C} 被授权者: ${E} 额度: ${D.toLocaleString()} COM`,timestamp:Date.now()}),e.addLog(12,"授权",`${C} → ${E}: ${D.toLocaleString()} COM`),{success:!0,message:`✅ 授权成功！${C} 授权 ${E} 可以使用 ${D.toLocaleString()} COM ✅ 恭喜解锁：授权函数！`,hints:["approve"],nextStep:"👉 查询 allowance 来学习授权额度查询！"})},w=(v,D)=>{var $;const k=(($=r.value[v])==null?void 0:$[D])||0,C=c(v),E=c(D);return e.addLog(12,"查询授权额度",`${E} 可用 ${C}: ${k.toLocaleString()} COM`),{success:!0,allowance:k,message:`🔍 查询成功！${E} 可使用 ${C} 的额度: ${k.toLocaleString()} COM 🗂️ 恭喜解锁：嵌套映射！🔍 恭喜解锁：授权额度查询！`,hints:["mapping_nested","allowance"],nextStep:"👉 切换到 Carol 执行代转账来学习 transferFrom！"}},A=(v,D,k)=>{var L;const C=a.value,E=c(C),$=c(v),b=c(D);if(o.value!=="carol")return e.addLog(12,"代转账失败","只有 Carol 才能执行代转账"),{success:!1,message:"❌ 代转账失败！只有被授权者 Carol 才能执行代转账。请切换到 Carol。",hints:[],nextStep:""};if(v!==s.alice)return e.addLog(12,"代转账失败","Carol 只被 Alice 授权"),{success:!1,message:"❌ 代转账失败！Carol 只被 Alice 授权，只能从 Alice 账户代转账。",hints:[],nextStep:""};const h=((L=r.value[v])==null?void 0:L[C])||0;return h<k?(e.addLog(12,"代转账失败",`授权额度不足: ${h.toLocaleString()} COM`),{success:!1,message:`❌ 授权额度不足！Carol 只能使用 Alice 的 ${h.toLocaleString()} COM，尝试转账: ${k.toLocaleString()} COM`,hints:[],nextStep:""}):n.value[v]<k?(e.addLog(12,"代转账失败",`余额不足: ${$}`),{success:!1,message:`❌ 余额不足！${$} 当前余额: ${n.value[v].toLocaleString()} COM`,hints:[],nextStep:""}):(n.value[v]-=k,n.value[D]=(n.value[D]||0)+k,r.value[v][C]-=k,i.value.push({icon:"🟢",name:"Transfer",details:`从: ${$} 到: ${b} 数量: ${k.toLocaleString()} COM (by ${E})`,timestamp:Date.now()}),e.addLog(12,"代转账",`${E} 代替 ${$} → ${b}: ${k.toLocaleString()} COM`),{success:!0,message:`✅ 代转账成功！${E} 代替 ${$} 向 ${b} 转账 ${k.toLocaleString()} COM 🔄 恭喜解锁：代转账函数！`,hints:["transferFrom"],nextStep:"🎉 你已掌握 ERC20 全部核心功能！"})},U=v=>new Date(v).toLocaleTimeString("zh-CN",{hour:"2-digit",minute:"2-digit",second:"2-digit"}),F=y(()=>({gasUsage:e.getDayGasUsage(12),ethCost:e.getDayEthCost(12),operationCount:e.getDayOperationCount(12)}));return{tokenInfo:t,roles:s,balances:n,allowances:r,currentRole:o,currentAddress:a,eventLog:i,realtimeData:F,switchRole:l,getBalance:p,transfer:g,approve:m,getAllowance:w,transferFrom:A,getRoleName:c,formatAddress:u,formatTime:U}}function Vc(e){return{realtimeData:y(()=>{switch(e.value){case 1:return Rc().realtimeData.value;case 2:return $c().realtimeData.value;case 3:return Lc().realtimeData.value;case 4:return Ic().realtimeData.value;case 5:return Fc().realtimeData.value;case 6:return Uc().realtimeData.value;case 7:return Hc().realtimeData.value;case 8:return Wc().realtimeData.value;case 9:return qc().realtimeData.value;case 10:return Nc().realtimeData.value;case 11:return Bc().realtimeData.value;case 12:return jc().realtimeData.value;default:return{gasUsage:0,ethCost:0,operationCount:0}}})}}const sn=(e,t)=>{const s=e.__vccOpts||e;for(const[n,r]of t)s[n]=r;return s},Kc={class:"header"},Gc={class:"header-center"},zc={class:"main-title"},Jc={class:"easter-egg-container"},Xc={__name:"AppHeader",props:{showLeftSidebar:{type:Boolean,default:!0},showRightSidebar:{type:Boolean,default:!0}},emits:["toggle-left-sidebar","toggle-right-sidebar"],setup(e){const t=Z(!1),s=()=>{t.value=!t.value,t.value?(document.documentElement.dataset.theme="dark",localStorage.setItem("theme","dark")):(document.documentElement.dataset.theme="light",localStorage.setItem("theme","light"))},n=Z(!1),r=Z(!1),o=Z("");let i=null;const a=["In Code We Trust!","🔮 今日宜：部署主网；忌：未 Audit","⚠️ 注意你的 Reentrancy 漏洞！","Gas 费太高了，先在这练练手！","HODL! 到下一个牛市！","🎉 签运：大吉！编译一遍过","🚀 To the Moon!","智能合约，不可篡改！","🧐 别忘了测边缘情况"],c=()=>{if(n.value)return;n.value=!0,setTimeout(()=>{n.value=!1},600);const u=a[Math.floor(Math.random()*a.length)];o.value=u,r.value=!0,i&&clearTimeout(i),i=setTimeout(()=>{r.value=!1},3e3)};return Ps(()=>{(localStorage.getItem("theme")||(window.matchMedia("(prefers-color-scheme: dark)").matches?"dark":"light"))==="dark"&&(t.value=!0,document.documentElement.dataset.theme="dark")}),(u,l)=>(ae(),ce("div",Kc,[N("button",{class:Fe(["sidebar-toggle-btn left-toggle",{active:e.showLeftSidebar}]),onClick:l[0]||(l[0]=p=>u.$emit("toggle-left-sidebar"))}," 📅 日程 ",2),N("div",Gc,[N("h1",zc,[N("div",Jc,[N("button",{class:Fe(["easter-egg-btn",{animating:n.value}]),onClick:c,title:"点这里有惊喜"}," 🎓 ",2),N("div",{class:Fe(["toast-message",{show:r.value}])},de(o.value),3)]),l[2]||(l[2]=N("span",null,"Solidity 学习互动演示",-1)),N("button",{class:"theme-toggle-btn",onClick:s,title:"切换模式"},de(t.value?"☀️":"🌙"),1)]),l[3]||(l[3]=N("div",{class:"warning-banner"},[N("span",null,"模拟环境，不消耗真实 Gas 或 ETH"),N("span",{class:"author-credit"},[Vt("by "),N("a",{href:"https://github.com/Tenlossiby",target:"_blank",rel:"noopener noreferrer"},"Tenlossiby")])],-1))]),N("button",{class:Fe(["sidebar-toggle-btn right-toggle",{active:e.showRightSidebar}]),onClick:l[1]||(l[1]=p=>u.$emit("toggle-right-sidebar"))}," 📊 进度 ",2)]))}},Yc=sn(Xc,[["__scopeId","data-v-9217367d"]]),Qc={class:"left-sidebar"},Zc={class:"sidebar-header"},el=["title"],tl=["onClick"],nl={class:"day-nav-header"},sl={class:"day-title"},rl={class:"day-subtitle"},ol={__name:"DayNavigation",props:{currentDay:{type:Number,required:!0}},emits:["switchDay"],setup(e){const t=Z(!0),s=()=>{t.value=!t.value},n=y(()=>{const o=Object.keys(Dt).map(Number);return t.value?o:o.reverse()}),r=o=>{var i;return((i=Dt[o])==null?void 0:i.subtitle)||"待定内容"};return(o,i)=>(ae(),ce("div",Qc,[N("div",Zc,[i[0]||(i[0]=N("h3",null,"📚 学习导航",-1)),N("button",{class:"sort-toggle-btn",onClick:s,title:t.value?"点击切换倒序":"点击切换正序"},de(t.value?"🔼 正序":"🔽 倒序"),9,el)]),(ae(!0),ce(Ee,null,Sn(n.value,a=>(ae(),ce("div",{key:a,class:Fe(["day-nav-item",{active:e.currentDay===a}]),onClick:c=>o.$emit("switchDay",a)},[N("div",nl,[N("div",sl,"Day "+de(a),1)]),N("div",rl,de(r(a)),1)],10,tl))),128))]))}},il=sn(ol,[["__scopeId","data-v-f0f44ca3"]]),al="modulepreload",cl=function(e,t){return new URL(e,t).href},Or={},$e=function(t,s,n){let r=Promise.resolve();if(s&&s.length>0){const i=document.getElementsByTagName("link"),a=document.querySelector("meta[property=csp-nonce]"),c=(a==null?void 0:a.nonce)||(a==null?void 0:a.getAttribute("nonce"));r=Promise.allSettled(s.map(u=>{if(u=cl(u,n),u in Or)return;Or[u]=!0;const l=u.endsWith(".css"),p=l?'[rel="stylesheet"]':"";if(!!n)for(let w=i.length-1;w>=0;w--){const A=i[w];if(A.href===u&&(!l||A.rel==="stylesheet"))return}else if(document.querySelector(`link[href="${u}"]${p}`))return;const m=document.createElement("link");if(m.rel=l?"stylesheet":al,l||(m.as="script"),m.crossOrigin="",m.href=u,c&&m.setAttribute("nonce",c),document.head.appendChild(m),l)return new Promise((w,A)=>{m.addEventListener("load",w),m.addEventListener("error",()=>A(new Error(`Unable to preload CSS for ${u}`)))})}))}function o(i){const a=new Event("vite:preloadError",{cancelable:!0});if(a.payload=i,window.dispatchEvent(a),!a.defaultPrevented)throw i}return r.then(i=>{for(const a of i||[])a.status==="rejected"&&o(a.reason);return t().catch(o)})},ll={class:"coming-soon-content"},ul={class:"coming-soon-card"},dl={class:"description"},fl={class:"suggestion"},pl={class:"available-days"},gl=["onClick"],ml={__name:"ComingSoon",props:{day:{type:Number,default:0}},emits:["switchDay"],setup(e,{emit:t}){const s=t,n=Object.keys(Dt).map(Number).sort((o,i)=>o-i),r=o=>{s("switchDay",o)};return(o,i)=>(ae(),ce("div",ll,[N("div",ul,[i[1]||(i[1]=N("div",{class:"icon"},"🚧",-1)),i[2]||(i[2]=N("h2",null,"内容建设中",-1)),i[3]||(i[3]=N("p",{class:"subtitle"},"Coming Soon",-1)),N("p",dl," Day "+de(e.day)+" 的内容正在开发中，敬请期待！ ",1),N("div",fl,[i[0]||(i[0]=N("p",null,"💡 提示：目前可用的学习内容：",-1)),N("div",pl,[(ae(!0),ce(Ee,null,Sn(Jt(n),a=>(ae(),ce("span",{key:a,class:"day-tag",onClick:c=>r(a)}," Day "+de(a),9,gl))),128))])])])]))}},hl=sn(ml,[["__scopeId","data-v-8b051cae"]]),_l={class:"center-content"},bl={__name:"DayContent",props:{currentDay:{type:Number,required:!0}},emits:["switchDay"],setup(e,{emit:t}){const s={1:Re(()=>$e(()=>import("./ClickCounter-ByHVgGIb.js"),__vite__mapDeps([0,1,2,3]),import.meta.url)),2:Re(()=>$e(()=>import("./SaveMyName-DKg1l27q.js"),__vite__mapDeps([4,1,2,5]),import.meta.url)),3:Re(()=>$e(()=>import("./PollStation-DFr21KsE.js"),__vite__mapDeps([6,1,2,7]),import.meta.url)),4:Re(()=>$e(()=>import("./AuctionHouse-CU1ybdQf.js"),__vite__mapDeps([8,1,2,9]),import.meta.url)),5:Re(()=>$e(()=>import("./AdminOnly-DcDj9NxX.js"),__vite__mapDeps([10,1,2,11]),import.meta.url)),6:Re(()=>$e(()=>import("./EtherPiggyBank-BTcVEW4I.js"),__vite__mapDeps([12,1,2,13]),import.meta.url)),7:Re(()=>$e(()=>import("./SimpleIOUApp-CeUzZQlc.js"),__vite__mapDeps([14,1,2,15]),import.meta.url)),8:Re(()=>$e(()=>import("./TipJar-ChoGMgzV.js"),__vite__mapDeps([16,1,2,17]),import.meta.url)),9:Re(()=>$e(()=>import("./SmartCalculator-BeVTgbqz.js"),__vite__mapDeps([18,1,2,19]),import.meta.url)),10:Re(()=>$e(()=>import("./ActivityTracker-C2XAcw2b.js"),__vite__mapDeps([20,1,2,21]),import.meta.url)),11:Re(()=>$e(()=>import("./MasterkeyContract-BzusUv6C.js"),__vite__mapDeps([22,1,2,23]),import.meta.url)),12:Re(()=>$e(()=>import("./ERC20Token-Clww1RmP.js"),__vite__mapDeps([24,1,2,25]),import.meta.url))},n=e,r=t,o=y(()=>s[n.currentDay]||hl),i=a=>{r("switchDay",a)};return(a,c)=>(ae(),ce("div",_l,[(ae(),Mo(ia(o.value),{key:e.currentDay,day:e.currentDay,onSwitchDay:i},null,40,["day"]))]))}},yl=sn(bl,[["__scopeId","data-v-cd6ea42d"]]),vl={class:"right-sidebar"},wl={class:"sidebar-card"},Cl={class:"progress-bar"},Al={class:"progress-stats"},Sl={class:"sidebar-card"},kl={class:"unlocked-list"},Tl={key:0,class:"locked"},xl={class:"icon"},El={key:0,class:"sidebar-card"},Dl={class:"realtime-data"},Ol={key:0},Pl={class:"data-row"},Ml={class:"value"},Rl={class:"data-row"},$l={class:"value"},Ll={class:"data-row"},Il={class:"value"},Fl={key:1,class:"no-operations"},Ul={class:"sidebar-card"},Hl={class:"operation-log"},Wl={key:0,class:"no-operations"},ql={key:1},Nl={class:"data-row"},Bl={class:"timestamp"},jl={key:0,class:"data-row gas-info"},Vl={class:"value"},Kl={class:"value"},Gl={__name:"Sidebar",props:{realtimeData:{type:Object,default:null},dayProgress:{type:Object,required:!0},currentDay:{type:Number,required:!0}},setup(e){const t=e,s=Me(),n=y(()=>s.getDayLogs(t.currentDay)),r=y(()=>{const c=t.dayProgress[t.currentDay];return!c||c.totalConcepts===0?0:Math.floor(c.unlockedConcepts.length/c.totalConcepts*100)}),o=y(()=>{const c=t.dayProgress[t.currentDay];return(c==null?void 0:c.unlockedConcepts.length)||0}),i=y(()=>{const c=t.dayProgress[t.currentDay];return(c==null?void 0:c.totalConcepts)||0}),a=y(()=>{const c=Dt[t.currentDay];if(!c||!c.concepts)return[];const u=t.dayProgress[t.currentDay],l=(u==null?void 0:u.unlockedConcepts)||[];let p=Oc;return t.currentDay===11?p=Pc:t.currentDay===12&&(p=Mc),c.concepts.map(g=>{const m=p[g];return{key:g,name:(m==null?void 0:m.name)||g,icon:l.includes(g)?m==null?void 0:m.icon:"🔒",isUnlocked:l.includes(g)}})});return(c,u)=>(ae(),ce("div",vl,[N("div",wl,[u[0]||(u[0]=N("h3",null,"🎓 学习进度",-1)),N("div",Cl,[N("div",{class:"progress-fill",style:In({width:r.value+"%"})},null,4)]),N("div",Al,[N("span",null,"完成度 "+de(r.value)+"%",1),N("span",null,"已解锁 "+de(o.value)+"/"+de(i.value),1)])]),N("div",Sl,[u[2]||(u[2]=N("h3",null,"✅ 已解锁概念",-1)),N("ul",kl,[a.value.length===0?(ae(),ce("li",Tl,[...u[1]||(u[1]=[N("span",{class:"icon"},"🚧",-1),Vt(" 内容开发中... ",-1)])])):_n("",!0),(ae(!0),ce(Ee,null,Sn(a.value,l=>(ae(),ce("li",{key:l.key,class:Fe({locked:!l.isUnlocked})},[N("span",xl,de(l.icon),1),Vt(" "+de(l.name),1)],2))),128))])]),e.realtimeData?(ae(),ce("div",El,[u[6]||(u[6]=N("h3",null,"📊 实时数据",-1)),N("div",Dl,[e.realtimeData.operationCount>0?(ae(),ce("div",Ol,[N("div",Pl,[u[3]||(u[3]=N("span",{class:"label"},"操作次数：",-1)),N("span",Ml,de(e.realtimeData.operationCount),1)]),N("div",Rl,[u[4]||(u[4]=N("span",{class:"label"},"Gas 消耗：",-1)),N("span",$l,de(e.realtimeData.gasUsage.toLocaleString()),1)]),N("div",Ll,[u[5]||(u[5]=N("span",{class:"label"},"ETH 费用：",-1)),N("span",Il,de(e.realtimeData.ethCost.toFixed(6)),1)])])):(ae(),ce("div",Fl," 暂无操作记录 "))])])):_n("",!0),N("div",Ul,[u[9]||(u[9]=N("h3",null,"📋 操作日志",-1)),N("div",Hl,[n.value.length===0?(ae(),ce("p",Wl,"暂无操作记录")):(ae(),ce("div",ql,[(ae(!0),ce(Ee,null,Sn(n.value.slice(0,10),l=>(ae(),ce("div",{key:l.id,class:"log-entry"},[N("div",Nl,[N("span",Bl,de(l.timestamp),1),N("span",null,[N("strong",null,de(l.operation),1),Vt(" "+de(l.details),1)])]),l.gasUsed>0?(ae(),ce("div",jl,[u[7]||(u[7]=N("span",{class:"label"},"Gas:",-1)),N("span",Vl,de(l.gasUsed.toLocaleString()),1),u[8]||(u[8]=N("span",{class:"label",style:{"margin-left":"15px"}},"ETH:",-1)),N("span",Kl,de(l.ethCost.toFixed(6)),1)])):_n("",!0)]))),128))]))])])]))}},zl=sn(Gl,[["__scopeId","data-v-af597ea6"]]),Jl={class:"app-container"},Xl={class:"main-layout"},Yl={__name:"App",setup(e){const t=Ie(),s=Z(!0),n=Z(!0),r=Z(1),o=Z(!1),{realtimeData:i}=Vc(r),a=()=>{const g=window.innerWidth<=1100;!o.value&&g&&(s.value=!1,n.value=!1),o.value&&!g&&(s.value=!0,n.value=!0),o.value=g},c=y(()=>o.value&&(s.value||n.value));Ps(()=>{a(),window.addEventListener("resize",a)}),Ms(()=>{window.removeEventListener("resize",a)});const u=p=>{r.value=p},l=()=>{s.value=!1,n.value=!1};return(p,g)=>(ae(),ce("div",Jl,[pe(Yc,{"show-left-sidebar":s.value,"show-right-sidebar":n.value,onToggleLeftSidebar:g[0]||(g[0]=m=>s.value=!s.value),onToggleRightSidebar:g[1]||(g[1]=m=>n.value=!n.value)},null,8,["show-left-sidebar","show-right-sidebar"]),c.value?(ae(),ce("div",{key:0,class:"sidebar-overlay active",onClick:hc(l,["stop"])})):_n("",!0),N("div",Xl,[pe(il,{"current-day":r.value,onSwitchDay:u,class:Fe({hidden:!s.value&&!o.value,"mobile-visible":o.value&&s.value,show:s.value&&o.value})},null,8,["current-day","class"]),pe(yl,{"current-day":r.value,onSwitchDay:u},null,8,["current-day"]),pe(zl,{"current-day":r.value,"day-progress":Jt(t).dayProgress,"realtime-data":Jt(i),class:Fe({hidden:!n.value&&!o.value,"mobile-visible":o.value&&n.value,show:n.value&&o.value})},null,8,["current-day","day-progress","realtime-data","class"])])]))}},Bo=vc(Yl),Ql=Ac();Bo.use(Ql);Bo.mount("#app");export{ru as A,qc as B,pn as C,Ps as D,nu as E,Ee as F,In as G,iu as H,Nc as I,Bc as J,jc as K,Mo as L,Pc as M,Oc as N,lu as O,cu as P,uu as Q,au as R,Mc as S,tu as T,sn as _,N as a,Jt as b,ce as c,pe as d,$c as e,ou as f,_n as g,Lc as h,Sn as i,Ic as j,hc as k,Ie as l,Fc as m,le as n,ae as o,Vt as p,y as q,Z as r,Uc as s,de as t,Rc as u,su as v,eu as w,Hc as x,Wc as y,Fe as z};
