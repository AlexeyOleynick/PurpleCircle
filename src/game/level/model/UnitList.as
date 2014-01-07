/**
 * Created by OOliinyk on 7/17/13.
 */
package game.level.model {
public class UnitList {

	private var units:Vector.<Unit>;

	public function UnitList() {
		units = new Vector.<Unit>;
	}

	public function getUnits():Vector.<Unit> {
		return units;
	}

	public function getUnitsByClass(unitSubclass:Class):Array {
		var subclassUnits:Array = new Array();
		for each(var unit:Unit in units) {
			if (unit is unitSubclass) subclassUnits.push(unit);
		}
		return subclassUnits;
	}

	public function remove(unit:Unit):void {
		if (units.indexOf(unit) != -1) {
			unit.destroy();
			units.splice(units.indexOf(unit), 1);
		} else {
			throw new ArgumentError('UnitList does not contain provided unit');
		}
	}

	public function isBiggestUnit(unitToCompare:Unit):Boolean {
		if (units.length < 0) return true;
		for each(var unit:Unit in units) {
			if (unitToCompare.getArea() < unit.getArea()) return false;
		}
		return true;
	}

	public function destroyAllUnits():void {
		for each(var unit:Unit in units) {
			unit.destroy();
		}
		units.length = 0;
	}


	public function add(unit:Unit):void {
		units.push(unit);
	}
}
}
