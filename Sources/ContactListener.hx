import box2D.dynamics.B2ContactListener;
import box2D.dynamics.contacts.B2Contact;
import box2D.dynamics.B2Fixture;
import box2D.dynamics.B2World;
import haxe.rtti.Rtti;
import haxe.ds.StringMap;
import pieces.*;

class ContactListener extends B2ContactListener {
	private var world : B2World;
	private var bodiesToRemove : Array<Body>;

	public function new(world:B2World) {
		super();
		this.world = world;
		initializeContactMaps();
	}

	private var contactBeginMap : StringMap<Body->Body->Void>;
	private var contactEndMap : StringMap<Body->Body->Void>;
	private function initializeContactMaps() {
		contactBeginMap = new StringMap<Body->Body->Void>();
		contactBeginMap.set('InvaderLaserTurret', invaderTurretBegin);
		contactBeginMap.set('LaserTurretInvader', (t, i) -> invaderTurretBegin(i, t));
		contactBeginMap.set('InvaderEarth', invaderEarthBegin);
		contactBeginMap.set('EarthInvader', (e, i) -> invaderEarthBegin(i, e));
		contactBeginMap.set('InvaderRadar', invaderRadarBegin);
		contactBeginMap.set('RadarInvader', (r, i) -> invaderRadarBegin(i, r));
		contactBeginMap.set('InvaderLaser', invaderLaserBegin);
		contactBeginMap.set('LaserInvader', (l, i) -> invaderLaserBegin(i, l));

		contactEndMap = new StringMap<Body->Body->Void>();
		/*
		contactEndMap.set('InvaderLaserTurret', invaderTurretEnd);
		contactEndMap.set('LaserTurretInvader', (t, i) -> invaderTurretEnd(i, t));
		contactEndMap.set('InvaderEarth', invaderEarthEnd);
		contactEndMap.set('EarthInvader', (e, i) -> invaderEarthEnd(i, e));
		*/
		contactEndMap.set('InvaderRadar', invaderRadarEnd);
		contactEndMap.set('RadarInvader', (r, i) -> invaderRadarEnd(i, r));
	}

	private var r = ~/(\w+\.)*(\w+)/g;
	override public function beginContact(contact:B2Contact) {
		var fixtureA = contact.getFixtureA();
		var fixtureB = contact.getFixtureB();
		if (fixtureA != null && fixtureB != null) {
			var parentA = fixtureA.getUserData();
			var parentB = fixtureB.getUserData();
			var nameA = Type.getClassName(Type.getClass(parentA));
			var nameB = Type.getClassName(Type.getClass(parentB));
			r.match(nameA);
			nameA = r.matched(2);
			r.match(nameB);
			nameB = r.matched(2);
			var contactHandler = contactBeginMap.get(nameA+nameB);
			if (contactHandler != null)
				contactHandler(parentA, parentB);
			else
				unknownCollision(parentA, parentB);
		}
	}

	override public function endContact(contact:B2Contact) {
		var fixtureA = contact.getFixtureA();
		var fixtureB = contact.getFixtureB();
		if (fixtureA != null && fixtureB != null) {
			var parentA = fixtureA.getUserData();
			var parentB = fixtureB.getUserData();
			var nameA = Type.getClassName(Type.getClass(parentA));
			var nameB = Type.getClassName(Type.getClass(parentB));
			r.match(nameA);
			nameA = r.matched(2);
			r.match(nameB);
			nameB = r.matched(2);
			var contactHandler = contactEndMap.get(nameA+nameB);
			if (contactHandler != null)
				contactHandler(parentA, parentB);
			else
				unknownCollision(parentA, parentB);
		}
	}

	private function invaderTurretBegin(invader:Body, turret:Body) {
		trace('invader hit turret');
	}

	private function invaderEarthBegin(invader:Body, earth:Body) {
		invader.remove();
		//TODO: lose health
	}

	private function invaderRadarBegin(invader:Body, radar:Body) {
		trace('invaderRadarBegin');
		cast(radar, Radar).detectedEnemies.set(invader.id, invader);
	}

	private function invaderRadarEnd(invader:Body, radar:Body) {
		trace('invaderRadarEnd');
		cast(radar, Radar).detectedEnemies.remove(invader.id);
	}

	private function invaderLaserBegin(invader:Body, laserB:Body) {
		var laser = cast(laserB, Laser);
		cast(invader, Invader).dealDamage(laser.damage);
		laser.remove();
	}

	private function unknownCollision(bodyA:Body, bodyB:Body) {

	}
}