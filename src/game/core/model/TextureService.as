package game.core.model {
import org.robotlegs.mvcs.Actor;

import starling.textures.Texture;
import starling.textures.TextureAtlas;

/**
 * @author OOliinyk
 */
public class TextureService extends Actor implements ITextureService {

	[Embed(source="/../media/assets.xml", mimeType="application/octet-stream")]
	private const AssetsLayoutXml:Class;

	[Embed(source="/../media/assets.png")]
	private const AssetsSpriteSheet:Class;

	private var assetsTextureAtlas:TextureAtlas;


	public function TextureService() {
		var assetsXml:XML = XML(new AssetsLayoutXml());
		var assetsTexture:Texture = Texture.fromBitmap(new AssetsSpriteSheet());
		assetsTextureAtlas = new TextureAtlas(assetsTexture, assetsXml);
	}

	//Get single texture
	public function getTexture(subTextureName:String):Texture {
		return assetsTextureAtlas.getTexture(subTextureName);
	}

	//Get textures by template
	public function getTextures(subTextureName:String):Vector.<Texture> {
		return assetsTextureAtlas.getTextures(subTextureName);
	}

}
}
