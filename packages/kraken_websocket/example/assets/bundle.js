let ws = new WebSocket('ws://127.0.0.1:8399');
ws.onopen = () => {
    ws.send('helloworld');
};
ws.onmessage = (event) => {
    console.log(event);
}