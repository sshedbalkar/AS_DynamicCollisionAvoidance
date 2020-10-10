package game.player
{
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	
	import assets.Embedded_Assets;
	
	public class PlayerView_1 extends Sprite
	{
		public function PlayerView_1()
		{
			super();
		}
		//
		public function create():void
		{
			var disp:Bitmap = new Bitmap( Embedded_Assets.Star_Red );
			disp.x -= disp.width * 0.5;
			disp.y -= disp.height * 0.5;
			addChild( disp );
			//var sh:Shape = new Shape();
			graphics.lineStyle(2, 0xffffff);
			graphics.beginFill(0xFFffff);
			graphics.drawCircle( 0.0, 0.0, 25 );
			graphics.endFill();
			//addChild( sh );
		}
	}
}