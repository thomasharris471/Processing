class Person {
  

  float x;
  float y;
  
  // 0 = susceptible, 1 = infectious, 2 = recovered
  int state;
  
  boolean hadContact;
  
  float xNoise;
  float yNoise;
  
  
  
  float xHolder;
  float yHolder;
  
  
  ArrayList<Person> contacts;
  
  Person(float x, float y, int state) {
    this.x = x;
    this.y = y;
    this.state = state;
    hadContact = false;
    
    contacts = new ArrayList<Person>();
    
    xNoise = random(-1000000,1000000);
    yNoise = random(-1000000,1000000);
    
    xHolder = x;
    yHolder = y;
  }
  
  boolean hasContacted(Person o) {
    return contacts.contains(o); 
  }
  
  
}
