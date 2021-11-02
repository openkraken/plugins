(function() {
  function validateUrl(url) {
    let protocol = url.substring(0, url.indexOf(':'));
    if (protocol !== 'ws' && protocol !== 'wss') {
      throw new Error(`Failed to construct 'WebSocket': The URL's scheme must be either 'ws' or 'wss'. '${protocol}' is not allowed.`);
    }
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

  const wsClientMap = {};
  function dispatchWebSocketEvent(clientId, event) {
    let client = wsClientMap[clientId];
    if (client) {
      let readyState = client.readyState;
      switch (event.type) {
        case 'open':
          readyState = ReadyState.OPEN;
          break;
        case 'close':
          readyState = ReadyState.CLOSED;
          break;
        case 'error':
          readyState = ReadyState.CLOSED;
          let connectionStatus = '';
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

  const builtInEvents$1 = [
    'open', 'close', 'message', 'error'
  ];

  class WebSocket extends EventTarget {
    constructor(url, protocol) {
      // @ts-ignore
      super();
      this.CONNECTING = ReadyState.CONNECTING;
      this.OPEN = ReadyState.OPEN;
      this.CLOSING = ReadyState.CLOSING;
      this.CLOSED = ReadyState.CLOSED;
      this.extensions = ''; // TODO add extensions support
      this.protocol = ''; // TODO add protocol support
      this.binaryType = BinaryType.blob;
      // verify url schema
      validateUrl(url);
      this.url = url;
      this.readyState = ReadyState.CONNECTING;
      this.id = kraken.invokeModule('WebSocket', 'init', url);
      wsClientMap[this.id] = this;
      initPropertyHandlersForEventTargets(this, builtInEvents$1);
    }
    addEventListener(type, callback) {
      kraken.invokeModule('WebSocket', 'addEvent', ([this.id, type]));
      super.addEventListener(type, callback);
    }
    // TODO add blob arrayBuffer ArrayBufferView format support
    send(message) {
      kraken.invokeModule('WebSocket', 'send', ([this.id, message]));
    }
    close(code, reason) {
      this.readyState = ReadyState.CLOSING;
      kraken.invokeModule('WebSocket', 'close', ([this.id, code, reason]));
    }
  }

  kraken.addKrakenModuleListener(function(moduleName, event, data) {
    if (moduleName === 'WebSocket') {
      dispatchWebSocketEvent(data, event);
    }
  });

  Object.defineProperty(globalThis, 'WebSocket', {
    enumerable: true,
    writable: false,
    configurable: false,
    value: WebSocket
  });
})();