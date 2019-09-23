// Classe que gerencia os robos

class Robo {
  float velD, velE, dAntiga, eAntiga;
  // Velocidades limite do robo (0 - 64)
  int velMax = 63;
  int velMin = -63;
  int velEmin = 30;
  int velDmin = 50;
  int v = 0;
  int index;
  
  Robo(int n) {
    index = n;
  }
  
  
  Robo(Robo r) {
    index = r.index;
  }
  void setVel(float vE, float vD) {
    // Verifica se as velocidades estão dentro dos limites estabelecidos
    // Os ajustes para velocidade negativa é feito direto na serial
    if(vE > velMax) vE = velMax;
    else if(vE < -velMax) vE = -velMax;
    if(vD > velMax) vD = velMax;
    else if(vD < -velMax) vD = -velMax;
    velE = vE;
    velD = vD;
  }
  // Funcoes de debug

  void show() {
    
  }
}
