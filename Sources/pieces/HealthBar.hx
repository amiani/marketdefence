package pieces;

import kha.math.FastVector2;
import kha.math.FastMatrix3;

class HealthBar extends Node {
	public function new(position:FastVector2, maxHealth:Int, parent:Node) {
		super(parent, position);
		this.maxHealth = maxHealth;
		this.health = maxHealth;
		this.length = 1;
	}

	private var length : Int;
	public var health : Int;
	public var maxHealth : Int;

	override public function update(dt:Float, ?parentWorldMatrix) {
		if (parentWorldMatrix == null) {
			worldMatrix.setFrom(localMatrix);
		} else {
			var translation = FastMatrix3.identity();
			translation._20 = parentWorldMatrix._20;
			translation._21 = parentWorldMatrix._21;
			//TODO: extract scaling
			worldMatrix = translation.multmat(localMatrix);
		}
		for (child in children) {
			child.update(dt, worldMatrix);
		}
	}

	override public function draw(g) {
		super.draw(g);
		g.pushTransformation(g.transformation.multmat(worldMatrix));
		g.color = 0xff00ff00;
		g.drawLine(0, 0, length*health/maxHealth, 0, .05);
		g.popTransformation();
	}
}