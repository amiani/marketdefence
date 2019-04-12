class LaserTurret extends Body {
	var gun : Sprite;
	var base : Sprite;

	private function new(image:Image, parent:Node, world:B2World) {
		super(position, parent, world, STATIC_BODY);
		gun = new Sprite(Assets.images.turret1, 28, 54, 52, 3, this);
		base = new Sprite(Assets.images.turret1, 64, 48, 35, 65, this);
	}

	override public function update(dt, ?parentWorldMatrix) {
		super.update(dt, parentWorldMatrix);
	}
}