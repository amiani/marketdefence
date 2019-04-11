import kha.Assets;
import kha.math.FastVector2;
import box2D.dynamics.B2World;
import box2D.common.math.B2Vec2;

class Invader extends Body {
	var sprite : Sprite;

	public function new(position:FastVector2, parent:Node, world:B2World) {
		super(position, parent, world, DYNAMIC_BODY);
		sprite = new Sprite(Assets.images.invadera, 64, 64, this);
		angle = Math.PI;
	}

	override private function updateBody(dt:Float) {
		b2body.applyForce(b2body.getWorldVector(new B2Vec2(0, 1)), b2body.getWorldCenter());
	}
}