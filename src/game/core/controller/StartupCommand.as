/**
 * Created by OOliinyk on 7/5/13.
 */
package game.core.controller {
import game.core.view.IStatsBgView;
import game.event.GameEvent;

import org.robotlegs.mvcs.StarlingCommand;

import starling.display.DisplayObject;

public class StartupCommand extends StarlingCommand {

	[Inject]
	public var statsBgView:IStatsBgView;

	override public function execute():void {
		contextView.addChild(statsBgView.getStarlingSprite());
		dispatch(new GameEvent(GameEvent.SHOW_START_SCREEN));
	}
}
}
