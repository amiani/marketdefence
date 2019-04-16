import box2D.dynamics.B2ContactListener;
import box2D.dynamics.contacts.B2Contact;
import box2D.dynamics.B2Fixture;
import box2D.dynamics.B2World;
import haxe.rtti.Rtti;
import haxe.ds.StringMap;

class ContactListener extends B2ContactListener {
	private var world : B2World;
	private var bodiesToRemove : Array<Body>;

	public function new(world:B2World, bodiesToRemove:Array<Body>) {
		super();
		this.world = world;
		this.bodiesToRemove = bodiesToRemove;
		initializeContactMap();
	}

	private var contactMap : StringMap<Body->Body->Void>;
	var bodyNames = ['Invader', 'LaserTurret', 'Earth', 'Radar'];
	private function initializeContactMap() {
		contactMap = new StringMap<Body->Body->Void>();
		contactMap.set('InvaderLaserTurret', invaderTurretBegin);
		contactMap.set('LaserTurretInvader', (t, i) -> invaderTurretBegin(i, t));
		contactMap.set('InvaderEarth', invaderEarthBegin);
		contactMap.set('EarthInvader', (e, i) -> invaderEarthBegin(i, e));
		contactMap.set('InvaderRadar', invaderRadarBegin);
		contactMap.set('RadarInvader', (r, i) -> invaderRadarBegin(i, r));
	}

	override public function beginContact(contact:B2Contact) {
		var fixtureA = contact.getFixtureA();
		var fixtureB = contact.getFixtureB();
		if (fixtureA != null && fixtureB != null) {
			var handlersA = fixtureA.getUserData();
			var handlersB = fixtureB.getUserData();
			var nameA = Type.getClassName(Type.getClass(handlersA));
			var nameB = Type.getClassName(Type.getClass(handlersB));
			var contactHandler = contactMap.get(nameA+nameB);
			if (contactHandler != null)
				contactHandler(handlersA, handlersB);
		}
	}

	override public function endContact(contact:B2Contact) {
		/*
		var fixtureA = contact.getFixtureA();
		var fixtureB = contact.getFixtureA();
		if (fixtureA != null && fixtureB != null) {
			var handlersA = fixtureA.getUserData();
			var handlersB = fixtureB.getUserData();
			handlersA.handleEndContact(fixtureB);
			handlersB.handleEndContact(fixtureA);
		}
		*/
	}

	private function invaderTurretBegin(invader:Body, turret:Body) {
		trace('invader hit turret');
	}

	private function invaderEarthBegin(invader:Body, earth:Body) {
		bodiesToRemove.push(invader);
		trace('destroyed invader');
		//TODO: lose health
	}

	private function invaderRadarBegin(invader:Body, radar:Body) {
		cast(radar, Radar).detectedEnemies.set(invader.id, invader);
	}
}