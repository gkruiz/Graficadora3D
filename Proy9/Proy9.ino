#include <StackList.h>
StackList<String> operacionx;
StackList<String> pila;


//[+(((1)x^(2))/1)+(((1)y^(2))/1)+(((1)z^(2))/1)=1600{5{5{5{5{5{5]
//[+(((1)x^(2))/1)+(((1)y^(2))/1)+(((1)z^(2))/1)=1600]
char operacion[100]="";

short longitudOp=0;//50
char numeros[11]={'0','1','2','3','4','5','6','7','8','9',0};
//signo, coeficiente , exponente ,divisor
int signo[4]={0,0,0,0};
int coefi[4]={1,1,1,0};
int expon[4]={1,1,1,0};
int divis[4]={1,1,1,0};

short constante=0;

int limsupz=50;
int liminfz=-40;   

int limsupy=40;
int liminfy=-40;

int limsupx=40;
int liminfx=-40;



short vari=-1;
short tipo=0;
bool finacons=false;

String numtemp="";
//         x  y  z
short cubo[8][8][8];


short xy[320];
short xz[320];
short yz[320];
//.
// .
//  .
//   .
//     ...>319

// x 319  ; y 200 



      
void setup() {

ExtraeValores();
  Serial.begin(9600);
    operacion[99]=0;
    xy[319]=0;
    xz[319]=0;
    yz[319]=0;
//    xy[0]=50;
//    xy[318]=60;
//    
//    xz[0]=51;
//    xz[318]=61;
//    
//    yz[0]=52;
//    yz[318]=62;
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


}


//void ExtraeValores(){
//  
//  
//  numtemp="";
//  vari=-1;
//  tipo=0; 
//  finacons=false;
//  constante=0;
//
//    
//  for(int i=0;i<longitudOp;i++){
//    //Serial.println("itera 1");
//    for(int j=0;j<10;j++){
//      short char1=operacion[i]*1;
//      short char2=numeros[j]*1;
//
//      short parente=')'*1;
//      short men='-'*1;
//      short mas='+'*1;
//      short igu='='*1;
//  
//        if(char1==char2){
//  //        Serial.println("char igual numero");
//             numtemp=numtemp+numeros[j];
//              if(finacons&&(numtemp.length()!=0)&&(i==(longitudOp-1))){
//                constante=numtemp.toInt();
//                numtemp="";
//              }
//          break;
//        }else if(char1==parente){
////Serial.println("parentesis");
//           if(numtemp.length()!=0){
//              int convierte=numtemp.toInt();
//              if(tipo==0){
//                coefi[vari]=convierte;
//              }else if(tipo==1){
//                expon[vari]=convierte; 
//              }else if(tipo==2){
//                divis[vari]=convierte;
//              }
//
//               tipo++;
//              numtemp="";
//            }
//          break;
//        }else if((char1==men)||(char1==mas)){
//      //    Serial.println("es un signo");
//          if(char1==men){
//            signo[vari+1]=1; 
//          }else{
//            signo[vari+1]=0;     
//          }
//            
//            vari++;
//            tipo=0;
//            break;
//        }else if((char1==igu)){
//       //   Serial.println("signo igual");
//              finacons=true;
//              break;
//        }
//    }
//    }
//
//}




void puntos3d(){
  bool buenot=false;
  double saltox=0;
  double saltoy=0; 
  double saltoz=0; 

  if(limsupz>liminfz){
    if(limsupy>liminfy){
      if(limsupx>liminfx){
      
        buenot=true;
         saltoz=saltovalor(limsupz,liminfz,8);
         saltox=saltovalor(limsupx,liminfx,8);
      
      }
    }
  }
  
//siempre lim sup mayor al menor
double supz=limsupz;
double infz=liminfz;

double supx=limsupx;
double infx=liminfx;


  if(buenot){
    
    for(int i=0;i<8;i++){
     //evualua z
         
         infx=liminfx;
         for(int j=0;j<8;j++){
         //evualua x
           double valoryR=0;
           double valory=Pvaluado(infx,infz);
              int residuo=expon[1]%2;
                
                
             //Serial.print("saca:"); Serial.println(valory);
          if(valory>=0||(valory<0)){
                 parametrizaY(valory,i,j);
                 
                if(residuo==0){//exponente par
                  valoryR=-1*valory;
                  parametrizaY(valoryR,i,j);
                }
                 //if(valoryR!=0){
                  
                 //}
          }
         
         
         infx=infx+saltox;
        }
        infz=infz+saltoz;
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


void parametrizaY(double valory,int z,int x){
  
 double saltoy=saltovalor(limsupy,liminfy,8);
 double infy=(double)liminfy; 
//Serial.println(valory);
   if((valory>=infy)&&(valory<(infy+saltoy))){
  
   cubo[x][0][z]=1;
  }else if((valory>=(infy+saltoy))&&(valory<(infy+saltoy*2))){
  cubo[x][1][z]=1;
  
  }else if((valory>=(infy+saltoy*2))&&(valory<(infy+saltoy*3))){
  cubo[x][2][z]=1;
  
  }else if((valory>=(infy+saltoy*3))&&(valory<(infy+saltoy*4))){
  cubo[x][3][z]=1;
  
  }else if((valory>=(infy+saltoy*4))&&(valory<(infy+saltoy*5))){
  cubo[x][4][z]=1;
  
  }else if((valory>=(infy+saltoy*5))&&(valory<(infy+saltoy*6))){
  cubo[x][5][z]=1;
  
  }else if((valory>=(infy+saltoy*6))&&(valory<(infy+saltoy*7))){
  cubo[x][6][z]=1;
  
  }else if((valory>=(infy+saltoy*7))&&(valory<=(infy+saltoy*8))){
  cubo[x][7][z]=1;
  
  }
  
}



void ImprimeCubo(){
  
  for(int i=0;i<8;i++){
    //valua z
    
    for(int j=0;j<8;j++){
      //valua y
        for(int k=0;k<8;k++){
        //valua x
        Serial.print(cubo[k][j][i]);
        
       }
       
       Serial.println("");
    }
    Serial.println("");
    Serial.println("");
  }
  


  for(int i=0;i<319;i++){
    
    Serial.print(xy[i]);
    Serial.print(",");
  }
  Serial.println("");
  for(int i=0;i<319;i++){
    
    Serial.print(xz[i]);
    Serial.print(",");
  }
  Serial.println("");
  for(int i=0;i<319;i++){
    
    Serial.print(yz[i]);
    Serial.print(",");
  }
Serial.println("");
  for(int i=0;i<longitudOp;i++){
    
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






double saltovalor(double sup,double inf,double veces){
  double rango=0;
  
  if(sup>=0&&inf>=0){
      rango=(sup+inf)/veces;
    
  }else if(sup>=0&&inf<=0){
      rango=(sup+(-1*inf))/veces;
    
  }else if(sup<=0&&inf<=0){
      rango=((-1*sup)+(-1*inf))/veces;
    
  }
  
  return rango;
}











double Pvaluado(int x ,int z){

  int Sigx=0;

  Sigx=signoda(signo[0]);
  
    int xvaluado=(coefi[0]*Sigx*(pow(x,expon[0])))/divis[0];

  Sigx=signoda(signo[2]);
   // Serial.println(xvaluado);
  
    int zvaluado=(coefi[2]*Sigx*(pow(z,expon[2])))/divis[2];
   //Serial.println(zvaluado);
  Sigx=signoda(signo[1]);
  
    int paren1=((constante+(-1*(xvaluado))+(-1*(zvaluado)))*divis[1])/(coefi[1]*Sigx);
     //Serial.println(paren1);
     double eex=(double)expon[1];
     //Serial.println(eex);
     double expox=1/eex;
     
  //double finalopera= 
//Serial.println(finalopera);
  return pow(paren1,expox);
}



int signoda(int eval){

  if(eval==1){
     return -1;
    }else{
     return 1; 
  }
}







void graph2D(){
  
  
  double liminx=liminfx;
  
  double liminy=liminfy;

  //double liminz=liminfz;

  //double saltoz=saltovalor(limsupz,liminfz,319);
  double saltoy=saltovalor(limsupy,liminfy,319);
  double saltox=saltovalor(limsupx,liminfx,319);



  for(int i=0;i<319;i++){
    double puntoval=Pvalxy(liminx);
    //Serial.print("Valuoxy:");
    //Serial.println(puntoval);
    //no valua espejo , porque envia array con 1 solo reflejo , solo 1 dato por celda
           PMxy(puntoval,i,1);   
     liminx=liminx+saltox;
  }

  liminx=liminfx;
  
  for(int i=0;i<319;i++){
    double puntoval=Pvalxz(liminx);
    //Serial.print("Valuoxz:");
    //Serial.println(puntoval);
    //no valua espejo , porque envia array con 1 solo reflejo , solo 1 dato por celda
           PMxy(puntoval,i,2);   
     liminx=liminx+saltox;
  }

  for(int i=0;i<319;i++){
    double puntoval=Pvalyz(liminy);
   // Serial.print("Valuoyz:");
    //Serial.println(puntoval);
    //no valua espejo , porque envia array con 1 solo reflejo , solo 1 dato por celda
           PMxy(puntoval,i,3);   
     liminy=liminy+saltoy;
  }
  
}


double Pvalxy(int x){
  
  int Sigx=0;

  Sigx=signoda(signo[0]);
  
    int xvaluado=(coefi[0]*Sigx*(pow(x,expon[0])))/divis[0];

  Sigx=signoda(signo[1]);
  
    int paren1=((constante+(-1*(xvaluado)))*divis[1])/(coefi[1]*Sigx);
     double eex=(double)expon[1];
     double expox=1/eex;
     
  return pow(paren1,expox);
  
}



double Pvalxz(int x){
  
  int Sigx=0;

  Sigx=signoda(signo[0]);
  
    int xvaluado=(coefi[0]*Sigx*(pow(x,expon[0])))/divis[0];

  Sigx=signoda(signo[2]);
  
    int paren1=((constante+(-1*(xvaluado)))*divis[2])/(coefi[2]*Sigx);
     double eex=(double)expon[2];
     double expox=1/eex;
     
  return pow(paren1,expox);
  
}



double Pvalyz(int x){
              //es valor y
  int Sigx=0;

  Sigx=signoda(signo[1]);
  
    int yvaluado=(coefi[1]*Sigx*(pow(x,expon[1])))/divis[1];

  Sigx=signoda(signo[2]);
  
    int paren1=((constante+(-1*(yvaluado)))*divis[2])/(coefi[2]*Sigx);
     double eex=(double)expon[2];
     double expox=1/eex;
     
  return pow(paren1,expox);
  
}


void PMxy(double valor,int posix,short ejes){
 double saltoy=saltovalor(limsupy,liminfy,200);
 
  for(int i=0;i<200;i++){
    
    if((valor>=(liminfy+(saltoy*i)))&&(valor<(liminfy+(saltoy*(i+1))))){
      if(ejes==1){
        xy[posix]=200-i;
      }else if(ejes==2){
        xz[posix]=200-i;
      }else{
        yz[posix]=200-i;  
      }
        
      break;
    }else if(i==(199)){
      if(ejes==1){
        xy[posix]=0;
      }else if(ejes==2){
        xz[posix]=0;
      }else{
        yz[posix]=0;  
      }
        
    }

  }
}












void limpiadata(){
  for( int i = 0; i < 100;  ++i ){
   operacion[i] = (char)0;
  }
  for(int i=0;i<8;i++){
      for(int j=0;j<8;j++){
          for(int k=0;k<8;k++){
          cubo[k][j][i]=0; 
         }
      } 
  }

  for( int i = 0; i < 4;  ++i ){
    signo[i]=0;
    coefi[i]=0;
    expon[i]=0;
    divis[i]=0;
  }
  for( int i = 0; i < 3;  ++i ){
    coefi[i]=1;
    expon[i]=1;
    divis[i]=1;
  }
 longitudOp=0;
 limsupz=0;
 liminfz=0;   
 limsupy=0;
 liminfy=0;
 limsupx=0;
 liminfx=0;
 constante=0;
 vari=-1;
 tipo=0;
 finacons=false;
 numtemp="";
}



//[+(((1)x^(4))/1)+(((1)y^(2))/1)+(((1)z^(3))/1)=1600{5{9{0{n{i{e]
void Comunicacion(){
  limpiadata();
  char lee=0;
  int tamx=0;
  longitudOp=0;
  
  short inicio=0;
  bool paramet=false;
  short Pparam=0;
  bool siga=true;

  while(true){
   lee=Serial.read();
    if(inicio==0&&lee=='['){
      inicio++;
    }else if(inicio==1&&lee==']'){
      inicio++;
    }else if(inicio==1&&lee=='{'){
      paramet=true;
      siga=false;
    }
      if((lee!='{')&&(lee!=']')&&(lee!='[')){
    //&&siga
        if(inicio==1&&!paramet&&lee!=-1&&siga){  
          //Serial.print("F");
          Serial.print(lee);
          operacion[longitudOp]=lee;
          longitudOp++;
        }else if(inicio==1&&paramet&&lee!=-1){
            Serial.print("G");
            Serial.print(lee);
            parmGuar(lee,Pparam);
            paramet=false;  
            Pparam++;
          
        }
      }
      
      if(inicio==2){
          break;
      }
    
  }

  
  Serial.println("");

  if(longitudOp!=0){
    ExtraeValores();
       Serial.println("*************");
    Serial.println(coefi[0]);
    Serial.println(coefi[1]);
    Serial.println(coefi[2]);
Serial.println("*************");
    Serial.println(expon[0]);
    Serial.println(expon[1]);
    Serial.println(expon[2]);
Serial.println("*************");
    Serial.println(divis[0]);
    Serial.println(divis[1]);
    Serial.println(divis[2]);
Serial.println("*************");
    Serial.println(signo[0]);
    Serial.println(signo[1]);
    Serial.println(signo[2]);
Serial.println("*************");
    Serial.println(constante);
Serial.println("*************");
    puntos3d();
    graph2D();
    enviaPuntos();
    //ImprimeCubo();

    
  }
  
}


void parmGuar(int num,int posi){
  
  switch(posi){
   case 0:
      limsupx=num;
    break;
   case 1:
      liminfx=num; 
    break;
   case 2:
      limsupy=num;
    break;
   case 3:
      liminfy=num;
    break;
   case 4:
      limsupz=num;
    break;
   case 5:
      liminfz=num;
    break;
  }

}



void enviaPuntos(){
  short pxe=expon[0]%2;
  short pye=expon[1]%2;
  short pze=expon[2]%2;
  char yy=0;
  char zz=0;
   if(pxe!=0){
     pxe=1;
   }
   if(pye!=0){
     yy=1;
   }
   if(pze!=0){
     zz=1;
   }
  int delayt=50;
  delay(1000);
  //escriDat('[');
  Serial.write('[');
          delay(delayt);
  for(int i=0;i<319;i++){
          //escriDat(xy[i]);
          Serial.write(xy[i]);
          delay(delayt);
  }
    //escriDat(yy);
    Serial.write(yy);
    delay(delayt);
  for(int i=0;i<319;i++){
          //escriDat(xz[i]);
          Serial.write(xz[i]);
          delay(delayt);
  }
    //escriDat(zz);
    Serial.write(zz);
    delay(delayt);
  for(int i=0;i<319;i++){
          //escriDat(yz[i]);
          Serial.write(yz[i]);
          delay(delayt);
  }
  //escriDat(']');
  Serial.write(']');
  delay(delayt);
  for(int i=0;i<50;i++){
          Serial.write(0);
          delay(delayt);
  }
//  Serial.println("**********+++---");
//  Serial.println("**********+++---");
//  Serial.println("**********+++---");
//  Serial.println(yy*1);
//  Serial.println(zz*1);
//  Serial.println("**********+++---");
//  Serial.println("**********+++---");
//  Serial.println("**********+++---");
}



void escriDat(char cc){

  int enviao=0;
  short reci=-1;
  Serial.write(cc);
  
  while(true){
    
    if(enviao>5000){
      Serial.write(cc);
      enviao=0;
    }

    reci =Serial.read()*1;
     
    if(reci!=-1){
      break;
    }
    enviao++;
  }
  
}
//extra de carlos y javier y mio*******************************************************



void ExtraeValores(){
  eliminaEspacios();
  //extrae coeficientes
    String regresof= BOpCoef('x');
    Serial.println(regresof);
    if(regresof.length()!=0){
      coefi[0]=getResultado(regresof);
    }

    regresof= BOpCoef('y');
    Serial.println(regresof);
    if(regresof.length()!=0){
      coefi[1]=getResultado(regresof);
    }

    regresof= BOpCoef('z');
    Serial.println(regresof);
    if(regresof.length()!=0){
      coefi[2]=getResultado(regresof);
    }
      
  //extrae exponentes-----------------------------
    regresof= BOpExpo('x');
    Serial.println(regresof);
    if(regresof.length()!=0){
      expon[0]=getResultado(regresof);
    }

    regresof= BOpExpo('y');
    Serial.println(regresof);
    if(regresof.length()!=0){
      expon[1]=getResultado(regresof);
    }

    regresof= BOpExpo('z');
    Serial.println(regresof);
    if(regresof.length()!=0){
      expon[2]=getResultado(regresof);
    }


  //extrae divisores-------------------------------
    regresof= BOpDivi('x');
    Serial.println(regresof);
    if(regresof.length()!=0){
      divis[0]=getResultado(regresof);
    }

    regresof= BOpDivi('y');
    Serial.println(regresof);
    if(regresof.length()!=0){
      divis[1]=getResultado(regresof);
    }

    regresof= BOpDivi('z');
    Serial.println(regresof);
    if(regresof.length()!=0){
      divis[2]=getResultado(regresof);
    }

  //extrae unarios
    ExtraeUnario('x');
    ExtraeUnario('y');
    ExtraeUnario('z');
  //extrae constante
  
  regresof= ExtraCons();
    if(regresof.length()!=0){
      constante=getResultado(regresof);
    }
  
}



String ExtraCons(){
  String retorx="";
  short tchigu=1*('=');

  short posiigu=-1;
  for(int i=0;i<longitudOp;i++){
    
            short tchara=1*(operacion[i]);
            if(tchara==tchigu){
                 posiigu=i;
                break;
            }
  }
  if(posiigu!=-1){
    posiigu++;
        for(int i=posiigu;i<longitudOp;i++){
          retorx=retorx+operacion[i];
        }    
  }
 return retorx;
}

void ExtraeUnario(char variableBus){
  
  
    short sumPar=0;
        //Cota superior corchete
        short posicionsup=-1;
        short varbusx=1*variableBus;
        
        bool vbuses=false;//si es la variable que busca
        bool signox=false;//false es positivo

            short parcc=1*(')');
            short paraa=1*('(');
            short masaa=1*('+');
            short menaa=1*('-');

        
        for(int i=0;i<longitudOp;i++){
    
            short tchara=1*(operacion[i]);
            
              if(tchara==parcc){
                if(sumPar!=0){
                          sumPar--;
                 }else{
                   break;  
                 }
                //sumPar--;
              }else if(tchara==paraa){
                sumPar++;
              }else if(tchara==varbusx){
                  vbuses=true;
              }
              else if(tchara==masaa){
                if(sumPar==0){
                  signox=false;
                }
              }else if(tchara==menaa){
                if(sumPar==0){
                  signox=true;
                }
              }
              
    
              if(sumPar==0&&(i!=0)&&(vbuses)){
                if(signox){
                  short sdfx='x'*1;
                  short sdfy='y'*1;
                  short sdfz='z'*1;
                  if(varbusx==sdfx){
                    signo[0]=1;
                  }else if(varbusx==sdfy){
                    signo[1]=1;
                  }else if(varbusx==sdfz){
                    signo[2]=1;
                  }
                }
               break; 
              }
        }
  
  
}



String BOpDivi(char variableBus){
  String retornarax="";
  //tambien guardara unario principal
        short sumPar=0;
        //Cota superior corchete
        short posicionsup=-1;
        short varbusx=1*variableBus;
        
        bool vbuses=false;//si es la variable que busca
        //bool signo=false;//false es positivo

            short parcc=1*(')');
            short paraa=1*('(');
//            short masaa=1*('+');
//            short menaa=1*('-');

        
        for(int i=0;i<longitudOp;i++){
    
            short tchara=1*(operacion[i]);
            
              if(tchara==parcc){
                sumPar--;
              }else if(tchara==paraa){
                sumPar++;
              }else if(tchara==varbusx){
                  vbuses=true;
              }
//              else if(tchara==masaa){
//                if(sumPar==0){
//                  signo=false;
//                }
//              }else if(tchara==menaa){
//                if(sumPar==0){
//                  signo=true;
//                }
//              }
              
    
              if(sumPar==0&&(i!=0)&&(vbuses)){
                posicionsup=i;//seria el extremo superior del corchete mayor
               break; 
              }
        }
        

   short sumPar2=0;
   short posicioninf=-1;
        if(posicionsup!=-1){
              posicionsup--;
              
              //Cota inferior
             
              for(int i=posicionsup;i>=0;i--){
          
                  short tchara=1*(operacion[i]);
                  short parcc=1*(')');
                  short paraa=1*('(');
                    if(tchara==parcc){
                      sumPar2++;
                    }else if(tchara==paraa){
                        if(i!=posicionsup){
                          sumPar2--;
                        }else{
                        break;  
                        }
                    }
          
                    if(sumPar2==0&&(i!=posicionsup)){
                      posicioninf=i;
                     break; 
                    }
              }
        }
      
      Serial.println(posicioninf);
      Serial.println(posicionsup);
      
      //Serial.println(sumPar);
      //Serial.println(sumPar2);


      
      
      if((posicioninf!=-1)&&(posicionsup!=-1)){
        short ttx=operacion[posicioninf-1]*1;
        short tty='/'*1;
          if(ttx==tty){//al final bloque ana queda una diago 
            for(int i=posicioninf;i<=posicionsup;i++){
             // Serial.println(operacion[i]);
               retornarax=retornarax+operacion[i];
            }
          }
      }
   return retornarax;   
}


String BOpExpo(char variableBus){
  
  String retornarax="";
   int posicion=-1;
   //cota superior
   short convVb=1*(variableBus);
    for(int i=0;i<longitudOp;i++){
        char texmul=operacion[i];
        short tchara=1*(texmul);
          if(tchara==convVb){
              posicion=i;
            break;
          } 
    }

  short exc=1*'^';
  short excs=operacion[posicion+1]*1;
  
      if((exc==excs)&&(posicion!=-1)){
    
        short sumPar=0;
        //Cota inferior
        short posicionsup=-1;
        posicion+=2;
        for(int i=posicion;i<longitudOp;i++){
    
            short tchara=1*(operacion[i]);
            short parcc=1*(')');
            short paraa=1*('(');
              if(tchara==parcc){
                if(i!=posicion){
                  sumPar--;
                }else{
                break;  
                }
              }else if(tchara==paraa){
                sumPar++;
              }
    
              if(sumPar==0&&(i!=(posicion))){
                posicionsup=i;
               break; 
              }
        }
        Serial.println(posicionsup);
        Serial.println(posicion);
        
        if((posicionsup!=-1)&&(posicion!=-1)){
          for(int i=posicion;i<=posicionsup;i++){
            //Serial.println(operacion[i]);
             retornarax=retornarax+operacion[i];
          }
        }
        
      }
  return retornarax;
}



String BOpCoef(char variableBus){

  String retornarax="";
   int posicion=-1;
   //cota superior
   short convVb=1*(variableBus);
    for(int i=0;i<longitudOp;i++){
        char texmul=operacion[i];
        short tchara=1*(texmul);
          if(tchara==convVb){
              posicion=i;
            break;
          } 
    }
    posicion--;
    short sumPar=0;
    //Cota inferior
    short posicioninf=-1;
    for(int i=posicion;i>=0;i--){

        short tchara=1*(operacion[i]);
        short parcc=1*(')');
        short paraa=1*('(');
          if(tchara==parcc){
               sumPar++;
          }else if(tchara==paraa){
            if(i!=posicion){
             sumPar--;
            }else{
            break;
            }
          }

          if(sumPar==0&&(i!=posicion)){
            posicioninf=i;
           break; 
          }
    }
    if((posicioninf!=-1)&&(posicion!=-1)){
      for(int i=posicioninf;i<=posicion;i++){
               retornarax=retornarax+operacion[i];
      }
    }
    

  return retornarax;
}

void eliminaEspacios(){
 int nuevoT=0;
 String nuevo="";
        for(int i=0;i<longitudOp;i++){
          short tcharaa=1*(operacion[i]);
          short convVba=1*(' ');
            if(tcharaa!=convVba){
               nuevo=nuevo+operacion[i];
               nuevoT++;
            }
        }
  longitudOp= nuevoT;     
       for(int i=nuevoT;i<100;i++){
               operacion[i]=0;
        }
       
       for(int i=0;i<nuevoT;i++){
        char cct=0;
          cct=nuevo.charAt(i);
          operacion[i]=cct;
        } 
}




//inicia otro----------------------------------------------


int getResultado(String valoresOperacion){
  return Operar(PostFijo(valoresOperacion));
}
int ObtenerPrecedencia(String caracter) {
  if (caracter == "+") {
    return 1;
  } else if (caracter == "-") {
    return 1;
  } else if (caracter == "/") {
    return 2;
  }
  else if (caracter == "*") {
    return 2;
  }
  else if (caracter == "%") {
    return 2;
  }
  else if (caracter == "^") {
    return 3;
  }
  else if (caracter == ")") {

    return  4;
  }
  else if (caracter == "(") {
    return  4;
  }
}
String PostFijo(String cadena) {
  //------------- limpiar la pila
  while (!pila.isEmpty()) {
    pila.pop();
  }
  //----------------
  String post = "";
  int i = 0;
  while (i < cadena.length()) {

    if (isDigit(cadena.charAt(i))) {
      post += cadena.charAt(i);
    } else {
      // Llamada a la pila
      if (pila.isEmpty() && String(cadena.charAt(i)) != ")") {
        pila.push(String(cadena.charAt(i)));
        post += ",";
      } else if (String(cadena.charAt(i)) == "(") {
        pila.push(String(cadena.charAt(i)));
      } else {
        int prectope = ObtenerPrecedencia(pila.peek());
        int precactual = ObtenerPrecedencia(String(cadena.charAt(i)));
        post += ",";
        if (prectope == 4 && precactual != 4) {
          pila.push(String(cadena.charAt(i)));
        }
        else if (precactual == 4) {
          bool flag = false;
          while (flag == false && !pila.isEmpty()) {
            String out = pila.pop();

            if (out == "(") {
              flag = true;

            } else {
              post += out;
            }
          }

          // vaciado de pila

        } else if (precactual > prectope) // se agrega pila
        {
          pila.push(String(cadena.charAt(i)));
          //post += ",";

        } else if (precactual < prectope)// saca operador
        {

          while (!pila.isEmpty() && pila.peek() != "(") {
            post += (pila.pop());
            if (pila.count() == 0) {

            } else {
              post += ",";
            }
          }

          pila.push(String(cadena.charAt(i)));
        } else if (precactual == prectope) // se cambia
        {
          String cambio = pila.pop();
          pila.push(String(cadena.charAt(i)));
          //post += ",";
          post += cambio;
          post += ",";
        }

      }
    }
    i++;
  }
  while (!pila.isEmpty()) {
    post += ",";
    post += (pila.pop());
  }
  // pone aqui el mensaje que imprima en consola de la variable post
  return post;
}

int Operar(String datos) {
  while (!operacionx.isEmpty()) {
    operacionx.pop();
  }
  int i = 0;
  String dato1 = "";
  int dato2 = "";
  while (i <= datos.length()) {
    dato1 = "";

    if (isDigit(datos.charAt(i))) {
      while (isDigit(datos.charAt(i))) {
        dato1 += datos.charAt(i);
        i++;
      }
      operacionx.push(dato1);
      i++;
    }
    else if (datos.charAt(i) == '+') {
      dato2 = Resolucion(operacionx.pop().toDouble(), operacionx.pop().toDouble(), '+');
      operacionx.push(String(dato2));
      i++;
    }
    else if (datos.charAt(i) == '-') {
      dato2 = Resolucion(operacionx.pop().toDouble(), operacionx.pop().toDouble(), '-');
      operacionx.push(String(dato2));
      i++;
    }
    else if (datos.charAt(i) == '*') {
      dato2 = Resolucion(operacionx.pop().toDouble(), operacionx.pop().toDouble(), '*');
      operacionx.push(String(dato2));
      i++;
    }
    else if (datos.charAt(i) == '/') {
      dato2 = Resolucion(operacionx.pop().toDouble(), operacionx.pop().toDouble(), '/');
      operacionx.push(String(dato2));
      i++;
    }
    else if (datos.charAt(i) == '^') {
      dato2 = Resolucion(operacionx.pop().toDouble(), operacionx.pop().toDouble(), '^');
      operacionx.push(String(dato2));
      i++;
    }
    else if (datos.charAt(i) == '%') {
      dato2 = Resolucion(operacionx.pop().toDouble(), operacionx.pop().toDouble(), '%');
      operacionx.push(String(dato2));
      i++;
    }
    else {
      i++;
    }

  }
  dato2 = operacionx.pop().toInt();

  return dato2;
}

int Resolucion(double valor1, double valor2, char tipo) {
  double respuesta = 0;
  if (tipo == '+') {
    respuesta = valor1 + valor2;
  }
  else if (tipo == '-') {
    respuesta = valor1 - valor2;
  }
  else if (tipo == '*') {
    respuesta = valor1 * valor2;
  }
  else if (tipo == '/') {
    respuesta = valor1 / valor2;
  }
  else if (tipo == '^') {
    respuesta = pow(valor1, valor2);
  }
  else if (tipo == '%') {
    respuesta = (int)valor1 % (int)valor2;
  }
  return (int)ceil(respuesta);
}
