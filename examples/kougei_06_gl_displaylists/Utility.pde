// Begin and End drawing to OpenGL
void beginGL(){
  gl = ((PGraphicsOpenGL)g).beginGL();
}
void endGL(){
  ((PGraphicsOpenGL)g).endGL();
}

// Cache Points to avoid Push/Pop
void genPoints(PVector pos, float _scale, int iter)
{
  for(int i = 0; i < 20; i++){
    PVector nx_pos = new PVector(
      pos.x + _scale * xs[i] * 0.666666,
      pos.y + _scale * ys[i] * 0.666666,
      pos.z + _scale * zs[i] * 0.666666
    );
    if(iter > 0){
      genPoints(nx_pos, _scale * 0.333333, iter - 1);
    }
    else{
      points.add(nx_pos);
      points_goal.add(nx_pos.get());
    }
  }
}

// Simple 3d Noise Function
PVector noise3(float time){
  return new PVector(
    noise(time, 333.3) * 2.0 - 1.0,
    noise(time, 666.6) * 2.0 - 1.0,
    noise(time, 999.9) * 2.0 - 1.0
  );
}

// Point Data
float xs[] = new float[]{ -1,  0,  1,  1,  1,  0, -1, -1,
                          -1,      1,      1,     -1,
                          -1,  0,  1,  1,  1,  0, -1, -1 };
float ys[] = new float[]{ -1, -1, -1,  0,  1,  1,  1,  0,
                          -1,     -1,      1,      1,
                          -1, -1, -1,  0,  1,  1,  1,  0 };
float zs[] = new float[]{ -1, -1, -1, -1, -1, -1, -1, -1,
                           0,      0,      0,      0,
                           1,  1,  1,  1,  1,  1,  1,  1 };

ArrayList points, points_goal;
