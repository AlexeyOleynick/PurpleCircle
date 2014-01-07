package game.level.arena.interactions.model {
import nape.callbacks.InteractionCallback;
import nape.callbacks.InteractionListener;

public interface IPlayerVsEnemyInteractionModel {
	function playerVsEnemyCollisionListener(interactionCallback:InteractionCallback):void;

	function absorberUpdatedListener(event:AbsorberEvent):void;

	function absorberTimeoutListener(event:AbsorberEvent):void;

	function unitAbsorbedListener(event:AbsorberEvent):void;

	function playerIsBiggest(absorber:Absorber):Boolean;

	function playerAbsorbed(absorber:Absorber):Boolean;

	function destroy():void;

	function getInteractionList():Vector.<InteractionListener>;
}
}
