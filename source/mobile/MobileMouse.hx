package mobile;

#if android
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;

class MobileMouseOverlay extends FlxSprite
{
    var isDragging:Bool = false;
    var lastTouch:FlxPoint = new FlxPoint();

    public function new()
    {
        super();
        loadGraphic("assets/images/game/mouse/cursor.png");
        scrollFactor.set();
        width = 44;
        height = 44;
        offset.set(0, 0);
        FlxG.signals.onStateSwitch.add(() -> if (!FlxG.state.members.contains(this)) FlxG.state.add(this));
        if (FlxG.state != null) FlxG.state.add(this);
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);
        var touch = FlxG.touches.list.length > 0 ? FlxG.touches.list[0] : null;
        if (touch != null)
        {
            if (isDragging)
            {
                x += touch.screenX - lastTouch.x;
                y += touch.screenY - lastTouch.y;
            }
            else
            {
                x = touch.screenX;
                y = touch.screenY;
            }
            lastTouch.set(touch.screenX, touch.screenY);
        }

        if (touch != null && touch.justPressed)
            loadGraphic("assets/images/game/mouse/click.png");
        else
            loadGraphic("assets/images/game/mouse/cursor.png");

        isDragging = touch != null && touch.pressed;
    }

    public static var instance:MobileMouseOverlay;

    public static function init():Void
    {
        if (instance == null)
        {
            instance = new MobileMouseOverlay();
        }
    }
}
#end
