/**
 * Created by OOliinyk on 7/12/13.
 */
package game.level.arena.interactions.model {

import flash.events.TimerEvent;
import flash.geom.Point;
import flash.utils.Timer;

import game.level.model.*;

import nape.callbacks.InteractionCallback;
import nape.dynamics.Contact;
import nape.geom.Vec2;

import org.casalib.events.RemovableEventDispatcher;

public class Absorber extends RemovableEventDispatcher {

	private var biggerUnit:Unit;
	private var smallerUnit:Unit;
	private var contactPoint:Point;

	private var normal:Point;

	private var timer:Timer;


	public function Absorber(cb:InteractionCallback) {
		var contact:Contact = cb.arbiters.at(0).collisionArbiter.contacts.at(0);
		contactPoint = new Point(contact.position.x, contact.position.y);

		var firstUnit:Unit = cb.int1.userData.model;
		var secondUnit:Unit = cb.int2.userData.model;

		if (firstUnit.getArea() > secondUnit.getArea()) {
			biggerUnit = firstUnit;
			smallerUnit = secondUnit;
		} else {
			biggerUnit = secondUnit;
			smallerUnit = firstUnit;
		}

		normal = contact.arbiter.normal.toPoint();

		timer = new Timer(2000, 1);
		timer.start();
		timer.addEventListener(TimerEvent.TIMER_COMPLETE, timeoutListener);
	}

	private function timeoutListener(event:TimerEvent):void {
		dispatchEvent(new AbsorberEvent(AbsorberEvent.TIMEOUT, this))
	}

	public function update(contactPoint:Point):void {
		timer.reset();
		timer.start();
		this.contactPoint = contactPoint;

		var step:Number = smallerUnit.getArea() / 20 + 20;

		if (smallerUnit.getArea() > step) {
			var gravityForce:Vec2 = biggerUnit.getPosition().sub(smallerUnit.getPosition()).mul(2);
			smallerUnit.setForce(gravityForce);
			biggerUnit.setForce(gravityForce.mul(-1));

			smallerUnit.setRadius(Math.sqrt((smallerUnit.getArea() - step) / Math.PI));
			biggerUnit.setRadius(Math.sqrt((biggerUnit.getArea() + step) / Math.PI));
			dispatchEvent(new AbsorberEvent(AbsorberEvent.UPDATED, this));
		} else {
			biggerUnit.setRadius(Math.sqrt((biggerUnit.getArea() + smallerUnit.getArea()) / Math.PI));
			dispatchEvent(new AbsorberEvent(AbsorberEvent.UNIT_ABSORBED, this));
		}
	}

	public function containsBoth(firstUnit:Unit, secondUnit:Unit):Boolean {
		if (biggerUnit == firstUnit && smallerUnit == secondUnit) return true;
		if (biggerUnit == secondUnit && smallerUnit == firstUnit) return true;
		return false;
	}

	public function containsSmaller(unit:Unit):Boolean {
		return smallerUnit == unit;
	}

	public function getContactPoint():Point {
		return contactPoint;
	}

	public function getSmallerUnit():Unit {
		return smallerUnit;
	}

	public function getBiggerUnit():Unit {
		return biggerUnit;
	}

	public function remove():void {
		timer.stop();
		timer.removeEventListener(TimerEvent.TIMER_COMPLETE, timeoutListener);
		biggerUnit.setForce(new Vec2(0, 0));
		smallerUnit.setForce(new Vec2(0, 0));
		super.destroy();
	}

	public function getContactNormal():Point {
		return normal;
	}
}
}
