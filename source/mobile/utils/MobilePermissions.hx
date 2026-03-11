package mobile;

#if android
import android.os.Build;
import android.os.Environment;
import android.content.Intent;
import android.provider.Settings;
import android.net.Uri;
import lime.app.Application;
#end

class FilePermissionHelper {

    public static function requestAllFilesAccess():Void {
        #if android
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
        
            if (!Environment.isExternalStorageManager()) {
                try {
                    var intent = new Intent(Settings.ACTION_MANAGE_APP_ALL_FILES_ACCESS_PERMISSION);
                    
                    var packageName = Application.current.meta.get("packageName");
                    var uri = Uri.parse("package:" + packageName);
                    intent.setData(uri);
                    
                    lime.app.Application.current.window.context.attributes.activity.startActivity(intent);
                    
                } catch (e:Dynamic) {
                    trace("Failed to launch All Files Access settings: " + e);
                }
            } else {
                trace("All Files Access is already granted!");
            }
            
        } else {
            var permissions = [
                "android.permission.READ_EXTERNAL_STORAGE",
                "android.permission.WRITE_EXTERNAL_STORAGE"
            ];
            lime.system.System.requestPermissions(permissions);
        }
        #else
        trace("This permission request is only necessary on Android.");
        #end
    }
}
