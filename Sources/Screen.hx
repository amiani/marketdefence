import kha.input.Mouse;
import Utils.clamp;
import kha.math.FastMatrix3;
import kha.math.FastVector2;

class Screen {
  public var position(default, null) = new FastVector2(0, 0);
  var screenHeight : Int;
  var worldHeight : Int;
  public var matrix(get, never) : FastMatrix3;
  
  public function new(screenHeight : Int, worldHeight: Int) {
    this.screenHeight = screenHeight;
    this.worldHeight = worldHeight;
    Mouse.get().notify(null, null, null, handleWheel);
  }

  public function onResize(screenWidth : Float, screenHeight : Float) {
  }

  function handleWheel(delta:Int):Void {
    position.y += delta*50;
    position.y = clamp(position.y, 0, worldHeight - screenHeight);
  }

  function get_matrix() {
    return FastMatrix3.translation(position.x, position.y);
  }
}