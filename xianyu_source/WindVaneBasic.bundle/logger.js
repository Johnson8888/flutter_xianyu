/* 2019-09-09 14:47:14 */
!function(e,r,n){var t=e.console;if(r&&t&&!t.__isWindVaneLog__){t.__isWindVaneLog__=!0;var a=Object.prototype.toString;if(n>=4){var o=t.log;t.log=function(){o.apply(t,arguments);var e=u(4,arguments);e&&r.postMessage(e)}}if(n>=3){var i=t.info;t.info=function(){i.apply(t,arguments);var e=u(3,arguments);e&&r.postMessage(e)}}if(n>=2){var c=t.warn;t.warn=function(){c.apply(t,arguments);var e=u(2,arguments);e&&r.postMessage(e)}}if(n>=1){var f=t.error;t.error=function(){f.apply(t,arguments);var e=u(1,arguments);e&&r.postMessage(e)}}}function s(e,r){for(var n in r)if(r[n]==e)return'"[Ref '+n+']"'}function l(r,n,t,o){if(null==r)return"null";if(void 0==r)return"undefined";var i;switch(a.call(r)){case"[object String]":case"[object Date]":case"[object Function]":i=r.toString();break;case"[object Boolean]":case"[object Number]":case"[object Regex]":n=!0,i=r.toString();break;case"[object Error]":i=r.stack;break;case"[object Arguments]":case"[object Array]":if(f=s(r,o))return f;o[t]=r,n=!0,i="[";for(var c=0;c<r.length;c++)c>0&&(i+=", "),i+=l(r[c],!1,t+"."+c,o);i+="]";break;default:if(e.HTMLElement&&r instanceof HTMLElement)i=r.outerHTML;else{var f;if(f=s(r,o))return f;if(o[t]=r,r.hasOwnProperty){n=!0,i="{";var u=!0;for(var c in r)if(r.hasOwnProperty(c)){u?u=!1:i+=", ";var g=JSON.stringify(c);i+=g,i+=": ",i+=l(r[c],!1,t+"."+g,o)}i+="}"}else i=a.call(r)}}return n||(i=JSON.stringify(i)),i}function u(e,r){if(0!=r.length){for(var n="",t=0;t<r.length;t++)t>0&&(n+=" "),n+=l(r[t],!0,"",{});return{level:e,log:n}}}}(WV_GLOBALOBJECT,WV_LOGGER,WV_LOGLEVEL);