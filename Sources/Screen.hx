import kha.input.Mouse;
import Utils.clamp;

class Screen {
  public var position(default, null) = new Vec2(0, 0);
  var screenHeight : Int;
  var worldHeight : Int;
  
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
    trace(position.y);
  }
}