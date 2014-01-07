/**
 * Created by OOliinyk on 7/5/13.
 */
package game.core.view {

import game.core.model.ITextureService;

import starling.display.Image;
import starling.display.Sprite;
import starling.events.Event;
import starling.textures.Texture;

public class StatsBgView extends Sprite implements IStatsBgView {

	private static const STATS_BACKGROUND:String = 'Stats';


	public function StatsBgView(textureService:ITextureService) {

		var statsBg:Texture = textureService.getTexture(STATS_BACKGROUND);
		var image:Image = new Image(statsBg);
		image.addEventListener(Event.ADDED_TO_STAGE, imageAddedToStageListener);
		addChild(image);

		addEventListener(Event.ENTER_FRAME, enterFrameListener);
	}

	private function imageAddedToStageListener(event:Event):void {
		var image:Image = event.currentTarget as Image;
		image.removeEventListener(Event.ADDED_TO_STAGE, imageAddedToStageListener);
		image.x = image.stage.stageWidth / 2 - image.width / 2;
	}

	private function enterFrameListener(event:Event):void {
		parent.addChild(this);
	}

	public function getStarlingSprite():Sprite {
		return this;
	}
}
}
