package mobile.utils;

import extension.androidtools.Settings;
import extension.androidtools.os.Environment;

class MobilePermissions
{
    public static function request():Void
    {
        #if android
        if (!Environment.isExternalStorageManager())
        {
            Settings.requestSetting("MANAGE_APP_ALL_FILES_ACCESS_PERMISSION");
        }
        #end
    }
}
