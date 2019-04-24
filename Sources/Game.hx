import haxe.Constraints.Constructible;
import kha.Framebuffer;
import kha.Assets;
import kha.math.FastVector2;
import box2D.dynamics.B2World;
import box2D.dynamics.B2Body;
import box2D.common.math.B2Vec2;

enum GameState {
	Stopped;
	Paused;
	Running;
}

class Game {
	var width : Int;
	var height : Int;

	public function new(width:Int, height:Int) {
		this.width = width;
		this.height = height;
		initScene();
	}

	var TIMESTEP = 1/60;

	public function update() : Void {
		scene.update(TIMESTEP);
		world.step(TIMESTEP, 8, 3);
		world.clearForces();
		for (b in bodiesToRemove) {
			world.destroyBody(b);
		}
		bodiesToRemove.resize(0);
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
		world.drawDebugData();
		debugDraw.draw(g);
		scene.draw(g);
    //background.draw(g, width, height);
		g.popTransformation();
    g.end();
	}

	var camera : Camera;
	var world : B2World;
	public static var worldScale = 64;
	var debugDraw : DebugDraw;
	public static var bodiesToRemove = new Array<B2Body>();
	var contactListener : ContactListener;
	var background : Background;
	var market : Market;
	var scene = new Node(null);
	var earth : Earth;
	var invaderLayer : Node;
	var spawner : Spawner<Invader>;
	var laserTurret : LaserTurret;

	function initScene() {
		camera = new Camera(height, height*2);
		world = new B2World(new B2Vec2(0, 0), true);
		debugDraw = new DebugDraw(camera);
		debugDraw.setFlags(box2D.dynamics.B2DebugDraw.e_shapeBit);
		//world.setDebugDraw(debugDraw);
		contactListener = new ContactListener(world);
		world.setContactListener(contactListener);

		//background = new Background(Assets.images.goldstartile, width, height);
		market = new Market(scene, height, camera);

		earth = new Earth(12, scene, world);
		invaderLayer = new Node(scene);
		spawner = new Spawner<Invader>(new FastVector2(4, 17), invaderLayer, world, invaderLayer);
		laserTurret = new LaserTurret(new FastVector2(12/2, 0), scene, world);
	}
}