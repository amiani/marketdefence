import kha.graphics2.Graphics;
import kha.math.FastMatrix3;
import kha.math.FastVector2;

class Node {
  static var lastId = 0;
  public var id(default, null) : Int;
  public var scale = 1.;

  public function new(parent:Node, ?position:FastVector2, ?priority: Int) {
    this.id = ++lastId;
    this.children = new Array<Node>();
    this.parent = parent;
    this.priority = priority == null ? 1 : priority;
    this.accumulatedPriority = priority;
    this.position = position == null ? new FastVector2() : position;
    linearVelocity = new FastVector2();
    angularVelocity = 0;
    angle = 0;
  }

  public var children(default, null) : Array<Node>;
  public var parent(default, set) : Node;
  public function set_parent(newParent:Node):Node {
    if (parent != null) {
      var index = parent.children.indexOf(this);
      if (index != -1)
        parent.children.splice(index, 1);
    }
    if (newParent != null) newParent.children.push(this);
    return parent = newParent;
  }

  public function update(dt:Float, ?parentWorldMatrix:FastMatrix3) {
    if (parentWorldMatrix == null) {
      worldMatrix.setFrom(localMatrix);
    } else {
      worldMatrix = parentWorldMatrix.multmat(localMatrix);
    }
    for (child in children) {
      child.update(dt, worldMatrix);
    }
    accumulatedPriority += priority;
  }
  
  public function draw(g:Graphics) {
    for (child in children) {
      child.draw(g);
    }
  }

  @:isVar public var position(get, set) : FastVector2;
  public function get_position() {
    return position;
  }
  private function set_position(p:FastVector2) {
    return position = p;
  }

  @:isVar public var linearVelocity(get, set) : FastVector2;
  public function get_linearVelocity() {
    return linearVelocity;
  }
  private function set_linearVelocity(v:FastVector2) {
    return linearVelocity = v;
  }

  @:s @:isVar public var angularVelocity(get, set) : Float;
  private function get_angularVelocity() {
    return angularVelocity;
  }
  private function set_angularVelocity(o:Float) {
    return angularVelocity = o;
  }

  @:s @:isVar public var angle(get, set) : Float;
  private function get_angle() {
    return angle;
  }
  private function set_angle(a:Float) {
    return angle = a;
  }

  private var worldMatrix = FastMatrix3.identity();
  private var localMatrix(get, never) : FastMatrix3;
  private function get_localMatrix() {
    return FastMatrix3.translation(position.x, position.y)
      .multmat(FastMatrix3.scale(scale, scale))
      .multmat(FastMatrix3.rotation(angle));
  }

  public function check():Bool {
    var av :Null<Float> = angularVelocity;
    var an : Null<Float> = angle;
    if (position == null || linearVelocity == null || av == null || an == null)
      return false;
    return true;
  }

  public var priority(default, null) : Int;
  public var accumulatedPriority(default, null) : Int;
  public inline function resetAccumulatedPriority() {
    accumulatedPriority = priority;
  }
}