import haxe.ui.core.Component;
import haxe.ui.core.UIEvent;
import haxe.ui.components.Button;

@:build(haxe.ui.macros.ComponentMacros.build('../Assets/ui/auction.xml', 'auction'))
class Auction extends Component {
	public function new() {
		super();
		buyButton.onClick = e->trace('hello');
		//this.handleBuy = handleBuy;
	}
}