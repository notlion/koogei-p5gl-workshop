import processing.opengl.*;

// Import GL
import javax.media.opengl.*;

void setup(){
  size(540, 540, OPENGL);
  
  points = new ArrayList();
  genPoints(new PVector(), 200, 4);
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
  gl.glRotatef(10, noi(10), noi(20), noi(30));
  
  // Draw our Array of Points
  gl.glColor3f(0, 0, 0);
  gl.glPointSize(2);
  gl.glBegin(GL.GL_POINTS);
  PVector pnt;
  for(int i = points.size(); --i >= 0;){
    pnt = (PVector)points.get(i);
    gl.glVertex3f(pnt.x, pnt.y, pnt.z);
  }
  gl.glEnd();
  
  // Stop Drawing in GL
  ((PGraphicsOpenGL)g).endGL();
}
