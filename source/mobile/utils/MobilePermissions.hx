package mobile.utils;

#if android
import extension.androidtools.os.Build as AndroidBuild;
import extension.androidtools.os.Environment as AndroidEnvironment;
import extension.androidtools.Settings as AndroidSettings;
import extension.androidtools.Permissions as AndroidPermissions;
#end

class AndroidHelper {

    public static function checkStoragePermission():Void {
        #if android
        if (AndroidBuild.SDK_INT >= 30) {
            if (!AndroidEnvironment.isExternalStorageManager()) {
                AndroidSettings.requestSetting("MANAGE_APP_ALL_FILES_ACCESS_PERMISSION");
            }
        } else {
            AndroidPermissions.requestPermissions([
                "android.permission.READ_EXTERNAL_STORAGE", 
                "android.permission.WRITE_EXTERNAL_STORAGE"
            ]);
        }
        #end
    }
}
