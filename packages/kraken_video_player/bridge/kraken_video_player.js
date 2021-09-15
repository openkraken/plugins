class MediaElement extends Element {
  constructor() {
    super();
  }
}

class VideoElement extends MediaElement {
  constructor() {
    super();
  }
}

customElements.define('video', VideoElement);