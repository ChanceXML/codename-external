package mobile.utils;

#if android
import extension.androidtools.os.Build;
import extension.androidtools.Permissions;
import extension.androidtools.os.Environment;
import extension.androidtools.Settings;
#end

class AndroidHelper
{
    #if android
    public static function checkStoragePermission():Void
    {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R)
        {
            if (!Environment.isExternalStorageManager())
                Settings.requestSetting("MANAGE_APP_ALL_FILES_ACCESS_PERMISSION");
        }
        else
        {
            Permissions.requestPermissions([
                "android.permission.READ_EXTERNAL_STORAGE",
                "android.permission.WRITE_EXTERNAL_STORAGE"
            ]);
        }
    }
    #end
}
