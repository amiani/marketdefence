import kha.math.FastVector2;
import kha.FastFloat;
import kha.graphics2.Graphics;
import box2D.dynamics.B2World;
import box2D.common.math.B2Vec2;

class Laser extends Body {
	public function new(position:FastVector2, angle:FastFloat, parent:Node, world:B2World) {
		super(position, parent, world, KINEMATIC_BODY);
		this.angle = angle;
		this.linearVelocity = new FastVector2(5*Math.cos(angle), 5*Math.sin(angle));
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