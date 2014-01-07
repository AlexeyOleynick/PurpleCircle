package game.core.view {
import starling.display.Sprite;

public interface ISpriteContainer {
	function removeFromParent(dispose:Boolean = false):void;
	function getStarlingSprite():Sprite;
}
}
