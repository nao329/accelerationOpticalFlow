float y = 0.0;    //ボールのy座標
float velocity = 0.0;    //ボールの初速
float gravity = 9.8;    //ボールにかかる重力
float reaction = 0.7;    //ボールの反発力
float dt = 0.1;

void setup() {
  size(400, 400);
  background(0);
  fill(255);
}

void draw() {
  noStroke();
  //フェードする時はtrue、しない場合はfalse
  fade(false);

  velocity += gravity * dt;    //スピードに重力が加算される
  y += velocity * dt;    //ボールにスピードが設定される

  if (y > height) {    //もしボールが画面の下まで落ちたら、
    velocity *= -reaction;    //反発力によって上に上がる
    y = height;    //ボールは画面の外に外れない
  }
  fill(255);
  ellipse(width/2, y-25, 50, 50);    //ボールを描く
  if (frameCount <= 1000) {
    saveFrame("frames/####.png");
  }
}

//フェード用関数
void fade(boolean _fadeFlag) {
  if (_fadeFlag) {
    fill(255, 10);  //透明度のあるrectを描画
    rect(0, 0, width, height);
    fill(255);
  } else {
    background(0);
  }
}
