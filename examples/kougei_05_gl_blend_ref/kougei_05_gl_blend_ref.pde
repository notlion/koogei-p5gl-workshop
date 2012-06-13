import processing.opengl.*;

// Import GL
import javax.media.opengl.*;

void setup(){
  size(540, 540, OPENGL);
}

// Our GL Object
GL gl;

void draw()
{
  background(map(sin(millis() / 1000.0), -1, 1, 32, 223));
  
  // Start Drawing in GL
  gl = ((PGraphicsOpenGL)g).beginGL();
  
  // Store Parameters for Noise
  float noise_time = millis() / 1000.0;
  float noise_freq = 0.005;
  
  // Disable Depth Testing and Enable Blending
  gl.glDisable(GL.GL_DEPTH_TEST);
  gl.glEnable(GL.GL_BLEND);
  
  // Subtractive Blending
  gl.glBlendFunc(GL.GL_ZERO, GL.GL_SRC_COLOR);
  gl.glPushMatrix();
  gl.glTranslatef(180, 180, 0.0);
  drawCircles(50);
  gl.glPopMatrix();
  
  // Additive Blending
  gl.glBlendFunc(GL.GL_SRC_COLOR, GL.GL_ONE);
  gl.glPushMatrix();
  gl.glTranslatef(360, 180, 0.0);
  drawCircles(50);
  gl.glPopMatrix();
  
  // Standard Blending
  gl.glBlendFunc(GL.GL_SRC_ALPHA, GL.GL_ONE_MINUS_SRC_ALPHA);
  gl.glPushMatrix();
  gl.glTranslatef(180, 360, 0.0);
  drawCircles(50);
  gl.glPopMatrix();
  
  // Invert Blending
  gl.glBlendFunc(GL.GL_ONE_MINUS_DST_COLOR, GL.GL_ZERO);
  gl.glPushMatrix();
  gl.glTranslatef(360, 360, 0.0);
  drawCircles(50);
  gl.glPopMatrix();
  
  // Stop Drawing in GL
  ((PGraphicsOpenGL)g).endGL();
}

float colors[] = new float[]{
  1.0, 0.0, 0.0,
  0.0, 1.0, 0.0,
  0.0, 0.0, 1.0
};

void drawCircles(float r)
{
  gl.glPushMatrix();
  gl.glRotatef(millis() / 20.0f, 0, 0, 1);
  for(int i = 0, c = 0; i < 3; i++){
    gl.glColor3f(colors[c], colors[c + 1], colors[c + 2]);
    gl.glRotatef(1.0 / 3.0 * 360.0, 0, 0, 1);
    drawCircle(r * 0.666666, 0, r, 64);
    c += 3;
  }
  gl.glPopMatrix();
}

void drawCircle(float x, float y, float r, int n)
{
  gl.glBegin(GL.GL_TRIANGLE_FAN);
  gl.glVertex2f(x, y);
  float time = millis() / 100.0;
  for(int i = 0; i < n; i++){
    float u  = i / (n - 1.0) * TWO_PI;
    float rr = r + r * sin(u * 5 + time) * sin(u * 2 - time / 2) * 0.1;
    gl.glVertex2f(x + rr * cos(u), y + rr * sin(u));
  }
  gl.glEnd();
}
