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
  background(255);
  
  // Start Drawing in GL
  gl = ((PGraphicsOpenGL)g).beginGL();
  
  // Setup Inital Transform and Rotate a little (for fun)
  gl.glTranslatef(width / 2, height / 2, 0);
  gl.glScalef(200, 200, 200);
  
  // Start Drawing
  gl.glColor3f(0, 0, 0);
  drawUnit(4);
  
  // Stop Drawing in GL
  ((PGraphicsOpenGL)g).endGL();
}

// Please Edit Me
void drawShape()
{
  gl.glBegin(GL.GL_QUADS);
  gl.glVertex3f(-1, -1, 0);
  gl.glVertex3f( 1, -1, 0);
  gl.glVertex3f( 1,  1, 0);
  gl.glVertex3f(-1,  1, 0);
  gl.glEnd();
}

// Position and Scale Logic
void drawUnit(int iter)
{
  for(int i = 0; i < 8; i++){
    gl.glPushMatrix();
    gl.glTranslatef(xs[i] * 0.666666, ys[i] * 0.666666, 0);
    gl.glScalef(0.333333, 0.333333, 0.333333);
    if(iter > 0)
      drawUnit(iter - 1);
    else
      drawShape();
    gl.glPopMatrix();
  }
}
