/**
 * Created by OOliinyk on 7/24/13.
 */
package game.level.arena.enemies.view {
import game.level.units.UnitView;

import starling.display.Sprite;

public class EnemyContainer extends Sprite implements IEnemiesContainer {
	public function EnemyContainer() {
		super();
	}


	public function addEnemyGraphics(enemyGraphics:UnitView):void {
		super.addChild(enemyGraphics);
	}

	public function removeEnemyGraphics(enemyView:UnitView):void {
		super.removeChild(enemyView, true);
	}


	public function getStarlingSprite():Sprite {
		return this;
	}
}
}
