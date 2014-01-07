/**
 * Created by OOliinyk on 7/6/13.
 */
package game.level.controller {
import game.event.GameEvent;

import org.robotlegs.mvcs.StarlingCommand;

public class BackToLobbyCommand extends StarlingCommand {


	override public function execute():void {
		dispatch(new GameEvent(GameEvent.EXIT_LEVEL));
		dispatch(new GameEvent(GameEvent.SHOW_START_SCREEN));
	}
}
}
