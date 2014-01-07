/**
 * Created by OOliinyk on 7/28/13.
 */
package game.level.arena.player.controller {
import game.level.arena.battlefield.model.IBattlefieldModel;
import game.level.arena.player.model.IPlayerModel;
import game.level.gameover.view.IGameOverView;

import org.robotlegs.mvcs.StarlingCommand;

import starling.display.DisplayObject;

public class PlayerWonCommand extends StarlingCommand {

	[Inject]
	public var battlefieldModel:IBattlefieldModel;
	[Inject]
	public var playerModel:IPlayerModel;
	[Inject]
	public var gameOverView:IGameOverView;

	override public function execute():void {
		playerModel.freeze();
		battlefieldModel.stop();
		gameOverView.victory = true;
		contextView.addChild(gameOverView.getStarlingSprite());
	}
}
}
