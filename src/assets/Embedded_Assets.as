package assets
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;

	public class Embedded_Assets
	{
		[Embed(source = "RG_bns_bkgd.jpg")]
		private static var m_BG_Img:Class;
		//
		[Embed(source = "RG_bns_jammerorange.png")]
		private static var m_Star_Orange:Class;
		//
		[Embed(source = "RG_bns_jammerred.png")]
		private static var m_Star_Red:Class;
		//
		[Embed(source = "moneyspot.png")]
		private static var m_green:Class;
		//
		public static var BG_Img:BitmapData;
		public static var Star_Orange:BitmapData;
		public static var Star_Red:BitmapData;
		public static var Money_Green:BitmapData;
		//
		public function Embedded_Assets()
		{
			//
		}
		//
		public static function init():void
		{
			BG_Img = ( new m_BG_Img() as Bitmap ).bitmapData;
			Star_Orange = ( new m_Star_Orange() as Bitmap ).bitmapData;
			Star_Red = ( new m_Star_Red() as Bitmap ).bitmapData;
			Money_Green = ( new m_green() as Bitmap ).bitmapData;
		}
	}
}