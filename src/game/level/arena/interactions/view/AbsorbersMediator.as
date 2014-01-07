/**
 * Created by OOliinyk on 7/20/13.
 */
package game.level.arena.interactions.view {
import flash.geom.Point;
import flash.utils.Dictionary;

import game.core.model.IConfigurationModel;
import game.core.model.ITextureService;
import game.event.GameEvent;
import game.level.arena.interactions.model.Absorber;
import game.level.arena.interactions.model.AbsorberEvent;
import game.level.model.Unit;

import org.robotlegs.mvcs.StarlingMediator;

public class AbsorbersMediator extends StarlingMediator {
	[Inject]
	public var view:IAbsorberContainer;
	[Inject]
	public var textureService:ITextureService;
	[Inject]
	public var configurationModel:IConfigurationModel;

	public var absorberViews:Dictionary;

	override public function onRegister():void {
		absorberViews = new Dictionary();

		addContextListener(AbsorberEvent.CREATED, absorberCreatedListener);
		addContextListener(AbsorberEvent.REMOVED, absorberRemovedListener);
		addContextListener(AbsorberEvent.UPDATED, absorberUpdatedListener);

		addContextListener(GameEvent.PLAYER_LOSE, playerKilledListener);
		addContextListener(GameEvent.EXIT_LEVEL, removeAbsorbersImmediately);

	}

	private function playerKilledListener(event:GameEvent):void {
		for each(var absorberView:AbsorberView in absorberViews) {
			absorberView.remove();
		}
	}

	private function removeAbsorbersImmediately(event:GameEvent):void {
		view.removeFromParent(true);
		mediatorMap.removeMediator(this);
	}

	private function absorberCreatedListener(event:AbsorberEvent):void {
		var absorber:Absorber = event.absorber;

		var smallerUnit:Unit = absorber.getSmallerUnit();
		var biggerUnit:Unit = absorber.getBiggerUnit();

		var startColor:uint = configurationModel.getUnitColor(smallerUnit);
		var stopColor:uint = configurationModel.getUnitColor(biggerUnit);

		var absorberGraphics:AbsorberView = new AbsorberView(textureService, startColor, stopColor);
		absorberViews[absorber] = absorberGraphics;
		var contactPoint:Point = absorber.getContactPoint();
		absorberGraphics.setCoordinates(contactPoint.x, contactPoint.y);
		view.addAbsorberGraphics(absorberGraphics);

	}

	private function absorberUpdatedListener(event:AbsorberEvent):void {
		var absorberGraphics:AbsorberView = absorberViews[event.absorber];
		var contactPoint:Point = event.absorber.getContactPoint();
		absorberGraphics.setCoordinates(contactPoint.x, contactPoint.y);
	}

	private function absorberRemovedListener(event:AbsorberEvent):void {
		var absorber:Absorber = event.absorber;
		removeAbsorberView(absorber);
	}

	private function removeAbsorberView(absorber:Absorber):void {
		(absorberViews[absorber] as AbsorberView).remove();
		delete absorberViews[absorber];
	}

}
}
