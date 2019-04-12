import kha.graphics2.Graphics;
import kha.graphics2.GraphicsExtension;
import kha.Color;
import kha.math.Vector2;
import kha.math.FastMatrix3;
import kha.Image;
import box2D.dynamics.B2DebugDraw;
import box2D.common.math.B2Vec2;
import box2D.common.B2Color;
import box2D.common.math.B2Transform;

class DebugDraw extends B2DebugDraw {
	private var image : Image;
	private var camera : Camera;
	public function new(camera) {
		super();
		this.camera = camera;
		image = Image.createRenderTarget(768, 1024);
	}

	public function draw(g:Graphics) {
		g.drawImage(image, 0, 0);
	}

	override public function drawPolygon(vertices:Array<B2Vec2>, vertexCount:Int, color:B2Color) : Void{
		var khaVertices = [for (v in vertices) new Vector2(v.x, v.y)];
		//image.g2.color = color;
		GraphicsExtension.drawPolygon(image.g2, 0, 0, khaVertices);
	}

	override public function drawSolidPolygon(vertices:Array <B2Vec2>, vertexCount:Int, color:B2Color) : Void{
		var khaVertices = [for (v in vertices) new Vector2(v.x, v.y)];
		image.g2.color = Color.Yellow;
		GraphicsExtension.fillPolygon(image.g2, 0, 0, khaVertices);
	}

	override public function drawCircle(center:B2Vec2, radius:Float, color:B2Color) : Void{
		image.g2.color = Color.Yellow;
		GraphicsExtension.drawCircle(image.g2, center.x * m_drawScale, center.y * m_drawScale, radius * m_drawScale);
	}
	
	override public function drawSolidCircle(center:B2Vec2, radius:Float, axis:B2Vec2, color:B2Color) : Void{
		image.g2.color = Color.Yellow;
		GraphicsExtension.fillCircle(image.g2, center.x * m_drawScale, center.y * m_drawScale, radius * m_drawScale);
	}
	
	override public function drawSegment(p1:B2Vec2, p2:B2Vec2, color:B2Color) : Void{
		image.g2.color = Color.Yellow;
		image.g2.drawLine(p1.x, p1.y, p2.x, p2.y);
	}

/*
	override public function drawTransform(xf:B2Transform) : Void{
		g.color = Color.Red;
		g.moveTo(xf.position.x * m_drawScale, xf.position.y * m_drawScale);
		g.lineTo((xf.position.x + m_xformScale*xf.R.col1.x) * m_drawScale, (xf.position.y + m_xformScale*xf.R.col1.y) * m_drawScale);
		
		g.color = Color.Green;
		g.moveTo(xf.position.x * m_drawScale, xf.position.y * m_drawScale);
		g.lineTo((xf.position.x + m_xformScale * xf.R.col2.x) * m_drawScale, (xf.position.y + m_xformScale * xf.R.col2.y) * m_drawScale);
	}
	*/

	override public function clear() {
		image.g2.clear();
		image.g2.pushTransformation(camera.matrix);
	}
}