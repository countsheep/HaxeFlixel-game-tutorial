package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxMath;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.tile.FlxTilemap;
import flixel.FlxObject;
import flixel.FlxCamera;
import flixel.group.FlxTypedGroup;

/**
 * A FlxState which can be used for the actual gameplay.
 */
class PlayState extends FlxState
{
	private var _player:Player;
	private var _map:FlxOgmoLoader;
	private var _mWalls:FlxTilemap;
	private var _grpCandy:FlxTypedGroup<Candy>;
	/**
	 * Function that is called up when to state is created to set it up. 
	 */
	override public function create():Void
	{
		_map = new FlxOgmoLoader(AssetPaths.room_002__oel);
		_mWalls = _map.loadTilemap(AssetPaths.tiles__png, 32, 32, "walls");
		_mWalls.setTileProperties(0, FlxObject.NONE);
		_mWalls.setTileProperties(1, FlxObject.ANY);
		add(_mWalls);

		_grpCandy = new FlxTypedGroup<Candy>();
		add(_grpCandy);

		_player = new Player();
		_map.loadEntities(placeEntities, "entities");
		add(_player);
		FlxG.camera.follow(_player, FlxCamera.STYLE_TOPDOWN, 1);
		super.create();
	}

	private function placeEntities(entityName:String, entityData:Xml):Void
	{
	    var x:Int = Std.parseInt(entityData.get("x"));
	    var y:Int = Std.parseInt(entityData.get("y"));
	    if (entityName == "player")
	    {
	        _player.x = x;
	        _player.y = y;    }
	    else if (entityName == "candy")
		{
		    _grpCandy.add(new Candy(x + 4, y + 4));
		}
	}
		
	/**
	 * Function that is called when this state is destroyed - you might want to 
	 * consider setting all objects this state uses to null to help garbage collection.
	 */
	override public function destroy():Void
	{
		super.destroy();
	}

	/**
	 * Function that is called once every frame.
	 */
	override public function update():Void
	{
		_player.movement();
		super.update();
		FlxG.collide(_player, _mWalls);
		FlxG.overlap(_player, _grpCandy, playerTouchCandy);
	}
	private function playerTouchCandy(P:Player, C:Candy):Void
{
    if (P.alive && P.exists && C.alive && C.exists)
    {
        C.kill();
    }
}
}