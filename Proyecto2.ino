int Latch = 26;
int Clock = 24;
int Data = 22;
int Nv1 = 45;
int Nv2 = 43;
int Nv3 = 41;
int Nv4 = 39;
int Nv5 = 37;
int Nv6 = 35;
int Nv7 = 33;
int Nv8 = 31;
//[+(((1)x^(2))/1)+(((1)y^(2))/1)+(((1)z^(2))/1)=1600{5{5{5{5{5{5]
//[+(((1)x^(2))/1)+(((1)y^(2))/1)+(((1)z^(2))/1)=1600]
char operacion[100] = "";
short longitudOp = 0; //50
char numeros[11] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 0};
//signo, coeficiente , exponente ,divisor
int signo[4] = {0, 0, 0, 0};
int coefi[4] = {0, 0, 0, 0};
int expon[4] = {0, 0, 0, 0};
int divis[4] = {0, 0, 0, 0};
short constante = 0;
int limsupz = 50;
int liminfz = -40;
int limsupy = 40;
int liminfy = -40;
int limsupx = 40;
int liminfx = -40;
short vari = -1;
short tipo = 0;
bool finacons = false;
String numtemp = "";
//         x  y  z
short cubo[8][8][8];
short xy[319];
short xz[319];
short yz[319];
//.
// .
//  .
//   .
//     ...>319
// x 319  ; y 200

void setup() {
  pinMode(Latch, OUTPUT);
  pinMode(Clock, OUTPUT);
  pinMode(Data, OUTPUT);
  pinMode(Nv1, OUTPUT);
  pinMode(Nv2, OUTPUT);
  pinMode(Nv3, OUTPUT);
  pinMode(Nv4, OUTPUT);
  pinMode(Nv5, OUTPUT);
  pinMode(Nv6, OUTPUT);
  pinMode(Nv7, OUTPUT);
  pinMode(Nv8, OUTPUT);
  Serial.begin(9600);
  operacion[99] = 0;
  xy[0] = 50;
  xy[318] = 60;
  xz[0] = 51;
  xz[318] = 61;
  yz[0] = 52;
  yz[318] = 62;
  //  ExtraeValores();
  //  puntos3d();
  //  graph2D();
  //ImprimeCubo();
  Serial.println("INICIA");
  Comunicacion();
  //Serial.write(200);
  //enviaPuntos();
}

void loop() {
  GraficarCubo(5000,1);
  delayMicroseconds(5000);
}

void LimpiarCubo() {
  for (int j = 0; j < 65; j++) {
    digitalWrite(Latch, LOW);
    shiftOut(Data, Clock, MSBFIRST, 0);
    digitalWrite(Latch, HIGH);
  }
}

void Pintar(char matrix[8][8]) {
  for (int j = 0; j < 8; j++) {
    for (int i = 0; i < 8; i++) {
      digitalWrite(Latch, HIGH);
      shiftOut(Data, Clock, MSBFIRST, matrix[j][i]);
      digitalWrite(Latch, LOW);
    }
  }
}

void getCapa(char capa[8][8], int indice) {
  for (int j = 0; j < 8; j++) {
    for (int i = 0; i < 8; i++) {
      if (cubo[i][j][indice] == 1) {
        capa[i][j] = '1';
      } else if (cubo[i][j][indice] == 0) {
        capa[i][j] = '0';
      }
    }
  }
}

void GraficarCubo(int dl, int ciclo) {
  char capa1[8][8];
  char capa2[8][8];
  char capa3[8][8];
  char capa4[8][8];
  getCapa(capa1, 0);
  getCapa(capa2, 1);
  getCapa(capa3, 2);
  getCapa(capa4, 3);
  for (int i = 0; i < ciclo; i++) {
    LimpiarCubo();
    Pintar(capa1);
    digitalWrite(Nv1, 1);
    delayMicroseconds(dl);
    digitalWrite(Nv1, 0);
    LimpiarCubo();
    Pintar(capa2);
    digitalWrite(Nv2, 1);
    delayMicroseconds(dl);
    digitalWrite(Nv2, 0);
    delayMicroseconds(dl);
    LimpiarCubo();
    Pintar(capa3);
    digitalWrite(Nv3, 1);
    delayMicroseconds(dl);
    digitalWrite(Nv3, 0);
    LimpiarCubo();
    Pintar(capa4);
    digitalWrite(Nv4, 1);
    delayMicroseconds(dl);
    digitalWrite(Nv4, 0);
  }
  getCapa(capa1, 4);
  getCapa(capa2, 5);
  getCapa(capa3, 6);
  getCapa(capa4, 7);
  for (int j = 0; j < ciclo; j++) {
    LimpiarCubo();
    Pintar(capa1);
    digitalWrite(Nv5, 1);
    delayMicroseconds(dl);
    digitalWrite(Nv5, 0);
    LimpiarCubo();
    Pintar(capa2);
    digitalWrite(Nv6, 1);
    delayMicroseconds(dl);
    digitalWrite(Nv6, 0);
    delayMicroseconds(dl);
    LimpiarCubo();
    Pintar(capa3);
    digitalWrite(Nv7, 1);
    delayMicroseconds(dl);
    digitalWrite(Nv7, 0);
    LimpiarCubo();
    Pintar(capa4);
    digitalWrite(Nv8, 1);
    delayMicroseconds(dl);
    digitalWrite(Nv8, 0);
  }
}

void ExtraeValores() {
  numtemp = "";
  vari = -1;
  tipo = 0;
  finacons = false;
  constante = 0;
  for (int i = 0; i < longitudOp; i++) {
    //Serial.println("itera 1");
    for (int j = 0; j < 10; j++) {
      short char1 = operacion[i] * 1;
      short char2 = numeros[j] * 1;
      short parente = ')' * 1;
      short men = '-' * 1;
      short mas = '+' * 1;
      short igu = '=' * 1;
      if (char1 == char2) {
        //        Serial.println("char igual numero");
        numtemp = numtemp + numeros[j];
        if (finacons && (numtemp.length() != 0) && (i == (longitudOp - 1))) {
          constante = numtemp.toInt();
          numtemp = "";
        }
        break;
      } else if (char1 == parente) {
        //Serial.println("parentesis");
        if (numtemp.length() != 0) {
          int convierte = numtemp.toInt();
          if (tipo == 0) {
            coefi[vari] = convierte;
          } else if (tipo == 1) {
            expon[vari] = convierte;
          } else if (tipo == 2) {
            divis[vari] = convierte;
          }
          tipo++;
          numtemp = "";
        }
        break;
      } else if ((char1 == men) || (char1 == mas)) {
        //    Serial.println("es un signo");
        if (char1 == men) {
          signo[vari + 1] = 1;
        } else {
          signo[vari + 1] = 0;
        }
        vari++;
        tipo = 0;
        break;
      } else if ((char1 == igu)) {
        //   Serial.println("signo igual");
        finacons = true;
        break;
      }
    }
  }
}

void puntos3d() {
  bool buenot = false;
  double saltox = 0;
  double saltoy = 0;
  double saltoz = 0;
  if (limsupz > liminfz) {
    if (limsupy > liminfy) {
      if (limsupx > liminfx) {
        buenot = true;
        saltoz = saltovalor(limsupz, liminfz, 8);
        saltox = saltovalor(limsupx, liminfx, 8);
      }
    }
  }
  //siempre lim sup mayor al menor
  double supz = limsupz;
  double infz = liminfz;
  double supx = limsupx;
  double infx = liminfx;
  if (buenot) {
    for (int i = 0; i < 8; i++) {
      //evualua z
      infx = liminfx;
      for (int j = 0; j < 8; j++) {
        //evualua x
        double valoryR = 0;
        double valory = Pvaluado(infx, infz);
        int residuo = expon[1] % 2;
        //Serial.print("saca:"); Serial.println(valory);
        if (valory >= 0 || (valory < 0)) {
          parametrizaY(valory, i, j);
          if (residuo == 0) { //exponente par
            valoryR = -1 * valory;
            parametrizaY(valoryR, i, j);
          }
          //if(valoryR!=0){
          //}
        }
        infx = infx + saltox;
      }
      infz = infz + saltoz;
    }
  }
}

//       liminfy        limsupy
//limsupz
//        z
//        ^
//        |
//        |
//liminfz |_ _ _ _ _ _>  y
//       /
//      /  liminfx
//     /
//    /
//   v
//  x   limsupx

void parametrizaY(double valory, int z, int x) {
  double saltoy = saltovalor(limsupy, liminfy, 8);
  double infy = (double)liminfy;
  //Serial.println(valory);
  if ((valory >= infy) && (valory < (infy + saltoy))) {
    cubo[x][0][z] = 1;
  } else if ((valory >= (infy + saltoy)) && (valory < (infy + saltoy * 2))) {
    cubo[x][1][z] = 1;
  } else if ((valory >= (infy + saltoy * 2)) && (valory < (infy + saltoy * 3))) {
    cubo[x][2][z] = 1;
  } else if ((valory >= (infy + saltoy * 3)) && (valory < (infy + saltoy * 4))) {
    cubo[x][3][z] = 1;
  } else if ((valory >= (infy + saltoy * 4)) && (valory < (infy + saltoy * 5))) {
    cubo[x][4][z] = 1;
  } else if ((valory >= (infy + saltoy * 5)) && (valory < (infy + saltoy * 6))) {
    cubo[x][5][z] = 1;
  } else if ((valory >= (infy + saltoy * 6)) && (valory < (infy + saltoy * 7))) {
    cubo[x][6][z] = 1;
  } else if ((valory >= (infy + saltoy * 7)) && (valory <= (infy + saltoy * 8))) {
    cubo[x][7][z] = 1;
  }
}

void ImprimeCubo() {
  for (int i = 0; i < 8; i++) {
    //valua z
    for (int j = 0; j < 8; j++) {
      //valua y
      for (int k = 0; k < 8; k++) {
        //valua x
        Serial.print(cubo[k][j][i]);
      }
      Serial.println("");
    }
    Serial.println("");
    Serial.println("");
  }
  for (int i = 0; i < 319; i++) {
    Serial.print(xy[i]);
    Serial.print(",");
  }
  Serial.println("");
  for (int i = 0; i < 319; i++) {
    Serial.print(xz[i]);
    Serial.print(",");
  }
  Serial.println("");
  for (int i = 0; i < 319; i++) {
    Serial.print(yz[i]);
    Serial.print(",");
  }
  Serial.println("");
  for (int i = 0; i < longitudOp; i++) {
    Serial.print(operacion[i]);
  }
  Serial.println("");
  Serial.println("----------");
  Serial.println(signo[0]);
  Serial.println(signo[1]);
  Serial.println(signo[2]);
  Serial.println(coefi[0]);
  Serial.println(coefi[1]);
  Serial.println(coefi[2]);
  Serial.println(expon[0]);
  Serial.println(expon[1]);
  Serial.println(expon[2]);
  Serial.println(divis[0]);
  Serial.println(divis[1]);
  Serial.println(divis[2]);
  Serial.println(constante);
  Serial.println(longitudOp);
  Serial.println("---------");
  Serial.println(limsupz);
  Serial.println(liminfz);
  Serial.println(limsupy);
  Serial.println(liminfy);
  Serial.println(limsupx);
  Serial.println(liminfx);
}

double saltovalor(double sup, double inf, double veces) {
  double rango = 0;
  if (sup >= 0 && inf >= 0) {
    rango = (sup + inf) / veces;
  } else if (sup >= 0 && inf <= 0) {
    rango = (sup + (-1 * inf)) / veces;
  } else if (sup <= 0 && inf <= 0) {
    rango = ((-1 * sup) + (-1 * inf)) / veces;
  }
  return rango;
}

double Pvaluado(int x , int z) {
  int Sigx = 0;
  Sigx = signoda(signo[0]);
  int xvaluado = (coefi[0] * Sigx * (pow(x, expon[0]))) / divis[0];
  Sigx = signoda(signo[2]);
  // Serial.println(xvaluado);
  int zvaluado = (coefi[2] * Sigx * (pow(z, expon[2]))) / divis[2];
  //Serial.println(zvaluado);
  Sigx = signoda(signo[1]);
  int paren1 = ((constante + (-1 * (xvaluado)) + (-1 * (zvaluado))) * divis[1]) / (coefi[1] * Sigx);
  //Serial.println(paren1);
  double eex = (double)expon[1];
  //Serial.println(eex);
  double expox = 1 / eex;
  //double finalopera=
  //Serial.println(finalopera);
  return pow(paren1, expox);
}

int signoda(int eval) {
  if (eval == 1) {
    return -1;
  } else {
    return 1;
  }
}

void graph2D() {
  double liminx = liminfx;
  double liminy = liminfy;
  //double liminz=liminfz;
  //double saltoz=saltovalor(limsupz,liminfz,319);
  double saltoy = saltovalor(limsupy, liminfy, 319);
  double saltox = saltovalor(limsupx, liminfx, 319);
  for (int i = 0; i < 319; i++) {
    double puntoval = Pvalxy(liminx);
    //Serial.print("Valuoxy:");
    //Serial.println(puntoval);
    //no valua espejo , porque envia array con 1 solo reflejo , solo 1 dato por celda
    PMxy(puntoval, i, 1);
    liminx = liminx + saltox;
  }
  liminx = liminfx;
  for (int i = 0; i < 319; i++) {
    double puntoval = Pvalxz(liminx);
    //Serial.print("Valuoxz:");
    //Serial.println(puntoval);
    //no valua espejo , porque envia array con 1 solo reflejo , solo 1 dato por celda
    PMxy(puntoval, i, 2);
    liminx = liminx + saltox;
  }
  for (int i = 0; i < 319; i++) {
    double puntoval = Pvalyz(liminy);
    // Serial.print("Valuoyz:");
    //Serial.println(puntoval);
    //no valua espejo , porque envia array con 1 solo reflejo , solo 1 dato por celda
    PMxy(puntoval, i, 3);
    liminy = liminy + saltoy;
  }
}

double Pvalxy(int x) {
  int Sigx = 0;
  Sigx = signoda(signo[0]);
  int xvaluado = (coefi[0] * Sigx * (pow(x, expon[0]))) / divis[0];
  Sigx = signoda(signo[1]);
  int paren1 = ((constante + (-1 * (xvaluado))) * divis[1]) / (coefi[1] * Sigx);
  double eex = (double)expon[1];
  double expox = 1 / eex;
  return pow(paren1, expox);
}

double Pvalxz(int x) {
  int Sigx = 0;
  Sigx = signoda(signo[0]);
  int xvaluado = (coefi[0] * Sigx * (pow(x, expon[0]))) / divis[0];
  Sigx = signoda(signo[2]);
  int paren1 = ((constante + (-1 * (xvaluado))) * divis[2]) / (coefi[2] * Sigx);
  double eex = (double)expon[2];
  double expox = 1 / eex;
  return pow(paren1, expox);

}

double Pvalyz(int x) {
  //es valor y
  int Sigx = 0;
  Sigx = signoda(signo[1]);
  int yvaluado = (coefi[1] * Sigx * (pow(x, expon[1]))) / divis[1];
  Sigx = signoda(signo[2]);
  int paren1 = ((constante + (-1 * (yvaluado))) * divis[2]) / (coefi[2] * Sigx);
  double eex = (double)expon[2];
  double expox = 1 / eex;
  return pow(paren1, expox);
}

void PMxy(double valor, int posix, short ejes) {
  double saltoy = saltovalor(limsupy, liminfy, 200);
  for (int i = 0; i < 200; i++) {
    if ((valor >= (liminfy + (saltoy * i))) && (valor < (liminfy + (saltoy * (i + 1))))) {
      if (ejes == 1) {
        xy[posix] = 200 - i;
      } else if (ejes == 2) {
        xz[posix] = 200 - i;
      } else {
        yz[posix] = 200 - i;
      }
      break;
    } else if (i == (199)) {
      if (ejes == 1) {
        xy[posix] = 0;
      } else if (ejes == 2) {
        xz[posix] = 0;
      } else {
        yz[posix] = 0;
      }
    }
  }
}

void limpiadata() {
  for ( int i = 0; i < 100;  ++i ) {
    operacion[i] = (char)0;
  }
  for (int i = 0; i < 8; i++) {
    for (int j = 0; j < 8; j++) {
      for (int k = 0; k < 8; k++) {
        cubo[k][j][i] = 0;
      }
    }
  }
  for ( int i = 0; i < 4;  ++i ) {
    signo[i] = 0;
    coefi[i] = 0;
    expon[i] = 0;
    divis[i] = 0;
  }
  longitudOp = 0;
  limsupz = 0;
  liminfz = 0;
  limsupy = 0;
  liminfy = 0;
  limsupx = 0;
  liminfx = 0;
  constante = 0;
  vari = -1;
  tipo = 0;
  finacons = false;
  numtemp = "";
}

//[+(((1)x^(4))/1)+(((1)y^(2))/1)+(((1)z^(3))/1)=1600{5{9{0{n{i{e]
void Comunicacion() {
  limpiadata();
  char lee = 0;
  int tamx = 0;
  longitudOp = 0;
  short inicio = 0;
  bool paramet = false;
  short Pparam = 0;
  bool siga = true;
  while (true) {
    lee = Serial.read();
    if (inicio == 0 && lee == '[') {
      inicio++;
    } else if (inicio == 1 && lee == ']') {
      inicio++;
    } else if (inicio == 1 && lee == '{') {
      paramet = true;
      siga = false;
    }
    if ((lee != '{') && (lee != ']') && (lee != '[')) {
      //&&siga
      if (inicio == 1 && !paramet && lee != -1 && siga) {
        //Serial.print("F");
        Serial.print(lee);
        operacion[longitudOp] = lee;
        longitudOp++;
      } else if (inicio == 1 && paramet && lee != -1) {
        Serial.print("G");
        Serial.print(lee);
        parmGuar(lee, Pparam);
        paramet = false;
        Pparam++;
      }
    }
    if (inicio == 2) {
      break;
    }
  }
  Serial.println("");
  if (longitudOp != 0) {
    ExtraeValores();
    puntos3d();
    graph2D();
    enviaPuntos();
    ImprimeCubo();
  }
}

void parmGuar(int num, int posi) {
  switch (posi) {
    case 0:
      limsupx = num;
      break;
    case 1:
      liminfx = num;
      break;
    case 2:
      limsupy = num;
      break;
    case 3:
      liminfy = num;
      break;
    case 4:
      limsupz = num;
      break;
    case 5:
      liminfz = num;
      break;
  }
}

void enviaPuntos() {
  short pxe = expon[0] % 2;
  short pye = expon[1] % 2;
  short pze = expon[2] % 2;
  char yy = 0;
  char zz = 0;
  if (pxe != 0) {
    pxe = 1;
  }
  if (pye != 0) {
    yy = 1;
  }
  if (pze != 0) {
    zz = 1;
  }
  int delayt = 10;
  Serial.write('[');
  delay(delayt);
  for (int i = 0; i < 319; i++) {
    Serial.write(xy[i]);
    delay(delayt);
  }
  Serial.write(yy);
  delay(delayt);
  for (int i = 0; i < 319; i++) {
    Serial.write(xz[i]);
    delay(delayt);
  }
  Serial.write(zz);
  delay(delayt);
  for (int i = 0; i < 319; i++) {
    Serial.write(yz[i]);
    delay(delayt);
  }
  Serial.write(']');
  delay(delayt);
  for (int i = 0; i < 100; i++) {
    Serial.write(0);
    delay(delayt);
  }
}
