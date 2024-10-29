float dt = 0.1;      //時間
float y;             //オブジェクトのy座標
float mass = 10.1;   //オブジェクトの質量
float k = 0.3;       //ばねの強さ（ばね定数）
float damp = 0.97;   //摩擦による減衰率
float velY = 0.0;    //y方向のスピード
float accel = 0;     //加速度
float force = 0;     //ばねの反発力 
float originY;       //基準点


void setup() {
  size(400, 400);
  background(0);

  y = 0;             //開始時のオブジェクトのy座標は0
  originY = 200;  //ばねの長さは200
}

void draw() {
  //フェードする時はtrue、しない場合はfalse
  fade(false);

  stroke(100);
  line(width/2, 0, width/2, y);

  float distY = originY - y;  //基準点からの距離
  force = k * distY;    //ばねの力を計算（F = kx）
  accel = force / mass;            //重さによる加速度を計算
  velY = damp * (velY + accel/dt);      //摩擦による減衰を計算
  y += velY * dt;                       //オブジェクトを移動

  fill(255);
  stroke(255);
  ellipse(width/2, y, 40, 40);     //円を描画
  strokeWeight( 5 );
  if (frameCount <= 1000) {
    saveFrame("frames/bound_ball/####.png");
  }
  
}

//クリックで円の位置をマウスのy座標にする
void mousePressed() {
  y = mouseY;
} 

//フェード用関数
void fade(boolean _fadeFlag) {
  if (_fadeFlag) {
    stroke(255, 10);
    fill(255, 10);  //透明度のあるrectを描画
    rect(0, 0, width, height);
    fill(255);      //オブジェクトは黒
  } else {
    background(0);
  }
}
