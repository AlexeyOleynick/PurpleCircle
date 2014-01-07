/**
 * Created by OOliinyk on 7/28/13.
 */
package game.level.arena.player.model {
import game.core.model.IContextModel;
import game.level.units.UnitEvent;

import nape.phys.BodyType;

import org.robotlegs.mvcs.Actor;

public class PlayerModel extends Actor implements IPlayerModel {

	private var player:Player;
	[Inject]
	public var contextModel:IContextModel;

	public function createPlayer(size:int):void {
		player = new Player(size);
		dispatch(new UnitEvent(UnitEvent.PLAYER_CREATED, player));
	}

	public function getPlayer():Player {
		return player;
	}

	public function update():void {
		dispatch(new UnitEvent(UnitEvent.PLAYER_UPDATED, getPlayer()));
	}

	public function freeze():void {
		player.getBody().type = BodyType.STATIC;
	}

	public function destroy():void {
		player.destroy();
	}
}
}
