package game.level.arena.battlefield.model {
import flash.geom.Rectangle;

import game.level.model.*;

import nape.phys.Body;
import nape.phys.BodyType;
import nape.phys.Material;
import nape.shape.Polygon;

public class Border extends PhysicsBodyContainer {

	public function Border(rectangle:Rectangle) {
		var r:Rectangle = rectangle;

		body = new Body(BodyType.STATIC);

		var topShape:Polygon = createPolygon(r.topLeft.x, r.topLeft.y, r.width, 1);
		var leftShape:Polygon = createPolygon(r.topLeft.x, r.topLeft.y, 1, r.height);
		var bottomShape:Polygon = createPolygon(r.bottomRight.x, r.bottomRight.y, -r.width, -1);
		var rightShape:Polygon = createPolygon(r.bottomRight.x, r.bottomRight.y, -1, -r.height);

		var material:Material = Material.rubber();

		topShape.material = material;
		leftShape.material = material;
		bottomShape.material = material;
		rightShape.material = material;

		body.shapes.add(topShape);
		body.shapes.add(leftShape);
		body.shapes.add(bottomShape);
		body.shapes.add(rightShape);
	}

	private function createPolygon(x:Number, y:Number, width:Number, height:Number):Polygon {
		return new Polygon(Polygon.rect(x, y, width, height));
	}

}
}
