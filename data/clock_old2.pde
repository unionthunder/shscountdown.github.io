/*This is probably the crappiest source code you've ever seen. Processing has no support for loading
outside files builtin (I guess you could do it with javascript, I'aven't tried) so everything is in one file.
The project was never meant to support all these features so a lot of code is copied all over the place.
There are syntax errors and misused varaible types that are fine in javascript but not in java, this is probably
because I made this on a text editor at school. Also the javascript console gives completly useless error messages
so debugging is a pain. */

//WIP
//Add custom selection for day
/* @pjs preload="https://sites.google.com/site/bowserinator/files/log-tree-fir-forest-lake-mountain-snow-sky-cloud.jpg,
https://sites.google.com/site/bowserinator/files/ussr.png,
https://sites.google.com/site/bowserinator/files/wave.jpg,
https://sites.google.com/site/bowserinator/files/sun.jpg,
https://sites.google.com/site/bowserinator/files/earth.jpg,
https://sites.google.com/site/bowserinator/files/405px-Meandros_flag.svg.png,
https://sites.google.com/site/bowserinator/files/drawing.png"; */

Timer hoursEnd, minutesEnd, secondsEnd;
SchoolEnd school;
LinkButton facebook_button, chrome_button, shortened_url, survey_button, app_button, ios_button, beta_button;

int backgroundState = 0; //0 = default background, 1 = communist flag, 2 = Fancy wave background,3 = sunset, 
int state = 0; // 0 = school countdown
int m,h,s,result;
boolean openSlide = false;
boolean openBackgroundSlide = false;

int backgroundSelect = backgroundState; //Default background selection thing

classroom classr;
PImage[] backgrounds;
String[] months = {"Jan","Feb","Mar","Apr","May","June","July","Aug","Sept","Oct","Nov","Dec"};
String[][] quotes = { 
  {"Computers don't lie, but liars can compute.","Terry Hayes"},
  {"A C on a lab won't always bring your grade down, it might it bring your grade up from a D","Sarah Daniel"},
  {"Drake wouldn't treat you like this","A meme apparently"},
  {"I am so clever that sometimes I don't understand a single word of what I am saying.","Oscar Wilde"},
  {"He who learns but does not think, is lost! He who dongs dongs, dongs dongs!","Confucius"},
  {"Parting with friends is a sadness. A place is only a place","Dune by Frank Herbert"},
  {"This is a clod! Destroying him will be a service to mankind","Dune by Frank Herbert"},
  {"Lord what fools these mortals be!","Puck, A Midsummer Night's Dream, (3.2.110-115)"},
  {"Violence is sometimes the answer","[Citation redacted]"},
  {"I feel strong enough to punch mister Hitler right in the snoot!","Dr. Seuss"},
  {"NOT IDIOT PROOF","DONT COMPLAIN LOL"},
  {"When I graduate I'll just take this down.",":D"},
  {"DONATE DONATE DONATE","DONATE DONATE DONATE"},
  {"There is no such thing as a new idea. It is impossible.","Mark Twain"},
  {"Everyone is racist.","[Citation redacted]"},
  {"sarcasm, it's just another free service I offer.","Not really, I was being sarcastic."},
  {"Rot26 is twice as secure as rot13!","A joke, see http://rot26.org/"},
  {"Don't look directly at the bugs!","Minecraft title splash"},
  {"There are two types of people: those who can extrapolate from incomplete data.","A joke."},
  {"The day before the day after tomorrow is the day after the day before the day after yesterday.","Got bored on IRC chat."},
  {"bababadalgharaghtakamminarronnkonnbronntonnerronntuonnthunntrovarrhounawnskawntoohoohoordenenthurnuk","Just google it."},
  {"I lost the game.","Reference to the Game (Mind Game)"},
  {"Mortals. I envy you. You think you can change things. Stop the universe. Undo what was done long before you came along.","Beautiful Creatures"},
  {"Make it idiot proof and someone will make a better idiot.","Some guy online somewhere"},
  {"He was too busy asking if he could, he didn't stop to ask if he should.","Some guy online somewhere"},
  {"The numbers, Mason! What do they mean?","Jason Hudson, Call of Duty"},
  {"Sometimes a majority simply means that all the fools are on the same side.","Claude C. McDonald"},
  {"If everyone believes it, does that make it true?","Winston, 1984 by George Orwell"},
  {"I can use this to spread propoganda.","You'll probably believe most of these quotes."},
  {"Big brother is watching you.","Government of Oceania, 1984 by George Orwell"},
  {"Now I have become death, the destroyer of worlds.","Bhagavad Gita"},
  {"Reading the source is cheating!","Find the quotes yourself."},
  {"90% bug free! Promise!","We may have a few bugs..."},
  {"How do you play a game against an omniscient opponent?","A logical paradox"},
  {"An interesting game. The only winning move is not to play.","NORAD, WarGames"},
  {"Despite goodwill, human intimacy cannot occur without substantial mutual harm.","A logical paradox"},
  {"Roses are Red Violets are Blue In Soviet Russia Poem writes YOU!!","A Russian reversal joke"},
  {"Perhaps it's impossible to wear an identity without becoming what you pretend to be.","Valentine, Ender's Game by Orson Scott Card"},
  {"Roses are red | Violets are blue | Don't you have anything | Better to do?","A humorous twist on the classic poem."},
  {"I find your lack of faith disturbing.","Lord Vader, Star Wars IV - A New Hope"},
  {"One day, somewhere in the future, my work will be quoted!","Minecraft splash title."},
  {"War is Peace | Freedom is Slavery | Ignorance is strength","1984 by George Orwell"},
  {"100% accurate (Assuming relative time)","Time is relative, thus this timer is 100% accurate in it's time frame"},
  {"Knowledge is power, and power corrupts. Does knowledge corrupt?","A mathamatical joke on mock logical reasoning."},
  {"Share this with your friends!","Do what the quote says."},
  {"Like us on facebook!","The link should be down below (Sometimes)"},
  {"In Soviet Russia, waldo finds you!","A russian reversal joke"},
  {"Peace cannot be kept by force; it can be achieved by understanding.","Albert Einstein"},
  {"Once we understand our limits, we go beyond them.","Albert Einstein"},
  {"A person is a person, no matter how small.","Dr. Seuss"},
  {"People who think they know everything are a great annoyance to those of us who do.","Isaac Asimov"},
  {"I am not a speed reader. I am a speed understander.","Isaac Asimov"},
  {"It is not only the living that are killed in a war.","Isaac Asimov"},
  {"Success is not final; failure is not fatal; it is the courage to continue that counts.","Winston Churchill"},
  {"You have enemies? Good. That means you've stood up for something, sometime in your life.","Winston Churchill"},
  {"To improve is to change; to be perfect is to change often.","Winston Churchill"},
  {"I am fond of pigs. Dogs look up to us. Cats look down on us. Pigs treat us as equals.","Winston Churchill"},
  {"We shape our buildings; thereafter they shape us.","Winston Churchill"},
  {"Nationalism is power hunger tempered by self-deception.","Notes on Nationalism by George Orwell"},
  {"Who controls the past controls the future. Who controls the present controls the past.","1984 by George Orwell"},
  {"All animals are equal, but some animals are more equal than others.","Animal Farm by George Orwell"},
  {"Men can only be happy when they do not assume that the object of life is happiness.","George Orwell"},
  {"Whoever is winning at the moment will always seem to be invincible.","George Orwell"},
  {"404 Quote not found","A play on the 404 error."},
  {"We build too many walls and not enough bridges.","Issac Newton"},
  {"People won't have time for you if you are always angry or complaining.","Stephen Hawking"},
  {"Intelligence is the ability to adapt to change.","Stephen Hawking"},
  {"When one's expectations are reduced to zero, one really appreciates everything one does have.","Stephen Hawking"},
  {"Work gives you meaning and purpose and life is empty without it.","Stephen Hawking"},
  {"Death is the solution to all problems. No man - no problem.","Joseph Stalin, leader of the USSR"},
  {"The death of one man is a tragedy. The death of millions is a statistic.","Joseph Stalin, leader of the USSR"},
  {"Print is the sharpest and the strongest weapon of our party.","Joseph Stalin, leader of the USSR"},
  {"I trust no one, not even myself.","Joseph Stalin, leader of the USSR"},
  {"1.21 gigawatts?! 1.21 gigawatts?! Great Scott!","Doc Brown, Back to the Future"},
  {"Run: cat /dev/random /dev/tty","Run this command in a linux shell."},
  {"The power to annoy is the power to destroy.","A common adage."},
  {"Bowserinator is always right!","(Usually right)"},
  {"He alone, who owns the youth, gains the future.","Adolf Hitler, Fuher of Nazi Germany"},
  {"Make the lie big, make it simple, keep saying it, and eventually they will believe it.","Adolf Hitler, Fuher of Nazi Germany"},
  {"The victor will never be asked if he told the truth.","Adolf Hitler, Fuher of Nazi Germany"},
  {"TWO PLUS TWO MAKES FIVE","Most commonly referenced to George Orwell's 1984"},
  {"Even in the valley of the shadow of death, two and two do not make six.","Russian Orthodox Church"},
  {"Stuff your eyes with wonder, he said, live as if you'd drop dead in ten seconds.","Fahrenheit 451 by Ray Bradbury"},
  {"See the world. It's more fantastic than any dream made or paid for in factories.","Fahrenheit 451 by Ray Bradbury"},
  {"If you hide your ignorance, no one will hit you and you'll never learn.","Fahrenheit 451 by Ray Bradbury"},
  {"When they give you lined paper, write the other way.","Fahrenheit 451 by Ray Bradbury"},
  {"The sun burnt every day. It burnt time.","Fahrenheit 451 by Ray Bradbury"},
  {"It's not the time that matters, it's the person.","11th Doctor, Doctor Who"},
  {"In 900 years of time and space, I've never met anyone who wasn't important","12th Doctor, Doctor Who"},
  {"Do what I do. Hold tight and pretend it's a plan!","12th Doctor, Doctor Who"},
  {"Never ignore coincidence. Unless, of course, you're busy. In which case, always ignore coincidence.","12th Doctor, Doctor Who"},
  {"We're all stories, in the end. Just make it a good one, eh?","12th Doctor, Doctor Who"},
  {"Come on, Rory! It isn't rocket science, it's just quantum physics!","12th Doctor, Doctor Who"},
  {"Allons-y!","11th Doctor, Doctor Who"},
  {"When life gives you lemons, you dont make lemonade! You throw the lemons back at life","Cave Johnson, Portal Series"},
  {"We do what we must because we can.","GLaDOS, Portal Series"},
  {"It's kind of hard to ask a dead guy what he did wrong.","Maze Runner by James Dashner"},
  {"You get lazy, you get sad. Start givin' up. Plain and simple.","Maze Runner by James Dashner"},
  {"Quit voting me down before you even think about what I'm saying.","Maze Runner by James Dashner"},
  {"Beyond here be dragons","Old saying"},
  {"If at first you don't succeed, try, try again","Common adage"},
  {"Infinite power just isn't very interesting, no matter what game you're playing.","Notch, Minecraft"},
  {"I'm just used to being on fire","Random person on the internet"},
  {"The end is never the end is never the end is never the end...","Stanley Parable"},
  {"You look quite well for a man that's been 'utterly destroyed","Spock, Star Trek"},
  {"If there's nothing wrong with me... maybe there's something wrong with the universe!","Dr. Crusher, Star Trek the Next Generation"},
  
};
//String rand_quote = quotes[round(random(0,quotes.length-1))];
int index = new Date().getMilliseconds()%quotes.length;
String rand_quote = quotes[index][0];
String rand_cite = quotes[index][1];

TextButton back_left,back_right,back_cancel,back_ok, back_open;
String[] back_names;

void setup(){
 // size(window.innerWidth,window.innerHeight);
  size(window.innerWidth, window.innerHeight);
  sizeX = window.innerWidth;
  sizeY = window.innerHeight;
  
  back_left = new TextButton("<");
  back_right = new TextButton(">");
  back_cancel = new TextButton("X");
  back_ok = new TextButton("\u2713");
  back_open = new TextButton(" Background ");
  
  facebook_button = new LinkButton("Facebook page: http://adf.ly/1aLXRZ","http://adf.ly/1aLXRZ");
  chrome_button = new LinkButton("Extension: http://adf.ly/1aLXMQ","http://adf.ly/1aLXMQ");
  shortened_button = new LinkButton("Shortned url: http://goo.gl/4yUUqr","http://goo.gl/4yUUqr");
  survey_button = new LinkButton("Suggestions: [Click here]","http://goo.gl/forms/3StDySWVSzoykXDo1");
  app_button = new LinkButton("Android App: [Click here]","http://adf.ly/1aUaws");
  ios_button = new LinkButton("IOS: [INFO]","https://sites.google.com/site/bowserinator/home/app-apple");
  beta_button = new LinkButton("BETA COUNTDOWN HERE","http://adf.ly/1apTNY");
  
  //Name: default, ussr, wave, sunset painting, earth
  back1 = requestImage("https://sites.google.com/site/bowserinator/files/log-tree-fir-forest-lake-mountain-snow-sky-cloud.jpg"); 
  back2 = requestImage("https://sites.google.com/site/bowserinator/files/ussr.png");
  back3 = requestImage("https://sites.google.com/site/bowserinator/files/wave.jpg");
  back4 = requestImage("https://sites.google.com/site/bowserinator/files/sun.jpg");
  back5 = requestImage("https://sites.google.com/site/bowserinator/files/earth.jpg");
  back6 = requestImage("https://sites.google.com/site/bowserinator/files/405px-Meandros_flag.svg.png");
  back7 = requestImage("https://sites.google.com/site/bowserinator/files/drawing.png");
  backgrounds = {{back1},{back2},{back3},{back4},{back5},{back6},{back7}};
  back_names = {"Default","Communism","Waves","Sunset painting","Earth","Neo Fascism","Cube Thing"};
  
  hoursEnd = new Timer(color(100,255,0),60,"Hours");
  minutesEnd = new Timer(color(255,100,0),60,"Minutes"); //color(255,100,0)
  secondsEnd = new Timer(color(0,100,255),1000,"Seconds");
  millisEnd = new Timer(color(255,255,0),180,"Days Left");
  //15,38,62,85
  school = new SchoolEnd();
  classr = new classroom();
  frameRate(100);
}

void draw(){
  size(window.innerWidth, window.innerHeight);
  sizeX = window.innerWidth;
  sizeY = window.innerHeight;
  
  background(50); //30
  image(backgrounds[backgroundState][  frameCount % backgrounds[backgroundState].length ],0,0,window.innerWidth*0.95,window.innerHeight);
  noStroke(); fill(0,0,0,200);
  rect(0,0,window.innerWidth,window.innerHeight);
  
  //Temp for now
  if(state == 0){    //ScHOOL COUNTDOWN DEFAULT
    Date now = new Date();
    textAlign(CENTER,TOP); 
    textSize(sizeX/20); fill(200);
    text("School Countdown Timer",sizeX/2,0);
    textSize(sizeX/70); 
    text("\""+rand_quote+"\"",sizeX/2,sizeX/20);
    textSize(sizeX/100); fill(150);
    text(rand_cite,sizeX/2,sizeX/20+sizeX/70);
    
    pushMatrix(); translate(0,-0.15*sizeY);
    
    textSize(sizeX/50); fill(200); textAlign(LEFT,TOP);
    text("Current date: " + months[month()-1] + " " + day() + " " + year(), sizeX * 0.05, sizeY*0.77); 
    text("Real time: "+realTime() ,sizeX*0.05,sizeY*0.81);
    text("School Time: " + school.schoolTime(),sizeX*0.05,sizeY*0.85);
    text("Today is a(n) " + classr.getDay() + " day.",sizeX*0.05,sizeY*0.89);
    text("Schedule: "+classr.getSchedule(),sizeX*0.05,sizeY*0.93);
    
    fill(150);
    text("TRY BETA COUNTDOWN V4 (SLIDER) >>>>",sizeX*0.05,sizeY*1.05);
    textAlign(CENTER,TOP); 

    //text("Today's block schedule is [NOT HERE]",sizeX/2,sizeY*0.94);
    textSize(sizeX/10); fill(255);
    text(classr.timeTillClass(school), sizeX*0.57,sizeY*0.73);
    textSize(sizeX/40);
    text("Time till class ends or starts.", sizeX*0.57,sizeY*0.73 + sizeX/10);
    
    //textSize(sizeX/30); fill(255);
    //text("Time till class starts/ends: " + classr.timeTillClass(school) ,sizeX/2,sizeY*0.9);
    
    result = school.getTimeRemaining();
    h = floor(result/3600); m = floor((result - h*3600)/60); s = result - m*60 - h*3600;
    hoursEnd.draw(m,h,sizeX*0.18,sizeX*0.38,sizeY*0.5);
    minutesEnd.draw(s,m,sizeX*0.18,sizeX*0.62,sizeY*0.5);
    secondsEnd.draw(1000-now.getMilliseconds(),s,sizeX*0.18,sizeX*0.85,sizeY*0.5);
  
    //if (result > 0){  millisEnd.draw( 1000-((1000-now.getMilliseconds())*10)%1000 , 1000-now.getMilliseconds()  ); }
    //else{  millisEnd.draw(0 ,0); }
    millisEnd.draw(classr.daysLeft(),classr.daysLeft(),sizeX*0.18,sizeX*0.15,sizeY*0.5);
    
    //DRAW PERCENT BAR
    fill(20);
    rect(sizeX*0.05,sizeY*0.715,sizeX*0.9,sizeY*0.01);
    if (!(m == 0 && s == 0 && h==0)){ 
      fill(255,50,0); textSize(sizeY*0.04);
      rect(sizeX*0.05,sizeY*0.715,sizeX*0.9 * (school.getPercentDone()),sizeY*0.01);
      text(int(school.getPercentDone()*100)+"%",sizeX*0.5,sizeY*0.69);
    }else{
      fill(255,50,0); textSize(sizeY*0.04);
      rect(sizeX*0.05,sizeY*0.715,sizeX*0.9 ,sizeY*0.01);
      text(int(100)+"%",sizeX*0.5,sizeY*0.69);
    }
    popMatrix();
  }
  
  //Draw button on the side
  fill(255,43,43,200);
  rect(sizeX*0.95,0,sizeX*0.05,sizeY);
  fill(255); textAlign(CENTER,CENTER); textSize(sizeX/40);
  if(!openSlide){ text("<",sizeX*0.965,sizeY*0.5); }
  else if(openSlide){ text(">",sizeX*0.965,sizeY*0.5); }
  
  back_open.draw(sizeX*0.7,sizeY*0.9,sizeX*0.2,sizeX*0.03,color(0));
  
  if(openBackgroundSlide){
    fill(0,0,0,200); rect(0,0,sizeX,sizeY);
    rectMode(CENTER); 
    fill(255); rect(sizeX*0.5,sizeY*0.5,sizeX*0.35,sizeX*0.35);
    rectMode(LEFT);
    image(backgrounds[backgroundSelect][0], sizeX*0.345,sizeY*0.5-sizeX*0.155,sizeX*0.31,sizeX*0.31*0.625);
    
    back_left.draw(sizeX*0.1,sizeY*0.5 - sizeX*0.35/2,sizeX*0.1,sizeX*0.1,color(0)); fill(255);
    back_right.draw(sizeX*0.8,sizeY*0.5 - sizeX*0.35/2,sizeX*0.1,sizeX*0.1,color(0)); fill(255);
    back_cancel.draw(sizeX*0.1,sizeY*0.5 + sizeX*0.35/2 - sizeX*0.1,sizeX*0.1,sizeX*0.1,color(255,0,0)); fill(255);
    back_ok.draw(sizeX*0.8,sizeY*0.5 + sizeX*0.35/2 - sizeX*0.1,sizeX*0.1,sizeX*0.1,color(0,255,0)); 
    fill(0); textSize(sizeX/40);
    
    text(back_names[backgroundSelect], sizeX*0.5,sizeY*0.5 + sizeX*0.31*0.625*0.3); fill(100);
    text("Crappy background selector", sizeX*0.5,sizeY*0.5 + sizeX*0.31*0.625*0.3 + sizeX*0.02);
    text("Arrows = change background", sizeX*0.5,sizeY*0.5 + sizeX*0.31*0.625*0.3 + sizeX*0.04);
    text("X = cancel check = OK", sizeX*0.5,sizeY*0.5 + sizeX*0.31*0.625*0.3 + sizeX*0.06);
  }
  
  if(openSlide){
    fill(0,0,0,240);
    rect(0,0,sizeX*0.95,sizeY); 
    textAlign(LEFT,TOP); fill(255); textSize(sizeX/40);
    
    text("Time left (Labs): ",sizeX*0.01,sizeX*0.01);
    fill(200); text(classr.timeLeftLab(school),sizeX*0.01 + textWidth("Time left (Labs): "),sizeX*0.01);
    
    fill(255); text("Time till summer ends: " ,sizeX*0.01,sizeX*0.03);
    fill(200); text(classr.daysSummer() + " days", sizeX*0.01 + textWidth("Time till summer ends: "),sizeX*0.03);
    
    fill(150); text("Timer made by Bowserinator" ,sizeX*0.01,sizeX*0.05);
    //text("[SCHEDULE]: " ,sizeX*0.01,sizeX*0.07);
    fill(255);text("Today's Schedule",sizeX*0.01,sizeX*0.09);
    
    fill(200);
    String[] schedule = classr.getTimeBlocks();
    String final_s = "";
    for(String x:schedule){
      final_s += x;
      final_s += "\n";
    }
    text(final_s ,sizeX*0.01,sizeX*0.12);
    
    fill(255);
    shortened_button.draw(sizeX*0.55,sizeX*0.01,sizeX/40);
    facebook_button.draw(sizeX*0.55,sizeX*0.03,sizeX/40);
    chrome_button.draw(sizeX*0.55,sizeX*0.05,sizeX/40);
    survey_button.draw(sizeX*0.55,sizeX*0.07,sizeX/40);
    app_button.draw(sizeX*0.55,sizeX*0.09,sizeX/40);
    ios_button.draw(sizeX*0.55,sizeX*0.11,sizeX/40);
    beta_button.draw(sizeX*0.55,sizeX*0.13,sizeX/40);
    
    text("Click adfly link to help earn $$",sizeX*0.55,sizeX*0.17);
    
    //Schedule goes like
    //Time block 1 | 7:45-8:45 | 60 minutes
  }
  
}



void mousePressed(){
  if(mouseX>= sizeX*0.95){
    openSlide = !openSlide;
  }

  if(back_open.isClick(sizeX*0.7,sizeY*0.9,sizeX*0.2,sizeX*0.03)){
    openBackgroundSlide = !openBackgroundSlide;
  }
  if(openBackgroundSlide){
    if(back_left.isClick(sizeX*0.1,sizeY*0.5 - sizeX*0.35/2,sizeX*0.1,sizeX*0.1)){ 
      backgroundSelect -= 1;
      if(backgroundSelect != 0){ backgroundSelect %= backgrounds.length; }
      if(backgroundSelect < 0){ backgroundSelect = backgrounds.length - 1; }
    }
    else if(back_right.isClick(sizeX*0.8,sizeY*0.5 - sizeX*0.35/2,sizeX*0.1,sizeX*0.1)){ 
      backgroundSelect += 1;
      backgroundSelect %= backgrounds.length;
      backgroundSelect = abs(backgroundSelect);
    }
    else if(back_cancel.isClick(sizeX*0.1,sizeY*0.5 + sizeX*0.35/2 - sizeX*0.1,sizeX*0.1,sizeX*0.1)){
      backgroundSelect = backgroundState;
      openBackgroundSlide = false;
    }
    else if(back_ok.isClick(sizeX*0.8,sizeY*0.5 + sizeX*0.35/2 - sizeX*0.1,sizeX*0.1,sizeX*0.1)){
      backgroundState = backgroundSelect;
      openBackgroundSlide = false;
    }
  }
  
  if(openSlide){
    facebook_button.isClick(sizeX*0.55,sizeX*0.03,sizeX/40);
    shortened_button.isClick(sizeX*0.55,sizeX*0.01,sizeX/40);
    chrome_button.isClick(sizeX*0.55,sizeX*0.05,sizeX/40);
    survey_button.isClick(sizeX*0.55,sizeX*0.07,sizeX/40);
    app_button.isClick(sizeX*0.55,sizeX*0.09,sizeX/40);
    ios_button.isClick(sizeX*0.55,sizeX*0.11,sizeX/40);
    beta_button.isClick(sizeX*0.55,sizeX*0.13,sizeX/40);
  }
}

class Timer{
  float total;
  color c; String label;
  Timer(color c1, float total1,String label1){
    total = total1; c = c1;  label = label1;
  }
  
  void drawRing(float x, float y, float w1, float w2, int segments){
    float deltaA=(1.0/(float)segments)*TWO_PI;
    beginShape(QUADS);
    for(int i=0;i<segments;i++)
    {
      vertex(x+w1*cos(i*deltaA),y+w1*sin(i*deltaA));
      vertex(x+w2*cos(i*deltaA),y+w2*sin(i*deltaA));
      vertex(x+w2*cos((i+1)*deltaA),y+w2*sin((i+1)*deltaA));
      vertex(x+w1*cos((i+1)*deltaA),y+w1*sin((i+1)*deltaA));
    }
    endShape();
  } 
  
  void drawRingFract(float x, float y, float w1, float w2, int segments, float percent){
    float deltaA=(1.0/(float)segments)*TWO_PI*percent;
    beginShape(QUADS);
    for(int i=0;i<segments;i++)
    {
      vertex(x+w1*cos(i*deltaA),y+w1*sin(i*deltaA));
      vertex(x+w2*cos(i*deltaA),y+w2*sin(i*deltaA));
      vertex(x+w2*cos((i+1)*deltaA),y+w2*sin((i+1)*deltaA));
      vertex(x+w1*cos((i+1)*deltaA),y+w1*sin((i+1)*deltaA));
    }
    endShape();
  } 
  
  void draw(float time,float displayTime,float r,float x,float y){
    noStroke(); fill(50);
    drawRing(x,y,r/2.0,r*0.95/2,50);             //ellipse(x,y,r,r);
    fill(25);
    drawRing(x,y,r*0.95/2,r*0.43,50);                    //ellipse(x,y,r*0.95,r*0.95);
    
    if (displayTime > 0){
      fill(c); drawRingFract(x,y,r*0.45,r*0.43,100,(time/total));
      /*beginShape(); fill(c); 
      for(float i=0;i<TWO_PI*(time/total);i+=0.01){
        vertex(x + cos(i)*r*0.95/2, y + sin(i)*r*0.95/2);
      }vertex(x,y);
      endShape();*/
    }
    fill(30);
    drawRing(x,y,r*0.43,r*0.41,50);            //ellipse(x,y,r*0.9,r*0.9);
    fill(255); textAlign(CENTER,CENTER);
    String t; textSize(r*2/5);
    if(displayTime < 10){t = "0"+int(displayTime);}
    else{t= ""+int(displayTime);}
    text(t,x,y); textSize(r*2/16);
    fill(c);
    text(label,x,y + r*0.25);
  }
}

class SchoolEnd{
  Day[] noschool = {new Day(9,7,5), new Day(9,14,5), new Day(9,23,5), new Day(10,12,5), new Day(11,5,5), new Day(11,6,5), new Day(11,26,5), new Day(11,27,5), new Day(12, 24,5),new Day(12, 25,5),new Day(12, 26,5),new Day(12, 27,5),new Day(12, 28,5),new Day(12, 29,5),new Day(12, 30,5),new Day(12, 31,5), new Day(1, 1,5),new Day(1, 2,5),new Day(1, 3,5),new Day(1, 4,5), new Day(1,18,5), new Day(2,15,5), new Day(2,16,5), new Day(4,11,5),new Day(4,12,5),new Day(4,13,5),new Day(4,14,5),new Day(4,15,5),new Day(5,30,5)};
  Day[] singleday = {new Day(11,25,5), new Day(12,23,5),new Day(1,29,5), new Day(2,24,5)};
  Day[] midterm = {new Day(2,1), new Day(2,2), new Day(2,3), new Day(2,4)};
  const TIMESHIFT = 191; //used to be 179
  
  SchoolEnd(){
    
  }
  
  int getTime(){
    return hour()*3600 + minute()*60 + second();
  }
  
  float getPercentDone(){
    int returned;
    for(Day i:noschool){ if(i.month == month() && i.day == day()){ return 1;} }
    
    if(14*3600 + 49*60 + TIMESHIFT >= 7*3600 + 45*60 + TIMESHIFT && 14*3600 + 49*60 + TIMESHIFT <= 14*3600 + 49*60 + TIMESHIFT){
      //Single days
      for(Day i:singleday){ 
        if(i.month == month() && i.day == day()){ 
           returned = 12*3600 + 6*60 + TIMESHIFT - second() - minute()*60 -hour()*3600;
           if(returned <= 0){return 1;}
            return 1.0 - returned/(12*3600 + 6*60 - 7*3600 - 45*60);
        }
      }
      //Midterm days
      for(Day i:midterm){ 
        if(i.month == month() && i.day == day()){ 
           returned = 12*3600 + 30*60 + TIMESHIFT - second() - minute()*60 -hour()*3600;
           if(returned <= 0){return 1;}
           return 1.0 - returned/(12*3600 + 30*60 - 7*3600 - 45*60);
        }
      }
      returned = 14*3600 + 49*60 + TIMESHIFT - second() - minute()*60 -hour()*3600;
      if(returned <= 0){return 1;}
      return 1.0 - returned/(14*3600 + 49*60 - 7*3600 - 45*60);
    }
    return 0;
  }
  
  String schoolTime(){
      int dif = getTime()-TIMESHIFT;
      int hour = dif / 3600; int minute = (dif - floor(hour)*3600)/60; int second = (dif - floor(hour)*3600 - floor(minute)*60);
      String h,m,s;
      hour = floor(hour); minute = floor(minute); second = floor(second);
      
      if (hour < 10){ h = "0"+hour;}
      else{h = ""+hour;}
      
      if (minute < 10){ m = "0"+minute;}
      else{m = ""+minute;}
      
      if (second < 10){ s = "0"+second;}
      else{s = ""+second;}
      return  h + ":" + m + ":" + s;
      
  }
  
  int getTimeRemaining(){ //Returns remaining time seconds
    //if day is saturday or sunday, return 0
    //if day is summer ,spring rbeak or winter break return 0
    //if day in no school return 0
    int returned;
    for(Day i:noschool){ if(i.month == month() && i.day == day()){ return 0;} }
    
    if(14*3600 + 49*60 + TIMESHIFT >= 7*3600 + 45*60 + TIMESHIFT && 14*3600 + 49*60 + TIMESHIFT <= 14*3600 + 49*60 + TIMESHIFT){
      //Single days
      for(Day i:singleday){ 
        if(i.month == month() && i.day == day()){ 
           returned = 12*3600 + 6*60 + TIMESHIFT - second() - minute()*60 -hour()*3600;
           if(returned <= 0){return 0;}
           return returned;
        }
      }
      //Midterm days
      for(Day i:midterm){ 
        if(i.month == month() && i.day == day()){ 
           returned = 12*3600 + 30*60 + TIMESHIFT - second() - minute()*60 -hour()*3600;
           if(returned <= 0){return 0;}
           return returned;
        }
      }
      returned = 14*3600 + 49*60 + TIMESHIFT - second() - minute()*60 -hour()*3600;
      if(returned <= 0){return 0;}
      return returned;
    }
    return 0;
 }

}

class Day{ //Type: 1 = A, 2 = B, ... 6 = half 7 = no school
  int month, day, type; 
  Day(int m,int d, int l){
    month  = m; day = d; type = l;
  }
}
String realTime(){
  String returned;
  String h,m,s;
  
  h = hour(); m = minute(); s = second();
  if(hour()<10){h = "0" + hour();}
  if(minute()<10){m = "0" + minute();}
  if(second()<10){s = "0" + second();}
  returned = h + ":"+ m + ":" + s;
  return returned;
}

class classroom{
    String[] days = {"1,2,3|6,7,8","2,3,4|7,8,5","3,4,1|8,5,6","4,1,2|5,6,7","1,2,3,4|5,6,7,8","1,2,3,4|5,6,7,8","EXAM,EXAM"}; 
    //0 = A day, 1 = B day etc..5 = half day, 6 =midterm, 7 = PARCC?
    String[] parcc_days = {"PARCC,1|2,5,6","PARCC,3|4,7,8","PARCC,2|1,5,6","PARCC,4|3,7,8",
    "PARCC,1|2,5,6","PARCC,3|4,7,8","PARCC,1,2,3,4,5,6,7,8"}; //Parcc day schedule :(
    String[] day_name = {"A","B","C","D","E","half","midterm","modified"};
    
    //Day types: 0 = A, 5 = half day, 6= midterm, 7 = MODIFIED SCHEDULE
    Day[] parcc = {new Day(4,19,7), new Day(4,20,7), new Day(4,21,7), new Day(4,22,7), new Day(4,27,7), new Day(4,28,7), new Day(4,29,7)};
    Day[] exceptions = {new Day(9,8,4), new Day(9,10,4), new Day(9,11,4), new Day(9,18,0), new Day(9,25,0), new Day(10,14,7), new Day(10,15,7),
    new Day(10,16,0), new Day(11,2,4), new Day(11,3,4), new Day(11,4,4), new Day(12,21,4), new Day(12,22,4),
    new Day(1,22,0), new Day(2,17,4),new Day(2,18,4),new Day(2,19,4), 
    new Day(4,19,7), new Day(4,20,7), new Day(4,21,7), new Day(4,22,7), new Day(4,25,4), new Day(4,26,4),
    new Day(4,27,7), new Day(4,28,7), new Day(4,29,7),
    new Day(6,3,0), new Day(6,13,4), new Day(6,14,4), new Day(6,15,4), new Day(6,16,4), new Day(6,17,4), 
    //Single session new Days
    new Day(11,25,5), new Day(12,23,5), new Day(1,29,5), new Day(2,24,5),
    //Midterms
    new Day(2,1,6), new Day(2,2,6), new Day(2,3,6), new Day(2,4,6),
    };
    
    Day[] noschool = {new Day(9,7,5), new Day(9,14,5), new Day(9,23,5), new Day(10,12,5), new Day(11,5,5), new Day(11,6,5), new Day(11,26,5), new Day(11,27,5), new Day(12, 24,5),new Day(12, 25,5),new Day(12, 26,5),new Day(12, 27,5),new Day(12, 28,5),new Day(12, 29,5),new Day(12, 30,5),new Day(12, 31,5), new Day(1, 1,5),new Day(1, 2,5),new Day(1, 3,5),new Day(1, 4,5), new Day(1,18,5), new Day(2,15,5), new Day(2,16,5), new Day(4,11,5),new Day(4,12,5),new Day(4,13,5),new Day(4,14,5),new Day(4,15,5),new Day(5,30,5)};
    
    //Yay finally school times
    //Yay finally school times
    ClassTime[][] classes = { 
        {new ClassTime(27900, 31380), new ClassTime(31620,35100), new ClassTime(35340,38820), new ClassTime(38820,42420), new ClassTime(42420,45900), new ClassTime(46140,49620), new ClassTime(49860,53340) }, 
        {new ClassTime(27900, 31380), new ClassTime(31620,35100), new ClassTime(35340,38820), new ClassTime(38820,42420), new ClassTime(42420,45900), new ClassTime(46140,49620), new ClassTime(49860,53340) }, 
        {new ClassTime(27900, 31380), new ClassTime(31620,35100), new ClassTime(35340,38820), new ClassTime(38820,42420), new ClassTime(42420,45900), new ClassTime(46140,49620), new ClassTime(49860,53340) }, 
        {new ClassTime(27900, 31380), new ClassTime(31620,35100), new ClassTime(35340,38820), new ClassTime(38820,42420), new ClassTime(42420,45900), new ClassTime(46140,49620), new ClassTime(49860,53340) }, 
        {new ClassTime(27900, 30480), new ClassTime(30720,33300), 