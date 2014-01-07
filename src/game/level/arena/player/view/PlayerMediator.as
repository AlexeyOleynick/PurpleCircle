/**
 * Created by OOliinyk on 7/23/13.
 */
package game.level.arena.player.view {
import flash.events.Event;
import flash.geom.Point;

import game.core.model.GameTouchEvent;
import game.core.model.IConfigurationModel;
import game.core.model.IContextModel;
import game.core.model.ITextureService;
import game.event.GameEvent;
import game.level.arena.player.model.IPlayerModel;
import game.level.arena.player.model.Player;
import game.level.units.UnitEvent;

import nape.geom.Vec2;

import org.robotlegs.mvcs.StarlingMediator;

import starling.events.Touch;
import starling.events.TouchPhase;

public class PlayerMediator extends StarlingMediator {

	[Inject]
	public var view:IPlayerContainer;
	[Inject]
	public var playerModel:IPlayerModel;
	[Inject]
	public var textureService:ITextureService;
	[Inject]
	public var configurationModel:IConfigurationModel;
	[Inject]
	public var contextModel:IContextModel;
	private var playerView:PlayerView;

	override public function onRegister():void {
		super.onRegister();
		addContextListener(GameEvent.EXIT_LEVEL, removePlayer);
		addContextListener(GameEvent.PLAYER_LOSE, playerKilledListener);
		addContextListener(UnitEvent.PLAYER_UPDATED, playerUpdatedListener);
		addContextListener(UnitEvent.PLAYER_CREATED, playerCreatedListener);
		addContextListener(Event.ENTER_FRAME, enterFrameListener);

	}

	private function enterFrameListener(e:Event):void {
		playerModel.update();
	}

	private function playerCreatedListener(event:UnitEvent):void {
		playerView = new PlayerView(textureService);
		view.addPlayerGraphics(playerView);
		addContextListener(GameTouchEvent.TOUCH, touchListener);

	}

	private function playerUpdatedListener(event:UnitEvent):void {
		var player:Player = event.unit as Player;

		playerView.rotation = player.getRotation();
		playerView.x = player.getX();
		playerView.y = player.getY();

		playerView.setPower(player.getCurrentPower());

		playerView.redraw(player.getRadius(), configurationModel.getUnitColor(player));
	}

	private function removePlayer(event:Event):void {
		view.removePlayerGraphics(playerView);
		mediatorMap.removeMediator(this);
	}


	protected function touchListener(event:GameTouchEvent):void {

		var touch:Touch = event.touch;
		//Situation when hover goes out of stage
		if (touch != null) {
			if (touch.phase == TouchPhase.BEGAN) {
				playerModel.getPlayer().startToConsumePower();
			} else if (touch.phase == TouchPhase.ENDED) {
				mouseUpListener(touch.globalX, touch.globalY);
			}
		}
	}

	private function mouseUpListener(stageX:Number, stageY:Number):void {
		var player:Player = playerModel.getPlayer();

		//Normalized vector between player and click point
		var directionVector:Vec2 = new Vec2(player.getX() - stageX, player.getY() - stageY);
		directionVector.normalise();

		//Convert player velocity in px/second to px/frame
		var jetVelocity:Point = player.getVelocity();
		jetVelocity.x /= contextModel.getFrameRate();
		jetVelocity.y /= contextModel.getFrameRate();


		var jetView:JetView = new JetView(textureService, directionVector.angle - Math.PI, player.getCurrentPower(), jetVelocity);

		//Set jetView coordinates to be on the border of the unit
		jetView.x = player.getX() - directionVector.x * player.getRadius();
		jetView.y = player.getY() - directionVector.y * player.getRadius();

		player.releasePower(directionVector.toPoint());
		playerView.setPower(0);
		playerView.parent.addChild(jetView);

	}

	private function playerKilledListener(event:Event):void {
		removeContextListener(GameTouchEvent.TOUCH, touchListener);
		view.removePlayerGraphics(playerView);
	}
}
}
