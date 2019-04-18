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
	private var world : B2World;

	public function new(position: FastVector2, parent:Node, world:B2World) {
		super(position, parent, world, STATIC_BODY);
		base = new Sprite(Assets.images.turret1, 64, 48, 35, 65, this);
		gun = new Sprite(Assets.images.turret1, 28, 54, 52, 3, this);
		gun.origin = new FastVector2(gun.width/2, gun.height);
		radar = new Radar(b2body, this);
		this.world = world;
	}

	private var target : Body;
	private var cooldownTimer = 0.;
	override public function update(dt, ?parentWorldMatrix) {
		cooldownTimer += dt;
		if (target == null || !target.isActive()) {
			target = radar.getClosest();
		}

		orient();
		fire();

		super.update(dt, parentWorldMatrix);
	}

	private var gunAngle = 0.;
	private function orient() {
		if (target == null || !target.isActive()) {
			gun.angle = 0.;
		} else {
			gunAngle = Math.atan2(-(target.position.x-position.x), target.position.y-position.y);
			gun.angle = gunAngle;
			trace(gunAngle);
		}
	}

	private function fire() {
		if (target != null && cooldownTimer >= 1) {
			new Laser(position, angle, parent, world);
			cooldownTimer = 0;
		}
	}
}