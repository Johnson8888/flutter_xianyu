(function() {
	// Meta 的 name
	var badCaseMetaName = undefined;
	var classNames = {};
	var ids = {};

	// 纯文本的标签
	var plainTextLabels = {
		'SPAN': 1,
		'I': 1
	};

	// 打标的名字
	var badCaseDOMName = "data-observe-windvane-FSP-badcase-domname";

	// 上次发送消息的时间
	var previousTime = 0;

	var callback = function(records) {
		// 读取 Meta 中的标记
		if (badCaseMetaName == undefined) {
			if (document.querySelector('meta[name="windvane-FSP-badcase-metaname"]')) {
				badCaseMetaName = document.querySelector('meta[name="windvane-FSP-badcase-metaname"]').getAttribute('content');
				if (badCaseMetaName) {
					// 解析 Meta 的内容
					var metaNames = [];
					metaNames = badCaseMetaName.split('|');
					for (var i = 0; i < metaNames.length; i++) {
						var metaName = metaNames[i].substring(1, metaNames[i].length);
						// classNames
						if (metaNames[i].substring(0, 1) == '.') {
							classNames[metaName] = true;
							// ids
						} else if (metaNames[i].substring(0, 1) == '#') {
							ids[metaName] = true;
						}
					}
				}
			}
		}

		// 可视范围（动态获取，途中可能发生改变）
		var visibleTop = 0;
		var visibleBottom = document.documentElement.clientHeight;
		var visibleLeft = 0;
		var visibleRight = document.documentElement.clientWidth;

		// 是否已经发送消息给 Native
		var isAlreadySendMessage = false;

		// 本次回调是否可见
		var show = undefined;

		// 本次回调中是否有 DOM 命中了 Bad Case 标记
		var hasBadCase = undefined;

		for (var key in records) {
			var record = records[key];
			if(!(record instanceof MutationRecord)) {
				continue;
			}
			var domNode = record.target;

			// 过滤 undefined 节点
			if (domNode == undefined) {
				continue;
			}

			// 过滤没有节点增加的变动
			if (record.addedNodes.length == 0) {
				continue;
			}

			// 识别节点类型（仅有 Element 才有 getBoundingClientRect() 方法，作用是获取当前 Element 相对于可视范围的位置）
			// 1 Element
			if (domNode.nodeType == 1) {
				// 2 Text
			} else if (domNode.nodeType == 3) {
				// Text 的父节点可能为 Element 或者 Attr
				var parentNode = domNode.parentElement;
				if (parentNode == undefined) {
					continue;
				}
				if (parentNode.nodeType == 1) {
					domNode = parentNode;
				} else {
					continue;
				}
				// 3 其他类型
			} else {
				continue;
			}

			// 过滤纯文本改变
			var isPlainText = true;
			for (var i = 0; i < record.addedNodes.length; i++) {
				var addedDom = record.addedNodes[i];
				if (addedDom != undefined && addedDom.nodeType == 1 && plainTextLabels[addedDom.tagName] != 1) {
					isPlainText = false;
					break;
				}
			}
			if (isPlainText) {
				continue;
			}

			// 过滤条件
			// 1 节点自身是否可见
			if (show == undefined) {
				// 获取当前 domNode 的位置
				var domNodeTop = domNode.getBoundingClientRect().top;
				var domNodeBottom = domNode.getBoundingClientRect().bottom;
				var domNodeLeft = domNode.getBoundingClientRect().left;
				var domNodeRight = domNode.getBoundingClientRect().right;
				show = domNodeTop < visibleBottom && domNodeBottom > visibleTop && domNodeLeft < visibleRight && domNodeRight > visibleLeft;

				// 2 插入的节点是否可见
				if (record.addedNodes.length > 0) {
					var firstAddedDom = record.addedNodes[0];
					if (firstAddedDom != undefined && firstAddedDom.nodeType == 1) {
						var addedDomNodeTop = firstAddedDom.getBoundingClientRect().top;
						var addedDomNodeBottom = firstAddedDom.getBoundingClientRect().bottom;
						var addedDomNodeLeft = firstAddedDom.getBoundingClientRect().left;
						var addedDomNodeRight = firstAddedDom.getBoundingClientRect().right;
						show = addedDomNodeTop < visibleBottom && addedDomNodeBottom > visibleTop && addedDomNodeLeft < visibleRight && addedDomNodeRight > visibleLeft;
					}
				}
			}
			// 2 过滤 HTML || BODY || HEAD || SCRIPT || STYLE
			var filter = domNode.tagName != 'HTML' && domNode.tagName != 'BODY' && domNode.tagName != 'HEAD' && domNode.tagName != 'SCRIPT' && domNode.tagName != 'STYLE';

			// 如果 DOM 不可见，则可认为之后的 DOM 均不可见（回调的 DOM 是按从上到下、从父到子的顺序）
			if (!show && filter) {
				break;
			}

			// 如果 DOM 可见
			if (show && filter) {
				// 过滤 style 中带有动画属性 (transform || animation) 的 DOM
				if (window.getComputedStyle && filter_animation_switch) {
					var domNodeCssStyle = window.getComputedStyle(domNode, null);
					if ((domNodeCssStyle.getPropertyValue("transform") != "" && domNodeCssStyle.getPropertyValue("transform") != "none") || (domNodeCssStyle.getPropertyValue("animation-name") != "" && domNodeCssStyle.getPropertyValue("animation-name") != "none")) {
						continue;
					}
					// 判断 addedNodes 中的 DOM
					var allHasAnimation = true;
					for (var i = 0; i < record.addedNodes.length; i++) {
						var addedDom = record.addedNodes[i];
						if (addedDom != undefined && addedDom.nodeType == 1) {
							var addedDomCssStyle = window.getComputedStyle(addedDom, null);
							if ((addedDomCssStyle.getPropertyValue("transform") != "" && addedDomCssStyle.getPropertyValue("transform") != "none") || (addedDomCssStyle.getPropertyValue("animation-name") != "" && addedDomCssStyle.getPropertyValue("animation-name") != "none")) {

                            } else {
								allHasAnimation = false;
								break;
							}
						}
					}
					if (allHasAnimation == true) {
						continue;
					}
				}

				// 对于没有 Bad Case 的页面，仅需要进行一次逻辑处理
				if (badCaseMetaName == undefined) {
					// 两种消息的聚合
					var currentTime = (new Date()).getTime();
					// 1 如果时间间隔少于 10 ms，则不向 Native 发送消息
					if (currentTime - previousTime > 10) {
						window.webkit.messageHandlers.WindVaneFirstScreenPaintTime.postMessage(currentTime);
						previousTime = currentTime;
					}
					// 2 一次回调仅发送一次消息
					break;
				}

				var isInIds = ids[domNode.id] == true;
				var isInClassNames = false;
				// 考虑到多个 ClassName
				for (var i = 0; i < domNode.classList.length; i++) {
					if (classNames[domNode.classList[i]] == true) {
						isInClassNames = true;
						break;
					}
				}

				// 给在过滤名单中的节点打标
				if (isInClassNames || isInIds) {
					domNode.setAttribute(badCaseDOMName, 'true');
					hasBadCase = true;
					continue;
				}

				if (domNode.parentNode != document) {
					// 判断父节点是否被打上了标记
					if (domNode.parentNode.getAttribute(badCaseDOMName) == 'true') {
						domNode.setAttribute(badCaseDOMName, 'true');
						hasBadCase = true;
						continue;
					}
				}

				// 两种消息发送的聚合
				// 1 一次回调仅发送一次消息
				if (hasBadCase == undefined && isAlreadySendMessage == false) {
					var currentTime = (new Date()).getTime();
					// 2 如果时间间隔少于 10 ms，则不向 Native 发送消息
					if (currentTime - previousTime > 10) {
						window.webkit.messageHandlers.WindVaneFirstScreenPaintTime.postMessage(currentTime);
						previousTime = currentTime;
						isAlreadySendMessage = true;
					}
				}
			}
		};
	};

	var mo = new MutationObserver(callback);
	var options = {
		'childList': true,
		'subtree': true
	};
	mo.observe(document.body, options);

	// 监听自定义事件，配合 Native 做关闭监听处理
	document.addEventListener('Event_FSP_Stop',
	function() {
		// 停止监听
		mo.disconnect();
		// 清除未处理的变动
		mo.takeRecords();
	});
})()
