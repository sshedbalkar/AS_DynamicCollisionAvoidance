package game.level
{
	import flash.display.Sprite;
	
	import game.Game;

	public class Scene extends Sprite
	{
		public function Scene()
		{
			//
		}
		//
		public function create():void
		{
			
		}
		//
		public function cleanup():void
		{
			
		}
		//
		public function add():void
		{
			Game.STAGE.addChild( this );
		}
		//
		public function remove():void
		{
			Game.STAGE.removeChild( this );
		}
		
	}
}