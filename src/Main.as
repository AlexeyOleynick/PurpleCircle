package {
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.events.Event;

import starling.core.Starling;

[SWF(width='760', height='625', frameRate='60', backgroundColor='#c0b9ad')]

public class Main extends Sprite {
	public var starling:Starling;

	public function Main() {
		addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
	}

	protected function onAddedToStage(event:Event):void {
		removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;

		starling = new Starling(StarlingAppContext, stage);
		starling.start();

	}
}
}