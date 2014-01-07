package game.level.units {
import flash.events.Event;

import game.level.model.Unit;

public class UnitEvent extends Event {
	public static const PLAYER_CREATED:String = 'PLAYER_CREATED';
	public static const PLAYER_UPDATED:String = 'PLAYER_UPDATED';
	public static const ENEMY_CREATED:String = 'ENEMY_CREATED';
	public static const ENEMY_UPDATED:String = 'ENEMY_UPDATED';
	public static const ENEMY_REMOVED:String = 'UNIT_REMOVED';
	public var unit:Unit;

	public function UnitEvent(type:String, unit:Unit = null) {
		this.unit = unit;
		super(type, false, false);
	}
}
}