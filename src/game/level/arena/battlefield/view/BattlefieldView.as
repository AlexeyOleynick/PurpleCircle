package game.level.arena.battlefield.view {
import flash.geom.Point;

import game.core.view.ISpriteContainer;

import starling.display.Sprite;
import starling.events.Event;

public class BattlefieldView extends Sprite implements IBattlefieldView{
	public var unitContainer:Sprite;

	private var dribbleSpeedX:Number = 0;
	private var dribbleSpeedY:Number = 0;

	private static const DRIBBLE_POWER:Number = 50;
	private static const DRIBBLE_ELASTICITY:Number = 0.8;
	private static const DRIBBLE_STRENGTH:Number = 0.5;

	public function BattlefieldView() {
		unitContainer = new Sprite();
		addChild(unitContainer);

		addEventListener(Event.ENTER_FRAME, enterFrameListener);
		addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageListener);
	}

	private function enterFrameListener(e:Event):void {
		dribbleSpeedX = dribbleSpeedX * DRIBBLE_ELASTICITY - x * DRIBBLE_STRENGTH;
		x += dribbleSpeedX;

		dribbleSpeedY = dribbleSpeedY * DRIBBLE_ELASTICITY - y * DRIBBLE_STRENGTH;
		y += dribbleSpeedY;
	}


	public function addContainer(container:ISpriteContainer):void {
		addChild(container.getStarlingSprite());
	}

	public function addDribble(point:Point):void {
		dribbleSpeedX += -point.x * DRIBBLE_POWER;
		dribbleSpeedY += -point.y * DRIBBLE_POWER;
	}

	private function removedFromStageListener(event:Event):void {
		removeEventListener(Event.ENTER_FRAME, enterFrameListener);
		removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageListener);
	}


	public function getStarlingSprite():Sprite {
		return this;
	}
}
}