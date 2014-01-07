package game.level.arena.battlefield.view {
import flash.events.Event;

import game.core.model.IConfigurationModel;
import game.core.model.IContextModel;
import game.core.model.ITextureService;
import game.event.GameEvent;
import game.level.arena.battlefield.model.IBattlefieldModel;
import game.level.arena.interactions.model.AbsorberEvent;

import org.robotlegs.mvcs.StarlingMediator;

public class BattlefieldMediator extends StarlingMediator {

	[Inject]
	public var view:IBattlefieldView;
	[Inject]
	public var battleFieldModel:IBattlefieldModel;
	[Inject]
	public var contextModel:IContextModel;
	[Inject]
	public var textureService:ITextureService;
	[Inject]
	public var configurationModel:IConfigurationModel;

	override public function onRegister():void {
		super.onRegister();
		addContextListener(AbsorberEvent.CREATED, absorberCreatedListener);
		addContextListener(GameEvent.EXIT_LEVEL, removeBattlefield);
		addContextListener(Event.ENTER_FRAME, enterFrameListener);
	}

	private function enterFrameListener(e:Event):void {
		battleFieldModel.update();
	}

	private function absorberCreatedListener(event:AbsorberEvent):void {
		view.addDribble(event.absorber.getContactNormal());
	}

	private function removeBattlefield(event:GameEvent):void {
		view.removeFromParent(true);
		mediatorMap.removeMediator(this);
	}

}
}