import processing.opengl.*;

// Import GL
import javax.media.opengl.*;

void setup(){
  size(540, 540, OPENGL);
  
  points = new ArrayList();
  genPoints(new PVector(), menger_scale, 3);
}

// Our GL Object
GL gl;

// Size of our Menger
float menger_scale = 200.0;

void draw()
{
  background(255);
  
  // Start Drawing in GL
  gl = ((PGraphicsOpenGL)g).beginGL();
  
  // Setup Inital Transform and Rotate a little (for fun)
  gl.glTranslatef(width / 2, height / 2, 0);
  gl.glRotatef(10, noi(10), noi(20), noi(30));
  
  // Store Parameters for Noise
  float noise_time = millis() / 1000.0;
  float noise_freq = 0.005;
  
  // Enable Subtractive Blending
  gl.glEnable(GL.GL_BLEND);
  gl.glBlendFunc(GL.GL_ZERO, GL.GL_SRC_COLOR);
  
  // Disable Depth Testing
  gl.glDisable(GL.GL_DEPTH_TEST);
  
  // Draw our Array of Points
  gl.glColor3f(0, 0, 0);
  PVector pnt;
  for(int i = points.size(); --i >= 0;){
    pnt = (PVector)points.get(i);
    
    // Calculate Noise
    float noi = noise(pnt.x * noise_freq, pnt.y * noise_freq, noise_time);
    
    // Set Color
    gl.glColor3f(abs(pnt.x / menger_scale), abs(pnt.y / menger_scale), noi);
    
    // Draw Circle
    gl.glPointSize(sq(noi) * 50);
    gl.glBegin(GL.GL_POINTS);
    gl.glVertex3f(pnt.x, pnt.y, pnt.z + (noi - 0.5) * 200);
    gl.glEnd();
  }
  
  // Stop Drawing in GL
  ((PGraphicsOpenGL)g).endGL();
}
