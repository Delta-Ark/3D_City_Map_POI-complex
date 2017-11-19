//IMPORT STATEMENT:
import main.Mapzen;
import main.net.MapzenUrl;
import main.net.MapzenUrlBuilder;
import toxi.geom.Vec3D;
import toxi.processing.ToxiclibsSupport;
import java.util.List;
import remixlab.proscene.*;
import remixlab.bias.core.*;
import remixlab.bias.event.*;
import remixlab.dandelion.geom.Vec;
//import codeanticode.syphon.*;

//CLASS OBJECTS:
private Mapzen mapzen;
ToxiclibsSupport toxi;
Scene scene;
ArrayList buttons; //these, I believe, are the buttons on the top left corner;
float h;
PFont buttonFont;
float xCounter; //these, I believe, are for manipulating the texts
float yCounter;
float rCounter;
float clickCounter;
PFont font;
int camPosition = 0;
float sceneCounter = 0;
int textCounter = 0;
float angleCounter = 0;
int mouseClick = 1;
int controlCounter = 0;
PGraphics pg;
int polyTrans = 200;
boolean navigator=true;

//THIS IS MY EXPERIMENT  //THIS IS MY EXPERIMENT  //THIS IS MY EXPERIMENT
Mark myMark;
//THIS IS MY EXPERIMENT  //THIS IS MY EXPERIMENT  //THIS IS MY EXPERIMENT

//THIS IS WHERE YOU WILL PLUG IN COORDINATES;
//This is coordinates from your tweets, Vec3D is similar to PVector
//Vec3D TweetCoordinate = new Vec3D(-122.434216, 37.734181, 0);
//Vec3D convertedTweetCoordiante;
Vec3D TweetCoordinateTwo = new Vec3D(-122.480198, 37.750747, 0);
Vec3D convertedTweetCoordianteTwo;
Vec3D TweetCoordinateThree = new Vec3D(-122.418789, 37.738618, 0); 
Vec3D convertedTweetCoordianteThree;

public void setup() {
  // **do not** use setLayrers("roads")...only buildings
  MapzenUrl url = new MapzenUrlBuilder().setLongitude(-122.409531f).setLatitude(37.782281f).setZoom(13).setLayer("buildings").setKey("vector-tiles-PADQnWp").buildUrl();
  mapzen =  new Mapzen(this, url); //this PApplet size
  scene = new Scene(this);

  //THIS IS MY EXPERIMENT  //THIS IS MY EXPERIMENT  //THIS IS MY EXPERIMENT
  myMark = new Mark(-122.434216, 37.734181, "I'm here");
  myMark.calculate();
  //THIS IS MY EXPERIMENT  //THIS IS MY EXPERIMENT  //THIS IS MY EXPERIMENT

  ////THIS IS WHERE THE CAMERAS GET CONSTRUCTED:
  ////first camera high above everything;
  //scene.camera().setPosition(2112.5588, -1205.6464, 2957.1484);
  //scene.camera().setFieldOfView(1.0471975803375244);
  //scene.camera().setUpVector(0.53446037, -0.5722393, -0.6220083);
  //scene.camera().setViewDirection(-0.27059785, 0.58134633, -0.7673417);
  //scene.camera().addKeyFrameToPath(1);
  ////zooms up
  //scene.camera().setPosition(4317.9624, 1741.2267, 518.7126);
  //scene.camera().setFieldOfView(1.0471975803375244);
  //scene.camera().setUpVector(0.101877406, -0.037434276, -0.9940924);
  //scene.camera().setViewDirection(-0.96795, -0.2343187, -0.09037452);
  //scene.camera().addKeyFrameToPath(1);
  ////third camera for WALL, question text;
  //scene.camera().setPosition(1691.2471, 543.21356, 194.24734);
  //scene.camera().setFieldOfView(1.0471975803375244);
  //scene.camera().setUpVector(0.036529277, -0.07828034, -0.99626195);
  //scene.camera().setViewDirection(-0.85749614, -0.5144121, 0.008978188);
  //scene.camera().addKeyFrameToPath(1);
  ////fourth camera for WALL, gets on text 1;
  //scene.camera().setPosition(26.099, 1751.3423, 37.22677);
  //scene.camera().setFieldOfView(1.0471975803375244);
  //scene.camera().setUpVector(0.017698657, -0.08064305, -0.9965859);
  //scene.camera().setViewDirection(-0.080820784, -0.9935957, 0.078965776);
  //scene.camera().addKeyFrameToPath(1);
  ////fifth camera for WALL, gets on text 2;
  //scene.camera().setPosition(-1892.2726, 1082.0692, -11.738281);
  //scene.camera().setFieldOfView(1.0471975803375244);
  //scene.camera().setUpVector(-0.15367264, 0.017253786, -0.9879712);
  //scene.camera().setViewDirection(0.97972965, -0.12737337, -0.15461513);
  //scene.camera().addKeyFrameToPath(1);
  ////sixth camera for WALL, gets on text 3;
  //scene.camera().setPosition(576.0609, 1697.1095, 17.873924);
  //scene.camera().setFieldOfView(1.0471975803375244);
  //scene.camera().setUpVector(0.004650806, 0.07771687, -0.9969646);
  //scene.camera().setViewDirection(-0.052847628, -0.99556303, -0.07785414);
  //scene.camera().addKeyFrameToPath(1);
  ////seventh camera for WALL, looks at ending ad;
  //scene.camera().setPosition(1090.4988, -195.70047, 67.201126);
  //scene.camera().setFieldOfView(1.0471975803375244);
  //scene.camera().setUpVector(-0.019956445, -0.08524717, -0.99616);
  //scene.camera().setViewDirection(0.15981397, 0.9832752, -0.087345935);
  //scene.camera().addKeyFrameToPath(1);
  ////fake camera;
  //scene.camera().setPosition(1083.9225, -236.1621, 70.795395);
  //scene.camera().setFieldOfView(1.0471975803375244);
  //scene.camera().setUpVector(-0.019956622, -0.08524687, -0.99616);
  //scene.camera().setViewDirection(0.15981363, 0.9832753, -0.08734568);
  //scene.camera().addKeyFrameToPath(1);

  scene.showAll();

  scene.setBoundingBox(new Vec(0, 0, 0), new Vec(width, height, 1000));
  scene.setRadius(2000);
  scene.setCenter(new Vec(width/2, height/2));
  scene.camera().setPosition(new Vec(width/2, height/2, 1000));

  //this is the speed;
  scene.camera().keyFrameInterpolator(1).setInterpolationSpeed(0.6f);
  //drawing of camera paths are toggled with key 'r'.
  scene.setPathsVisualHint(true);

  //buttons
  buttons = new ArrayList(6);
  for (int i=0; i<5; ++i)
    buttons.add(null);
  buttonFont = loadFont("FreeSans-16.vlw");
  Button2D button = new ClickButton(scene, new PVector(10, 5), buttonFont, 0);
  h = button.myHeight;
  buttons.set(0, button);

  toxi=new ToxiclibsSupport(this);

  //coordinate convertion takes place
  //convertedTweetCoordiante=mapzen.convert(TweetCoordinate);
  convertedTweetCoordianteTwo=mapzen.convert(TweetCoordinateTwo);
  convertedTweetCoordianteThree=mapzen.convert(TweetCoordinateThree);

  //text
  //font = loadFont("a.vlw");
  font = loadFont("b.vlw");
  //  server = new SyphonServer(this, "Processing Syphon");
}

public void draw() {
  background(0);

  //>>>>>>>>>FLOW CONTROLLER>>>>>>>
  controlCounter++;
  //color control;
  if (mouseClick==6) {
    if (polyTrans>0) {
      polyTrans=polyTrans-2;
    }
  }
  //some color control;
  if (mouseClick==7) {
    mouseClick=0;
    controlCounter=0;
    polyTrans=200;
  }
  //time that it takes to shift;
  if (controlCounter==180) {
    mouseClick++;
    controlCounter=0;
  }
  if (navigator==true) {
    //you need to re-enable this to fly through things:
    //scene.camera().interpolateTo(scene.camera().keyFrameInterpolator(1).keyFrame(mouseClick));
  }

  //TEXT MANIPULATION; load it;
  textCounter++;
  if (textCounter==1) {
    textFont(font, 12);
  }
  fill(255, 255);
  //>>>>>>>>>TEXTS>>>>>>>>>
  angleCounter=angleCounter+.005;
  //THIS IS THE QUESTION-TEXT;
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
  //THIS IS THE FIRST STANZA:
  //#11; THIS IS THE TESTIMONY-TEXT #11; ************
  pushMatrix();
  translate(485*30, 718*30, 5);
  rotateZ(-.0459);
  translate(-485*30, -718*30, -5);
  translate(854+90, 1000+20, 5);
  rotateX(4.7300606);
  translate(-854+90, -1000+20, -5);
  text("Landlord is moving into flat, along with her family. Google and Genetech bus stops across the street.", 854-184, 1000-110, 200, 200);
  popMatrix();
  //#12; THIS IS THE TESTIMONY-TEXT #12; ***********
  pushMatrix();
  translate(900*-2, 550*2);
  rotateZ(1.5149988);
  rotateX(4.7300606);
  //rotateX(4.9350653);
  translate((900*-2)*-1, (550*2)*-1);
  //second translation;
  text("I am in a true catch-22.", (900*-2)+(388-500), (550*2)+13, 200, 200);
  popMatrix();
  //#13; THIS IS THE TESTIMONY-TEXT #13; ***********
  pushMatrix();
  float x = 485*30;
  float y = 718*30;
  translate(x-700, y-12000, 5);
  rotateZ(-.0459);
  translate(-x+700, -y+12000, -5);
  translate(854+68, 1000, 5);
  rotateX(4.7300606);
  translate((854+68)*-1, -1000, -5);
  text("This story is mine. I am real.", 854, 1000, 200, 200);
  popMatrix();

  //THIS IS THE ADVERTISING-TEXT;
  pushMatrix();
  translate(1100, -100, 100);
  rotateZ(3.0100214);
  rotateX(4.71506);
  translate(-1100, +100, -100);
  translate(0, 0, 100);
  text("Anti-Eviction: antievictmap.com Data-Protection: ssd.eff.org Broadcasting: saitogroup.info 415-617-9782", 1000, -100, 200, 200);  
  translate(0, 0, -100);
  popMatrix();

  //>>>>>>>>>MARKERS>>>>>>>>>
  myMark.display();
  //pushMatrix();
  //pushStyle();
  //strokeWeight(10);
  //stroke(255, 255, 255);
  //translate(convertedTweetCoordiante.x(), convertedTweetCoordiante.y(), 0);
  //float t=map(sin(frameCount*.2), -1, 1, 0, 200);
  //line(0, 0, 0, 0, 0, t);
  //popStyle();
  //popMatrix();
  //second quardinate counted;
  //THIS IS THE MARKER OF THE HOUSE;
  pushMatrix();
  pushStyle();
  strokeWeight(10);
  stroke(255, 255, 255);
  translate(convertedTweetCoordianteTwo.x(), convertedTweetCoordianteTwo.y(), 0);
  float t=map(sin(frameCount*.2), -1, 1, 0, 200);
  line(0, 0, 0, 0, 0, t);
  popStyle();
  popMatrix();
  //third coordinate counted;
  //THIS IS THE MARKER OF THE HOUSE;
  pushMatrix();
  pushStyle();
  strokeWeight(10);
  stroke(255, 255, 255);
  translate(convertedTweetCoordianteThree.x(), convertedTweetCoordianteThree.y(), 0);
  //float t=map(sin(frameCount*.2), -1, 1, 0, 200);
  line(0, 0, 0, 0, 0, t);
  popStyle();
  popMatrix();

  //>>>>>>>>>MAPS>>>>>>>>
  //for now: renderPolygons(red,green,blue,opacity) -->fill of the buildings, all sides of the building get the same fill color you set here
  mapzen.renderPolygons(255, 255, 255, polyTrans);//150
  //drawGeoRoads(red, green, blue, strokeWeight);
  mapzen.drawGeoRoads(255, 255, 255, 1);

  updateButtons();
  displayButtons();
  //  server.sendScreen();
}

public void settings() {
  //        size(1300,850);
  //size(1900, 1050, "processing.opengl.PGraphics3D");
  size(1900, 1050, P3D);
  PJOGL.profile=1;
  //        fullScreen(P3D,2);
}

void updateButtons() {
  for (int i = 1; i < buttons.size(); i++) {
    // Check if CameraPathPlayer is still valid
    if ((buttons.get(i) != null) && (scene.camera().keyFrameInterpolator(i) == null ) )
      buttons.set(i, null);
    // Or add it if needed
    if ((scene.camera().keyFrameInterpolator(i) != null) && (buttons.get(i) == null))
      buttons.set(i, new ClickButton(scene, new PVector(10, + ( i ) * ( h + 7 )), buttonFont, i));
  }
}

void displayButtons() {
  for (int i = 0; i < buttons.size(); i++) {
    Button2D button = (Button2D) buttons.get(i);
    if ( button != null )
      button.display();
  }
}

void mousePressed() {
  if (mouseClick<=6) {
    mouseClick++;
  }
  if (mouseClick==7) {
    mouseClick=0;
  }
}