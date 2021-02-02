/*global amc*/

// 元指令调用逻辑，需要在invoke函数替换之前执行，所以amc-meta.js一定要比amc-api.js先执行
document._meta_invoke = document.invoke;
function metaApiCall(name, PARAMS, CALLBACK) {
    var _this = this;
    setTimeout(function () {
        document._meta_invoke.call(_this, 'meta-' + name, PARAMS || {}, CALLBACK || (function () {}));
    }, 0);
}

var mp = {};

mp.openURL = function (OPTION, CALLBACK) {
    if (typeof OPTION === 'string') {
        metaApiCall('openURL', {
            'URL': OPTION || ''
        }, CALLBACK);
    } else if (typeof OPTION === 'object') {
        metaApiCall('openURL', OPTION, CALLBACK);
    }
};

mp.openIntent = function (OPTION, CALLBACK) {
    if (amc.isIOS) {
        if (typeof CALLBACK === 'function') {
            CALLBACK();
        }
        return;
    }
    metaApiCall('openIntent', OPTION, CALLBACK);
};

mp.getDRMConfig = function (OPTION, CALLBACK) {
    if (typeof OPTION === 'string') {
        metaApiCall('getDRMConfig', {
            'key': OPTION
        }, CALLBACK);
    } else if (typeof OPTION === 'object') {
        metaApiCall('getDRMConfig', OPTION, CALLBACK);
    }
};

mp.getSessionData = function (key, CALLBACK) {
    var obj = {};
    if (typeof key === 'string') {
        obj.key = key;
    } else if (amc.fn.isArray(key)) {
        obj.keys = key;
    }

    metaApiCall('getSessionData', obj, CALLBACK);
};

mp.setSessionData = function (OPTION, CALLBACK) {
    metaApiCall('setSessionData', OPTION, CALLBACK);
};

mp.getBizData = function (key, CALLBACK) {
    metaApiCall('getBizData', {
        'key': key
    }, CALLBACK);
};

mp.exit = function (mode) {
    metaApiCall('exit', {
        'mode': mode
    });
};

mp.hideAllView = function (CALLBACK) {
    if (amc.isAndroid) {
        if (typeof CALLBACK === 'function') {
            CALLBACK();
        }
        return;
    }

    metaApiCall('hideAllView', {}, CALLBACK);
};

mp.resumeAllView = function (CALLBACK) {
    if (amc.isAndroid) {
        if (typeof CALLBACK === 'function') {
            CALLBACK();
        }
        return;
    }

    metaApiCall('resumeAllView', {}, CALLBACK);
};

mp.spmPageCreate = function (OPTION) {
    if (typeof OPTION === 'object') {
        metaApiCall('spmPageCreate', OPTION);
    } else if (typeof OPTION === 'string') {
        metaApiCall('spmPageCreate', {
            'spmId': OPTION
        });
    }
};

mp.spmPageDestroy = function (OPTION) {
    if (typeof OPTION === 'object') {
        metaApiCall('spmPageDestroy', OPTION);
    } else if (typeof OPTION === 'string') {
        metaApiCall('spmPageDestroy', {
            'spmId': OPTION,
            'bizCode': 'pay'
        });
    }
};

mp.spmClicked = function (OPTION) {
    if (typeof OPTION === 'object') {
        metaApiCall('spmClicked', OPTION);
    } else if (typeof OPTION === 'string') {
        metaApiCall('spmClicked', {
            'spmId': OPTION,
            'bizCode': 'pay'
        });
    }
};

mp.spmExposure = function (OPTION) {
    if (typeof OPTION === 'object') {
        metaApiCall('spmExposure', OPTION);
    } else if (typeof OPTION === 'string') {
        metaApiCall('spmExposure', {
            'spmId': OPTION,
            'bizCode': 'pay'
        });
    }
};

mp.mspLogError = function (OPTION) {
    metaApiCall('mspLogError', OPTION);
};

mp.mspLogPerf = function (OPTION) {
    metaApiCall('mspLogPerf', OPTION);
};

mp.mspLogCount = function (OPTION) {
    metaApiCall('mspLogCount', OPTION);
};

mp.mspLogEvent = function (OPTION) {
    metaApiCall('mspLogEvent', OPTION);
};

mp.alert = function (OPTION, CALLBACK) {
    if (typeof OPTION === 'string') {
        metaApiCall('alert', {
            'message': OPTION
        }, CALLBACK);
    } else if (typeof OPTION === 'object') {
        metaApiCall('alert', OPTION, CALLBACK);
    }
};

mp.hideKeyboard = function () {
    if (amc.isAndroid) {
        return;
    }

    metaApiCall('hideKeyboard');
};

mp.onOutJumpResume = function (CALLBACK) {
    metaApiCall('onOutJumpResume', {}, CALLBACK);
};

mp.isAppInstalled = function (OPTION, CALLBACK) {
    if (amc.isIOS) {
        if (typeof CALLBACK === 'function') {
            CALLBACK();
        }
        return;
    }

    metaApiCall('isAppInstalled', OPTION, CALLBACK);
};

mp.sendNotification = function (OPTION) {
    metaApiCall('sendNotification', OPTION);
};

mp.onNotification = function (OPTION, CALLBACK) {
    if (typeof OPTION === 'string') {
        metaApiCall('onNotification', {
            name: OPTION
        }, CALLBACK);
    } else if (typeof OPTION === 'object') {
        metaApiCall('onNotification', OPTION, CALLBACK);
    }
};

mp.offNotification = function (OPTION) {
    if (typeof OPTION === 'string') {
        metaApiCall('offNotification', {
            name: OPTION
        });
    } else if (typeof OPTION === 'object') {
        metaApiCall('offNotification', OPTION);
    }
};