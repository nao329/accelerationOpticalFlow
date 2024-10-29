float dt = 1;
float x, y;             //円の座標
float R = 220;          //回転半径
float rad = PI/4;  //スタート時の回転角
float angle_vel = 0.0;        //角速度
float gravity = 9.8;    //重力
float angle_accel;            //角加速度
float damp = 0.980;     //減衰率
int M = 10; // 質量
 
void setup() {
  size(400, 400);
  background(0);
  fill(255);
}
 
void draw() {
  noStroke();
  //フェードする時はtrue、しない場合はfalse
  fade(false);
 
  //Ma = (-1*重力/回転半径)*sin(角度)
  angle_accel = (-1*gravity/R)*sin(rad);
  angle_vel += angle_accel * dt;  //角速度を計算
  angle_vel *= damp;         //減衰率を計算
  rad += angle_vel * dt;          //角度に角速度を計算  
 
  //一番下は円の角度だと90度（-90度ではない。プログラムの場合はy方向が反対）。
  //ラジアンにすると0.5PIなので、計算結果に90度足している。
  x = R*cos(rad + 0.5*PI);
  y = R*sin(rad + 0.5*PI);
 
  stroke(100);
  line(width/2, 0, x + width/2, y);   //線
  noStroke();
  ellipse(x + width/2, y, 50, 50);      //円
  strokeWeight( 5 );
  //stroke( 255, 0, 0 );
  //line(x + width/2, y, x + width/2, y + gravity);
  if (frameCount <= 1000) {
    saveFrame("frames/single_loop_ball/####.png");
  }
}
 
//フェード用関数
void fade(boolean _fadeFlag) {
  if (_fadeFlag) {
    fill(255, 10);  //透明度のあるrectを描画
    rect(0, 0, width, height);
    fill(255);      //オブジェクトは黒
  } else {
    background(0);
  }
}
