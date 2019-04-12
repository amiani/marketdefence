import kha.Assets;
import kha.math.FastVector2;
import box2D.dynamics.B2World;
import box2D.common.math.B2Vec2;
import box2D.collision.shapes.B2PolygonShape;
import box2D.dynamics.B2FixtureDef;

class LaserTurret extends Body {
	var gun : Sprite;
	var base : Sprite;
	var semiCircleShape : B2PolygonShape;
	public static var category = 0x0002;

	public function new(position: FastVector2, parent:Node, world:B2World) {
		super(position, parent, world, STATIC_BODY);
		base = new Sprite(Assets.images.turret1, 64, 48, 35, 65, this);
		gun = new Sprite(Assets.images.turret1, 28, 54, 52, 3, this);
		gun.origin = new FastVector2(gun.width/2, gun.height);

		var vertices = [for (k in 0...8) new B2Vec2(8*Math.cos(2*k*Math.PI/14), 8*Math.sin(2*k*Math.PI/14))];
		semiCircleShape = B2PolygonShape.asVector(vertices, 8);
		var radarFixtureDef = new B2FixtureDef();
		radarFixtureDef.shape = semiCircleShape;
		radarFixtureDef.density = 1;
		radarFixtureDef.friction = .3;
		radarFixtureDef.isSensor = true;
		radarFixtureDef.userData = this;
		radarFixtureDef.filter.categoryBits = category;
		radarFixtureDef.filter.maskBits = Invader.category;
		b2body.createFixture(radarFixtureDef);
	}

	override public function update(dt, ?parentWorldMatrix) {
		
		super.update(dt, parentWorldMatrix);
	}
}