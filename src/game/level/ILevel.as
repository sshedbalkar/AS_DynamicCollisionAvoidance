package game.level
{
	public interface ILevel
	{
		function load():void;
		function update( dt:Number ):void;
		function unload():void;
	}
}