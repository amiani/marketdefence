import box2D.dynamics.B2ContactListener;
import box2D.dynamics.contacts.B2Contact;
import box2D.dynamics.B2Fixture;

class ContactListener extends B2ContactListener {
	override public function beginContact(contact:B2Contact) {
		var fixtureA = contact.getFixtureA();
		var fixtureB = contact.getFixtureB();
		if (fixtureA != null && fixtureB != null) {
			var bodyA = cast(fixtureA.getBody().getUserData(), Body);
			var bodyB = cast(fixtureB.getBody().getUserData(), Body);
			bodyA.handleBeginContact(bodyB);
			bodyB.handleBeginContact(bodyA);
		}
	}

	override public function endContact(contact:B2Contact) {
		var fixtureA = contact.getFixtureA():
		var fixtureB = contact.getFixtureA();
		if (fixtureA != null && fixtureB != null) {
			var bodyA = cast(fixtureA, Body);
			var bodyB = cast(fixtureB, Body);
			bodyA.handleEndContact(bodyB);
			bodyB.handleEndContact(bodyA);
		}
	}
}