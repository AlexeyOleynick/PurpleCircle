/**
 * Created by OOliinyk on 7/4/13.
 */
package game.level.arena.battlefield.model {
import flash.geom.Rectangle;

import game.level.model.*;

import nape.phys.Body;
import nape.phys.BodyType;
import nape.shape.Polygon;

public class Fluid extends PhysicsBodyContainer {


	public function Fluid(rectangle:Rectangle) {

		body = new Body(BodyType.STATIC);

		var fluidShape:Polygon = new Polygon(Polygon.rect(rectangle.x, rectangle.y, rectangle.width, rectangle.height));
		fluidShape.fluidEnabled = true;
		fluidShape.fluidProperties.viscosity = 0.9;

		body.shapes.add(fluidShape);
	}

}
}
