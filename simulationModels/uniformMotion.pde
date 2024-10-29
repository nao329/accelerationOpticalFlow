float fr;
//半径ピクセル
int r;
//角速度θ/s^2
float w;
//速度 ピクセル/フレーム
float v;
int preX;
int preY;
float preVx;
float preVy;
float preAx;
float preAy;
int preFrame;

// データを保存するためのPrintWriter
PrintWriter output;

void setup() {
  frameRate(60);
  size(500, 500);
  fr = 0;
  v = 1.0;
  r = 200;
  w = v / r;
  preX = (int)(r * cos(w));
  preY = (int)(r * sin(w));
  preVx = -v * sin(w);
  preVy = v * cos(w);
  preAx = 0;
  preAy = 0;
  preFrame = 0;

  // ファイルを開く
  output = createWriter("uniform_motion_withNoEdit_analysis3.csv");

  // CSVのヘッダーを書き込む
  output.println("Frame,X,Y,Vx,Vy,Ax,Ay,TheoX,TheoY,TheoVx,TheoVy,TheoAx,TheoAy");
}

void draw() {
  int x, y;
  float Vx, Vy, Ax, Ay;

  w = v / r;

  background(0);
  fr += 1.0;

  // 現在のフレーム数
  int currentFrame = frameCount;

  // 位置の計算（整数値）
  x = (int)(r * cos(w * fr));
  y = (int)(r * sin(w * fr));

  // フレーム間の時間
  float dt = (currentFrame - preFrame) / frameRate;

  if (dt > 0) {
    // 速度の計算
    Vx = (x - preX) / dt;
    Vy = (y - preY) / dt;

    // 加速度の計算
    Ax = (Vx - preVx) / dt;
    Ay = (Vy - preVy) / dt;
    // 速度の計算
    Vx = (x - preX);
    Vy = (y - preY);

    // 加速度の計算
    Ax = (Vx - preVx);
    Ay = (Vy - preVy);
  } else {
    Vx = 0;
    Vy = 0;
    Ax = 0;
    Ay = 0;
  }

  // 理論値の計算
  float TheoX = r * cos(w * fr);
  float TheoY = r * sin(w * fr);
  float TheoVx = -v * sin(w * fr);
  float TheoVy = v * cos(w * fr);
  float TheoAx = -v * w * cos(w * fr);
  float TheoAy = -v * w * sin(w * fr);

  // 物体の描画
  stroke(0);
  fill(255);
  ellipse(x + 250, y + 250, 50, 50);
  
  // 中心
  fill(100);
  ellipse(250, 250, 10, 10);

  //// 速度ベクトルの描画
  //stroke(0, 255, 0);
  //strokeWeight( 3 );
  //line(x + 250, y + 250, x + 250 + Vx * 10, y + 250 + Vy * 10);

  //// 加速度ベクトルの描画
  //stroke(255, 0, 0);
  //line(x + 250, y + 250, x + 250 + Ax * 10, y + 250 + Ay * 10);

  // デバッグ情報のCSV書き込み
  output.println(currentFrame + "," + x + "," + y + "," + Vx + "," + Vy + "," + Ax + "," + Ay + "," + TheoX + "," + TheoY + "," + TheoVx + "," + TheoVy + "," + TheoAx + "," + TheoAy);

  // 次のフレームのために現在の値を保存
  preX = x;
  preY = y;
  preVx = Vx;
  preVy = Vy;
  preFrame = currentFrame;
  
  if (frameCount <= 1000) {
    saveFrame("frames/uniformMotionWithNoEdit/####.png");
  }
}

void keyPressed() {
  // 任意のキーを押したらファイルを閉じる
  output.close();
  println("CSVファイルへの書き込みが完了しました。");
  exit();
}
