import kha.Framebuffer;
import kha.Assets;

enum GameState {
	Stopped;
	Paused;
	Running;
}

class Game {
	var width : Int;
	var height : Int;

	var background : Background;
	var screen : Screen;
	var market : Market;
	var scene = new Node(null);
	var TIMESTEP = 1/60;

	public function new(width:Int, height:Int) {
		this.width = width;
		this.height = height;
		initScene();
	}

	public function update() : Void {
		scene.update(TIMESTEP);
	}

	public function draw(frames:Array<Framebuffer>) : Void {
		var frameBuffer = frames[0];
		if (frameBuffer.width != width || frameBuffer.height != height) {
      width = frameBuffer.width;
      height = frameBuffer.height;
    }

    var g = frameBuffer.g2;
    g.begin();
		g.pushTransformation(g.transformation.multmat(screen.matrix));
		scene.draw(g);
    //background.draw(g, width, height);
    //scene.draw(g, worldToScreen);
		g.popTransformation();
    g.end();
	}

	function initScene() {
		//background = new Background(Assets.images.goldstartile, width, height);
		screen = new Screen(height, height*2);
		market = new Market(scene, height);
	}
}