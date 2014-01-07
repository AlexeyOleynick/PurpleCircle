/**
 * Created by OOliinyk on 7/28/13.
 */
package game.level.arena.interactions.model {
import flash.geom.Point;

import game.event.GameEvent;
import game.level.arena.enemies.model.Enemy;
import game.level.arena.enemies.model.IEnemiesModel;
import game.level.arena.player.model.IPlayerModel;
import game.level.arena.player.model.Player;
import game.level.model.UnitList;

import nape.callbacks.CbEvent;
import nape.callbacks.InteractionCallback;
import nape.callbacks.InteractionListener;
import nape.callbacks.InteractionType;
import nape.dynamics.Contact;

import org.robotlegs.mvcs.Actor;

public class PlayerVsEnemyInteractionModel extends Actor implements IPlayerVsEnemyInteractionModel {

	private var playerVsEnemyCollisionBegin:InteractionListener;
	private var playerVsEnemyCollisionOnGoing:InteractionListener;

	private var absorberList:AbsorberList;

	[Inject]
	public var playerModel:IPlayerModel;
	[Inject]
	public var enemiesModel:IEnemiesModel;

	function PlayerVsEnemyInteractionModel():void {
		playerVsEnemyCollisionBegin = new InteractionListener(CbEvent.BEGIN, InteractionType.COLLISION, Player.PLAYER_TYPE, Enemy.ENEMY_TYPE, playerVsEnemyCollisionListener);
		playerVsEnemyCollisionOnGoing = new InteractionListener(CbEvent.ONGOING, InteractionType.COLLISION, Player.PLAYER_TYPE, Enemy.ENEMY_TYPE, playerVsEnemyCollisionListener);
		absorberList = new AbsorberList();
	}

	public function playerVsEnemyCollisionListener(interactionCallback:InteractionCallback):void {
		if (interactionCallback.arbiters.length == 0) return;

		if (absorberList.containsByInteractionCallback(interactionCallback)) {
			var contact:Contact = interactionCallback.arbiters.at(0).collisionArbiter.contacts.at(0);
			var contactPoint:Point = new Point(contact.position.x, contact.position.y);
			var existingAbsorber:Absorber = absorberList.getAbsorberFromInteractionCallback(interactionCallback);
			existingAbsorber.update(contactPoint);
		} else {
			var uniqueAbsorber:Absorber = absorberList.addByInteractionCallback(interactionCallback);
			uniqueAbsorber.addEventListener(AbsorberEvent.TIMEOUT, absorberTimeoutListener);
			uniqueAbsorber.addEventListener(AbsorberEvent.UNIT_ABSORBED, unitAbsorbedListener);
			uniqueAbsorber.addEventListener(AbsorberEvent.UPDATED, absorberUpdatedListener);
			dispatch(new AbsorberEvent(AbsorberEvent.CREATED, uniqueAbsorber));
		}
	}

	public function absorberUpdatedListener(event:AbsorberEvent):void {
		dispatch(new AbsorberEvent(AbsorberEvent.UPDATED, event.absorber));
	}

	public function absorberTimeoutListener(event:AbsorberEvent):void {
		var absorber:Absorber = event.absorber;
		absorberList.remove(absorber);
		dispatch(new AbsorberEvent(AbsorberEvent.REMOVED, absorber));
	}

	public function unitAbsorbedListener(event:AbsorberEvent):void {
		var absorber:Absorber = event.absorber;

		absorberList.remove(absorber);
		dispatch(new AbsorberEvent(AbsorberEvent.REMOVED, absorber));

		if (playerIsBiggest(absorber)) {
			dispatch(new GameEvent(GameEvent.PLAYER_WON));
			enemiesModel.removeEnemy(absorber.getSmallerUnit());
		} else if (playerAbsorbed(absorber)) {
			dispatch(new GameEvent(GameEvent.PLAYER_LOSE));
		} else {
			enemiesModel.removeEnemy(absorber.getSmallerUnit());
		}
	}

	public function playerIsBiggest(absorber:Absorber):Boolean {
		var player:Player = playerModel.getPlayer();
		var enemyList:UnitList = enemiesModel.getEnemyList();

		if (absorber.containsSmaller(player)) {
			return false;
		} else if (enemyList.isBiggestUnit(player)) {
			return true;
		}
		return false;
	}

	public function playerAbsorbed(absorber:Absorber):Boolean {
		return absorber.containsSmaller(playerModel.getPlayer());
	}

	public function destroy():void {
		for each(var absorber:Absorber in absorberList.getAbsorbers()) {
			dispatch(new AbsorberEvent(AbsorberEvent.REMOVED, absorber));
		}
		absorberList.destroyAllAbsorbers();
	}

	public function getInteractionList():Vector.<InteractionListener> {
		var interactionListeners:Vector.<InteractionListener> = new Vector.<InteractionListener>();
		interactionListeners.push(playerVsEnemyCollisionBegin);
		interactionListeners.push(playerVsEnemyCollisionOnGoing);
		return interactionListeners;
	}
}
}
