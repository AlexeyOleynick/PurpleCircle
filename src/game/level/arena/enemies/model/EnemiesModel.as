/**
 * Created by OOliinyk on 7/28/13.
 */
package game.level.arena.enemies.model {

import flash.geom.Point;

import game.level.model.Unit;
import game.level.model.UnitList;
import game.level.units.UnitEvent;

import org.robotlegs.mvcs.Actor;

public class EnemiesModel extends Actor implements IEnemiesModel {
	private var enemyList:UnitList;

	public function initialize():void {
		enemyList = new UnitList();
	}

	public function getEnemyList():UnitList {
		return enemyList;
	}

	public function generateEnemies(averageSize:Number, count:int):void {
		initialize();

		var minValue:Number = averageSize / 2;
		var maxValue:Number = averageSize * 2;

		for (var i:int = 0; i < count; i++) {
			var randomSize:Number = Math.random() * (maxValue - minValue) + minValue;
			var position:Point = new Point(Math.random() * 760, Math.random() * 625);
			var enemy:Enemy = new Enemy(position, randomSize);
			enemyList.add(enemy);
			dispatch(new UnitEvent(UnitEvent.ENEMY_CREATED, enemy));
		}
	}

	public function removeEnemy(enemy:Unit):void {
		enemyList.remove(enemy);
		dispatch(new UnitEvent(UnitEvent.ENEMY_REMOVED, enemy))
	}

	public function destroy():void {
		enemyList.destroyAllUnits();
	}

	public function kickEnemies():void {
		var enemies:Array = enemyList.getUnitsByClass(Enemy);
		for each(var enemy:Enemy in enemies) {
			enemy.randomKick();
		}
	}

	public function update():void {
		kickEnemies();
		for each(var enemy:Unit in enemyList.getUnitsByClass(Enemy)) {
			dispatch(new UnitEvent(UnitEvent.ENEMY_UPDATED, enemy))
		}
	}

}
}
