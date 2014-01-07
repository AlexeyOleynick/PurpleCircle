package game.level.arena.enemies.model {
import flash.geom.Point;

import game.level.model.*;

import nape.callbacks.CbType;
import nape.geom.Vec2;
import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Circle;

import org.casalib.util.NumberUtil;

public class Enemy extends Unit {

	public static const ENEMY_TYPE:CbType = new CbType();

	public function Enemy(position:Point, size:int) {
		body = new Body(BodyType.DYNAMIC);
		body.position = Vec2.fromPoint(position);
		var enemyShape:Circle = new Circle(size);
		body.shapes.add(enemyShape);
		body.userData.model = this;
		body.cbTypes.add(ENEMY_TYPE);
	}

	public function randomKick():void {
		var randomDirectionX:Number = NumberUtil.randomWithinRange(-1, 1);
		var randomDirectionY:Number = (1 - Math.abs(randomDirectionX)) * (Math.random() > 0.5 ? 1 : -1);
		var power:Number = NumberUtil.randomWithinRange(0, 0.3);

		var maxPower:int = 200;
		var massRelatedPower:int = maxPower * getBody().mass;

		if (Math.random() > 0.99)
			getBody().applyImpulse(new Vec2(randomDirectionX * power * massRelatedPower, randomDirectionY * power * massRelatedPower));
	}


}
}