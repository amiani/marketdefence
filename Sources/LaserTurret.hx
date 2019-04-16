import kha.Assets;
import kha.math.FastVector2;
import box2D.dynamics.B2World;
import box2D.common.math.B2Vec2;
import box2D.collision.shapes.B2PolygonShape;
import box2D.dynamics.B2FixtureDef;
import box2D.dynamics.B2Fixture;

class LaserTurret extends Body {
	private var gun : Sprite;
	private var base : Sprite;
	private var radar : Radar;

	public function new(position: FastVector2, parent:Node, world:B2World) {
		super(position, parent, world, STATIC_BODY);
		base = new Sprite(Assets.images.turret1, 64, 48, 35, 65, this);
		gun = new Sprite(Assets.images.turret1, 28, 54, 52, 3, this);
		gun.origin = new FastVector2(gun.width/2, gun.height);
		radar = new Radar(b2body, this);
	}

	private var target : Body;
	override public function update(dt, ?parentWorldMatrix) {
		if (target == null || !target.isActive()) {
			target = radar.getClosest();
		}

		super.update(dt, parentWorldMatrix);
	}
}