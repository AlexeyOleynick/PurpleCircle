/**
 * Created by OOliinyk on 7/5/13.
 */
package game.level.controls.view {
import flash.events.Event;

import game.core.model.ITextureService;
import game.event.GameEvent;
import game.level.arena.battlefield.model.IBattlefieldModel;

import org.robotlegs.mvcs.StarlingMediator;

import starling.events.Event;

public class ControlsMediator extends StarlingMediator {

	[Inject]
	public var view:IControlsView;
	[Inject]
	public var textureService:ITextureService;
	[Inject]
	public var battleFieldModel:IBattlefieldModel;

	override public function onRegister():void {
		super.onRegister();
		addViewListener(view.EXIT_BUTTON_PRESSED, exitButtonPressedListener);
		addViewListener(view.RESTART_BUTTON_PRESSED, restartButtonPressedListener);
		addContextListener(GameEvent.EXIT_LEVEL, removeControl);
	}

	private function removeControl(e:flash.events.Event):void {
		view.removeFromParent(true);
		mediatorMap.removeMediator(this);
	}

	private function restartButtonPressedListener(e:starling.events.Event):void {
		dispatch(new GameEvent(GameEvent.RESTART_LEVEL));
	}

	private function exitButtonPressedListener(e:starling.events.Event):void {
		dispatch(new GameEvent(GameEvent.BACK_TO_LOBBY));
	}
}
}
