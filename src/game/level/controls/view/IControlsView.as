package game.level.controls.view {
import game.core.view.ISpriteContainer;

public interface IControlsView extends ISpriteContainer {

	function get RESTART_BUTTON_PRESSED():String;

	function get EXIT_BUTTON_PRESSED():String;

}
}
