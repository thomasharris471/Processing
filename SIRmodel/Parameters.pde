float s0 = 1000;
float i0 = 100;
float r0 = 0;


float infectionRadius = 30;


//unit time is float time  = 1;
//percentage, 1, through 100, this is change of infection per unit TIME spent in presence of infected
float chanceOfInfection = 8;
float chanceOfRecovery = 2;


float worldSize = 1000;
float maxTravelSpeed = 50;









float dt = .1;
int stepsPerFrame = 1;

float unitTime = 1;


color susColor = color(255,255,255);
color infColor = color(0,255,0);
color recColor = color(255,0,0);
color contactColor = color(0,0,255);
float infectionRadiusopacity = 30;

float personSize = 3;

boolean drawInfectionRadius = true;
boolean displayContaced = false;

float panelPercentageSize = .2;
