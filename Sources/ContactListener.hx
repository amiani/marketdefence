import box2D.dynamics.B2ContactListener;
import box2D.dynamics.contacts.B2Contact;
import box2D.dynamics.B2Fixture;

class ContactListener extends B2ContactListener {
	override public function beginContact(contact:B2Contact) {
		var fixtureA = contact.getFixtureA();
		var fixtureB = contact.getFixtureB();
		if (fixtureA != null && fixtureB != null) {
			var handlersA = fixtureA.getUserData();
			var handlersB = fixtureB.getUserData();
			handlersA.handleBeginContact(fixtureB);
			handlersB.handleBeginContact(fixtureA);
		}
	}

	override public function endContact(contact:B2Contact) {
		var fixtureA = contact.getFixtureA();
		var fixtureB = contact.getFixtureA();
		if (fixtureA != null && fixtureB != null) {
			var handlersA = fixtureA.getUserData();
			var handlersB = fixtureB.getUserData();
			handlersA.handleEndContact(fixtureB);
			handlersB.handleEndContact(fixtureA);
		}
	}
}