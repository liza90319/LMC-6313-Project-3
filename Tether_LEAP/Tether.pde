class Tether {
  PVector position;
  //PVector weightRange;
  ColorPicker cp;
  Bang bang;

  // generate random tether
  Tether(PVector tetherPosition, color c) {
    position = tetherPosition;
    //weightRange = new PVector(0, 3);

    //Init gui
    Group g = cp5.addGroup("Tether -" + (tethers.size()+1))
      .setBackgroundHeight(80)
        .setBackgroundColor(color(0, 100))
          ;

    cp = cp5.addColorPicker("color"+(tethers.size()+1))
      //.setWidth(120)
      .setPosition(10, 10)
        .setColorValue(c)
          .moveTo(g)
            .setId(tethers.size()+1)
              .activateEvent(false)
                ;
 

    // accordion.setItemHeight(80);
    accordion.addItem(g);
    accordion.open(tethers.size());
  }



  void connect(PVector fingerPosition) {
    color c1 = cp.getColorValue();
    stroke(c1, Transparency);
    float w = map(fingerPosition.z, 500, -600, lineWeightMin, lineWeightMax);
    strokeWeight(w);
    line(fingerPosition.x, fingerPosition.y, position.x, position.y);
  }

  //void new(PVector gesturePosition) {
}

