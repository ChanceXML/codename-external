package funkin.backend.assets;

import flixel.util.FlxSignal.FlxTypedSignal;
import funkin.backend.system.MainState;
import haxe.io.Path;
import lime.text.Font;
import openfl.text.Font as OpenFLFont;
import openfl.utils.AssetLibrary;
import openfl.utils.AssetManifest;

using StringTools;

#if (sys || MOD_SUPPORT)
import sys.FileSystem;
#end

class ModsFolder {
	@:dox(hide) public static var onModSwitch:FlxTypedSignal<String->Void> = new FlxTypedSignal<String->Void>();

	public static var currentModFolder:String = null;
	public static var modsPath:String = getDefaultModsPath();
	public static var addonsPath:String = "./addons/";
	public static var useLibFile:Bool = true;
	private static var __firstTime:Bool = true;

	public static function init() {
		if(!getModsList().contains(Options.lastLoadedMod)) {
			Options.lastLoadedMod = null;
		}
	}

	public static function switchMod(mod:String) {
		Options.lastLoadedMod = currentModFolder = mod;
		reloadMods();
	}

	public static function reloadMods() {
		if (!__firstTime)
			FlxG.switchState(new MainState());
		__firstTime = false;
	}

	public static function loadModLib(path:String, force:Bool = false, ?modName:String) {
		#if (sys || MOD_SUPPORT)
		if (FileSystem.exists('$path.zip'))
			return loadLibraryFromZip('$path'.toLowerCase(), '$path.zip', force, modName);
		else
			return loadLibraryFromFolder('$path'.toLowerCase(), '$path', force, modName);
		#else
		return null;
		#end
	}

	public static function getModsList():Array<String> {
		var mods:Array<String> = [];
		#if (sys || MOD_SUPPORT)
		if (!FileSystem.exists(modsPath)) {
			try { FileSystem.createDirectory(modsPath); } catch(e) {}
		}
		if (!FileSystem.exists(modsPath)) return mods;
		final modsList:Array<String> = FileSystem.readDirectory(modsPath);
		if (modsList == null || modsList.length <= 0) return mods;
		for (modFolder in modsList) {
			if (FileSystem.isDirectory(modsPath + modFolder)) {
				mods.push(modFolder);
			} else if (Path.extension(modFolder).toLowerCase() == 'zip') {
				mods.push(Path.withoutExtension(modFolder));
			}
		}
		#end
		return mods;
	}

	public static function getLoadedModsLibs(skipTranslated:Bool = false):Array<IModsAssetLibrary> {
		var libs = [];
		for (i in Paths.assetsTree.libraries) {
			var l = AssetsLibraryList.getCleanLibrary(i);
			#if TRANSLATIONS_SUPPORT
			if(skipTranslated && (l is TranslatedAssetLibrary)) continue;
			#end
			if (l is ScriptedAssetLibrary || l is IModsAssetLibrary) libs.push(cast(l, IModsAssetLibrary));
		}
		return libs;
	}

	public static function getLoadedMods(skipTranslated:Bool = false):Array<String>
		return [for (modLib in getLoadedModsLibs(skipTranslated)) modLib.modName];

	public static function prepareLibrary(libName:String, force:Bool = false) {
		var assets:AssetManifest = new AssetManifest();
		assets.name = libName;
		assets.version = 2;
		assets.libraryArgs = [];
		assets.assets = [];
		return AssetLibrary.fromManifest(assets);
	}

	public static function registerFont(font:Font) {
		var openflFont = new OpenFLFont();
		@:privateAccess openflFont.__fromLimeFont(font);
		OpenFLFont.registerFont(openflFont);
		return font;
	}

	public static function prepareModLibrary(libName:String, lib:IModsAssetLibrary, force:Bool = false, ?tag:AssetSource) {
		var openLib = prepareLibrary(libName, force);
		lib.prefix = 'assets/';
		@:privateAccess openLib.__proxy = cast(lib, lime.utils.AssetLibrary);
		if (tag != null) {
			openLib.tag = tag;
			cast(lib, lime.utils.AssetLibrary).tag = tag;
		}
		return openLib;
	}

	public static function getDefaultModsPath():String {
		#if android
		return "/storage/emulated/0/Android/media/com.yoshman29.codenameengine/files/mods/";
		#else
		return "./mods/";
		#end
	}

	#if (sys || MOD_SUPPORT)
	public static function loadLibraryFromFolder(libName:String, folder:String, force:Bool = false, ?modName:String, ?tag:AssetSource = MODS) {
		return prepareModLibrary(libName, new ModsFolderLibrary(folder, libName, modName), force, tag);
	}

	public static function loadLibraryFromZip(libName:String, zipPath:String, force:Bool = false, ?modName:String, ?tag:AssetSource = MODS) {
		return prepareModLibrary(libName, new ZipFolderLibrary(zipPath, libName, modName), force, tag);
	}
	#end
}
