//interrupt error (?)

class Poem {
  Paragraph[] myParagraph;
  Poem () {
  }
  void calculate() {
    myParagraph = new Paragraph[stanzas.length];
    for (int i = 0; i < stanzas.length; i++) {
      myParagraph[i] = new Paragraph(i, i);
      myParagraph[i].calculate();
    }
  }
  void display() {
    myParagraph[flowLine].display(); //<---------- is that the answer (?)    
    //for (int i = 0; i < stanzas.length; i++) {
    //  myParagraph[i].display();
    //}
  }
}

class Paragraph {
  Mark[] myMark; 
  Start myStart; 
  End myEnd; 
  int tag; //which stanza is being referred to
  int number; //which camera path this should be on
  //paragraph constructor
  Paragraph(int t, int n) {
    tag = t;
    number = n;
  }
  void calculate() {
    myStart = new Start(number); 
    myStart.calculate(); 
    myMark = new Mark[stanzas[tag].length];
    for (int i = 0; i < stanzas[tag].length; i++) {
      myMark[i] = new Mark(stanzas[tag][i].coord.x, stanzas[tag][i].coord.y, stanzas[tag][i].label, number);
      myMark[i].calculate();
    }
    myEnd = new End(number); 
    myEnd.calculate();
  }
  void display() {
    myStart.display(); 
    for (int i = 0; i < stanzas[tag].length; i++) {
      myMark[i].display();
    }
    myEnd.display();
  }
}

class Start {
  int path; 
  Start(int p) {
    path = p;
  }
  void calculate() {
    scene.camera().setPosition(1691.2471, 543.21356, 194.24734); 
    scene.camera().setFieldOfView(1.0471975803375244); 
    scene.camera().setUpVector(0.036529277, -0.07828034, -0.99626195); 
    scene.camera().setViewDirection(-0.85749614, -0.5144121, 0.008978188); 
    scene.camera().addKeyFrameToPath(path);
  }
  void display() {    
    pushMatrix(); 
    translate(1500+100, 500, 250); 
    rotateZ(-.0459); 
    rotateX(4.655059); 
    rotateY(0.9099993); 
    translate(-1500-100, -500, -250); 
    translate(0, 0, 250);
    text("Is this the future we want or is it another, one where we manage the space and the data together?", 1500, 500, 200, 200); 
    translate(0, 0, -250); 
    popMatrix();
  }
}

class Mark {
  int path; 
  float mark_lat = 0; 
  float mark_lon = 0; 
  String sign_text = ""; 
  float sign_height = random(100, 200); 
  float sign_rot = random(360); 
  float ulx = 0; 
  float uly = 0; 
  float ulz = 0;
  int textS = 30; //this is a hack <-- manipulates the size of the font, will have to continually adjust
  Vec3D TweetCoordiante; 
  Vec3D convertedTweetCoordiante; 
  Mark(float mlat, float mlon, String st, int p) {
    mark_lat = mlat; 
    mark_lon = mlon; 
    sign_text = st; 
    path = p;
  } 
  void calculate() {
    //coordinates
    TweetCoordiante = new Vec3D(mark_lat, mark_lon, 0); 
    convertedTweetCoordiante=mapzen.convert(TweetCoordiante); 
    //calculate the camera position based upon a rotate box
    //I know that this looks complicated [...]
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
    translate(0, 0, -sign_height); 
    popMatrix(); 

    //CAMERA:
    //scene.camera().setPosition(convertedTweetCoordiante.x(), convertedTweetCoordiante.y()+200, sign_height);
    scene.camera().setPosition(ulx, uly, ulz); 
    scene.camera().lookAt(convertedTweetCoordiante.x(), convertedTweetCoordiante.y(), sign_height); 
    scene.camera().setUpVector(0, 0, -1); 
    scene.camera().addKeyFrameToPath(path);
  }
  //this basically shows the text;
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
    textSize(textS);
    //**********IS THE PROBLEM HERE?
    translate(convertedTweetCoordiante.x()-textWidth(sign_text)/2, convertedTweetCoordiante.y(), sign_height); 
    rotateX(radians(-90)); 
    translate(textWidth(sign_text)/2, 0, 0); 
    rotateY(radians(sign_rot)); 
    translate(-textWidth(sign_text)/2, 0, 0); 
    translate(-convertedTweetCoordiante.x(), -convertedTweetCoordiante.y(), -sign_height); 
    translate(0, 0, sign_height);
    //*********IS THE PROBLEM BELOW********
    text(sign_text, convertedTweetCoordiante.x(), convertedTweetCoordiante.y(), 400, 400); //xy
    translate(0, 0, -sign_height); 
    popMatrix();
  }
}

class End {
  int path; 
  int textS = 12;
  End(int p) {
    path = p;
  }
  void calculate() {
    scene.camera().setPosition(1090.4988, -195.70047, 67.201126); 
    scene.camera().setFieldOfView(1.0471975803375244); 
    scene.camera().setUpVector(-0.019956445, -0.08524717, -0.99616); 
    scene.camera().setViewDirection(0.15981397, 0.9832752, -0.087345935); 
    scene.camera().addKeyFrameToPath(path);
  }
  void display() {    
    pushMatrix(); 
    translate(1100, -100, 100); 
    rotateZ(3.0100214); 
    rotateX(4.71506); 
    translate(-1100, +100, -100); 
    translate(0, 0, 100); 
    textSize(textS);
    text("Anti-Eviction: antievictmap.com Data-Protection: ssd.eff.org Broadcasting: saitogroup.info 415-617-9782", 1000, -100, 200, 200); 
    translate(0, 0, -100); 
    popMatrix();
  }
}