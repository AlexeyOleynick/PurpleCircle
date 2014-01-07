package game.event {
import flash.events.Event;

public class GameEvent extends Event {

	public static const START_LEVEL:String = 'START_LEVEL';
	public static const EXIT_LEVEL:String = 'EXIT_LEVEL';
	public static const SHOW_START_SCREEN:String = 'SHOW_START_SCREEN';
	public static const RESTART_LEVEL:String = 'RESTART_LEVEL';
	public static const BACK_TO_LOBBY:String = 'BACK_TO_LOBBY';
	public static const PLAYER_LOSE:String = 'PLAYER_KILLED';
	public static const CREATE_ENEMIES:String = 'CREATE_ENEMIES';
	public static const CREATE_PLAYER:String = 'CREATE_PLAYER';
	public static const CREATE_PLAYER_VS_ENEMY_INTERACTION:String = 'CREATE_PLAYER_VS_ENEMY_INTERACTION';
	public static const PLAYER_WON:String = 'PLAYER_WON';

	public function GameEvent(type:String) {
		super(type, false, false);
	}
}
}