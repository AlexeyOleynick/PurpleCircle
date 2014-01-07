package game.core.model {
import flash.events.Event;

import starling.display.Stage;
import starling.events.Touch;
import starling.events.TouchEvent;

public class GameTouchEvent extends Event {
	private var touchEvent:TouchEvent;
	private var stage:Stage;
	public static const TOUCH:String = 'GAME_TOUCH_EVENT';

	public function GameTouchEvent(starlingTouchEvent:TouchEvent, stage:Stage) {
		touchEvent = starlingTouchEvent;
		this.stage = stage;
		super(TOUCH);
	}

	public function get touch():Touch {
		return touchEvent.getTouch(stage);
	}

}
}
