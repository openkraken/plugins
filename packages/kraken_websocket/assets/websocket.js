var extendStatics = function (d, b) {
  extendStatics = Object.setPrototypeOf ||
    ({ __proto__: [] } instanceof Array && function (d, b) { d.__proto__ = b; }) ||
    function (d, b) { for (var p in b) if (b.hasOwnProperty(p)) d[p] = b[p]; };
  return extendStatics(d, b);
};

function __extends(d, b) {
  extendStatics(d, b);
  function __() { this.constructor = d; }
  d.prototype = b === null ? Object.create(b) : (__.prototype = b.prototype, new __());
}

function initPropertyHandlersForEventTargets(eventTarget, builtInEvents) {
  var _loop_1 = function (i) {
    var eventName = builtInEvents[i];
    var propertyName = 'on' + eventName;
    Object.defineProperty(eventTarget, propertyName, {
      get: function () {
        return this['_' + propertyName];
      },
      set: function (value) {
        if (value == null) {
          this.removeEventListener(eventName, this['_' + propertyName]);
        }
        else {
          this.addEventListener(eventName, value);
        }
        this['_' + propertyName] = value;
      }
    });
  };
  for (var i = 0; i < builtInEvents.length; i++) {
    _loop_1(i);
  }
}

function validateUrl(url) {
  var protocol = url.substring(0, url.indexOf(':'));
  if (protocol !== 'ws' && protocol !== 'wss') {
    throw new Error("Failed to construct 'WebSocket': The URL's scheme must be either 'ws' or 'wss'. '" + protocol + "' is not allowed.");
  }
}
var ReadyState;
(function (ReadyState) {
  ReadyState[ReadyState["CONNECTING"] = 0] = "CONNECTING";
  ReadyState[ReadyState["OPEN"] = 1] = "OPEN";
  ReadyState[ReadyState["CLOSING"] = 2] = "CLOSING";
  ReadyState[ReadyState["CLOSED"] = 3] = "CLOSED";
})(ReadyState || (ReadyState = {}));

var BinaryType;
(function (BinaryType) {
  BinaryType["blob"] = "blob";
  BinaryType["arraybuffer"] = "arraybuffer";
})(BinaryType || (BinaryType = {}));

var wsClientMap = {};
function dispatchWebSocketEvent(clientId, event) {
  var client = wsClientMap[clientId];
  if (client) {
    var readyState = client.readyState;
    switch (event.type) {
      case 'open':
        readyState = ReadyState.OPEN;
        break;
      case 'close':
        readyState = ReadyState.CLOSED;
        break;
      case 'error':
        readyState = ReadyState.CLOSED;
        var connectionStatus = '';
        switch (readyState) {
          case ReadyState.CLOSED: {
            connectionStatus = 'closed';
            break;
          }
          case ReadyState.OPEN: {
            connectionStatus = 'establishment';
            break;
          }
          case ReadyState.CONNECTING: {
            connectionStatus = 'establishment';
            break;
          }
        }
        console.error('WebSocket connection to \'' + client.url + '\' failed: ' +
          'Error in connection ' + connectionStatus + ': ' + event.error);
        break;
    }
    client.readyState = readyState;
    client.dispatchEvent(event);
  }
}

kraken.addKrakenModuleListener((moduleName, event, data) => {
  if (moduleName == 'WebSocket') {
    dispatchWebSocketEvent(data, event);
  }
});

var builtInEvents = [
  'open', 'close', 'message', 'error'
];
var WebSocket = /** @class */ (function (_super) {
  __extends(WebSocket, _super);
  function WebSocket(url, protocol) {
    var _this =
      // @ts-ignore
      _super.call(this, builtInEvents) || this;
    _this.CONNECTING = ReadyState.CONNECTING;
    _this.OPEN = ReadyState.OPEN;
    _this.CLOSING = ReadyState.CLOSING;
    _this.CLOSED = ReadyState.CLOSED;
    _this.extensions = ''; // TODO add extensions support
    _this.protocol = ''; // TODO add protocol support
    _this.binaryType = BinaryType.blob;
    // verify url schema
    validateUrl(url);
    _this.url = url;
    _this.readyState = ReadyState.CONNECTING;
    _this.id = kraken.invokeModule('WebSocket', 'init', url);
    wsClientMap[_this.id] = _this;
    initPropertyHandlersForEventTargets(_this, builtInEvents);
    return _this;
  }
  WebSocket.prototype.addEventListener = function (type, callback) {
    kraken.invokeModule('WebSocket', 'addEvent', ([this.id, type]));
    _super.prototype.addEventListener.call(this, type, callback);
  };
  // TODO add blob arrayBuffer ArrayBufferView format support
  WebSocket.prototype.send = function (message) {
    kraken.invokeModule('WebSocket', 'send', ([this.id, message]));
  };
  WebSocket.prototype.close = function (code, reason) {
    this.readyState = ReadyState.CLOSING;
    kraken.invokeModule('WebSocket', 'close', ([this.id, code, reason]));
  };
  return WebSocket;
}(EventTarget));

Object.defineProperty(globalThis, 'WebSocket', {
  value: WebSocket,
  enumerable: true,
  writable: false,
  configurable: false
});