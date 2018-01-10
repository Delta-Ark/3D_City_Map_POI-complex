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
import java.awt.geom.Point2D; //you need this for your new data structure
//import codeanticode.syphon.*;

//CLASS OBJECTS: (a lot of these are probably null and void)
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
int mouseClick = 0;
int controlCounter = 0;
PGraphics pg;
int polyTrans = 200;
boolean navigator=true;
int flowLine = 0; //this is the path of cameras we're on

//THIS IS MY EXPERIMENT  //THIS IS MY EXPERIMENT  //THIS IS MY EXPERIMENT
//Start myStart;
//Mark myMark;
//Mark myMarkTwo;
//Mark myMarkThree;
//End myEnd;
//new level
//Paragraph myParagraph;
//Paragraph mySecondParagraph;
Poem myPoem;

public void setup() {
  // **do not** use setLayrers("roads")... only buildings
  MapzenUrl url = new MapzenUrlBuilder().setLongitude(-122.409531f).setLatitude(37.782281f).setZoom(13).setLayer("buildings").setKey("vector-tiles-PADQnWp").buildUrl();
  mapzen =  new Mapzen(this, url); //this PApplet size
  scene = new Scene(this);

  //first camera high above everything;
  //you could choose the center point of the map, 
  //a lot of feet above, looking down (?)
  //scene.camera().setPosition(2112.5588, -1205.6464, 2957.1484);
  //scene.camera().setFieldOfView(1.0471975803375244);
  //scene.camera().setUpVector(0.53446037, -0.5722393, -0.6220083);
  //scene.camera().setViewDirection(-0.27059785, 0.58134633, -0.7673417);
  //scene.camera().addKeyFrameToPath(0);

  //THIS IS MY EXPERIMENT  //THIS IS MY EXPERIMENT  //THIS IS MY EXPERIMENT
  //myStart = new Start();
  //myStart.calculate();
  //myMark = new Mark(-122.434216, 37.734181, "I'm here #1");
  //myMark.calculate();
  //myMarkTwo = new Mark(-122.480198, 37.750747, "I'm here #2");
  //myMarkTwo.calculate();
  //myMarkThree = new Mark(-122.418789, 37.738618, "I'm here #3");
  //myMarkThree.calculate();
  //myEnd = new End();
  //myEnd.calculate();
  //new level
  //myParagraph = new Paragraph(0, 0);
  //myParagraph.calculate();
  //mySecondParagraph = new Paragraph(1, 1);
  //mySecondParagraph.calculate();
  //new level
  myPoem = new Poem();
  myPoem.calculate();

  scene.showAll();

  //this is where the scene is created;
  scene.setBoundingBox(new Vec(0, 0, 0), new Vec(width, height, 1000));
  scene.setRadius(2000);
  scene.setCenter(new Vec(width/2, height/2));
  scene.camera().setPosition(new Vec(width/2, height/2, 1000));

  //this is the speed;
  scene.camera().keyFrameInterpolator(0).setInterpolationSpeed(0.1f); //before .6
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

  //text
  //font = loadFont("a.vlw");
  font = loadFont("b.vlw");
  //  server = new SyphonServer(this, "Processing Syphon");
}

public void draw() {
  background(0);

  // >>>>>>>>>> flow controller >>>>>>>>>

  //flowLine = camera path

  //this control counter drives the entire operation
  controlCounter++;
  //time that it takes to shift;
  if (controlCounter==150) { //previously 180
    mouseClick++;
    controlCounter=0;
  }
  //reset function
  if (mouseClick==stanzas[flowLine].length+2) {
    mouseClick=0;
    controlCounter=0;
    //does this properly control the flow lines (?)
    //3 should be stanzas.length ***********
    if (flowLine != stanzas.length) {
      flowLine = flowLine + 1;
    }
    if (flowLine == 3) {
      flowLine = 0;
    }
  }
  //this navigator advances the frame;
  if (navigator==true) {
    scene.camera().interpolateTo(scene.camera().keyFrameInterpolator(flowLine).keyFrame(mouseClick));
  }
  //color control;
  //if (mouseClick==6) {
  //  if (polyTrans>0) {
  //    polyTrans=polyTrans-2;
  //  }
  //}
  //some color control;
  //if (mouseClick==7) {
  //  mouseClick=0;
  //  controlCounter=0;
  //  polyTrans=200;
  //}


  //TEXT MANIPULATION; load it;
  textCounter++;
  //if (textCounter==1) {
    textFont(font, 12);
  //}
  fill(255, 255);

  //>>>>>>>>>MARKERS>>>>>>>>>
  //myStart.display();
  //myMark.display();
  //myMarkTwo.display();
  //myMarkThree.display();
  //myEnd.display();
  //next level
  //myParagraph.display();
  //mySecondParagraph.display();
  myPoem.display();

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

//this is more of the control structure;
//void mousePressed() {
//  if (mouseClick<=6) {
//    mouseClick++;
//  }
//  if (mouseClick==7) {
//    mouseClick=0;
//  }
//}