package game.level.arena.interactions.model {
import flash.events.Event;

public class AbsorberEvent extends Event {

	public var absorber:Absorber;
	public static const CREATED:String = 'ABSORBER_CREATED';
	public static const UPDATED:String = 'ABSORBER_UPDATED';

	public static const UNIT_ABSORBED:String = 'UNIT_ABSORBED';
	public static const REMOVED:String = 'ABSORBER_REMOVED';
	public static const TIMEOUT:String = 'ABSORBER_TIMEOUT';

	public function AbsorberEvent(type:String, absorber:Absorber) {
		this.absorber = absorber;
		super(type, false, false);
	}
}
}