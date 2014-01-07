/**
 * Created by OOliinyk on 7/20/13.
 */
package game.level.arena.player.view {
import game.core.model.ITextureService;
import game.level.units.UnitView;

import starling.animation.Tween;
import starling.core.Starling;
import starling.display.BlendMode;
import starling.display.Image;
import starling.events.Event;
import starling.textures.Texture;

public class PlayerView extends UnitView {

	private var powerOverlay:Image;
	private var tween:Tween;

	private static const POWER_INDICATOR:String = 'PowerIndicator0000';

	public function PlayerView(textureService:ITextureService) {
		super(textureService);
		var playerPowerTexture:Texture = textureService.getTexture(POWER_INDICATOR);

		powerOverlay = new Image(playerPowerTexture);
		powerOverlay.blendMode = BlendMode.ADD;

		powerOverlay.width = unitGraphicsContainer.width;
		powerOverlay.height = unitGraphicsContainer.height;

		powerOverlay.x = -powerOverlay.width / 2;
		powerOverlay.y = -powerOverlay.height / 2;
		powerOverlay.alpha = 0;

		unitGraphicsContainer.addChild(powerOverlay);

	}


	override protected function removedFromStageListener(event:Event):void {
		if (tween) tween.dispatchEventWith(Event.REMOVE_FROM_JUGGLER);
		super.removedFromStageListener(event);
	}

	override public function redraw(radius:Number, color:uint = 0):void {
		super.redraw(radius, color);
	}

	public function setPower(power:Number):void {
		if (tween) tween.dispatchEventWith(Event.REMOVE_FROM_JUGGLER);
		tween = new Tween(powerOverlay, 0.3);
		tween.animate('alpha', power);
		Starling.juggler.add(tween);
	}
}
}
