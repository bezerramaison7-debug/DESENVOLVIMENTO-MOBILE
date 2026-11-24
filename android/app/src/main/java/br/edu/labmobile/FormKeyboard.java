package br.edu.labmobile;

import android.app.Activity;
import android.view.inputmethod.InputMethodManager;

final class FormKeyboard {
    private FormKeyboard() {}

    static void dismiss(Activity activity) {
        var focused = activity.getCurrentFocus();
        if (focused != null) {
            var keyboard = activity.getSystemService(InputMethodManager.class);
            keyboard.hideSoftInputFromWindow(focused.getWindowToken(), 0);
        }
    }
}
