package mobile;

import flixel.FlxG;
import flixel.system.FlxPlugin;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.input.touch.FlxTouch;

class MobileMouse extends FlxPlugin
{
    var cursor:FlxSprite;

    var lastX:Float = 0;
    var lastY:Float = 0;
    var dragging:Bool = false;

    var sensitivity:Float = 1.2;

    public function new()
    {
        super();

        cursor = new FlxSprite();
        cursor.loadGraphic("assets/images/game/mouse/cursor.png");
        cursor.scrollFactor.set();

        cursor.x = FlxG.width / 2;
        cursor.y = FlxG.height / 2;

        FlxG.mouse.visible = false;
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        if (FlxG.state != null && !FlxG.state.members.contains(cursor))
        {
            FlxG.state.add(cursor);
        }

        if (FlxG.touches.list.length > 0)
        {
            var touch:FlxTouch = FlxG.touches.list[0];

            if (touch.justPressed)
            {
                lastX = touch.screenX;
                lastY = touch.screenY;
                dragging = true;
            }

            if (dragging)
            {
                var dx = touch.screenX - lastX;
                var dy = touch.screenY - lastY;

                cursor.x += dx * sensitivity;
                cursor.y += dy * sensitivity;

                lastX = touch.screenX;
                lastY = touch.screenY;
            }

            if (touch.justReleased)
            {
                dragging = false;
            }
        }

        cursor.x = FlxMath.bound(cursor.x, 0, FlxG.width - cursor.width);
        cursor.y = FlxMath.bound(cursor.y, 0, FlxG.height - cursor.height);

        updateCursor();
    }

    function updateCursor()
    {
        var hovering:Bool = false;

        for (obj in FlxG.state.members)
        {
            if (obj != null && obj.exists && obj.visible)
            {
                if (Std.isOfType(obj, flixel.ui.FlxButton))
                {
                    var btn:flixel.ui.FlxButton = cast obj;
                    if (cursor.overlaps(btn))
                    {
                        hovering = true;
                        break;
                    }
                }
            }
        }

        if (hovering)
            cursor.loadGraphic("assets/images/game/mouse/click.png");
        else
            cursor.loadGraphic("assets/images/game/mouse/cursor.png");
    }
}
