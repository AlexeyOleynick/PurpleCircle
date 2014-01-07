package {
import game.core.controller.StartupCommand;
import game.core.model.ConfigurationModel;
import game.core.model.ContextModel;
import game.core.model.IConfigurationModel;
import game.core.model.IContextModel;
import game.core.model.ITextureService;
import game.core.model.TextureService;
import game.core.view.IStatsBgView;
import game.core.view.StatsBgView;
import game.event.GameEvent;
import game.level.arena.battlefield.model.BattlefieldModel;
import game.level.arena.battlefield.model.IBattlefieldModel;
import game.level.arena.battlefield.view.BattlefieldMediator;
import game.level.arena.battlefield.view.BattlefieldMediator;
import game.level.arena.battlefield.view.BattlefieldView;
import game.level.arena.battlefield.view.IBattlefieldView;
import game.level.arena.enemies.controller.CreateEnemiesCommand;
import game.level.arena.enemies.model.EnemiesModel;
import game.level.arena.enemies.model.IEnemiesModel;
import game.level.arena.enemies.view.EnemiesMediator;
import game.level.arena.enemies.view.EnemyContainer;
import game.level.arena.enemies.view.IEnemiesContainer;
import game.level.arena.interactions.controller.CreatePlayerVsEnemyInteractionCommand;
import game.level.arena.interactions.model.IPlayerVsEnemyInteractionModel;
import game.level.arena.interactions.model.PlayerVsEnemyInteractionModel;
import game.level.arena.interactions.view.AbsorberContainer;
import game.level.arena.interactions.view.AbsorbersMediator;
import game.level.arena.interactions.view.IAbsorberContainer;
import game.level.arena.player.controller.CreatePlayerCommand;
import game.level.arena.player.controller.PlayerLoseCommand;
import game.level.arena.player.controller.PlayerWonCommand;
import game.level.arena.player.model.IPlayerModel;
import game.level.arena.player.model.PlayerModel;
import game.level.arena.player.view.IPlayerContainer;
import game.level.arena.player.view.PlayerContainer;
import game.level.arena.player.view.PlayerMediator;
import game.level.controller.BackToLobbyCommand;
import game.level.controller.ExitLevelCommand;
import game.level.controller.RestartLevelCommand;
import game.level.controller.StartLevelCommand;
import game.level.controls.view.ControlsMediator;
import game.level.controls.view.ControlsView;
import game.level.controls.view.IControlsView;
import game.level.gameover.view.GameOverMediator;
import game.level.gameover.view.GameOverView;
import game.level.gameover.view.IGameOverView;
import game.startup.controller.ShowStartScreenCommand;
import game.startup.view.IStartScreenView;
import game.startup.view.StartScreenMediator;
import game.startup.view.StartScreenView;

import org.robotlegs.base.ContextEvent;
import org.robotlegs.mvcs.StarlingContext;

import starling.core.Starling;
import starling.display.DisplayObjectContainer;

public class RobotlegsAppContext extends StarlingContext {
	public function RobotlegsAppContext(contextView:DisplayObjectContainer = null, autoStartup:Boolean = true) {
		super(contextView, autoStartup);
	}

	override public function startup():void {
		commandMap.mapEvent(ContextEvent.STARTUP_COMPLETE, StartupCommand, ContextEvent);
		commandMap.mapEvent(GameEvent.SHOW_START_SCREEN, ShowStartScreenCommand);
		commandMap.mapEvent(GameEvent.START_LEVEL, StartLevelCommand, GameEvent);
		commandMap.mapEvent(GameEvent.EXIT_LEVEL, ExitLevelCommand, GameEvent);
		commandMap.mapEvent(GameEvent.RESTART_LEVEL, RestartLevelCommand, GameEvent);
		commandMap.mapEvent(GameEvent.BACK_TO_LOBBY, BackToLobbyCommand, GameEvent);
		commandMap.mapEvent(GameEvent.CREATE_ENEMIES, CreateEnemiesCommand, GameEvent);
		commandMap.mapEvent(GameEvent.CREATE_PLAYER, CreatePlayerCommand, GameEvent);
		commandMap.mapEvent(GameEvent.CREATE_PLAYER_VS_ENEMY_INTERACTION, CreatePlayerVsEnemyInteractionCommand, GameEvent);
		commandMap.mapEvent(GameEvent.PLAYER_LOSE, PlayerLoseCommand, GameEvent);
		commandMap.mapEvent(GameEvent.PLAYER_WON, PlayerWonCommand, GameEvent);

		mapViewClassToInterface(BattlefieldMediator, IBattlefieldView, BattlefieldView);
		mapViewClassToInterface(StartScreenMediator, IStartScreenView, StartScreenView);
		mapViewClassToInterface(ControlsMediator, IControlsView, ControlsView);
		mapViewClassToInterface(GameOverMediator, IGameOverView, GameOverView);
		mapViewClassToInterface(AbsorbersMediator, IAbsorberContainer, AbsorberContainer);
		mapViewClassToInterface(PlayerMediator, IPlayerContainer, PlayerContainer);
		mapViewClassToInterface(EnemiesMediator, IEnemiesContainer, EnemyContainer);

		injector.mapClass(IStatsBgView, StatsBgView);

		injector.mapSingletonOf(IBattlefieldModel, BattlefieldModel);
		injector.mapSingletonOf(IEnemiesModel, EnemiesModel);
		injector.mapSingletonOf(IPlayerModel, PlayerModel);
		injector.mapSingletonOf(IConfigurationModel, ConfigurationModel);
		injector.mapSingletonOf(ITextureService, TextureService);
		injector.mapSingletonOf(IPlayerVsEnemyInteractionModel, PlayerVsEnemyInteractionModel);

		var contextModel:ContextModel = new ContextModel(contextView);
		injector.mapValue(IContextModel, contextModel);
		injector.injectInto(contextModel);

		Starling.current.showStatsAt("middle");

		super.startup();
	}

	private function mapViewClassToInterface(mediatorClass:Class ,whenAskedForClass:Class, instantiateClass:Class):void {
		mediatorMap.mapView(instantiateClass, mediatorClass, whenAskedForClass);
		injector.mapClass(whenAskedForClass, instantiateClass);
	}

}
}