//>>>>>>>>>>SAVING CAMERA POSITIONS "BY HAND"
import processing.data.JSONObject;
import java.util.Arrays;

//this is how you save the camera, theoretically;
//save a Proscene scene current camera settings in as a JSON string in a file

PVector convertVtoPV(Vec v) {
  return new PVector(v.x(), v.y(), v.z());
}
Vec convertPVtoV(PVector v) {
  return new Vec(v.x, v.y, v.z);
}

void saveCamera(Scene scene, String fileName ) {
  processing.data.JSONObject json = new JSONObject();
  json.setFloat("fov", scene.camera().fieldOfView() ); 
  setVector(json, "position", convertVtoPV(scene.camera().position()) );
  setVector(json, "viewdirection", convertVtoPV(scene.camera().viewDirection()) );
  setVector(json, "upvector", convertVtoPV(scene.camera().upVector()) );
  saveJSONObject(json, fileName);
}

//Add a PVector as a string representation of a float array to a JSON object
void setVector(JSONObject json, String attributeName, PVector v) {
  json.setString( attributeName, Arrays.toString( new float[]{ v.x, v.y, v.z} ) );
}

//#####this is how you load the camera, theoretically;
void loadCamera(Scene scene, String fileName) {
  JSONObject json = loadJSONObject(fileName);
  scene.camera().setFieldOfView( json.getFloat("fov") );
  scene.camera().setUpVector( convertPVtoV(getVector(json, "upvector")) );
  scene.camera().setViewDirection( convertPVtoV(getVector(json, "viewdirection")) );
  scene.camera().setPosition( convertPVtoV((getVector(json, "position"))) );
}
//Parse a PVector from its string representation as an array of float in a JSON object
PVector getVector(JSONObject json, String attributeName) {
  String o =  json.getString(attributeName);
  String[] arr = o.substring(1, o.length()-1).split(", ");
  float[] f = new float[arr.length];
  int i = 0;
  for (String s : arr) {
    f[i] = Float.parseFloat(s);
    i++;
  }
  return new PVector(f[0], f[1], f[2]);
}

void keyPressed() {
  if (key=='s') {
    println("save");
    saveCamera(scene, "data/new.json");
  }
  if (key=='l') {
    println("load");
    loadCamera(scene, "data/new.json");
  }
    if (key=='q') {
    navigator=false;
  }
  if (key=='w') {
    navigator=true;
  }
}