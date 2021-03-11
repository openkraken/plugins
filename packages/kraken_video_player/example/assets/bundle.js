function setElementStyle(dom, object) {
    if (object == null) return;
    for (let key in object) {
        if (object.hasOwnProperty(key)) {
            dom.style[key] = object[key];
        }
    }
}

function setAttributes(dom, object) {
    for (const key in object) {
        if (object.hasOwnProperty(key)) {
            dom.setAttribute(key, object[key]);
        }
    }
}

const container1 = document.createElement('div');
setElementStyle(container1, {
    height: '500px',
});

document.body.appendChild(container1);

const video = document.createElement('video');
setElementStyle(video, {
    width: '750px',
    height: '400px',
});

setAttributes(video, {
    autoPlay: true,
    src:
        'https://videocdn.taobao.com/oss/ali-video/1fa0c3345eb3433b8af7e995e2013cea/1458900536/video.mp4',
});

video.addEventListener('canplay', () => {
    console.log('vide can play');
});

container1.appendChild(video);

const pauseBtn = document.createElement('div');
pauseBtn.appendChild(document.createTextNode('pause button'));
pauseBtn.addEventListener('click', () => {
    video.pause();
});
container1.appendChild(pauseBtn);

const playBtn = document.createElement('div');
playBtn.appendChild(document.createTextNode('playBtn button'));
playBtn.addEventListener('click', () => {
    video.play();
});
container1.appendChild(playBtn);