import hxd.res.DefaultFont;
import h2d.Font;
import h2d.Anim;
import h2d.Bitmap;
import h2d.Text;
import h2d.Tile;

class Main extends hxd.App {
	var bmp:Bitmap;
	var anim:Anim;
	var tf:Text;
	var ySpeed:Int = 1;
	var xSpeed:Int = 1;
	var scaleFactor:Float = 1.1;
	var rotationFactor:Float = 0.001;

	override function init() {
		var font:Font = DefaultFont.get();

		// -- Introduction --
		// allocate a Texture with red color and creates a 100x100 Tile from it
		var tile = Tile.fromColor(0xFF0000, 50, 50);

		// create a Bitmap object, which will display the tile
		// and will be added to our 2D scene (s2d)
		bmp = new Bitmap(tile, s2d);

		// modify the display position of the Bitmap sprite
		bmp.x = s2d.width * 0.5;
		bmp.y = s2d.height * 0.5;
		bmp.tile.dx = -bmp.tile.width / 2;
		bmp.tile.dy = -bmp.tile.height / 2;

		// -- Animation --
		// creates three tiles with different color
		var t1 = Tile.fromColor(0xFF1493, 8, 8);
		var t2 = Tile.fromColor(0x00BFFF, 10, 10);
		var t3 = Tile.fromColor(0xFFFFFF, 10, 10);
		var ballTiles = [t1, t2, t3];
		for (i in 0...ballTiles.length) {
			var tile = ballTiles[i];
			tile.dx = -tile.width / 2;
			tile.dy = -tile.height / 2;
		}

		// creates an animation for these tiles
		anim = new Anim([t1, t2, t3, t2], s2d);
		anim.speed = 12;
		anim.loop = true;
		var ballText = new Text(font);
		ballText.text = 'ball';
		ballText.textAlign = Center;
		ballText.y = 10;
		anim.addChild(ballText);

		// -- Text --
		tf = new Text(font);
		tf.text = 'Pong';
		tf.textAlign = Center;
		tf.x = s2d.width / 2;
		tf.y = 10;

		// add to any parent, in this case we append to root
		s2d.addChild(tf);
	}

	// on each frame
	override function update(dt:Float) {
		// increment the display bitmap rotation by 0.1 radians
		bmp.rotation += 0.1;

		if (anim.y >= s2d.height && ySpeed > 0) {
			ySpeed = ySpeed * -1;
		} else if (anim.y <= 0 && ySpeed < 0) {
			ySpeed = ySpeed * -1;
		}

		if (anim.x >= s2d.width && xSpeed > 0) {
			xSpeed = xSpeed * -1;
		} else if (anim.x <= 0 && xSpeed < 0) {
			xSpeed = xSpeed * -1;
		}

		anim.x += xSpeed;
		anim.y += ySpeed;

		tf.scale(scaleFactor);
		if (tf.scaleX >= 2.5) {
			scaleFactor = 0.975;
		} else if (tf.scaleX <= 0.75) {
			scaleFactor = 1.025;
		}
		tf.rotation += rotationFactor;
		if (tf.rotation > 0.1) {
			rotationFactor = -0.001;
		} else if (tf.rotation < -0.1) {
			rotationFactor = 0.001;
		}
	}

	static function main() {
		new Main();
	}
}
