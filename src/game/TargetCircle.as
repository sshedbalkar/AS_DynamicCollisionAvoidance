package game
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	import assets.Embedded_Assets;
	
	public class TargetCircle extends Sprite implements ICircle
	{
		public function TargetCircle( rad:Number )
		{
			super();
			//
			m_radius = rad;
		}
		//
		public function debugDraw():void
		{
			graphics.lineStyle(2, 0xffaabb);
			graphics.beginFill(0xFF0000);
			graphics.drawCircle( 0.0, 0.0, m_radius );
			graphics.endFill();
			alpha = 0.6;
		}
		//
		public function draw():void
		{
			var bm:Bitmap = new Bitmap( Embedded_Assets.Money_Green );
			bm.x -= bm.width * 0.5;
			bm.y -= bm.height * 0.5;
			addChild( bm );
		}
		//
		public function get radius():Number
		{
			return m_radius;
		}
		//
		private var m_radius:Number;
	}
}