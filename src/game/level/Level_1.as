package game.level
{
	public class Level_1 implements ILevel
	{
		public function Level_1()
		{
			//
		}
		//
		public function load():void
		{
			m_scene = new Scene();
			m_scene.create();
			m_scene.add();
		}
		public function update( dt:Number ):void
		{
			
		}
		public function unload():void
		{
			m_scene.remove();
			m_scene.cleanup();
		}
		//
		private var m_scene:Scene;
	}
}