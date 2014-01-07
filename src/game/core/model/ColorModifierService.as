package game.core.model {
public class ColorModifierService {

	public function fade(ratio:Number, firstColor:uint = 0x000000, secondColor:uint = 0xffffff):uint {
		if (ratio < 0) return firstColor;
		if (ratio > 1) return secondColor;
		var r:uint = firstColor >> 16;
		var g:uint = firstColor >> 8 & 0xFF;
		var b:uint = firstColor & 0xFF;
		r += ((secondColor >> 16) - r) * ratio;
		g += ((secondColor >> 8 & 0xFF) - g) * ratio;
		b += ((secondColor & 0xFF) - b) * ratio;
		return(r << 16 | g << 8 | b);
	}

}
}