/**
 * Anaflos. 
 * 
 * Hello
 */
int wrec = 11;
int hrec = 7;
float rwidth, rheight;
int curXcor = 0;
int curYcor = 0;
boolean pressed = false;
boolean[][] clicked;

/* JS script */
var updateClicked = function () {
//    document.getElementById('msg').innerHTML = 'Message: ' + clickedJS;
    console.log("updateClicked!");
    sendMsg();

};

var sendMsg = function () {
    console.log('sendMsg()');
    var xmlhttp;
    if (window.XMLHttpRequest) {
        xmlhttp = new XMLHttpRequest();
    }
    else {
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }

    xmlhttp.open("GET", "http://192.168.0.100:8080/getstring", true);
    xmlhttp.onreadystatechange = function() {
        if (xmlhttp.readyState == 4 && xmlhttp.status == 200) {
            document.getElementById("msg").innerHTML = xmlhttp.responseText;
        }else if ( xmlhttp.readyState == 4 && xmlhttp.status == 500) {
            document.getElementById("msg").innerHTML = xmlhttp.responseText;
        }
    };
    xmlhttp.send();
};


void setup() {
  size(640, 640);
  rwidth = width / wrec;
  rheight = height / hrec;
  println(rwidth);
  println(rheight);

  clicked = new boolean[wrec][hrec];  
  
}

void draw() {
  background(0);
  strokeWeight(0.4);
  stroke(255);
  

  for (float i = 0; i < width; i += rwidth){
    line(i, 0, i, height);
  };
  
  for (float j = 0; j < height; j += rheight){
    line(0, j, width, j);
  };
  
  fillClicked();
}

void fillClicked()
{
  for (int i = 0; i < wrec; i++){
    for (int j = 0; j < hrec; j++){
      if (clicked[i][j] == true){
        fillRect(i, j);
      }else{
        unFillRect(i, j);
      }
    }
  }
}

void fillRect(int x, int y)
{
  fill(255, 255, 255);
  rect(x * rwidth, y * rheight, rwidth, rheight);
}

void unFillRect(int x, int y)
{
  fill(0, 0, 0);
  rect(x * rwidth, y * rheight, rwidth, rheight);
}

void getCoord()
{
  for (int i = 0; i < wrec; i++){
      for (int j = 0; j < hrec; j++){
        if (i*rwidth < mouseX && mouseX < (i+1)*rwidth) {
          if (j*rheight < mouseY && mouseY < (j+1)*rheight) {
            curXcor = i;
            curYcor = j;
//            if (clicked[i][j] == true) clicked[i][j] = false;
//            if (clicked[i][j] == false) clicked[i][j] = true;
            clicked[i][j] = !(clicked[i][j]);
          }
        }
      }
    }  
}

boolean[][] getClicked()
{
  return clicked;
}

void mousePressed() {
  if (!pressed){
    getCoord();
    pressed = true;
    println("X: " + (curXcor + 1) + " / Y: " + (curYcor + 1) + " " + clicked[curXcor][curYcor]);                      
    updateClicked();
  }
}

void mouseDragged() {
  getCoord();
}

void mouseReleased() {
  pressed = false;
}


