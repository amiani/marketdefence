import kha.Image;
import kha.math.FastMatrix3;
import kha.math.FastVector2;
import kha.graphics2.Graphics;

class Sprite extends Node {
  public var image(default, null) : Image;
  public var width(default, null) : Int;
  public var height(default, null) : Int;
  public var origin : FastVector2 = new FastVector2();
  public var sx(default, null) : Int;
  public var sy(default, null) : Int;
  var visible = true;

  public function new(image : Image, width: Int, height:Int, sx:Int=0, sy:Int=0, parent:Node) {
    super(parent);
    this.image = image;
    this.width = width;
    this.height = height;
    this.sx = sx;
    this.sy = sy;
    this.origin = new FastVector2(width/2, height/2);
  }

	override public function draw(g: Graphics) {
		if (image != null && visible) {
      g.pushTransformation(g.transformation
        .multmat(worldMatrix)
        .multmat(FastMatrix3.scale(1/Game.worldScale, -1/Game.worldScale)));
      trace(worldMatrix);
      g.color = 0xffffffff;
      g.drawScaledSubImage(image, sx, sy, width, height, -origin.x, -origin.y, width*scale, height*scale);
      g.popTransformation();
			//g.drawScaledSubImage(image, Std.int(animation.get() * w) % image.width, Math.floor(animation.get() * w / image.width) * h, w, h, Math.round(x - collider.x * scaleX), Math.round(y - collider.y * scaleY), width, height);
		}
    super.draw(g);
  }
}