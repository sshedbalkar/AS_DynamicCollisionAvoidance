package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	
	import game.Game;
	
	[SWF(width="1024", height="768", backgroundColor="#000000", frameRate="30")]
	public class Dyn_CollisionAvoidance extends Sprite
	{
		public function Dyn_CollisionAvoidance()
		{
			addEventListener( Event.ADDED_TO_STAGE, init );
		}
		//
		private function init( e:Event = null ):void 
		{
			removeEventListener( Event.ADDED_TO_STAGE, init );
			//
			stage.frameRate = 30;
			//
			//m_game = new Game();
			addChild( Game.getInstance() );
			//
			trace( "w: "+stage.stageWidth+", h: "+stage.stageHeight );
			//
			stage.addEventListener( Event.ENTER_FRAME, enterFrame );
			stage.addEventListener( MouseEvent.MOUSE_MOVE, mouseMove );
		}
		
		private function mouseMove( e:MouseEvent ):void
		{
			//Game.mouse.x = e.stageX;
			//Game.mouse.y = e.stageY;
			//trace( "x: "+e.stageX+", y: "+e.stageY );
		}
		
		private function enterFrame( e:Event ):void
		{
			var time:Number = getTimer();
			var dt:Number = ( time - m_lastTime )/1000.0;
			m_lastTime = time;
			//trace( "enter frame: "+dt );
			dt = 0.03333333;
			//
			Game.getInstance().update( dt );
		}
		//
		private var m_game:Game;
		private var m_lastTime:Number = 0;
	}
}