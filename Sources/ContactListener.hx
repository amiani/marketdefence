import box2D.dynamics.B2ContactListener;
import box2D.dynamics.contacts.B2Contact;
import box2D.dynamics.B2Fixture;

class ContactListener extends B2ContactListener {
	override public function beginContact(contact:B2Contact) {
		var fixtureA = contact.getFixtureA();
		var fixtureB = contact.getFixtureA();
		var sensorA = fixtureA.isSensor();
		var sensorB = fixtureB.isSensor();
		if (sensorA || sensorB) {
			var bodyA = cast(fixtureA.getBody().getUserData(), Body);
			var bodyB = cast(fixtureB.getBody().getUserData(), Body);
			bodyA.handleBeginContact(bodyB);
			bodyB.handleBeginContact(bodyA);
		}
	}

	override public function endContact(contact:B2Contact) {
		var bodyAUserData = contact.getFixtureA().getBody().getUserData();
		var bodyBUserData = contact.getFixtureA().getBody().getUserData();
		if (bodyAUserData != null && bodyBUserData != null) {
			var bodyA = cast(bodyAUserData, Body);
			var bodyB = cast(bodyBUserData, Body);
			bodyA.handleEndContact(bodyB);
			bodyB.handleEndContact(bodyA);
		}
	}
	
	private function alertSensors(fixtureA:B2Fixture, fixtureB:B2Fixture) {

	}
}