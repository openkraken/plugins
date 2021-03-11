const positionWatcherMap = new Map();

function dispatchPositionEvent(data) {
  positionWatcherMap.forEach((watcher) => {
    if (data.coords != null) {
      watcher.success(data);
    } else if (watcher.error != null) {
      watcher.error(data);
    }
  });
}

kraken.addKrakenModuleListener((moduleName, event, data) => {
  if (moduleName == 'Geolocation') {
    dispatchPositionEvent(data);
  }
});

const geolocation = {
  getCurrentPosition(success, error, options) {
    if (success == null) {
      throw new TypeError(`Failed to execute 'getCurrentPosition' on 'Geolocation': 1 argument required, but only 0 present`);
    }

    kraken.invokeModule('Geolocation', 'getCurrentPosition', options || {}, (e, result) => {
      if (e && error) return error(e);
      if (result['coords'] != null) {
        success(result);
      } else if (error != null) {
        error(result);
      }
    });
  },
  watchPosition(success, error, options) {
    if (success == null) {
      throw new TypeError(`Failed to execute 'watchPosition' on 'Geolocation': 1 argument required, but only 0 present.`);
    }
    const watchId = kraken.invokeModule('Geolocation', 'watchPosition', options || {});
    positionWatcherMap.set(watchId, {success: success, error: error});
    return parseInt(watchId);
  },
  clearWatch(id) {
    if (id == null) {
      throw new TypeError(`Failed to execute 'clearWatch' on 'Geolocation': 1 argument required, but only 0 present.`);
    }
    positionWatcherMap.delete(id.toString());
    if (positionWatcherMap.size === 0) {
      kraken.invokeModule('Geolocation', 'clearWatch');
    }
  }
}

Object.defineProperty(navigator, 'geolocation', {
  value: geolocation,
  enumerable: true,
  writable: false,
  configurable: false
});