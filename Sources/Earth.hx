import kha.math.FastVector2;
import box2D.dynamics.B2World;
import box2D.dynamics.B2FixtureDef;
import box2D.collision.shapes.B2PolygonShape;

class Earth extends Body {
	public static var category = 0x0003;
	public function new(width:Int, parent:Node, world:B2World) {
		super(new FastVector2(6, -3), parent, world, STATIC_BODY);
		var boxShape = B2PolygonShape.asBox(width/2, 3);
		var boxFixture = b2body.createFixture2(boxShape);
		boxFixture.setUserData(this);
	}
}