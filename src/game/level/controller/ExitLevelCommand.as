package game.level.controller {
import game.level.arena.battlefield.model.IBattlefieldModel;
import game.level.arena.enemies.model.IEnemiesModel;
import game.level.arena.interactions.model.IPlayerVsEnemyInteractionModel;
import game.level.arena.player.model.IPlayerModel;

import org.robotlegs.mvcs.StarlingCommand;

public class ExitLevelCommand extends StarlingCommand {

	[Inject]
	public var battleFieldModel:IBattlefieldModel;
	[Inject]
	public var playerVsEnemyInteractionModel:IPlayerVsEnemyInteractionModel;
	[Inject]
	public var playerModel:IPlayerModel;
	[Inject]
	public var enemiesModel:IEnemiesModel;

	override public function execute():void {
		battleFieldModel.destroy();
		playerModel.destroy();
		enemiesModel.destroy();
		playerVsEnemyInteractionModel.destroy();
	}

}
}