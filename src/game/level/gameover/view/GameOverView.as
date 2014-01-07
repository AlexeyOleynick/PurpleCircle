/**
 * Created by OOliinyk on 7/13/13.
 */
package game.level.gameover.view {
import game.core.model.ITextureService;

import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;
import starling.textures.TextureSmoothing;

public class GameOverView extends Sprite implements IGameOverView {

	private var gameOver:Image;
	private static const GAME_OVER_TEXTURE_NAME:String = 'GameOver0000';
	private static const VICTORY_TEXTURE_NAME:String = 'Victory0000';

	private var textureService:ITextureService;


	public function GameOverView(textureService:ITextureService) {
		this.textureService = textureService;

		addEventListener(Event.ADDED_TO_STAGE, addedToStageListener);

	}

	private function addedToStageListener(event:Event):void {
		removeEventListener(Event.ADDED_TO_STAGE, addedToStageListener);
		setPosition();
	}

	private function setPosition():void {
		gameOver.x = stage.stageWidth / 2 - gameOver.width / 2;
		gameOver.y = stage.stageHeight / 2 - 50;
	}

	public function set victory(victory:Boolean):void {
		if (victory) {
			gameOver = new Image(textureService.getTexture(VICTORY_TEXTURE_NAME));
		}
		else
			gameOver = new Image(textureService.getTexture(GAME_OVER_TEXTURE_NAME));

		addChild(gameOver);

		gameOver.smoothing = TextureSmoothing.NONE;
		gameOver.scaleX = 0.5;
		gameOver.scaleY = 0.5;
	}


	public function getStarlingSprite():Sprite {
		return this;
	}
}
}
