const iframe = document.createElement('iframe');
iframe.setAttribute(
    'src',
    'https://www.baidu.com'
);
iframe.style.width = '360px';
iframe.style.height = '375px';

const div = document.createElement('div');
div.style.width = div.style.height = '200px';
div.style.backgroundColor = 'cyan';
document.body.appendChild(div);
document.body.appendChild(iframe);

const div2 = document.createElement('div');
div2.style.width = div2.style.height = '100px';
div2.style.backgroundColor = 'red';
document.body.appendChild(div2);