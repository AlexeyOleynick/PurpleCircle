package game.startup.view {
import game.core.model.ITextureService;

import starling.display.Button;
import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;

public class StartScreenView extends Sprite implements IStartScreenView {
	private var startButton:Button;
	private var technologies:Image;

	private const START_BUTTON_TEXTURE_NAME:String = 'StartButton0000';
	private const TECHNOLOGIES_TEXTURE_NAME:String = 'Technologies';

	public function get START_GAME_CLICK():String {
		return 'START_GAME_PRESSED';
	}

	public function StartScreenView(textureService:ITextureService) {
		startButton = new Button(textureService.getTexture(START_BUTTON_TEXTURE_NAME));
		addChild(startButton);

		technologies = new Image(textureService.getTexture(TECHNOLOGIES_TEXTURE_NAME));
		addChild(technologies);

		addEventListener(Event.ADDED_TO_STAGE, addedToStageListener);
	}

	private function addedToStageListener(event:Event):void {
		removeEventListener(Event.ADDED_TO_STAGE, addedToStageListener);
		setPosition();
		startButton.addEventListener(Event.TRIGGERED, startButtonPressedListener);
	}

	private function setPosition():void {
		startButton.x = stage.stageWidth / 2 - startButton.width / 2;
		startButton.y = stage.stageHeight / 2 - startButton.height;

		technologies.x = stage.stageWidth / 2 - technologies.width / 2;
		technologies.y = stage.stageHeight - technologies.height / 2 - 80;
	}

	private function startButtonPressedListener(event:Event):void {
		dispatchEvent(new Event(START_GAME_CLICK));
	}

	public function getStarlingSprite():Sprite {
		return this;
	}
}
}