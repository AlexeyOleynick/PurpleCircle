/**
 * Created by OOliinyk on 7/24/13.
 */
package game.level.arena.enemies.view {
import flash.events.Event;
import flash.utils.Dictionary;

import game.core.model.IConfigurationModel;
import game.core.model.ITextureService;
import game.event.GameEvent;
import game.level.arena.battlefield.model.IBattlefieldModel;
import game.level.arena.enemies.model.IEnemiesModel;
import game.level.model.Unit;
import game.level.units.UnitEvent;
import game.level.units.UnitView;

import org.robotlegs.mvcs.StarlingMediator;

public class EnemiesMediator extends StarlingMediator {

	[Inject]
	public var view:IEnemiesContainer;
	[Inject]
	public var battleFieldModel:IBattlefieldModel;
	[Inject]
	public var textureService:ITextureService;
	[Inject]
	public var configurationModel:IConfigurationModel;
	[Inject]
	public var enemiesModel:IEnemiesModel;

	private var enemyViews:Dictionary;


	override public function onRegister():void {
		addContextListener(UnitEvent.ENEMY_CREATED, enemyCreatedListener);
		addContextListener(UnitEvent.ENEMY_UPDATED, enemyUpdatedListener);
		addContextListener(UnitEvent.ENEMY_REMOVED, enemyRemovedListener);
		addContextListener(Event.ENTER_FRAME, enterFrameListener);
		addContextListener(GameEvent.EXIT_LEVEL, removeEnemies);
		enemyViews = new Dictionary();
	}

	private function enterFrameListener(event:Event):void {
		enemiesModel.update();
	}

	private function removeEnemies(event:GameEvent):void {
		enemyViews.length = 0;
		view.removeFromParent(true);
		mediatorMap.removeMediator(this);
	}

	private function enemyCreatedListener(event:UnitEvent):void {
		var unit:Unit = event.unit;
		createEnemyGraphics(unit);
	}

	private function createEnemyGraphics(enemy:Unit):void {
		var enemyGraphics:UnitView = new UnitView(textureService);

		enemyViews[enemy] = enemyGraphics;
		view.addEnemyGraphics(enemyGraphics);
		updateEnemyGraphics(enemy);
	}

	private function enemyRemovedListener(event:UnitEvent):void {
		var unit:Unit = event.unit;
		view.removeEnemyGraphics(enemyViews[unit]);
		delete enemyViews[unit];
	}

	private function enemyUpdatedListener(event:UnitEvent):void {
		var unit:Unit = event.unit;
		updateEnemyGraphics(unit);
	}

	private function updateEnemyGraphics(unit:Unit):void {
		var graphics:UnitView = enemyViews[unit];
		graphics.rotation = unit.getRotation();
		graphics.x = unit.getX();
		graphics.y = unit.getY();
		graphics.redraw(unit.getRadius(), configurationModel.getUnitColor(unit));
	}
}
}
