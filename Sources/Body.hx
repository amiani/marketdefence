import kha.graphics2.Graphics;
import kha.math.FastVector2;
import box2D.collision.shapes.B2MassData;
import box2D.common.math.B2Vec2;
import box2D.dynamics.*;

class Body extends Node {
  var b2body : B2Body;

  public function new(
    position: FastVector2,
    parent: Node,
    world : B2World,
    bodyType : box2D.dynamics.B2BodyType 
  ) {
    super(parent);
    var bodyDef = new B2BodyDef();
    bodyDef.type = bodyType;
    trace(position);
    bodyDef.position.set(position.x/Game.worldScale, position.y/Game.worldScale);
    bodyDef.linearDamping = 1;
    bodyDef.angularDamping = 3;
    b2body = world.createBody(bodyDef);
  }

  override public function update(dt:Float, ?parentscreenMatrix) {
    super.update(dt);
  }

  override function get_position():FastVector2 {
    if (b2body == null)
      return super.get_position();
    else {
      var b2pos = b2body.getPosition();
      return new FastVector2(b2pos.x*Game.worldScale, b2pos.y*Game.worldScale);
    }
  }
  override function set_position(p:FastVector2):FastVector2 {
    if (b2body == null)
      super.set_position(p);
    else
      b2body.setPosition(new B2Vec2(p.x/Game.worldScale, p.y/Game.worldScale));
    return p;
  }

  override function get_linearVelocity():FastVector2 {
    if (b2body == null)
      return super.get_linearVelocity();
    else {
      var b2LinVel = b2body.getLinearVelocity();
      return new FastVector2(b2LinVel.x, b2LinVel.y);
    }
  }
  override function set_linearVelocity(v:FastVector2):FastVector2 {
    if (b2body == null)
      super.set_linearVelocity(v);
    else
      b2body.setLinearVelocity(new B2Vec2(v.x, v.y));
    return v;
  }

  override function get_angularVelocity() {
    if (b2body == null)
      return super.get_angularVelocity();
    else
      return b2body.getAngularVelocity();
  }
  override function set_angularVelocity(o:Float) {
    if (b2body == null)
      super.set_angularVelocity(o);
    else
      b2body.setAngularVelocity(o);
    return o;
  }

  override function get_angle() {
    if (b2body == null)
      return super.get_angle();
    else
      return b2body.getAngle();
  }
  override function set_angle(a:Float) {
    if (b2body == null)
      super.set_angle(a);
    else
      b2body.setAngle(a);
    return a;
  }
}