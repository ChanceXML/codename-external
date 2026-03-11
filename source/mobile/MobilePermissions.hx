package mobile;

#if sys
import sys.FileSystem;
import sys.io.File;
#end

#if android
import extension.androidtools.os.Build.VERSION as AndroidVersion;
import extension.androidtools.os.Build.VERSION_CODES as AndroidVersionCode;
import extension.androidtools.Permissions as AndroidPermissions;
import extension.androidtools.os.Environment as AndroidEnvironment;
import extension.androidtools.Settings as AndroidSettings;
import lime.system.System;
#end

class StorageUtil
{
	#if sys
	public static function getStorageDirectory():String
		return #if android haxe.io.Path.addTrailingSlash(AndroidContext.getExternalFilesDir()) #elseif ios lime.system.System.documentsDirectory #else Sys.getCwd() #end;
	#end

	#if android
	public static function getExternalStorageDirectory():String
		return "/storage/emulated/0/.CodenameEngine/";

	public static function getModsPath():String
	{
		final externalFile:String = System.applicationStorageDirectory + "external.txt";
		final externalStatus:String = FileSystem.exists(externalFile) ? File.getContent(externalFile) : "false";
		return externalStatus == "true" ? StorageUtil.getExternalStorageDirectory() : StorageUtil.getStorageDirectory();
	}

	public static function requestPermissions():Void
	{
		if (AndroidVersion.SDK_INT >= AndroidVersionCode.TIRAMISU)
			AndroidPermissions.requestPermissions([
				"READ_MEDIA_IMAGES",
				"READ_MEDIA_VIDEO",
				"READ_MEDIA_AUDIO",
				"READ_MEDIA_VISUAL_USER_SELECTED"
			]);
		else
			AndroidPermissions.requestPermissions([
				"READ_EXTERNAL_STORAGE",
				"WRITE_EXTERNAL_STORAGE"
			]);

		if (!AndroidEnvironment.isExternalStorageManager())
			AndroidSettings.requestSetting("MANAGE_APP_ALL_FILES_ACCESS_PERMISSION");

		try
		{
			if (!FileSystem.exists(StorageUtil.getStorageDirectory()))
				FileSystem.createDirectory(StorageUtil.getStorageDirectory());
		}
		catch (e:Dynamic)
		{
			lime.system.System.exit(1);
		}
	}
	#end
}
