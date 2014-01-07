package game.level.arena.battlefield.model {
import flash.geom.Rectangle;

import game.level.model.Unit;
import game.level.model.UnitList;

import nape.callbacks.InteractionListener;

public interface IBattlefieldModel {
	function initialize(area:Rectangle):void;

	function update():void;

	function addUnit(unit:Unit):void;

	function destroy():void;

	function stop():void;

	function addUnits(unitList:UnitList):void;

	function addInteractions(interactions:Vector.<InteractionListener>):void;
}
}
