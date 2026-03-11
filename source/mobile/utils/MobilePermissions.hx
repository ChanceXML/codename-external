package mobile.utils;

import extension.androidtools.Settings;
import extension.androidtools.os.Environment;
import lime.system.System;

class MobilePermissions
{
    public static function request():Void
    {
        #if android
        if (!Environment.isExternalStorageManager())
        {
            Settings.requestSetting("MANAGE_APP_ALL_FILES_ACCESS_PERMISSION");
        }

        var mediaPermissions = [
            "android.permission.READ_MEDIA_IMAGES",
            "android.permission.READ_MEDIA_VIDEO",
            "android.permission.READ_MEDIA_AUDIO",
            "android.permission.READ_MEDIA_VISUAL_USER_SELECTED"
        ];

        for (permission in mediaPermissions)
        {
            System.requestPermission(permission);
        }
        #end
    }
}
