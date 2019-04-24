import kha.math.FastVector2;
import kha.math.FastMatrix3;
import haxe.Constraints.Constructible;
import box2D.dynamics.B2World;

@:generic
class Spawner<InvaderType:Constructible<FastVector2->Node->B2World->Void>> extends Node {
	var invaders : Array<InvaderType>;
	var invaderLayer : Node;
	var world : B2World;

	public function new(position:FastVector2, invaderLayer:Node, world:B2World, parent:Node) {
		super(parent, position);
		this.world = world;
		this.invaderLayer = invaderLayer;
		this.invaders = new Array<InvaderType>();
	}

	var timer = 0.;
	override public function update(dt:Float, ?parentWorldMatrix:FastMatrix3) {
		super.update(dt, parentWorldMatrix);
		timer += dt;
		if (timer >= 4) {
			spawn();
		}
	}

	private function spawn() {
		var inv:InvaderType = new InvaderType(new FastVector2(position.x, position.y), invaderLayer, world);
		invaders.push(inv);
		timer -= 1;
	}
}