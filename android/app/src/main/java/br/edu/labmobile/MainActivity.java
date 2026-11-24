package br.edu.labmobile;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.widget.TextView;

public class MainActivity extends Activity {
    private static final int MENU_REQUEST = 4;

    @Override
    public void onCreate(Bundle state) {
        super.onCreate(state);
        setContentView(R.layout.r1_android_studio);
        open(R.id.r2, LoginActivity.class);
        findViewById(R.id.r4).setOnClickListener(view ->
            startActivityForResult(new Intent(this, MenuActivity.class), MENU_REQUEST));
        open(R.id.r5, CheckboxActivity.class);
        open(R.id.r6, PreferencesActivity.class);
        open(R.id.r7, SecureActivity.class);
    }

    private void open(int button, Class<? extends Activity> screen) {
        findViewById(button).setOnClickListener(view ->
            startActivity(new Intent(this, screen)));
    }

    @Override
    protected void onActivityResult(int request, int result, Intent data) {
        super.onActivityResult(request, result, data);
        if (request == MENU_REQUEST && result == RESULT_OK) {
            ((TextView) findViewById(R.id.status)).setText(R.string.menu_returned);
        }
    }
}
