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
  
  // Set GL Draw Color
  gl.glColor3f(1, 0, 0);
  
  // Draw Simple Rotating Square
  gl.glTranslatef(width / 2, height / 2, 0);
  gl.glScalef(100, 100, 100);
  gl.glRotatef(frameCount, 0, 0, 1);
  gl.glBegin(GL.GL_QUADS);
  gl.glVertex3f(-1, -1, 0);
  gl.glVertex3f( 1, -1, 0);
  gl.glVertex3f( 1,  1, 0);
  gl.glVertex3f(-1,  1, 0);
  gl.glEnd();
  
  // Stop Drawing in GL
  ((PGraphicsOpenGL)g).endGL();
}
