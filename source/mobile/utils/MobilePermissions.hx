package mobile.utils;

import extension.androidtools.Settings;
import extension.androidtools.os.Environment;
import extension.androidtools.os.Permissions;
import extension.androidtools.os.Build;

class MobilePermissions
{
    public static function request():Void
    {
        #if android
        // checking if sdk is higher than 30 to ask for this permission
        if (Build.VERSION.SDK_INT >= 30) {
            if (!Environment.isExternalStorageManager()) {
                Settings.requestSetting("MANAGE_APP_ALL_FILES_ACCESS_PERMISSION");
            }
        }

        // media permissions.
        if (Build.VERSION.SDK_INT >= 33) {
            var permissions:Array<String> = [
                "android.permission.READ_MEDIA_IMAGES",
                "android.permission.READ_MEDIA_VIDEO",
                "android.permission.READ_MEDIA_AUDIO"
            ];
            
            // something
            if (Build.VERSION.SDK_INT >= 34) {
                permissions.push("android.permission.READ_MEDIA_VISUAL_USER_SELECTED");
            }

            Permissions.requestPermissions(permissions);
        } else {
            // something part 2
            Permissions.requestPermissions(["android.permission.READ_EXTERNAL_STORAGE", "android.permission.WRITE_EXTERNAL_STORAGE"]);
        }
        #end
    }
}

