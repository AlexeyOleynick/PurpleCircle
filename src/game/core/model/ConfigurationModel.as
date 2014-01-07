/**
 * Created by OOliinyk on 7/21/13.
 */
package game.core.model {
import game.level.arena.player.model.IPlayerModel;
import game.level.arena.player.model.Player;
import game.level.model.Unit;

import org.casalib.math.Percent;
import org.casalib.math.Range;
import org.robotlegs.mvcs.Actor;

import game.core.model.ColorModifierService;

public class ConfigurationModel extends Actor implements IConfigurationModel {

	[Inject]
	public var playerModel:IPlayerModel;

	public function getDangerousColor():uint {
		return 0xFF0066;
	}

	public function getSafeColor():uint {
		return 0x00BFFF;

	}

	public function getUnitColor(unit:Unit):uint {
		var player:Player = playerModel.getPlayer();
		if (player == null) return getDangerousColor();
		if (unit == player) return getPlayerColor();


		var rate:Percent;
		var min:Number = player.getArea() / 2;
		var max:Number = player.getArea() * 2;

		var range:Range = new Range(min, max);
		rate = range.getPercentOfValue(unit.getArea());

		var colorModifier:ColorModifierService = new ColorModifierService();
		return colorModifier.fade(rate.decimalPercentage, 0x00BFFF, 0xFF0066);
	}

	public function getPlayerColor():uint {
		return 0x62CC86;
	}


}
}
