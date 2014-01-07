package game.level.controller {
import flash.geom.Rectangle;

import game.core.model.IContextModel;
import game.event.GameEvent;
import game.level.arena.battlefield.model.IBattlefieldModel;
import game.level.arena.battlefield.view.IBattlefieldView;
import game.level.arena.enemies.view.IEnemiesContainer;
import game.level.arena.interactions.view.IAbsorberContainer;
import game.level.arena.player.view.IPlayerContainer;
import game.level.controls.view.IControlsView;

import org.robotlegs.mvcs.StarlingCommand;

import starling.display.DisplayObject;

public class StartLevelCommand extends StarlingCommand {

	[Inject]
	public var battleFieldModel:IBattlefieldModel;
	[Inject]
	public var contextModel:IContextModel;
	[Inject]
	public var controlsView:IControlsView;
	[Inject]
	public var battleFieldView:IBattlefieldView;
	[Inject]
	public var absorberContainer:IAbsorberContainer;
	[Inject]
	public var playerContainer:IPlayerContainer;
	[Inject]
	public var enemyContiner:IEnemiesContainer;

	override public function execute():void {


		battleFieldView.addContainer(enemyContiner);
		battleFieldView.addContainer(playerContainer);
		battleFieldView.addContainer(absorberContainer);

		contextView.addChild(battleFieldView.getStarlingSprite());
		contextView.addChild(controlsView.getStarlingSprite());

		var battleFieldArea:Rectangle = new Rectangle(0, 0);
		battleFieldArea.width = contextModel.getWidth();
		battleFieldArea.height = contextModel.getHeight();
		battleFieldModel.initialize(battleFieldArea);

		dispatch(new GameEvent(GameEvent.CREATE_ENEMIES));
		dispatch(new GameEvent(GameEvent.CREATE_PLAYER));
		dispatch(new GameEvent(GameEvent.CREATE_PLAYER_VS_ENEMY_INTERACTION));

	}


}
}