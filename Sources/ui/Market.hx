package ui;

import haxe.ui.Toolkit;
import haxe.ui.components.Button;
import haxe.ui.components.Label;
import haxe.ui.core.UIEvent;
import haxe.ui.macros.ComponentMacros;
import haxe.ui.core.Component;
import kha.math.FastVector2;
import kha.math.FastMatrix3;
import kha.graphics2.Graphics;
import haxe.ui.containers.VBox;
import kha.Image;

class Market extends Node {
	private var main : Component;
	private var camera : Camera;
	private var height : Int;
	private var onBuy : String->Void;

	public function new(parent:Node, height:Int, onBuy, camera:Camera) {
		super(parent);
		this.camera = camera;
		this.height = height;
		this.onBuy = onBuy;
		main = ComponentMacros.buildComponent('../Assets/ui/market.xml', Vbox);
		creditsLabel = main.findComponent('playerCredits', Label);
		var auction = Auction.make({ handleBuy: handleBuy });
		main.addComponent(auction);
		main.ready();
	}

	private var creditsLabel : Label;
	override public function update(dt:Float, ?parentWorldMatrix) {
		super.update(dt, parentWorldMatrix);
		creditsLabel.text = 'Credits: ' + playerCredits;
	}

	override public function draw(g:Graphics) {
		g.pushTransformation(g.transformation
			.multmat(worldMatrix)
			.multmat(FastMatrix3.scale(1/Game.worldScale, -1/Game.worldScale)));
		main.renderTo(g);
		g.popTransformation();
		super.draw(g);
	}

	public var playerCredits(default, null) = 120;

	private function handleBuy(e:UIEvent) {
		onBuy('LaserTurret');
	}
}