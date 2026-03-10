package funkin.options.categories;

import flixel.FlxG;
import funkin.options.Options;
import funkin.options.type.Checkbox;
import funkin.options.type.SliderOption;

class AndroidOptions extends TreeMenuScreen {

    public function new() {
        super('optionsTree.android-name', 'optionsTree.android-desc', '');

        add(new Checkbox(
            getNameID('hitboxHints'),
            getDescID('hitboxHints'),
            'hitboxHints'
        ));

        add(new SliderOption(
            getNameID('hitboxOpacity'),
            getDescID('hitboxOpacity'),
            0,
            1,
            0.05,
            5,
            'hitboxOpacity'
        ));
    }
}
