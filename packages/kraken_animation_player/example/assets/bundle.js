const ASSET = 'https://andycall.oss-cn-beijing.aliyuncs.com/data/Teddy.flr';
const animationPlayer = document.createElement('animation-player');
animationPlayer.setAttribute('type', 'flare');
animationPlayer.setAttribute('src', ASSET);
Object.assign(animationPlayer.style, {
  width: '360px',
  height: '640px',
  objectFit: 'contain',
});

document.body.appendChild(animationPlayer);

document.body.onclick = () => animationPlayer.play('hands_up');