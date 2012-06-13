// Cache Points to avoid Push/Pop
void genPoints(PVector pos, float _scale, int iter)
{
  for(int i = 0; i < 8; i++){
    PVector nx_pos = new PVector(
      pos.x + _scale * xs[i] * 0.666666,
      pos.y + _scale * ys[i] * 0.666666
    );
    if(iter > 0)
      genPoints(nx_pos, _scale * 0.333333, iter - 1);
    else
      points.add(nx_pos);
  }
}

// Simple Time Based Noise Function for Rotation
float noi(float x){
  return noise(millis() / 5000.0, x) * 2.0 - 1.0;
}

// Point Data
float xs[] = new float[]{ -1,  0,  1,  1,  1,  0, -1, -1 };
float ys[] = new float[]{ -1, -1, -1,  0,  1,  1,  1,  0 };

ArrayList points;
