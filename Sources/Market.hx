import haxe.ui.Toolkit;
import haxe.ui.components.Button;
//import haxe.ui.events.UIEvent;
import haxe.ui.macros.ComponentMacros;
import haxe.ui.core.Component;
import kha.math.FastVector2;

class Market extends Node {
	var main : Component;

	public function new(parent:Node, height:Int) {
		super(parent);
		position.setFrom(new FastVector2(0, height/2));
		main = ComponentMacros.buildComponent('../Assets/ui/market.xml');
		main.ready();
	}

	override public function draw(g) {
		main.renderTo(g);
		super.draw(g);
	}
}