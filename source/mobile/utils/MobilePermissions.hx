package mobile.utils;

#if android
import extension.androidtools.os.Build.VERSION as AndroidVersion;
import extension.androidtools.os.Build.VERSION_CODES as AndroidVersionCode;
import extension.androidtools.os.Environment as AndroidEnvironment;
import extension.androidtools.Settings as AndroidSettings;
import extension.androidtools.Permissions as AndroidPermissions;
#end

class AndroidHelper {

    public static function request():Void {
        #if android
        if (AndroidVersion.SDK_INT >= AndroidVersionCode.R) {
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
