import haxe.ui.Toolkit;
import haxe.ui.components.Button;
import haxe.ui.core.UIEvent;
import haxe.ui.macros.ComponentMacros;
import haxe.ui.core.Component;
import kha.math.FastVector2;
import kha.math.FastMatrix3;
import kha.graphics2.Graphics;
import haxe.ui.containers.VBox;
import kha.Image;

class Market extends Node {
	var main : Component;
	var camera : Camera;
	var height : Int;

	public function new(parent:Node, height:Int, camera:Camera) {
		super(parent);
		this.camera = camera;
		this.height = height;
		position.setFrom(new FastVector2(0, height));
		main = ComponentMacros.buildComponent('../Assets/ui/market.xml', Vbox);
		var button:Button = main.findComponent('testButton', Button);
		button.onClick = (e:UIEvent) -> trace('hello');
		main.ready();
	}

	override public function draw(g:Graphics) {
		g.pushTransformation(g.transformation.multmat(screenMatrix));
		main.renderTo(g);
		g.popTransformation();
		super.draw(g);
	}
}