import kha.Assets;
import kha.math.FastVector2;
import box2D.dynamics.B2World;

class Invader extends Body {
	var sprite : Sprite;

	public function new(position:FastVector2, parent:Node, world:B2World) {
		super(position, parent, world, DYNAMIC_BODY);
		sprite = new Sprite(Assets.images.invadera, 512, 512, this);
		sprite.origin = new FastVector2(512/2, 512/2);
	}
}