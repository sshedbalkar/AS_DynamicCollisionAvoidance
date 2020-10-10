package game.ai.steering
{
	import flash.geom.Vector3D;
	
	import game.ICircle;

	public class Boid implements ICircle
	{
		public static const MAX_FORCE 			:Number = 7.2;
		public static const MAX_VELOCITY 		:Number = 8;
		public static const MAX_AVOID_AHEAD	 	:Number = 100;
		public static const AVOID_FORCE	 		:Number = 450;
		//
		private var position 	:Vector3D;
		private var velocity 	:Vector3D;
		private var desired 	:Vector3D;
		private var ahead 		:Vector3D;
		private var ahead2 		:Vector3D;
		private var steering 	:Vector3D;
		private var avoidance 	:Vector3D;
		private var mass		:Number;
		private var m_radius	:Number;
		private var m_avoidList	:Vector.<ICircle>;
		private var m_seekTarget:Vector3D;
		//
		public function Boid( posX:Number, posY:Number, totalMass:Number, rad:Number )
		{
			position 	= new Vector3D(posX, posY);
			velocity 	= new Vector3D(-1, -2);
			desired	 	= new Vector3D(0, 0); 
			steering 	= new Vector3D(0, 0); 
			ahead 		= new Vector3D(0, 0); 
			avoidance 	= new Vector3D(0, 0); 
			mass	 	= totalMass;
			m_seekTarget= new Vector3D(0, 0);
			m_radius 	= rad;
			
			truncate(velocity, MAX_VELOCITY);
		}
		public function avoid( vec:Vector.<ICircle> ):void
		{
			m_avoidList = vec;
		}
		public function setSeekTarget( x1:Number, y1:Number ):void
		{
			m_seekTarget.x = x1;
			m_seekTarget.y = y1;
		}
		public function set x( x1:Number ):void
		{
			position.x = x1;
		}
		public function set y( y1:Number ):void
		{
			position.y = y1;
		}
		public function get radius():Number
		{
			return m_radius;
		}
		public function get x():Number
		{
			return position.x;
		}
		public function get y():Number
		{
			return position.y;
		}
		private function seek( target:Vector3D ):Vector3D
		{
			var force:Vector3D;
			desired = target.subtract(position);
			desired.normalize();
			desired.scaleBy(MAX_VELOCITY);
			//force = desired;
			force = desired.subtract(velocity);
			
			return force;
		}
		
		private function collisionAvoidance( arr:Vector.<ICircle> ):Vector3D
		{
			var tv :Vector3D = velocity.clone();
			tv.normalize();
			tv.scaleBy(MAX_AVOID_AHEAD * velocity.length / MAX_VELOCITY);
			
			ahead = position.clone().add(tv);
			
			var mostThreatening:ICircle = null;
			
			for each( var cir:ICircle in arr )
			{
				var collision:Boolean = lineIntersecsCircle( position, ahead, cir );
				if( collision )
				{
					trace( "can collideeee" );
				}
				if( collision && (mostThreatening == null || distance(position, cir) < distance(position, mostThreatening)) )
				{
					mostThreatening = cir;
				}
			}
			
			if (mostThreatening != null)
			{
				//alpha = 0.4; // make the boid a little bit transparent to indicate it is colliding
				
				avoidance.x = ahead.x - mostThreatening.x;
				avoidance.y = ahead.y - mostThreatening.y;
				
				avoidance.normalize();
				avoidance.scaleBy(AVOID_FORCE);
			}
			else
			{
				//alpha = 1; // make the boid opaque to indicate there is no collision.
				avoidance.scaleBy(0); // nullify the avoidance force
			}
			
			return avoidance;
		}
		
		public static function distance( a:Object, b:Object ):Number
		{
			return Math.sqrt((a.x - b.x) * (a.x - b.x)  + (a.y - b.y) * (a.y - b.y));
		}
		
		private function lineIntersecsCircle( position:Vector3D, ahead:Vector3D, c:ICircle ):Boolean
		{
			var tv:Vector3D = velocity.clone();
			tv.normalize();
			tv.scaleBy(MAX_AVOID_AHEAD * 0.5 * velocity.length / MAX_VELOCITY);
			
			ahead2 = position.clone().add(tv);
			return distance(c, ahead) <= c.radius || distance(c, ahead2) <= c.radius || distance(c, this) <= c.radius;
		}
		
		public function truncate( vector:Vector3D, max:Number ):void
		{
			var i:Number;
			
			i = max / vector.length;
			i = i < 1.0 ? i : 1.0;
			
			vector.scaleBy(i);
		}
		
		public function getAngle( vector:Vector3D ):Number
		{
			return Math.atan2(vector.y, vector.x);
		}
		public function get rotation():Number
		{
			return 90.0 + ((180.0 * getAngle(velocity)) / Math.PI);
		}
		public function update( dt:Number ):void
		{
			steering = seek(m_seekTarget);
			//steering = steering.add(collisionAvoidance(m_avoidList));
			
			truncate(steering, MAX_FORCE);
			//steering.scaleBy(1 / mass);
			steering.scaleBy( dt );
			
			velocity = velocity.add(steering);
			truncate(velocity, MAX_VELOCITY);
			
			position = position.add(velocity);
			
			//x = position.x;
			//y = position.y;
			
			// Adjust boid rodation to match the velocity vector.
			//rotation = 90 + (180 * getAngle(velocity)) / Math.PI;
		}
	}
}