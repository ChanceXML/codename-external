package mobile.controls;

import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.ui.FlxButton;
import flixel.input.keyboard.FlxKey;
import openfl.events.KeyboardEvent;
import openfl.Lib;
import flixel.FlxCamera;

class MobileControls extends FlxGroup
{
    public static inline var NONE:Int = -1;
    public static inline var UP_DOWN:Int = 0;
    public static inline var LEFT_RIGHT:Int = 1;
    public static inline var FULL:Int = 2;
    public static inline var A_B:Int = 0;
    public static inline var A_B_X_Y:Int = 1;

    var cam:FlxCamera;

    public function new(dpad:Int, actions:Int, camera:FlxCamera)
    {
        super();
        cam = camera;
        createDpad(dpad);
        createActions(actions);
    }

    function createButton(x:Float, y:Float, img:String, key:String)
    {
        var btn = new FlxButton(x, y);
        btn.loadGraphic("assets/images/mobile/buttons/" + img + ".png");
        btn.alpha = 0.5;
        var pressed:Bool = false;

        btn.onDown.callback = function()
        {
            if (pressed) return;
            pressed = true;
            btn.alpha = 0.9;
            triggerKey(key, true);
            triggerKey(key, false);
        };

        btn.onUp.callback = function()
        {
            pressed = false;
            btn.alpha = 0.5;
        };

        btn.onOut.callback = btn.onUp.callback;
        btn.cameras = [cam];
        add(btn);
    }

    function createDpad(type:Int)
    {
        switch(type)
        {
            case UP_DOWN:
                createButton(32.5, 432.5, "UP", "UP");
                createButton(32.5, 582.5, "DOWN", "DOWN");
            case LEFT_RIGHT:
                createButton(32.5, 582.5, "LEFT", "LEFT");
                createButton(177.5, 582.5, "RIGHT", "RIGHT");
            case FULL:
                createButton(137.5, 387.5, "UP", "UP");
                createButton(22.5, 482.5, "LEFT", "LEFT");
                createButton(257.5, 482.5, "RIGHT", "RIGHT");
                createButton(137.5, 592.5, "DOWN", "DOWN");
        }
    }

    function createActions(type:Int)
    {
        switch(type)
        {
            case NONE:

            case A_B:
                createButton(982.5, 582.5, "A", "ENTER");
                createButton(1132.5, 582.5, "B", "BACKSPACE");
            case A_B_X_Y:
                createButton(982.5, 432.5, "Y", "TAB");
                createButton(1135.5, 432.5, "X", "7");
                createButton(982.5, 582.5, "A", "ENTER");
                createButton(1132.5, 582.5, "B", "BACKSPACE");
        }
    }

    function triggerKey(key:String, pressed:Bool)
    {
        var type = pressed ? KeyboardEvent.KEY_DOWN : KeyboardEvent.KEY_UP;
        var evt = new KeyboardEvent(type, true, false, 0, getFlxKeyCode(key));
        Lib.current.stage.dispatchEvent(evt);
    }

    function getFlxKeyCode(key:String):Int
    {
        switch(key)
        {
            case "UP": return 38;
            case "DOWN": return 40;
            case "LEFT": return 37;
            case "RIGHT": return 39;
            case "ENTER": return 13;
            case "BACKSPACE": return 8;
            case "TAB": return 9;
            case "7": return 55;
            default: return 0;
        }
    }
		}
