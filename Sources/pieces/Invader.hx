package pieces;

import kha.Assets;
import kha.math.FastVector2;
import box2D.dynamics.B2World;
import box2D.common.math.B2Vec2;
import box2D.dynamics.B2FixtureDef;
import box2D.collision.shapes.B2PolygonShape;

class Invader extends Body {
	private var sprite : Sprite;
	private var healthBar : HealthBar;
	public static var category = 0x0001;

	public function new(position:FastVector2, parent:Node, world:B2World) {
		super(position, parent, world, DYNAMIC_BODY);
		sprite = new Sprite(Assets.images.invadera, 64, 64, 0, 0, Math.PI/2, this);
		healthBar = new HealthBar(new FastVector2(-.5, .5), 3, this);
		angle = -Math.PI/2;
		var fixtureDef = new B2FixtureDef();
		fixtureDef.shape = B2PolygonShape.asBox(.5, .5);
		fixtureDef.friction = .3;
		fixtureDef.filter.categoryBits = category;
		fixtureDef.userData = this;
		b2body.createFixture(fixtureDef);
	}

	override public function update(dt:Float, ?parentWorldMatrix) {
		super.update(dt, parentWorldMatrix);
		if (healthBar.health > 0) {
			b2body.applyForce(b2body.getWorldVector(new B2Vec2(1, 0)), b2body.getWorldCenter());
		} else {
			remove();
		}
	}

	public function dealDamage(amt:Int) {
		healthBar.health -= amt;
	}
}