package game.level.model {
import flash.geom.Point;

import nape.geom.Vec2;
import nape.phys.Body;
import nape.phys.BodyType;

import org.casalib.events.RemovableEventDispatcher;

public class Unit extends RemovableEventDispatcher {
	protected var body:Body;


	public function getBody():Body {
		return body;
	}

	public function getRadius():Number {
		return getBody().shapes.at(0).castCircle.radius;
	}

	public function setRadius(radius:Number):Number {
		return getBody().shapes.at(0).castCircle.radius = radius;
	}

	public function getArea():Number {
		return getBody().shapes.at(0).castCircle.area;
	}

	public function getX():Number {
		return getBody().position.x;
	}

	public function getY():Number {
		return getBody().position.y;
	}

	public function getRotation():Number {
		return getBody().rotation;
	}

	public function getVelocity():Point {
		return getBody().velocity.toPoint();
	}

	override public function destroy():void {
		getBody().cbTypes.clear();
		delete getBody().userData.model;
		getBody().space = null;
		super.destroy();
	}

	public function getPosition():Vec2 {
		return getBody().position;
	}

	public function setForce(force:Vec2):void {
		if (getBody().type == BodyType.DYNAMIC)
			getBody().force = force;
	}

}
}