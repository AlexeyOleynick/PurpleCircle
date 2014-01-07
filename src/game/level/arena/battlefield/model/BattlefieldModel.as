package game.level.arena.battlefield.model {

import flash.geom.Rectangle;

import game.core.model.IContextModel;
import game.level.model.*;

import nape.callbacks.InteractionListener;
import nape.geom.Vec2;
import nape.space.Space;
import nape.util.ShapeDebug;

import org.robotlegs.mvcs.Actor;

public class BattlefieldModel extends Actor implements IBattlefieldModel {
	public var napeDebug:ShapeDebug;
	private var space:Space;
	private var fluid:Fluid;

	[Inject]
	public var contextModel:IContextModel;

	public function initialize(area:Rectangle):void {
		napeDebug = new ShapeDebug(area.width, area.height);

		space = new Space(new Vec2(0, 0));

		var battlefieldBorder:Border = new Border(area);
		space.bodies.add(battlefieldBorder.getBody());

		fluid = new Fluid(area);
		space.bodies.add(fluid.getBody());
	}

	public function update():void {
		space.step(contextModel.getFrameDurationInSeconds());
		/*
		 napeDebug.clear();
		 napeDebug.draw(space);
		 napeDebug.flush();
		 */
	}

	public function addUnit(unit:Unit):void {
		this.space.bodies.add(unit.getBody());
	}

	public function destroy():void {
		space.clear();
	}

	public function stop():void {
		space.gravity = new Vec2(0, 600);
		fluid.getBody().space = null;
		space.listeners.clear();
	}

	public function addUnits(unitList:UnitList):void {
		for each(var unit:Unit in unitList.getUnits()) {
			addUnit(unit);
		}
	}

	public function addInteractions(interactions:Vector.<InteractionListener>):void {
		for each(var interaction:InteractionListener in interactions) {
			space.listeners.add(interaction);
		}
	}
}
}