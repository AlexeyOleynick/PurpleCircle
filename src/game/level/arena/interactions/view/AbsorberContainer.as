/**
 * Created by OOliinyk on 7/21/13.
 */
package game.level.arena.interactions.view {
import starling.display.Sprite;

public class AbsorberContainer extends Sprite implements IAbsorberContainer {
	public function AbsorberContainer() {
		super();
	}

	public function addAbsorberGraphics(absorberGraphics:AbsorberView):void {
		super.addChild(absorberGraphics);
	}


	public function getStarlingSprite():Sprite {
		return this;
	}
}
}
