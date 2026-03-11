package mobile.utils;

import extension.androidtools.Settings;
import extension.androidtools.os.Environment;
import extension.androidtools.Permissions;
import extension.androidtools.os.Build;
import extension.androidtools.os.Build.VERSION;
import extension.androidtools.os.Build.VERSION_CODES;

class MobilePermissions
{
    public static function request():Void
    {
        #if android
        if (VERSION.SDK_INT >= VERSION_CODES.R) {
            if (!Environment.isExternalStorageManager()) {
                Settings.requestSetting("MANAGE_APP_ALL_FILES_ACCESS_PERMISSION");
            }
        }

        if (VERSION.SDK_INT >= VERSION_CODES.TIRAMISU) {
            var permissions:Array<String> = [
                "android.permission.READ_MEDIA_IMAGES",
                "android.permission.READ_MEDIA_VIDEO",
                "android.permission.READ_MEDIA_AUDIO"
            ];
            
            if (VERSION.SDK_INT >= VERSION_CODES.UPSIDE_DOWN_CAKE) {
                permissions.push("android.permission.READ_MEDIA_VISUAL_USER_SELECTED");
            }

            Permissions.requestPermissions(permissions);
        } else {
            Permissions.requestPermissions(["android.permission.READ_EXTERNAL_STORAGE", "android.permission.WRITE_EXTERNAL_STORAGE"]);
        }
        #end
    }
}
