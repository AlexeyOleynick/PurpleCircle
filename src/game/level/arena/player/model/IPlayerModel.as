package game.level.arena.player.model {
public interface IPlayerModel {
	function createPlayer(size:int):void;

	function getPlayer():Player;

	function update():void;

	function freeze():void;

	function destroy():void;
}
}
