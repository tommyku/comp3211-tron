#include <iostream>
#include <string>
#include <vector>
#include <algorithm>
#include <math.h>
#include <cmath>

using namespace std;

int width = 30;
int height = 20;
int map[30][20];
int tmap[30][20];


enum movement{
  up = 0, down = 1, left = 2 , right = 3
};
struct pos{
  int x = 0;
  int y = 0;
};

pos curPos[4];


bool outOfBound(int x, int y) {
    if (x<0 || x>=30 || y<0 || y>=20 || tmap[x][y] == -1) 
    {return true;};
    return false;
}

double distance(int x1,int y1,int x2,int y2) {
    //return sqrt(pow((double)x1-x2,2)+pow((double)y1-y2,2));
    return abs(x1-x2)+abs(y1-y2);
}


double evaluate(int x, int y, pos* allPos, int P , int N, int dir, int depth) {
    //if(depth==0) {return 0;}
    //if(depth<5 && outOfBound(x,y)) {return -2;}
    int dx =0,dy = 0;
    double value = 0;
     switch (dir) {
    case 0:    dy=-1;    break;
    case 1:    dy=1;    break;
    case 2:    dx=-1;    break;
    case 3:    dx=1;    break;
    default:
    0;
     }

    if(outOfBound(x+dx,y+dy)) {return -200000;}
    if(x==0||y==0||x==29||y==19) {return -100;}
     //depth--;
     int n=0;
      for(int i = 0;i<30;i++) {
    for(int j =0;j<20;j++) {
        double d = distance(i,j,x+dx,y+dy);
        if(d<5) {n++;value+=tmap[i][j]/(d+1);};
    }
      }
      value-=(4*3-4-n)*10;
      value-=tmap[x][y];
      //cerr<<"Val: "<<value<<endl;
     
     
     //calc heuristics
     
     
        
        //  value+=evaluate(x+1,y,allPos,P,N,0,depth);
        //  value+=evaluate(x-1,y,allPos,P,N,0,depth);
        //  value+=evaluate(x,y+1,allPos,P,N,0,depth);
        //  value+=evaluate(x,y-1,allPos,P,N,0,depth);
        //  value=value*depth/60;
        //  value+=10;


        //
        //if(depth<4) {return value;}
        
          for (int i = 0; i<N;i++) {
              if(i==P) {continue;};
              int d = distance(allPos[i].x,allPos[i].y,x,y);
              if (d>3) {value +=2000/pow(d,3);};
          }
          //cerr<<"val: "<<value<<endl;
    return value;
};

double minMax(int x1, int y1, pos* allPos, int P , int N, int dir, int depth,int mM) {
    int dx =0,dy = 0;
    double value = 0;
     switch (dir) {
    case 0:    dy=-1;    break;
    case 1:    dy=1;    break;
    case 2:    dx=-1;    break;
    case 3:    dx=1;    break;
    default:
    0;
     }

    if(outOfBound(x1+dx,y1+dy)) {return -200000;}
    double min = 100000;
    double max = -100000;
    int temp;
    int x = allPos[mM].x;
    int y = allPos[mM].y;
    double v[4];
    int c1,c2;
    if (depth==1) {
        temp=tmap[x+1][y];
    tmap[x+1][y]=-1;
    v[0] = evaluate(x+1,y,allPos,P,N,dir,depth-1);
    tmap[x+1][y]=temp;
    
    temp=tmap[x-1][y];
    tmap[x-1][y]=-1;
    v[1] = evaluate(x-1,y,allPos,P,N,dir,depth-1);
    tmap[x-1][y]=temp;
    
    temp=tmap[x][y+1];
    tmap[x][y+1]=-1;
    v[2] = evaluate(x,y+1,allPos,P,N,dir,depth-1);
    tmap[x][y+1]=temp;
    
    temp=tmap[x][y-1];
    tmap[x][y-1]=-1;
    v[3] = evaluate(x,y-1,allPos,P,N,dir,depth-1);
    tmap[x][y-1]=temp;
    
    cerr<<v[0]<<"  "<<v[1]<<"  "<<v[2]<<"  "<<v[3]<<endl;
    
    for(int i =0;i<4;i++) {
        if(v[i]>max) {max=v[i];c2=i;};
        if(v[i]<min) {min=v[i];c1=i;};
    }
    if(mM==1) {return min;}
   return max;
    
        };


    
    
    temp=tmap[x+1][y];
    tmap[x+1][y]=-1;
    v[0] = minMax(x+1,y,allPos,P,N,dir,depth-1,abs(mM-1));
    tmap[x+1][y]=temp;
    
    temp=tmap[x-1][y];
    tmap[x-1][y]=-1;
    v[1] = minMax(x-1,y,allPos,P,N,dir,depth-1,abs(mM-1));
    tmap[x-1][y]=temp;
    
    temp=tmap[x][y+1];
    tmap[x][y+1]=-1;
    v[2] = minMax(x,y+1,allPos,P,N,dir,depth-1,abs(mM-1));
    tmap[x][y+1]=temp;
    
    temp=tmap[x][y-1];
    tmap[x][y-1]=-1;
    v[3] = minMax(x,y-1,allPos,P,N,dir,depth-1,abs(mM-1));
    tmap[x][y-1]=temp;
    
    
    for(int i =0;i<4;i++) {
        if(v[i]>max) {max==v[i];c2==i;};
        if(v[i]<min) {min==v[i];c1==i;};
    }
    if(mM==1) {return min;}
    return max;
    
    
}







void move(int dir, pos &cur){
  switch (dir) {
    case 0:
    cout << "UP" << endl;
    cur.y--;
    break;
    case 1:
    cout << "DOWN" << endl;
    cur.y++;
    break;
    case 2:
    cout << "LEFT" << endl;
    cur.x--;
    break;
    case 3:
    cout << "RIGHT" << endl;
    cur.x++;
    break;
  }
};

int main()
{
    for(int i = 0;i<30;i++) {
    for(int j =0;j<20;j++) {
        map[i][j]=1;
        tmap[i][j]=1;
    }
}

    int dir = 0;
    double best;
    double temp;

    while (1) {
        int N; // total number of players (2 to 4).
        int P; // your player number (0 to 3).
        cin >> N >> P; cin.ignore();
        for (int i = 0; i < N; i++) {
            int X0; // tail
            int Y0;
            int X1; // head
            int Y1;

            cin >> X0 >> Y0 >> X1 >> Y1; cin.ignore();
            curPos[i].x = X1;
            curPos[i].y = Y1;
            
            map[X1][Y1] = -1;
            tmap[X1][Y1] = -1;
       
    if(i==P) {
        cerr<<"Cur Pos: "<<curPos[0].x<<"     "<<curPos[0].y<<endl;
        best = -1000;
        temp = 0;
        for(int i =0;i<4;i++) {
            temp = minMax(curPos[P].x,curPos[P].y, curPos, P, N,i,1,0);
            //temp = evaluate(curPos[P].x,curPos[P].y, curPos, P, N,i,5);
            cerr<<i<<"     "<<temp<<endl;
            if (temp> best) {
                best = temp;
                dir = i;
            }
        }
        cerr<<endl;
        move(dir, curPos[P]);};
            
        }
        
    
    
    }
}




