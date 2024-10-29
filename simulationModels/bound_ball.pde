float x, y;    //ボールのy座標
float velX = 20.0;    //ボールのx軸の初速
float velY = 0.0;    //ボールのy軸の初速
float gravity = 9.8;    //ボールにかかる重力
float reaction = 0.7;    //ボールの反発力
float damp = 0.7;    //摩擦による減衰
float dt = 0.1;


void setup() {
  size(400, 400);
  background(0);
  noStroke();
  fill(0);
  x = y = 0.0;  //x, yを0.0で初期化
}

void draw() {
  //フェードする時はtrue、しない場合はfalse
  fade(false);
  //noStroke();

  stroke(255);
  fill(255);
  ellipse(x, y, 50,50);    //ボールを描く
  strokeWeight( 5 );

  //line(x, y, x, y + gravity);

  velY += gravity * dt;    //スピードに重力が加算される

  x += velX * dt;
  y += velY * dt;

  if (frameCount <= 1000) {
    saveFrame("frames/bound_ball/####.jpg");
  }
  
  //ボールが画面の横幅を超えたら反対の向きになる
  if (x+25 > width || x < 0) velX = -velX;

  if (y > height-25) {    //もしボールが画面の下まで落ちたら、
    velY *= -reaction;    //反発力によって上に上がる
    velX *= damp;    //velXを減衰
    y = height-25;    //ボールは画面の外に外れない
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
