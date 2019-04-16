import kha.math.FastVector2;
import kha.FastFloat;
import kha.graphics2.Graphics;
import box2D.dynamics.B2World;
import box2D.common.math.B2Vec2;

class Laser extends Body {
	public function new(position:FastVector2, angle:FastFloat, parent:Node, world:B2World) {
		super(position, parent, world, KINEMATIC_BODY);
		this.angle = angle;
	}

	override public function update(dt:Float, ?parentWorldMatrix) {
		b2body.applyForce(b2body.getWorldVector(new B2Vec2(0, 2)), b2body.getWorldCenter());
		super.update(dt, parentWorldMatrix);
	}

	private var length = .4;
	override public function draw(g:Graphics) {
		super.draw(g);
		g.pushTransformation(g.transformation.multmat(worldMatrix));
		g.color = 0xffff0000;
		g.drawLine(position.x, position.y-length/2, position.x, position.y+length/2, .1);
		g.popTransformation();
	}
}