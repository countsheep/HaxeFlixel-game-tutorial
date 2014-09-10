package ;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxAngle;
import flixel.FlxObject;
import flixel.group.FlxTypedGroup;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

class Candy extends FlxSprite
{
    public function new(X:Float=0, Y:Float=0) 
    {
        super(X, Y);
        loadGraphic(AssetPaths.candy__png, false, 16, 16);
	}
    
    override public function kill():Void
    {
        alive = false;
        FlxTween.tween(this, { alpha:0, y:y - 16 }, .33, { ease:FlxEase.circOut, complete:finishKill } );
    }

    private function finishKill(tween:FlxTween):Void
    {
        exists = false;
    }
}