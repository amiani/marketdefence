import kha.Image;
import kha.graphics2.Graphics;
import kha.math.FastMatrix3;

class Background {
	public var image : Image;

	public function new(image:Image, screenWidth:Int, screenHeight:Int) {
		this.image = image;
	}

	public function draw(g:Graphics, width, height) {
		var cols = Math.ceil(width / image.width);
		var rows = Math.ceil(height / image.height);
		g.pushTransformation(FastMatrix3.scale(1/Game.worldScale, 1/Game.worldScale));
		g.color = 0xffffffff;
		for (i in -1...rows) for (j in 0...cols) {
			g.drawImage(image, j * image.width, i * image.height);
		}
		g.popTransformation();
	}
}