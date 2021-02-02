/*global amc mp*/

amc.fn.parseActionNameParams = function (name) {
    return name.match(/'([^,]*)'/g).map(function (item) {
        if (item.length > 2) {
            return item.substring(1, item.length - 1);
        } else {
            return item;
        }
    });
};

amc.api = {};

amc.api.openurl = function (obj) {
    // 隐藏键盘
    mp.hideKeyboard();

    // 从name中解析入参，兼容老格式
    var name = obj.action.name || '';
    var params = obj.action.params || {};

    if (name.indexOf('(') > 0 && name.indexOf(')') > 0) {
        var paramArr = amc.fn.parseActionNameParams(name) || [];
        if (paramArr.length > 0) {
            params.url = paramArr[0];
        }
        if (paramArr.length > 1) {
            params.endflag = paramArr[1];
        }
    }

    var url = params.url || '';
    var endflag = params.endflag || '';

    var completeHandler = function (result) {
        var success = !!result.success;
        if (endflag === '2') {
            if (success) {
                var succact = params.succact || {};
                if (amc.fn.isObject(succact) && succact.name) {
                    document.submit({
                        'action': succact
                    });
                }
            } else {
                var failact = params.failact || {};
                if (amc.fn.isObject(failact) && failact.name) {
                    document.submit({
                        'action': failact
                    });
                }
            }
        }

        if (endflag === '4' && !success) {
            mp.resumeAllView();
        }
    };

    if (amc.isAndroid && params.andurl) {
        mp.openIntent({
            'scheme': params.andurl.scheme || '',
            'package': params.andurl.package || '',
            'extras': params.andurl.extras || {}
        }, completeHandler);
    } else {
        mp.openURL({
            'URL': url,
            'delay': 10
        }, completeHandler);
    }

    var exitMode = amc.isAndroid ? 'exitonly' : 'exitall';
    if (endflag === '0') {
        if (amc.isAndroid) {
            return;
        }
        if (amc.isIOS && amc.isSDK && url.indexOf('alipays://platformapi') === 0) {
            return;
        }
    } else if (endflag === '1') {
        exitMode = 'exit';
    } else if (endflag === '2') {
        return;
    } else if (endflag === '3') {
        if (amc.isSDK && url.indexOf('alipays://platformapi') === 0) {
            return;
        } else {
            exitMode = 'exitallresume';
        }
    } else if (endflag === '4') {
        mp.hideAllView();
        var followAct = params.followAct || {};
        if (amc.fn.isObject(followAct) && followAct.name) {
            mp.onOutJumpResume(function () {
                mp.resumeAllView();
                document.submit({
                    'action': followAct
                });
            });
        }
        return;
    } else if (endflag === '5') {
        exitMode = 'exitonly';
    }

    mp.mspLogEvent({
        'type': 'dyapi',
        'name': 'exit|' + exitMode,
        'currView': amc.fn.getTplId()
    });
    amc.api.exit({
        'action': {
            'name': 'loc:exit',
            'params': {
                'mode': exitMode
            }
        }
    });
};

amc.api.exit = function (obj) {
    var params = obj.action.params || {};
    var mode = params.mode || 'exit';

    mp.getBizData('result', function (bizData) {
        if (!bizData.result || !bizData.result.extendInfo || !bizData.result.extendInfo.thirdPrompt) {
            mp.exit(mode);
            return;
        }

        mp.getBizData('bizContext', function (bizData) {
            var bizContext = bizData.bizContext;
            if (!bizContext || bizContext.sc !== 'jsapi' || !bizContext.isThirdDomain || mode === 'exitonly') {
                mp.exit(mode);
                return;
            }

            mp.getDRMConfig(amc.isIOS ? 'degrade_third_domain_prompt' : 'third_domain_prompt_degrade', function (drmConfig) {
                if (drmConfig.isEnable) {
                    mp.exit(mode);
                    return;
                }

                var alertExitExec = function () {
                    var domain = bizContext.domain;
                    var message = '即将离开支付宝页面，访问第三方页面';
                    if (typeof domain === 'string') {
                        message = '即将离开支付宝页面，访问\n' + domain;
                    }

                    mp.spmExposure('a283.b2979.c14592');
                    mp.spmExposure('a283.b2979.c14592.d27159');
                    mp.spmExposure('a283.b2979.c14592.d27158');

                    mp.alert({
                        'message': message,
                        'buttons': ['去首页', '允许']
                    }, function (adata) {
                        if (adata.index === '0') {
                            mp.spmClicked('a283.b2979.c14592.d27159');
                            mp.openURL('alipays://platformapi/startapp?appId=20000001&actionType=20000002', function () {
                                mp.exit('exitonly');
                            });
                        } else if (adata.index === '1') {
                            mp.spmClicked('a283.b2979.c14592.d27158');
                            mp.exit(mode);
                        }
                    });
                };

                if (amc.isIOS) {
                    mp.getSessionData(['resultPageData', 'resultDisplayed'], function (sdata) {
                        if (sdata.resultPageData && sdata.resultDisplayed || !sdata.resultPageData) {
                            alertExitExec();
                        } else {
                            mp.exit(mode);
                        }
                    });
                } else {
                    alertExitExec();
                }
            });
        });
    });
};

amc.api.postNotification = function (obj) {
    if (obj.action.params) {
        var params = obj.action.params;
        var notifyName = params.notifyName || '';
        if (notifyName.length > 0) {
            var note = {
                'name': notifyName
            };
            note.userInfo = params.data;

            mp.sendNotification(note);
        }
    }
    
};

(function () {
    // 指令通用执行器
    function apiExec(origFunc, origFuncType, name, obj, callback) {
        var apiKey = name || '';
        var isOldFormat = false;
        if (apiKey.indexOf('loc:') >= 0) {
            apiKey = apiKey.substring('loc:'.length);
            var substrStop = apiKey.indexOf('(');
            if (substrStop > 0 && apiKey.indexOf(')') > 0) {
                apiKey = apiKey.substring(0, substrStop);
                isOldFormat = true;
            }
        }

        // 上下文暂存
        var _this = this;
        var _arguments = arguments;

        var degradeFunc = function (origFunc, origFuncType, name, obj, callback) {
            if (origFuncType === 'submit') {
                origFunc.call(_this, obj);
            } else if (origFuncType === 'asyncSubmit') {
                origFunc.call(_this, obj, callback);
            } else if (origFuncType === 'invoke') {
                origFunc.call(_this, name, obj, callback);
            }
        };

        var apiFunc = amc.api[apiKey];
        if (typeof apiFunc === 'function') {
            mp.getDRMConfig({
                'key': 'gray_dynamic_api',
                'subkey': apiKey
            }, function (result) {
                if (result.isEnable) {
                    var logObj = {
                        'type': 'dyapi',
                        'currView': amc.fn.getTplId()
                    };
                    if (isOldFormat) {
                        logObj.name = name;
                    } else {
                        var logName = apiKey;
                        var logParams = obj.action.params;
                        if (typeof logParams === 'object') {
                            logName = logName + '|' + JSON.stringify(logParams).substring(0, 100);
                        }
                        logObj.name = logName;
                    }
                    mp.mspLogEvent(logObj);

                    apiFunc.call(amc.api, obj, callback);
                } else {
                    degradeFunc.apply(_this, _arguments);
                }
            });
            return;
        }

        degradeFunc.apply(this, arguments);
    }

    // submit覆写逻辑
    document._orig_submit = document.submit;
    document.submit = function (obj) {
        if (obj.action && obj.action.name) {
            var nameArr = obj.action.name.split(';');
            if (nameArr.length === 1) {
                apiExec.call(this, document._orig_submit, 'submit', obj.action.name, obj);
            } else if (nameArr.length > 1) {
                var objArr = [];
                nameArr.forEach(function (eachName) {
                    var tmpObj;
                    var tmpName = eachName;
                    if (tmpName.indexOf('loc:') !== 0 && tmpName.indexOf('/') !== 0) {
                        tmpObj = objArr.pop();
                        tmpName = tmpObj.action.name + ';' + tmpName;
                    } else {
                        tmpObj = JSON.parse(JSON.stringify(obj));
                    }
                    
                    tmpObj['action']['name'] = tmpName;
                    objArr.push(tmpObj);
                });
                
                var _this = this;
                objArr.forEach(function (objArrItem) {
                    apiExec.call(_this, document._orig_submit, 'submit', objArrItem.action.name, objArrItem);
                });
            }
        } else {
            document._orig_submit.apply(this, arguments);
        }
    };

    // asyncSubmit覆写逻辑
    document._orig_asyncSubmit = document.asyncSubmit;
    document.asyncSubmit = function (obj, callback) {
        if (obj.action && obj.action.name) {
            apiExec.call(this, document._orig_asyncSubmit, 'asyncSubmit', obj.action.name, obj, callback);
        } else {
            document._orig_asyncSubmit.apply(this, arguments);
        }
    };

    document._orig_invoke = document.invoke;
    document.invoke = function (name, obj, callback) {
        apiExec.call(this, document._orig_invoke, 'invoke', name, obj, callback);
    };
})();