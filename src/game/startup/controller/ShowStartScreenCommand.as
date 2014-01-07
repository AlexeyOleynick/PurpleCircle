package game.startup.controller {
import game.startup.view.IStartScreenView;

import org.robotlegs.mvcs.StarlingCommand;

import starling.display.DisplayObject;

public class ShowStartScreenCommand extends StarlingCommand {
	[Inject]
	public var startScreenView:IStartScreenView;

	override public function execute():void {
		contextView.addChild(startScreenView.getStarlingSprite());
	}

}
}