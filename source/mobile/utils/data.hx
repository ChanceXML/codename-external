import sys.FileSystem;
import sys.io.File;
import sys.io.FileOutput;

class CopyAssets
{
    static var DEST = "/storage/emulated/0/Android/data/com.yoshman29.codenameengine/files/";

    static function main()
    {
        ensureDirectory(DEST);

        var folders = ["assets", "mods"];

        for (folder in folders)
        {
            var srcPath = folder;
            var destPath = DEST + folder;
            copyFolder(srcPath, destPath);
        }

        trace("Folders copied successfully!");
    }

    static function ensureDirectory(path:String)
    {
        var parts = path.split("/");
        var current = "";

        for (part in parts)
        {
            if (part == "") continue;

            current += "/" + part;

            if (!FileSystem.exists(current))
                FileSystem.createDirectory(current);
        }
    }

    static function copyFolder(src:String, dest:String)
    {
        if (!FileSystem.exists(src)) return;

        ensureDirectory(dest);

        for (file in FileSystem.readDirectory(src))
        {
            var srcFile = src + "/" + file;
            var destFile = dest + "/" + file;

            if (FileSystem.isDirectory(srcFile))
            {
                copyFolder(srcFile, destFile);
            }
            else
            {
                copyFile(srcFile, destFile);
            }
        }
    }

    static function copyFile(src:String, dest:String)
    {
        ensureDirectory(dest.substr(0, dest.lastIndexOf("/")));

        var content = File.getBytes(src);
        var out = File.write(dest, true);
        out.write(content);
        out.close();
    }
}
