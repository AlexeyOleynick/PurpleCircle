package game.startup.view {
import game.event.GameEvent;

import org.robotlegs.mvcs.StarlingMediator;

import starling.events.Event;

public class StartScreenMediator extends StarlingMediator {

	[Inject]
	public var view:IStartScreenView;

	override public function onRegister():void {
		addViewListener(view.START_GAME_CLICK, startGameClickListener);
	}

	private function startGameClickListener(event:Event):void {
		view.removeFromParent(true);
		dispatch(new GameEvent(GameEvent.START_LEVEL));
	}

}
}