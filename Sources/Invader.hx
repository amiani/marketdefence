import kha.Assets;
import kha.math.FastVector2;
import box2D.dynamics.B2World;
import box2D.common.math.B2Vec2;
import box2D.dynamics.B2FixtureDef;
import box2D.dynamics.B2Fixture;
import box2D.collision.shapes.B2PolygonShape;

class Invader extends Body {
	var sprite : Sprite;
	public static var category = 0x0001;

	public function new(position:FastVector2, parent:Node, world:B2World) {
		super(position, parent, world, DYNAMIC_BODY);
		sprite = new Sprite(Assets.images.invadera, 64, 64, this);
		angle = Math.PI;
		var fixtureDef = new B2FixtureDef();
		fixtureDef.shape = B2PolygonShape.asBox(.5, .5);
		fixtureDef.friction = .3;
		fixtureDef.filter.categoryBits = category;
		fixtureDef.userData = this;
		b2body.createFixture(fixtureDef);
	}

	override private function updateBody(dt:Float) {
		b2body.applyForce(b2body.getWorldVector(new B2Vec2(0, 1)), b2body.getWorldCenter());
	}
}