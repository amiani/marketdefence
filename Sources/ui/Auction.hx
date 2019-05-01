package ui;

import haxe.ui.core.Component;
import haxe.ui.core.UIEvent;
import haxe.ui.components.Button;

@:build(haxe.ui.macros.ComponentMacros.build('../Assets/ui/auction.xml', 'auction'))
class Auction extends Component {
	public static function make(props):Auction {
		var auction = new Auction();
		auction.buyButton.onClick = props.handleBuy;
		return auction;
	}

	public function new() super();
}