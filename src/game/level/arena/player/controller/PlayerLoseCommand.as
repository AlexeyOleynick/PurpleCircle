package game.level.arena.player.controller {
import game.core.model.IContextModel;
import game.level.arena.battlefield.model.IBattlefieldModel;
import game.level.gameover.view.IGameOverView;

import org.robotlegs.mvcs.StarlingCommand;

import starling.display.DisplayObject;

public class PlayerLoseCommand extends StarlingCommand {

	[Inject]
	public var battleFieldModel:IBattlefieldModel;
	[Inject]
	public var contextModel:IContextModel;
	[Inject]
	public var gameOverView:IGameOverView;


	override public function execute():void {
		battleFieldModel.stop();
		gameOverView.victory = false;
		contextView.addChild(gameOverView.getStarlingSprite());
	}


}
}