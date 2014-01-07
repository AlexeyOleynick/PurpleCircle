/**
 * Created by OOliinyk on 7/28/13.
 */
package game.level.arena.interactions.controller {
import game.level.arena.battlefield.model.IBattlefieldModel;
import game.level.arena.interactions.model.IPlayerVsEnemyInteractionModel;

import nape.callbacks.InteractionListener;

import org.robotlegs.mvcs.StarlingCommand;

public class CreatePlayerVsEnemyInteractionCommand extends StarlingCommand {

	[Inject]
	public var battlefieldModel:IBattlefieldModel;
	[Inject]
	public var playerVsEnemyModel:IPlayerVsEnemyInteractionModel;

	override public function execute():void {
		var interactions:Vector.<InteractionListener> = playerVsEnemyModel.getInteractionList();
		battlefieldModel.addInteractions(interactions);
	}
}
}
