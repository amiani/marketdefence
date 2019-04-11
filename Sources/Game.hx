import haxe.Constraints.Constructible;
import kha.Framebuffer;
import kha.Assets;
import kha.math.FastVector2;
import box2D.dynamics.B2World;
import box2D.common.math.B2Vec2;

enum GameState {
	Stopped;
	Paused;
	Running;
}

class Game {
	var width : Int;
	var height : Int;

	var background : Background;
	var camera : Camera;
	var market : Market;
	var scene = new Node(null);
	var world : B2World;
	public static var worldScale = 64;
	var spawner : Spawner<Invader>;
	var TIMESTEP = 1/60;
	//var layers = new Array<Node>();
	var invaderLayer : Node;

	public function new(width:Int, height:Int) {
		this.width = width;
		this.height = height;
		initScene();
	}

	public function update() : Void {
		scene.update(TIMESTEP);
		world.step(TIMESTEP, 8, 3);
		world.clearForces();
	}

	public function draw(frames:Array<Framebuffer>) : Void {
		var frameBuffer = frames[0];
		if (frameBuffer.width != width || frameBuffer.height != height) {
      width = frameBuffer.width;
      height = frameBuffer.height;
    }

    var g = frameBuffer.g2;
    g.begin();
		g.pushTransformation(g.transformation.multmat(camera.matrix));
		scene.draw(g);
    //background.draw(g, width, height);
		g.popTransformation();
    g.end();
	}

	function initScene() {
		//background = new Background(Assets.images.goldstartile, width, height);
		camera = new Camera(height, height*2);
		market = new Market(scene, height, camera);
		world = new B2World(new B2Vec2(0, 0), true);
		invaderLayer = new Node(scene);
		spawner = new Spawner<Invader>(new FastVector2(width/2, 0), invaderLayer, world, invaderLayer);
	}
}