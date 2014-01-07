/**
 * Created by OOliinyk on 7/23/13.
 */
package game.level.arena.player.view {
import game.core.view.ISpriteContainer;

import starling.display.Sprite;

public class PlayerContainer extends Sprite implements IPlayerContainer{
	public function PlayerContainer() {
		super();
	}


	public function removePlayerGraphics(playerView:PlayerView):void {
		super.removeChild(playerView);
	}

	public function addPlayerGraphics(playerView:PlayerView):void {
		super.addChild(playerView);
	}

	public function getStarlingSprite():Sprite {
		return this;
	}
}
}
