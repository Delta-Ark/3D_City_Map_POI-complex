static final int STANZAS = 3, COORDS = 3;
final LabelCoord[][] stanzas = new LabelCoord[STANZAS][];

//these are the data structures:
{ // dummy stanza one:
  stanzas[0] = new LabelCoord[] {
    new LabelCoord("this is the first", -122.434216, 37.734181), 
    new LabelCoord("this is the second", -122.480198, 37.750747), 
    new LabelCoord("this is the third", -122.418789, 37.738618)
  };
}

{ // dummy stanza two:
  stanzas[1] = new LabelCoord[] {
    new LabelCoord("1", -122.444216, 37.734181), 
    new LabelCoord("2", -122.490198, 37.750747)
  };
}

{ // dummy stanza three:
  stanzas[2] = new LabelCoord[] {
    new LabelCoord("one", -122.424216, 37.734181), 
    new LabelCoord("two", -122.470198, 37.750747), 
    new LabelCoord("three", -122.408789, 37.738618), 
    new LabelCoord("last", -122.408789, 37.738618)
  };
}

//this is the object you reference in your data structure
static final class LabelCoord {
  final String label;
  final Point2D.Float coord;

  LabelCoord(final String txt, final float lat, final float lon) {
    label = txt;
    coord = new Point2D.Float(lat, lon);
  }

  @ Override String toString() {
    return label + ": " + coord;
  }
}


//dummy stanza one
String[] p1 = {
  "this is the first", 
  "this is the second", 
  "this it the third"
};
float[] p1lat = {
  -122.434216, 
  -122.480198, 
  -122.418789
};
float[] p1lon = {
  37.734181, 
  37.750747, 
  37.738618
};
//dummy stanza two
String[] p2 = {
  "1", 
  "2", 
  "3"
};
float[] p2lat = {
  -122.444216, 
  -122.490198, 
  -122.428789
};
float[] p2lon = {
  37.734181, 
  37.750747, 
  37.738618
};
//dummy stanza three
String[] p3 = {
  "one", 
  "two", 
  "three"
};
float[] p3lat = {
  -122.424216, 
  -122.470198, 
  -122.408789
};
float[] p3lon = {
  37.734181, 
  37.750747, 
  37.738618
};