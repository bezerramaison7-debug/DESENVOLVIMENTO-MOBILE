package br.edu.labmobile;

import android.app.Activity;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.widget.EditText;
import android.widget.TextView;

public class PreferencesActivity extends Activity {
    private static final String NAME_KEY = "display_name";

    @Override
    public void onCreate(Bundle state) {
        super.onCreate(state);
        setContentView(R.layout.r6_preferences);
        EditText field = findViewById(R.id.name);
        TextView status = findViewById(R.id.status);
        SharedPreferences preferences = getSharedPreferences("profile", MODE_PRIVATE);
        String storedName = preferences.getString(NAME_KEY, "");

        if (!storedName.isEmpty()) {
            field.setText(storedName);
            status.setText(getString(R.string.restored, storedName));
        }

        findViewById(R.id.save).setOnClickListener(view -> {
            FormKeyboard.dismiss(this);
            String name = field.getText().toString().trim();
            if (name.isEmpty()) {
                status.setText(R.string.empty_name);
                return;
            }
            preferences.edit().putString(NAME_KEY, name).apply();
            status.setText(getString(R.string.saved, name));
        });
    }
}
