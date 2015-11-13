
//In this example we:  1. generate a unique name, made up of a random first name and last name.
//2. Then, we test this unique generated name against a regular expression pattern.
//This pattern tests for a variety of slightly different names.


String pattern;
String[] firstNames;
String[] lastNames;

void setup() {
  pattern = "Jo(ha|h)?n Eri(x|((c|k|ck)s{1,2}))on"; //| will make you choose ha or h; http://www.regexr.com/
  firstNames = new String[]{"Jon", "John", "Johan"};
  lastNames = new String[]{"Erixon", "Ericson", "Ericsson", "Erikson", "Eriksson", "Erickson", "Ericksson"};
}

void draw() {
  String newName = firstNames[int(random(firstNames.length))]+" " +lastNames[int(random(lastNames.length))];

  if (newName.matches(pattern)) {
    background(255,255,255);
    println(newName+ " matches the pattern."); //(this won't fail)
  } else { //(not going to happen unless you modify one of the arrays in setup)
    
    println(newName+ " -does not- match the pattern."); //(this won't fail)
    background(255,0,0);
    noLoop();
  }
  
}
