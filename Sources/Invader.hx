import kha.Assets;
import kha.math.FastVector2;
import box2D.dynamics.B2World;

class Invader extends Body {
	var sprite : Sprite;

	public function new(position:FastVector2, parent:Node, world:B2World) {
		super(position, parent, world, DYNAMIC_BODY);
		sprite = new Sprite(Assets.images.invadera, 64, 64, this);
		linearVelocity = new FastVector2(0, 1);
	}
}