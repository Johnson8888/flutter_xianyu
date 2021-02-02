/**
 * CommonUtil.js全局通用库
 * 依赖: amc.js, amc-bridge.js
 */

(function(global) {
  /**
   * 对象输出为可用字符串
   * @param @required obj 需要转换的对象
   * @param spliter 字符串的分隔符
   */
  function objToStr(obj, spliter) {
    spliter = spliter || '&';
    var strArr = [];

    if (amc.fn.isArray(obj)) {
      strArr = obj;
    } else if (amc.fn.isObject(obj)) {
      var prop;
      for (prop in obj) {
        if (obj.hasOwnProperty(prop) && obj[prop] !== null && obj[prop] !== undefined) {
          strArr.push(prop + '=' + obj[prop]);
        }
      }
    }
    return strArr.join(spliter);
  }

  function isArray(obj) {
    return amc.fn.isArray(obj);
  }

  function startWith(str, key) {
    if (!str) {
      return false;
    }

    str = str + '';
    key = key || '';
    return str.indexOf(key) === 0;
  }

  /*
   * 格式化日期
   * @param date Date 或 timestamp
   * @param formatter yyyyMMddHHmmss
   */
  function formatDate(date, formatter) {
    if (typeof date !== 'object') {
      date = new Date(date);
    }
    var transform = function(value) {
      return value < 10 ? '0' + value : value;
    };

    return formatter.replace(/^YYYY|MM|DD|hh|mm|ss/g, function(match) {
      switch (match) {
        case 'YYYY':
          return transform(date.getFullYear());
        case 'MM':
          return transform(date.getMonth() + 1);
        case 'mm':
          return transform(date.getMinutes());
        case 'DD':
          return transform(date.getDate());
        case 'hh':
          return transform(date.getHours());
        case 'ss':
          return transform(date.getSeconds());
      }
    });
  }

  /**
   *  判断是否为空对象
   *
   */
  function isEmpty(obj) {
    if (obj === null || obj === undefined) {
      return true;
    }

    if (obj && obj.length !== undefined && obj.length > 0) {
      return false;
    }

    for (var key in obj) {
      if (obj.hasOwnProperty(key)) {
        return false;
      }
    }

    return true;
  }

  function parseStrToInt(intStr, defaultVal) {
    defaultVal = defaultVal || null;
    try {
      var intVal = parseInt(intStr, 10);
      if (isNaN(intVal)) {
        return defaultVal;
      }
      return intVal;
    } catch (e) {
      return defaultVal;
    }
  }

  /**
   * appendQuery zain URL末尾拼接query
   * @param  {String} url url
   * @param {String} query 'key1=value1&key2=value2'
   * @param {Boolean} loadControl 是否需要做防重复控制
   */
  function appendQuery(url, query) {
    if (!url || !query) {
      return url;
    }
    var separator = url.indexOf('?') === -1 ? '?' : '&';
    // 如果最后一位是?或&
    if (url.indexOf('?') === url.length - 1 || url.indexOf('&') === url.length - 1) {
      separator = '';
    }
    return url + separator + query;
  }

  /**
   * 深拷贝: 将对象拷贝到第一个参数中
   * @returns
   */
  function merge() {
    var target = arguments[0];
    for (var index = 1; index < arguments.length; index += 1) {
      var obj = arguments[index];
      if (obj && obj.__proto__ === Object.prototype) {
        for (var prop in obj) {
          var value = obj[prop];
          if (value && value.__proto__ === Object.prototype) {
            target[prop] = merge({}, value);
          } else {
            target[prop] = value;
          }
        }
      }
    }
    return target;
  }

  /**
   * 估算字符宽度。英文、数字、半角符号（正则区域: 0x20 ~ 0x7E）算0.45个汉字的宽度
   * @param   {string} str
   * @returns {number} 估计的宽度，以“汉字的数量”计算。
   */
  function calculateFontWidth(str) {
    if (!str) {
      return 0;
    }
    var count = 0;
    var reg = /^[ -~]*$/;
    for (var i = 0; i < str.length; i++) {
      if (reg.test(str[i])) {
        count += 0.45;
      } else {
        count++;
      }
    }
    return Math.round(count);
  }

  /**
   * 钱包spm埋点
   * @param  {string} type      'click'/'exposure'/'create'/'destroy' 与收银台Native约定的类型
   * @param  {string} bizCode   业务标识, 参考所申请的埋点
   * @param  {string} spmId     spmId
   * @param  {object} param4Map 扩展参数,最多4个
   */
  function _walletSpmLog(type, spmId, bizCode, param4Map) {
    if (!type || !spmId) {
      return;
    }

    // 参考: https://yuque.antfin-inc.com/licongqi.lcq/byg9vk/dwa2fn#qz0iee
    var TYPE_ACTION_ID = {
      click: 'clicked',
      exposure: 'exposure',
      create: 'pageMonitor',
      destroy: 'pageMonitor'
    };

    var obj = {
      type: type,
      spmId: spmId,
      param4: param4Map ? JSON.stringify(param4Map) : '',
      actionId: TYPE_ACTION_ID[type] || 'clicked',
      logLevel: '2',
      bizCode: bizCode || 'pay' // 请参考埋点的bizType 收银台是pay, 收钱码是TransferPay
    };

    amc.fn.feedback('spmtracker', obj);
  }

  /**
   * 钱包框架点击埋点，钱包外不能调用
   * 备注: 从钱包10.1.38开始params改版为->param4Map
   * @param {string} spmId 埋点码
   * @param {object} param4Map 埋点参数
   */
  function trackLog(spmId, bizType, param4Map) {
    _walletSpmLog('click', spmId, bizType, param4Map);
  }

  /**
   * 钱包框架点击埋点，钱包外不能调用
   * 备注: 从钱包10.1.38开始params改版为->param4Map
   */
  function trackSpmExpo(spmId, bizType, param4Map) {
    _walletSpmLog('exposure', spmId, bizType, param4Map);
  }

  /**
   * pageMonitor的创建和销毁。在页面创建和销毁时分别调用
   * since: 10.1.38
   * @param {String} type 'create'/'destroy' 与收银台Native约定的类型
   * @param {string} spmId 埋点码
   * @param {Object} param4Map 透传参数
   */
  function trackPageMonitor(type, spmId, bizType, param4Map) {
    if (type !== 'create' && type !== 'destroy') {
      return;
    }
    _walletSpmLog(type, spmId, bizType, param4Map);
  }

  /**
   * 收银台错误埋点
   * @param {String} bizType 业务码
   * @param {String} code 埋点码，错误平台报错码, 不能为空
   * @param {Object} obj... 详情
   */
  function logError(bizType, code) {
    var desc = '';
    for (var i = 1; i < arguments.length; i++) {
      var str = amc.fn.isString(arguments[i]) ? arguments[i] : JSON.stringify(arguments[i]);
      desc += str;
    }
    amc.fn.logError(bizType + '-' + code, desc);
  }


  /**
   * 计数埋点
   * https://jiankong.alipay.com/exhibit/report.htm?pageId=tec_merchantAppSDK_sdkCount
   * @param {String} category 业务分类
   * @param {String} code 计数编码
   */
  function logCount(category, code) {
    category = category || 'tpl';
    amc.fn.logCount(category, code, '');
  }

  /**
   * 收银台行为埋点
   * @param {String} type 1) clilck: 用户行为 2) qrPage: 动态码页面相关 3)realName: 实名弹窗相关
   * @param {*} name
   */
  function logAction(type, name) {
    // native调整过字段顺序
    amc.fn.logAction(name, type);
  }

  global.CommonUtil = {
    objToStr: objToStr,
    trackLog: trackLog,
    isArray: isArray,
    startWith: startWith,
    formatDate: formatDate,
    isEmpty: isEmpty,
    parseInt: parseStrToInt,
    trackSpmExpo: trackSpmExpo,
    appendQuery: appendQuery,
    merge: merge,
    calculateFontWidth: calculateFontWidth,
    logError: logError,
    logAction: logAction,
    logCount: logCount,
    trackPageMonitor: trackPageMonitor
  };
})(window);