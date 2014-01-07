/**
 * Created by OOliinyk on 7/16/13.
 */
package game.level.arena.interactions.model {
import game.level.model.*;

import nape.callbacks.InteractionCallback;

public class AbsorberList {

	public var absorbers:Vector.<Absorber>;

	public function AbsorberList() {
		absorbers = new Vector.<Absorber>;
	}

	public function getAbsorbers():Vector.<Absorber> {
		return absorbers;
	}

	public function addByInteractionCallback(interactionCallback:InteractionCallback):Absorber {
		var absorber:Absorber = new Absorber(interactionCallback);
		absorbers.push(absorber);
		return absorber;
	}

	public function containsByInteractionCallback(interactionCallback:InteractionCallback):Boolean {
		var firstUnit:Unit = interactionCallback.int1.userData.model;
		var secondUnit:Unit = interactionCallback.int2.userData.model;

		return absorberExist(firstUnit, secondUnit);
	}

	public function getAbsorberFromInteractionCallback(interactionCallback:InteractionCallback):Absorber {
		var firstUnit:Unit = interactionCallback.int1.userData.model;
		var secondUnit:Unit = interactionCallback.int2.userData.model;

		return getAbsorber(firstUnit, secondUnit);
	}

	private function absorberExist(firstUnit:Unit, secondUnit:Unit):Boolean {
		for each(var absorber:Absorber in absorbers) {
			if (absorber.containsBoth(firstUnit, secondUnit)) {
				return true;
			}
		}
		return false;
	}

	private function getAbsorber(firstUnit:Unit, secondUnit:Unit):Absorber {
		for each(var absorber:Absorber in absorbers) {
			if (absorber.containsBoth(firstUnit, secondUnit)) {
				return absorber;
			}
		}
		return null;
	}

	public function destroyAllAbsorbers():void {
		for each(var absorber:Absorber in absorbers) {
			absorber.remove();
		}
		absorbers.length = 0;
	}

	public function remove(absorber:Absorber):void {
		absorber.remove();
		absorbers.splice(absorbers.indexOf(absorber), 1);
	}
}
}
