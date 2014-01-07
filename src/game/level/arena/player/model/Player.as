package game.level.arena.player.model {
import flash.geom.Point;
import flash.utils.Timer;

import game.level.model.*;

import nape.callbacks.CbType;
import nape.geom.Vec2;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Circle;

public class Player extends Unit {

	public static const PLAYER_TYPE:CbType = new CbType();
	private var powerTimer:Timer;

	public function Player(size:int) {
		body = new Body(BodyType.DYNAMIC);
		body.userData.model = this;
		var circleShape:Circle = new Circle(size);
		body.shapes.add(circleShape);
		body.cbTypes.add(PLAYER_TYPE);
		body.position.x = 100;
		body.position.y = 100;

		powerTimer = new Timer(20, 100);
	}

	public function startToConsumePower():void {
		powerTimer.start();
	}

	public function getCurrentPower():Number {
		return powerTimer.currentCount / 100;
	}


	override public function destroy():void {
		powerTimer.stop();
		super.destroy();
	}

	public function releasePower(directionVector:Point):void {
		var x:Number = directionVector.x;
		var y:Number = directionVector.y;
		if (getBody().type == BodyType.DYNAMIC) {
			var power:Number = getCurrentPower();
			var maxPower:int = 500;
			var massRelatedPower:int = maxPower * getBody().mass;
			setRadius(getRadius() * (1 - power / 10));
			getBody().applyImpulse(new Vec2(x * power * massRelatedPower, y * power * massRelatedPower));
		}
		powerTimer.reset();
	}

}
}