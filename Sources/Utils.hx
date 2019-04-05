class Utils {
	inline public static function clamp(value:Float, min:Float, max:Float) {
		return value > max ? max : value < min ? min : value;
	}
}