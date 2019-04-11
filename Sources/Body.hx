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
    var bodyDef = new B2BodyDef();
    bodyDef.type = bodyType;
    bodyDef.position.set(position.x/Game.worldScale, position.y/Game.worldScale);
    bodyDef.linearDamping = 1;
    bodyDef.angularDamping = 3;
    b2body = world.createBody(bodyDef);
    super(parent, position);
  }

  override public function update(dt:Float, ?parentscreenMatrix) {
    super.update(dt, null);
  }

  override function get_position():FastVector2 {
    var b2pos = b2body.getPosition();
    return new FastVector2(b2pos.x*Game.worldScale, b2pos.y*Game.worldScale);
  }
  override function set_position(p:FastVector2):FastVector2 {
    b2body.setPosition(new B2Vec2(p.x/Game.worldScale, p.y/Game.worldScale));
    return p;
  }

  override function get_linearVelocity():FastVector2 {
    var b2LinVel = b2body.getLinearVelocity();
    return new FastVector2(b2LinVel.x, b2LinVel.y);
  }
  override function set_linearVelocity(v:FastVector2):FastVector2 {
    b2body.setLinearVelocity(new B2Vec2(v.x, v.y));
    return v;
  }

  override function get_angularVelocity() {
    return b2body.getAngularVelocity();
  }
  override function set_angularVelocity(o:Float) {
    b2body.setAngularVelocity(o);
    return o;
  }

  override function get_angle() {
    return b2body.getAngle();
  }
  override function set_angle(a:Float) {
    b2body.setAngle(a);
    return a;
  }
}