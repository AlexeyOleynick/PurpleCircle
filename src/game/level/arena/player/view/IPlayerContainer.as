package game.level.arena.player.view {
import game.core.view.ISpriteContainer;

public interface IPlayerContainer extends ISpriteContainer {
	function removePlayerGraphics(playerView:PlayerView):void;

	function addPlayerGraphics(playerView:PlayerView):void;
}
}
