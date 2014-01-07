/**
 * Created by OOliinyk on 7/28/13.
 */
package game.level.arena.enemies.controller {
import game.level.arena.battlefield.model.IBattlefieldModel;
import game.level.arena.enemies.model.IEnemiesModel;

import org.robotlegs.mvcs.StarlingCommand;

public class CreateEnemiesCommand extends StarlingCommand {

	[Inject]
	public var enemiesModel:IEnemiesModel;
	[Inject]
	public var battlefieldModel:IBattlefieldModel;

	override public function execute():void {
		enemiesModel.generateEnemies(20, 20);
		battlefieldModel.addUnits(enemiesModel.getEnemyList());
	}
}
}
