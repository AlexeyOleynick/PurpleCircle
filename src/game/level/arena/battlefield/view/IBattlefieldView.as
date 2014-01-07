package game.level.arena.battlefield.view {
import flash.geom.Point;

import game.core.view.ISpriteContainer;

public interface IBattlefieldView extends ISpriteContainer{
	function addContainer(container:ISpriteContainer):void;
	function addDribble(point:Point):void;
}
}
