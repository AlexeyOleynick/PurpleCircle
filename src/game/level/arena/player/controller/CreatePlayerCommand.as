/**
 * Created by OOliinyk on 7/28/13.
 */
package game.level.arena.player.controller {
import game.level.arena.battlefield.model.IBattlefieldModel;
import game.level.arena.player.model.IPlayerModel;

import org.robotlegs.mvcs.StarlingCommand;

public class CreatePlayerCommand extends StarlingCommand {

	[Inject]
	public var playerModel:IPlayerModel;
	[Inject]
	public var battlefieldModel:IBattlefieldModel;

	override public function execute():void {
		playerModel.createPlayer(20);
		battlefieldModel.addUnit(playerModel.getPlayer());
	}
}
}
