import net.java.games.input.*;
import org.gamecontrolplus.*;
import org.gamecontrolplus.gui.*;

import processing.video.*;
import processing.serial.*;

// Flags de debug
boolean debug = true;
boolean calibra = true;
boolean visao = false;
boolean dimensionaCampo = true;
boolean campoDimensionado = false;
boolean buscandoCor = true;
boolean algumPonto = false;
boolean radio = true;
// Verifica se ainda estamos configurando o robo
boolean configRobo = false;
// Verifica se é a primeira vez que chamamos millis() no alinhandando
boolean primeiraVezAlinhandando = true;

boolean andaReto = false;

Serial myPort = new Serial(this, Serial.list()[0], 115200);
//Serial myPort;

color trackColor;
color mouseColor; 
// current color sendo calibrada
int calColor = -1;
// Numero de pixels do maior blob da cor vermelha
int numMaior = 0;
// Numero de pixels do menor blob da cor verde
int numMenor = 0;
// Conta o tempo de execucao
double tempo = millis();
double antes = millis();
// Quantidade de quadros para vencer a inercia no controle alinhandando
int contagemAlinhandando = 0;

ArrayList<Robo> robos = new ArrayList<Robo>();

// Parametros do controle

ControlIO controle;
ControlDevice stick;
float px;
boolean accel;
boolean turbo;

void setup() {
  printArray(Serial.list());
  size(960, 540);  
  frame.removeNotify();
  frameRate(30);
  
  // Initialise the ControlIO
  controle = ControlIO.getInstance(this);
  // Find a device that matches the configuration file
  stick = controle.getMatchedDevice("Controle");
  if (stick == null) {
    println("No suitable device configured");
    System.exit(-1); // End the program NOW!
  }
  
}

//void movieEvent(Movie m) {
//  m.read();
//}
void captureEvent(Capture c) {
  c.read();
}

void getEntradaControle(){
  px = map(stick.getSlider("XANALOG").getValue(), -1, 1, -1, 1);
  accel = stick.getButton("ACCEL").pressed();
  turbo = stick.getButton("TURBO").pressed();
}

float velE, velD;

void draw() {
  //showBola();
  //velBola();
  getEntradaControle();
  if(accel){
    //50
    //robos.get(0).velE = 50;
    //robos.get(0).velD = 50;
    velE = 10;
    velD = 10;
    
    //63
    if(turbo){
      //robos.get(0).velE = 63;
      //robos.get(0).velD = 63;
      velE = 63;
      velD = 63;
    }
  }
  else{
    velE = 0;
    velD = 0;
  }
  
  if(px < 0){
    //robos.get(0).velE = robos.get(0).velE * (1 + px);
    velE = velE * (1 + 2*px);
  }
  else if(px > 0){
    //robos.get(0).velD = robos.get(0).velD * (1 - px);
    velD = velD * (1 - 2*px);
  }
  
  // Inicializa os robos
  if(robos.size() == 0) {
    //robos.clear();
    for(int i=0; i<2; i++) {
      robos.add(new Robo(i));
    }
  }
  
  // Envia os comandos
  //enviar();
  println("px = " + px);
  //println("velE = " + robos.get(0).velE);
  //println("velD = " + robos.get(0).velD);
  println("velE = " + velE);
  println("velD = " + velD);
  
}
