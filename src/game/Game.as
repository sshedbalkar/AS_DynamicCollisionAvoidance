package game
{
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import assets.Embedded_Assets;
	
	import game.player.Player;
	import game.player.PlayerView_1;
	import game.player.PlayerView_2;
	
	public class Game extends Sprite
	{
		public function Game()
		{
			super();
			//
			addEventListener( Event.ADDED_TO_STAGE, init );
			m_obstacles = new Vector.<ICircle>();
		}
		//
		public function init( e:Event = null ):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, init );
			//
			Embedded_Assets.init();
			//
			STAGE = stage;
			EVENT_MANAGER = this;
			//
			addBG();
			createPlayers();
			assignTracePoints();
			createObstacles();
			assignObstacles();
		}
		//
		private function createObstacles():void
		{
			var tp1:TargetCircle;
			tp1 = new TargetCircle( 80.0 );
			tp1.x = 410;
			tp1.y = 325;
			tp1.debugDraw();
			addChild( tp1 );
			m_obstacles.push( tp1 );
			//
			var tp2:TargetCircle;
			tp2 = new TargetCircle( 80.0 );
			tp2.x = 512;
			tp2.y = 325;
			tp2.debugDraw();
			addChild( tp2 );
			m_obstacles.push( tp2 );
			//
			var tp3:TargetCircle;
			tp3 = new TargetCircle( 80.0 );
			tp3.x = 614;
			tp3.y = 325;
			tp3.debugDraw();
			addChild( tp3 );
			m_obstacles.push( tp3 );
		}
		//
		private function assignObstacles():void
		{
			var vec:Vector.<ICircle>;
			for each( var pl1:Player in m_players )
			{
				vec = new Vector.<ICircle>();
				for each( var pl2:Player in m_players )
				{
					if( pl1 === pl2 ) continue;
					vec.push( pl2.collider );
				}
				for each( var obs:ICircle in m_obstacles )
				{
					vec.push( obs );
				}
				pl1.avoid( vec );
			}
		}
		//
		private function assignTracePoints():void
		{
			/*
			for each( var pl:Player in m_players )
			{
				var arr1:Array = getRandomTracePoints( 5 );
				var sh1:Shape = drawTargetPoints( arr1 );
				addChildAt( sh1, 1 );
				pl.tracePoints( arr1 );
			}
			*/
			var arr1:Array = getRandomTracePoints1( 5 );
			var sh1:Shape = drawTargetPoints( arr1 );
			addChildAt( sh1, 1 );
			m_players[0].tracePoints( arr1 );
			//
			var arr2:Array = getRandomTracePoints2( 5 );
			var sh2:Shape = drawTargetPoints( arr2 );
			addChildAt( sh2, 1 );
			m_players[1].tracePoints( arr2 );
		}
		private function drawTargetPoints( arr:Array ):Shape
		{
			var sh:Shape = new Shape();
			sh.graphics.lineStyle( 4, 0xFF0000 );
			sh.graphics.moveTo( arr[0].x, arr[0].y );
			for( var l:uint = 1; l < arr.length; ++l )
			{
				sh.graphics.lineTo( arr[l].x, arr[l].y );
			}
			//
			return sh;
		}
		//
		private function getRandomTracePoints1( len:int ):Array
		{
			var arr:Array = new Array();
			var x1:int;
			var y1:int;
			var tp:TargetCircle;
			//
			tp = new TargetCircle( 10.0 );
			tp.x = 400;
			tp.y = 150;
			tp.draw();
			addChild( tp );
			arr.push( tp );
			//
			tp = new TargetCircle( 10.0 );
			tp.x = 220;
			tp.y = 330;
			tp.draw();
			addChild( tp );
			arr.push( tp );
			//
			tp = new TargetCircle( 10.0 );
			tp.x = 400;
			tp.y = 510;
			tp.draw();
			addChild( tp );
			arr.push( tp );
			//
			tp = new TargetCircle( 10.0 );
			tp.x = 660;
			tp.y = 510;
			tp.draw();
			addChild( tp );
			arr.push( tp );
			//
			tp = new TargetCircle( 10.0 );
			tp.x = 830;
			tp.y = 330;
			tp.draw();
			addChild( tp );
			arr.push( tp );
			//
			return arr;
		}
		//
		private function getRandomTracePoints2( len:int ):Array
		{
			var arr:Array = new Array();
			var x1:int;
			var y1:int;
			var tp:TargetCircle;
			//
			tp = new TargetCircle( 10.0 );
			tp.x = 400;
			tp.y = 194;
			tp.draw();
			addChild( tp );
			arr.push( tp );
			//
			tp = new TargetCircle( 10.0 );
			tp.x = 190;
			tp.y = 390;
			tp.draw();
			addChild( tp );
			arr.push( tp );
			//
			tp = new TargetCircle( 10.0 );
			tp.x = 400;
			tp.y = 450;
			tp.draw();
			addChild( tp );
			arr.push( tp );
			//
			tp = new TargetCircle( 10.0 );
			tp.x = 660;
			tp.y = 450;
			tp.draw();
			addChild( tp );
			arr.push( tp );
			//
			tp = new TargetCircle( 10.0 );
			tp.x = 770;
			tp.y = 330;
			tp.draw();
			addChild( tp );
			arr.push( tp );
			//
			return arr;
		}
		//
		private function getRandomTracePoints( len:int ):Array
		{
			var arr:Array = new Array();
			var x1:int;
			var y1:int;
			var tp:TargetCircle;
			for( var l:int = len - 1; l > -1; --l )
			{
				x1 = Math.ceil( Math.random() * Game.STAGE.stageWidth );
				y1 = Math.ceil( Math.random() * Game.STAGE.stageHeight );
				tp = new TargetCircle( 10.0 );
				tp.x = x1;
				tp.y = y1;
				tp.draw();
				addChild( tp );
				arr.push( tp );
			}
			//
			return arr;
		}
		//
		public static function getInstance():Game
		{
			if( m_game == null )
			{
				m_game = new Game();
			}
			return m_game;
		}
		//
		public function update( dt:Number ):void
		{
			for each( var player:Player in m_players )
			{
				player.update( dt );
			}
		}
		//
		private function createPlayers():void
		{
			m_players = new Vector.<Player>();
			var v1:PlayerView_1 = new PlayerView_1();
			v1.create();
			var player:Player = new Player( 1 );
			player.init( v1 );
			addChild( player.view );
			player.view.scaleX = 0.5;
			player.view.scaleY = 0.5;
			player.x = 500;
			player.y = 150;
			m_players.push( player );
			//
			player = new Player( 2 );
			var v2:PlayerView_2 = new PlayerView_2();
			v2.create();
			player.init( v2 );
			addChild( player.view );
			player.view.scaleX = 0.5;
			player.view.scaleY = 0.5;
			player.x = 500;
			player.y = 194;
			m_players.push( player );
		}
		//
		private function addBG():void
		{
			m_bg = new Bitmap( Embedded_Assets.BG_Img );
			var asp:Number = stage.stageWidth / stage.stageHeight;
			m_bg.height = stage.stageHeight;
			m_bg.width = stage.stageWidth;
			//
			addChild( m_bg );
		}
		//
		public function get players():Vector.<Player>
		{
			return m_players;
		}
		//
		private var m_bg:Bitmap;
		private var m_players:Vector.<Player>;
		private var m_obstacles:Vector.<ICircle>;
		private static var m_game:Game = null;
		//
		public static var STAGE:Stage;
		public static var EVENT_MANAGER:EventDispatcher;
	}
}