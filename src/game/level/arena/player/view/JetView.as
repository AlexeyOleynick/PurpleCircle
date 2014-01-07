package game.level.arena.player.view {
import flash.display3D.Context3DBlendFactor;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.utils.Timer;

import game.core.model.ITextureService;

import org.casalib.util.ColorUtil;

import starling.core.Starling;
import starling.display.Sprite;
import starling.events.EnterFrameEvent;
import starling.extensions.ColorArgb;
import starling.extensions.PDParticleSystem;
import starling.textures.Texture;

public class JetView extends Sprite {

	// embed configuration XML
	[Embed(source="/../media/particle.pex", mimeType="application/octet-stream")]
	private static const FireConfig:Class;

	private var mParticleSystem:PDParticleSystem;
	private var velocity:Point;

	private static const JET_PARTICLE:String = 'JetParticle0000';


	public function JetView(textureService:ITextureService, direction:Number, power:Number, velocity:Point) {
		this.velocity = velocity;
		rotation = direction;

		var jetTexture:Texture = textureService.getTexture(JET_PARTICLE);

		// create particle system
		mParticleSystem = new PDParticleSystem(XML(new FireConfig), jetTexture);

		mParticleSystem.blendFactorSource = Context3DBlendFactor.ONE;
		mParticleSystem.blendFactorDestination = Context3DBlendFactor.ONE_MINUS_SOURCE_ALPHA;
		mParticleSystem.emissionRate = mParticleSystem.emissionRate * power * 10;
		mParticleSystem.speed = mParticleSystem.speed + mParticleSystem.speed * power * 3
		mParticleSystem.gravityX = -10;

		var startArgbColor:Object = ColorUtil.getRGB(0x62CC86);
		var endArgbColor:Object = ColorUtil.getRGB(0xE0B700);

		mParticleSystem.startColor = new ColorArgb(startArgbColor.r / 255, startArgbColor.g / 255, startArgbColor.b / 255, 1);
		mParticleSystem.endColor = new ColorArgb(endArgbColor.r / 255, endArgbColor.g / 255, endArgbColor.b / 255, 0);


		addChild(mParticleSystem);
		Starling.juggler.add(mParticleSystem);

		mParticleSystem.start(0.1);
		var removerTimer:Timer = new Timer(100 + 1000 * (mParticleSystem.lifespan + mParticleSystem.lifespanVariance), 1);
		removerTimer.start();
		removerTimer.addEventListener(TimerEvent.TIMER_COMPLETE, timerCompleteListener);
		addEventListener(EnterFrameEvent.ENTER_FRAME, enterFrameListener);
	}

	private function enterFrameListener(event:EnterFrameEvent):void {
		x += velocity.x;
		y += velocity.y;
	}

	private function timerCompleteListener(event:TimerEvent):void {
		removeEventListener(EnterFrameEvent.ENTER_FRAME, enterFrameListener);
		(event.target as Timer).removeEventListener(TimerEvent.TIMER_COMPLETE, timerCompleteListener);
		mParticleSystem.stop();
		Starling.juggler.remove(mParticleSystem);
		removeFromParent(true);
	}
}
}