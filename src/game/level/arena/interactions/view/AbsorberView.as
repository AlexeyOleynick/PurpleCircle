package game.level.arena.interactions.view {
import flash.display3D.Context3DBlendFactor;
import flash.events.TimerEvent;
import flash.utils.Timer;

import game.core.model.ITextureService;

import org.casalib.util.ColorUtil;

import starling.animation.Tween;
import starling.core.Starling;
import starling.display.Sprite;
import starling.extensions.ColorArgb;
import starling.extensions.PDParticleSystem;
import starling.textures.Texture;

public class AbsorberView extends Sprite {
	// embed configuration XML
	[Embed(source="/../media/absorberParticle.pex", mimeType="application/octet-stream")]
	private static const AbsorberConfig:Class;

	private static const ABSORBER_PARTICLE:String = 'AbsorberParticle0000';

	private var mParticleSystem:PDParticleSystem;

	public function AbsorberView(textureService:ITextureService, startColor:uint, stopColor:uint) {


		var absorberTexture:Texture = textureService.getTexture(ABSORBER_PARTICLE);

		// create particle system
		mParticleSystem = new PDParticleSystem(XML(new AbsorberConfig), absorberTexture);
		addChild(mParticleSystem);
		Starling.juggler.add(mParticleSystem);
		mParticleSystem.emissionRate = 500;
		mParticleSystem.start();

		mParticleSystem.blendFactorSource = Context3DBlendFactor.ONE;
		mParticleSystem.blendFactorDestination = Context3DBlendFactor.ONE;

		var startArgbColor:Object = ColorUtil.getRGB(startColor);
		var endArgbColor:Object = ColorUtil.getRGB(stopColor);

		mParticleSystem.startColor = new ColorArgb(startArgbColor.r / 255, startArgbColor.g / 255, startArgbColor.b / 255, 1);
		mParticleSystem.endColor = new ColorArgb(endArgbColor.r / 255, endArgbColor.g / 255, endArgbColor.b / 255, 0);

		var timer:Timer = new Timer(200, 1);
		timer.start();
		timer.addEventListener(TimerEvent.TIMER_COMPLETE, burstCompleteListener);

	}

	private function burstCompleteListener(event:TimerEvent):void {
		(event.target as Timer).removeEventListener(TimerEvent.TIMER_COMPLETE, burstCompleteListener);
		var tween:Tween = new Tween(mParticleSystem, 1);
		tween.animate('maxNumParticles', 30);
		tween.onComplete = tweenCompleteListener;
		tween.onCompleteArgs = [tween];
		Starling.juggler.add(tween);
		mParticleSystem.speed = 20;
		mParticleSystem.speedVariance = 5;
		mParticleSystem.lifespan = 1;
		mParticleSystem.lifespanVariance = 1;
	}

	private function tweenCompleteListener(tween:Tween):void {
		Starling.juggler.remove(tween);
	}

	public function setCoordinates(x:Number, y:Number):void {
		mParticleSystem.emitterX = x;
		mParticleSystem.emitterY = y;
	}

	public function remove():void {
		mParticleSystem.stop();
		var timer:Timer = new Timer(3000, 1);
		timer.start();
		timer.addEventListener(TimerEvent.TIMER_COMPLETE, timerCompleteListener);

	}

	private function timerCompleteListener(event:TimerEvent):void {
		(event.target as Timer).removeEventListener(TimerEvent.TIMER_COMPLETE, timerCompleteListener);
		Starling.juggler.remove(mParticleSystem);
		//remove from parent and dispose
		removeFromParent(true);
	}
}

}