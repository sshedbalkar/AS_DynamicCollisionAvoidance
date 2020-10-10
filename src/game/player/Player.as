package game.player
{
	import flash.display.DisplayObject;
	import flash.geom.Vector3D;
	
	import game.ICircle;
	import game.ai.steering.Boid;

	public class Player
	{
		public function Player( iid:int )
		{
			super();
			//
			m_id = iid;
			m_pointsToTrace = new Array();
			m_boid = new Boid( 0, 0, 20, 25 );
			m_currentTarget = new Vector3D();
			m_update = true;
		}
		//
		public function set x( x1:Number ):void
		{
			m_view.x = m_boid.x = x1;
		}
		public function set y( y1:Number ):void
		{
			m_view.y = m_boid.y = y1;
		}
		public function init( disp:DisplayObject ):void
		{
			m_view = disp;
		}
		//
		public function get view():DisplayObject
		{
			return m_view;
		}
		//
		public function tracePoints( arr:Array ):void
		{
			m_pointsToTrace = arr;
			if( arr.length > 0 )
			{
				m_boid.setSeekTarget( arr[0].x, arr[0].y );
				var obj:Object = m_pointsToTrace.shift();
				m_currentTarget.x = obj.x;
				m_currentTarget.y = obj.y;
			}
		}
		//
		public function avoid( vec:Vector.<ICircle> ):void
		{
			m_boid.avoid( vec );
		}
		//
		public function update( dt:Number ):void
		{
			if( m_update )
			{
				m_boid.update( dt );
				m_view.x = m_boid.x;
				m_view.y = m_boid.y;
				m_view.rotation = m_boid.rotation;
				if( m_id == 1 )
				{
					//trace( "x: "+m_view.x+", y: "+m_view.y+", r: "+m_boid.rotation );
				}
				//Math.random();
				//
				var dist:Number = Boid.distance(m_currentTarget, m_boid);
				if( m_id == 2 )
				{
					trace( "dist: "+dist );
				}
				if( dist < DIST_EPSILON )
				{
					if( m_id == 2 )
					{
						trace( "changed targetttttttttttttttttttttttttttttt" );
					}
					if( m_pointsToTrace.length > 0 )
					{
						var obj:Object = m_pointsToTrace.shift();
						m_currentTarget.x = obj.x;
						m_currentTarget.y = obj.y;
						m_boid.setSeekTarget( obj.x, obj.y );
					}
					else
					{
						m_update = false;
					}
				}
			}
		}
		public function get collider():ICircle
		{
			return m_boid;
		}
		//
		public function get id():int
		{
			return m_id;
		}
		//
		private var m_view:DisplayObject;
		private var m_id:int;
		private var m_pointsToTrace:Array = null;
		private var m_boid:Boid;
		private var m_currentTarget:Vector3D;
		private static const DIST_EPSILON:Number = 20.0;
		private var m_update:Boolean;
	}
}