#include "ofMain.h"
#include "ofApp.h"

int main(){
	//ofSetupOpenGL(1024,768,OF_FULLSCREEN);			// <-------- setup the GL context
	ofAppiOSWindow * window = new ofAppiOSWindow();
    window->enableRetina();
    window->enableAntiAliasing(4); //fixed smoothing
	window->enableDepthBuffer();
	ofSetupOpenGL(window, 1024, 768, OF_FULLSCREEN);
	ofRunApp(new ofApp());
}
