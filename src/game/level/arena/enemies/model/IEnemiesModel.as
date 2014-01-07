package game.level.arena.enemies.model {
import game.level.model.Unit;
import game.level.model.UnitList;

public interface IEnemiesModel {
	function initialize():void;

	function getEnemyList():UnitList;

	function generateEnemies(averageSize:Number, count:int):void;

	function removeEnemy(enemy:Unit):void;

	function destroy():void;

	function kickEnemies():void;

	function update():void;
}
}
