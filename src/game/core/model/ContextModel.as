package game.core.model {
import flash.events.Event;

import org.robotlegs.mvcs.Actor;

import starling.core.Starling;
import starling.display.DisplayObjectContainer;
import starling.events.EnterFrameEvent;
import starling.events.TouchEvent;

public class ContextModel extends Actor implements IContextModel {
	private var context:DisplayObjectContainer;

	public function ContextModel(context:DisplayObjectContainer) {
		this.context = context;
		this.context.addEventListener(EnterFrameEvent.ENTER_FRAME, stageEnterFrameListener);
		this.context.stage.addEventListener(TouchEvent.TOUCH, stageTouchedListener);
	}

	private function stageTouchedListener(event:TouchEvent):void {
		dispatch(new GameTouchEvent(event, context.stage));
	}

	private function stageEnterFrameListener(event:EnterFrameEvent):void {
		dispatch(new Event(Event.ENTER_FRAME));
	}

	public function getWidth():int {
		return context.stage.stageWidth;
	}

	public function getHeight():int {
		return context.stage.stageHeight;
	}

	public function getFrameRate():int {
		return Starling.current.nativeStage.frameRate;
	}

	public function getFrameDurationInSeconds():Number {
		return 1 / Starling.current.nativeStage.frameRate;
	}
}
}