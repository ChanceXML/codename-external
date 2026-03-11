package mobile.utils;

#if android
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxRect;
import flixel.input.touch.FlxTouch;

class MobileMouseOverlay extends FlxSprite
{
    var isDragging:Bool = false;
    var lastTouchX:Float = 0;
    var lastTouchY:Float = 0;

    public function new()
    {
        super();
        loadGraphic("assets/images/game/mouse/cursor.png");
        scrollFactor.set();
        width = 44;
        height = 44;
        offset.set(0, 0);

        if (FlxG.state != null && !FlxG.state.members.contains(this))
            FlxG.state.add(this);

        FlxG.signals.postStateSwitch.add(() -> {
            if (!FlxG.state.members.contains(this))
                FlxG.state.add(this);
        });
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);

        var touch:FlxTouch = FlxG.touches.list.length > 0 ? FlxG.touches.list[0] : null;

        if (touch != null)
        {
            if (isDragging)
            {
                x += touch.screenX - lastTouchX;
                y += touch.screenY - lastTouchY;
            }
            else
            {
                x = touch.screenX;
                y = touch.screenY;
            }

            lastTouchX = touch.screenX;
            lastTouchY = touch.screenY;

            isDragging = touch.pressed;

            if (touch.justPressed)
                loadGraphic("assets/images/game/mouse/click.png");
            else
                loadGraphic("assets/images/game/mouse/cursor.png");
        }
    }

    public static var instance:MobileMouseOverlay;

    public static function init():Void
    {
        if (instance == null)
            instance = new MobileMouseOverlay();
    }
}
#end
