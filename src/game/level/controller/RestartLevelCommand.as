/**
 * Created by OOliinyk on 7/5/13.
 */
package game.level.controller {
import game.event.GameEvent;
import game.level.arena.battlefield.model.IBattlefieldModel;

import org.robotlegs.mvcs.StarlingCommand;

public class RestartLevelCommand extends StarlingCommand {

	[Inject]
	public var battleFieldModel:IBattlefieldModel;

	override public function execute():void {
		dispatch(new GameEvent(GameEvent.EXIT_LEVEL));
		dispatch(new GameEvent(GameEvent.START_LEVEL));
		super.execute();
	}

}
}
