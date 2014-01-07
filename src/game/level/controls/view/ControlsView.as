/**
 * Created by OOliinyk on 7/5/13.
 */
package game.level.controls.view {


import game.core.model.ITextureService;

import starling.display.Button;
import starling.display.Sprite;
import starling.events.Event;

public class ControlsView extends Sprite implements IControlsView {

	private var exitButton:Button;
	private var restartButton:Button;
	private var textureService:ITextureService;

	private static const RESTART_BUTTON_TEXTURE_NAME:String = 'RestartButton0000';
	private static const EXIT_BUTTON_TEXTURE_NAME:String = 'ExitButton0000';

	public function ControlsView(textureService:ITextureService) {
		this.textureService = textureService;
		addEventListener(Event.ADDED_TO_STAGE, addedToStageListener);
	}

	private function addedToStageListener(event:Event):void {
		removeEventListener(Event.ADDED_TO_STAGE, addedToStageListener);
		setExitButton();
		setRestartButton();
	}

	public function setExitButton():void {
		exitButton = new Button(textureService.getTexture(EXIT_BUTTON_TEXTURE_NAME));
		setExitButtonPosition();

		exitButton.addEventListener(Event.TRIGGERED, exitButtonPressedListener);
		addChild(exitButton);
	}

	private function setExitButtonPosition():void {
		exitButton.x = stage.stageWidth / 2 - exitButton.width / 2 + 60;
		exitButton.y = 5;
	}

	private function exitButtonPressedListener(event:Event):void {
		dispatchEventWith(EXIT_BUTTON_PRESSED);
	}

	public function setRestartButton():void {
		restartButton = new Button(textureService.getTexture(RESTART_BUTTON_TEXTURE_NAME));
		setRestartButtonPosition();
		restartButton.addEventListener(Event.TRIGGERED, restartButtonPressedListener);

		addChild(restartButton);
	}

	private function setRestartButtonPosition():void {
		restartButton.x = stage.stageWidth / 2 - restartButton.width / 2 - 60;
		restartButton.y = 5;
	}

	private function restartButtonPressedListener(event:Event):void {
		dispatchEventWith(RESTART_BUTTON_PRESSED);
	}

	public function get RESTART_BUTTON_PRESSED():String {
		return 'RESTART_BUTTON_PRESSED';
	}

	public function get EXIT_BUTTON_PRESSED():String {
		return 'EXIT_BUTTON_PRESSED';
	}


	public function getStarlingSprite():Sprite {
		return this;
	}
}
}
