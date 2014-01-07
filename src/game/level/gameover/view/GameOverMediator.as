/**
 * Created by OOliinyk on 7/5/13.
 */
package game.level.gameover.view {
import flash.events.Event;

import game.core.model.ITextureService;
import game.event.GameEvent;

import org.robotlegs.mvcs.StarlingMediator;

public class GameOverMediator extends StarlingMediator {

	[Inject]
	public var view:IGameOverView;
	[Inject]
	public var textureService:ITextureService;

	override public function onRegister():void {
		super.onRegister();
		addContextListener(GameEvent.EXIT_LEVEL, removeGameOverView);
	}

	private function removeGameOverView(e:Event):void {
		view.removeFromParent(true);
		mediatorMap.removeMediator(this);
	}

}
}
