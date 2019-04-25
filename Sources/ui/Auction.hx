package ui;

import haxe.ui.core.Component;
import haxe.ui.core.UIEvent;
import haxe.ui.components.Button;

@:build(haxe.ui.macros.ComponentMacros.build('../Assets/ui/auction.xml', 'auction'))
class Auction extends Component {
	public function new() {
		super();
	}

	public var onBuy(default, set) : UIEvent->Void;
	private function set_onBuy(handler:UIEvent->Void) {
		buyButton.onClick = handler;
		return handler;
	}
}