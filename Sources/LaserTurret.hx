import kha.Assets;
import kha.math.FastVector2;
import box2D.dynamics.B2World;
import box2D.common.math.B2Vec2;
import box2D.collision.shapes.B2PolygonShape;
import box2D.dynamics.B2FixtureDef;
import box2D.dynamics.B2Fixture;
import haxe.ds.IntMap;

class LaserTurret extends Body {
	private var gun : Sprite;
	private var base : Sprite;
	private var semiCircleShape : B2PolygonShape;
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
		radarFixtureDef.userData = { handleBeginContact: handleBeginRadarContact, handleEndContact: handleEndRadarContact };
		radarFixtureDef.filter.categoryBits = category;
		radarFixtureDef.filter.maskBits = Invader.category;
		b2body.createFixture(radarFixtureDef);
	}

	private var enemiesInRange = new IntMap<Body>();
	private var target : Body;
	override public function update(dt, ?parentWorldMatrix) {
		
		super.update(dt, parentWorldMatrix);
	}

	public function handleBeginRadarContact(contacted:B2Fixture) {
		if (contacted.isSensor()) return;

		var contactedBody = cast(contacted.getBody().getUserData(), Body);
		enemiesInRange.set(contactedBody.id, contactedBody);
	}

	public function handleEndRadarContact(uncontacted:B2Fixture) {
		if (uncontacted.isSensor()) return;

		var uncontactedBody = cast(uncontacted.getBody().getUserData(), Body);
		enemiesInRange.remove(uncontactedBody.id);
	}
}