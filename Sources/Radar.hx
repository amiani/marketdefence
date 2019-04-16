import haxe.ds.IntMap;
import kha.FastFloat;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2FixtureDef;
import box2D.common.math.B2Vec2;
import box2D.collision.shapes.B2PolygonShape;

class Radar extends Node {
	public static var category = 0x0002;

	public function new(b2body:B2Body, parent:Node) {
		super(parent);
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

	public var detectedEnemies(default, null) = new IntMap<Body>();
	
	public function getClosest():Body {
		var closestEnemy:Body = null;
		var closestEnemyDistance:FastFloat = 999999;
		for (enemy in detectedEnemies.iterator()) {
			var enemyDistance = enemy.position.sub(position).length;
			if (enemyDistance < closestEnemyDistance) {
				closestEnemy = enemy;
				closestEnemyDistance = enemyDistance;
				trace('got new target: '+enemy.id);
			}
		}
		return closestEnemy;
	}
}