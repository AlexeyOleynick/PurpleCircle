package game.level.arena.enemies.view {
import game.core.view.ISpriteContainer;
import game.level.units.UnitView;

public interface IEnemiesContainer extends ISpriteContainer {
	function addEnemyGraphics(enemyGraphics:UnitView):void;

	function removeEnemyGraphics(enemyView:UnitView):void;
}
}
