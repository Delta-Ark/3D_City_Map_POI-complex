//show cam

//work w/multiple texts

//load data
//creat objects
//set parameters

class Mark_Connector {
  //would you tell it to do things from a file?
}

//*if I could get the vector of my box, I would solve this problem
//*if I could rotate the camera, I could solve this problem

class Mark {
  float mark_lat = 0;
  float mark_lon = 0;
  String sign_text = "";
  float sign_height = random(100, 200);
  float sign_rot = random(360);
  float ulx = 0;
  float uly = 0;
  float ulz = 0;
  Vec3D TweetCoordiante;
  Vec3D convertedTweetCoordiante;
  Mark(float mlat, float mlon, String st) {
    mark_lat = mlat;
    mark_lon = mlon;
    sign_text = st;
  } 
  void calculate() {
    //coordinates
    TweetCoordiante = new Vec3D(mark_lat, mark_lon, 0);  
    convertedTweetCoordiante=mapzen.convert(TweetCoordiante);

    //one idea: find the box coordinates and replace them;
    //another idea: find the rotate camera method in proscene;

    //CAMERA:
    //this is the line that I have to figure out:
    //scene.camera().setPosition(convertedTweetCoordiante.x(), convertedTweetCoordiante.y()+200, sign_height);
    scene.camera().setPosition(ulx, uly, ulz);
    //
    scene.camera().lookAt(convertedTweetCoordiante.x(), convertedTweetCoordiante.y(), sign_height);
    scene.camera().addKeyFrameToPath(1);
  }
  void display() {
    //MARK:
    pushMatrix();
    pushStyle();
    strokeWeight(10);
    stroke(255, 0, 255);
    translate(convertedTweetCoordiante.x(), convertedTweetCoordiante.y(), 0);
    float tp=map(sin(frameCount*.2), -1, 1, 0, 800);
    line(0, 0, 0, 0, 0, tp);
    popStyle();
    popMatrix();
    //TEXT w/two rotations:
    pushMatrix();
    translate(convertedTweetCoordiante.x()-textWidth(sign_text)/2, convertedTweetCoordiante.y(), sign_height);
    rotateX(radians(-90));
    translate(textWidth(sign_text)/2, 0, 0);
    rotateY(radians(sign_rot));

    translate(0, 0, 200);
    box(20);
    ulx = modelX(0, 0, 0);
    uly = modelY(0, 0, 0);
    ulz = modelZ(0, 0, 0);
    translate(0, 0, -200);

    translate(-textWidth(sign_text)/2, 0, 0);
    translate(-convertedTweetCoordiante.x(), -convertedTweetCoordiante.y(), -sign_height);
    translate(0, 0, sign_height);
    println(sign_height);
    text(sign_text, convertedTweetCoordiante.x(), convertedTweetCoordiante.y(), 200, 200); //xy
    translate(0, 0, -sign_height);

    popMatrix();
  }
}