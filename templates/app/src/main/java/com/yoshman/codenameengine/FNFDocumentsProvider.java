package com.yoshman29.codenameengine;

import android.provider.DocumentsProvider;
import android.database.Cursor;
import android.database.MatrixCursor;
import android.os.ParcelFileDescriptor;
import android.provider.DocumentsContract;
import java.io.File;
import java.io.FileNotFoundException;

public class FNFDocumentsProvider extends DocumentsProvider {

    static final String ROOT = "/storage/emulated/0/Android/data/com.yoshman29.codenameengine/files";

    @Override
    public boolean onCreate() {
        return true;
    }

    @Override
    public Cursor queryRoots(String[] projection) {
        MatrixCursor result = new MatrixCursor(new String[]{
            DocumentsContract.Root.COLUMN_ROOT_ID,
            DocumentsContract.Root.COLUMN_TITLE,
            DocumentsContract.Root.COLUMN_FLAGS,
            DocumentsContract.Root.COLUMN_DOCUMENT_ID
        });

        result.newRow()
            .add("fnf_root")
            .add("Codename Data Folder")
            .add(DocumentsContract.Root.FLAG_SUPPORTS_CREATE)
            .add("fnf_root");

        return result;
    }

    @Override
    public Cursor queryDocument(String documentId, String[] projection) {
        MatrixCursor result = new MatrixCursor(new String[]{
            DocumentsContract.Document.COLUMN_DOCUMENT_ID,
            DocumentsContract.Document.COLUMN_DISPLAY_NAME,
            DocumentsContract.Document.COLUMN_SIZE,
            DocumentsContract.Document.COLUMN_MIME_TYPE
        });

        File file = new File(ROOT);

        result.newRow()
            .add("fnf_root")
            .add(file.getName())
            .add(file.length())
            .add(DocumentsContract.Document.MIME_TYPE_DIR);

        return result;
    }

    @Override
    public ParcelFileDescriptor openDocument(String documentId, String mode) throws FileNotFoundException {
        File file = new File(ROOT);
        return ParcelFileDescriptor.open(file, ParcelFileDescriptor.MODE_READ_WRITE);
    }
}
