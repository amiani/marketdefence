package pieces;

import kha.math.FastVector2;
import kha.FastFloat;
import kha.graphics2.Graphics;
import box2D.dynamics.B2World;
import box2D.common.math.B2Vec2;
import box2D.collision.shapes.B2PolygonShape;
import box2D.dynamics.B2FixtureDef;

class Laser extends Body {
	public var damage(default, null) = 1;
	public function new(position:FastVector2, angle:FastFloat, parent:Node, world:B2World) {
		super(position, parent, world, KINEMATIC_BODY);
		this.angle = angle;
		this.linearVelocity = new FastVector2(7*Math.cos(angle), 7*Math.sin(angle));
		var fixtureDef = new B2FixtureDef();
		fixtureDef.shape = B2PolygonShape.asBox(.035/2, length/2);
		fixtureDef.userData = this;
		fixtureDef.isSensor = true;
		b2body.createFixture(fixtureDef);
	}

	private var length = .4;
	override public function draw(g:Graphics) {
		super.draw(g);
		g.pushTransformation(g.transformation.multmat(worldMatrix));
		g.color = 0xffff0000;
		g.drawLine(-length/2, 0, length/2, 0, .035);
		g.popTransformation();
	}
}