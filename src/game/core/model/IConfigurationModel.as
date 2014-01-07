package game.core.model {
import game.level.model.Unit;

public interface IConfigurationModel {
	function getDangerousColor():uint;

	function getSafeColor():uint;

	function getUnitColor(unit:Unit):uint;

	function getPlayerColor():uint;
}
}
