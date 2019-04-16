import box2D.dynamics.B2Body;
import box2D.dynamics.B2FixtureDef;

class Radar {
	public function new(b2body:B2Body) {
		var vertices = [for (k in 0...8) new B2Vec2(8*Math.cos(2*k*Math.PI/14), 8*Math.sin(2*k*Math.PI/14))];
		var semiCircleShape = B2PolygonShape.asVector(vertices, 8);
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
}