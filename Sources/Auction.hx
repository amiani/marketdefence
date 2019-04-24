import haxe.ui.core.Component;
import haxe.ui.components.HBox;
import haxe.ui.core.UIEvent;
import haxe.ui.components.Button;
import haxe.ui.macros.ComponentMacros;

class Auction extends HBox {
	private var handleBuy : UIEvent->Void;
	public function new(handleBuy:UIEvent->Void) {
		super();
		this.handleBuy = handleBuy;
	}

	private var buyButton : Button;
	override private function initialize() {
		super.initialize();
		buyButton = findChild('buy', Button);
		buyButton.onClick = handleBuy;
	}
}