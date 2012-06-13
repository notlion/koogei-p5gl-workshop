import processing.opengl.*;

// Import GL
import javax.media.opengl.*;
import com.sun.opengl.util.*;

void setup(){
  size(540, 540, OPENGL);
  
  // Generate Menger
  points = new ArrayList();
  points_goal = new ArrayList();
  genPoints(new PVector(), menger_scale, 2);
  
  // Generate Display List for a Cube
  beginGL();
  list_id = gl.glGenLists(1);           // Create a new Display List
  gl.glNewList(list_id, GL.GL_COMPILE); // Begin Recording
  GLUT glut = new GLUT();
  glut.glutSolidCube(11.11111111);      // Use GLUT Utility to draw a Cube
  gl.glEndList();                       // End Recording
  endGL();
}

// Our GL Object
GL gl;

// Our Display List ID
int list_id;

// Size of our Menger
float menger_scale = 150.0;

// Gravity Location
PVector grav_pnt;

void draw()
{
  float time = millis();
  
  // Cube Dynamics
  PVector pnt, pntg;
  PVector pnt_grav = noise3(time / 2000.0f);
  pnt_grav.mult(300);
  for(int i = points.size(); --i >= 0;){
    pnt = (PVector)points.get(i);
    pntg = (PVector)points_goal.get(i);
    // Goal
    pnt.add(
      (pntg.x - pnt.x) * 0.05,
      (pntg.y - pnt.y) * 0.05,
      (pntg.z - pnt.z) * 0.05
    );
    // Distortion
    if(frameCount % 1000 > 250){
      float r = lerp(10, 200, noise(time / 3000.0));
      float d = map(min(200, pnt.dist(pnt_grav)), 200, 0, 0, 0.2);
      pnt.add(
        (pnt.x - pnt_grav.x) * d,
        (pnt.y - pnt_grav.y) * d,
        (pnt.z - pnt_grav.z) * d
      );
    }
  }
  
  background(255);
  
  // Start Drawing in GL
  beginGL();
  
  // Setup Inital Transform and Rotate a little (for fun)
  PVector raxis = noise3(time / 5000.0);
  gl.glTranslatef(width / 2, height / 2, 0);
  gl.glRotatef(10, raxis.x, raxis.y, raxis.z);
  
  // Draw our Array of Points
  for(int i = points.size(); --i >= 0;){
    pnt = (PVector)points.get(i);
    
    // Set Color
    float gs = map(pnt.z, -menger_scale, menger_scale, 0.1, 0.9);
    gl.glColor3f(gs, gs, gs);
    
    // Draw our Display List
    gl.glPushMatrix();
    gl.glTranslatef(pnt.x, pnt.y, pnt.z);
    gl.glCallList(list_id);
    gl.glPopMatrix();
  }
  
  // Stop Drawing in GL
  endGL();
}
