package game.level.units {

import game.core.model.ITextureService;

import starling.core.Starling;
import starling.display.MovieClip;
import starling.display.Sprite;
import starling.events.Event;
import starling.textures.Texture;

public class UnitView extends Sprite {
	private var color:uint = 0x000000;
	private var textureRadius:Number;

	private var movie:MovieClip;
	private static const TEXTURE_SIZE_MULTIPLIER:Number = 1.05;
	private static const UNIT:String = 'Unit';

	protected var unitGraphicsContainer:Sprite;

	public function UnitView(textureService:ITextureService) {
		var texture:Vector.<Texture> = textureService.getTextures(UNIT);

		movie = new MovieClip(texture, 12);
		movie.advanceTime(Math.random());
		movie.x = movie.y = -movie.height / 2;
		Starling.juggler.add(movie);

		unitGraphicsContainer = new Sprite;
		unitGraphicsContainer.addChild(movie);
		addChild(unitGraphicsContainer);

		movie.addEventListener(Event.REMOVED_FROM_STAGE, removedFromStageListener)
	}

	protected function removedFromStageListener(event:Event):void {
		Starling.juggler.remove(movie);
		movie.removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStageListener)
	}

	public function redraw(radius:Number, color:uint = 0):void {
		if (textureRadius != radius * TEXTURE_SIZE_MULTIPLIER || this.color != color) {

			textureRadius = radius * TEXTURE_SIZE_MULTIPLIER;
			this.color = color;

			movie.color = color;
			unitGraphicsContainer.width = unitGraphicsContainer.height = textureRadius * 2 * TEXTURE_SIZE_MULTIPLIER;
		}

	}
}
}