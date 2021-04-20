var div = document.createElement("DIV");
div.style.display = "flex";
div.style.flexDirection = "column";
div.style.alignItems = "center";
document.body.appendChild(div);

var camera = document.createElement("CAMERA-PREVIEW");
camera.style.width = camera.style.height = "200px";
camera.setAttribute("resolution-preset", "medium");
camera.setAttribute("lens", "back");
div.appendChild(camera);

var text = document.createTextNode("Take Picture");
var p = document.createElement("p");
p.style.textAlign = "center";
p.style.background = getRandomColor();
p.style.color = "#FFFFFF";
p.style.fontSize = "24px";
p.style.padding = "15rpx 15rpx 15rpx 15rpx";
p.style.margin = "40rpx 20rpx 20rpx 20rpx";
p.appendChild(text);
p.textNode = text;
p.onclick = function (e) {
  var timestamp = Date.parse(new Date());
  var picName = timestamp + ".png";
  camera.setAttribute("take-picture", picName);
};
div.appendChild(p);

function getRandomColor() {
  var letters = "0123456789ABCDEF";
  var color = "#";
  for (var i = 0; i < 6; i++) {
    color += letters[Math.floor(Math.random() * 16)];
  }
  return color;
}
