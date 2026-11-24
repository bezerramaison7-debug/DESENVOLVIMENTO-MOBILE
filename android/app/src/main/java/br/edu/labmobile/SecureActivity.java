package br.edu.labmobile;

import android.app.Activity;
import android.os.Bundle;
import android.util.Patterns;
import android.widget.EditText;
import android.widget.TextView;

public class SecureActivity extends Activity {
    @Override
    public void onCreate(Bundle state) {
        super.onCreate(state);
        setContentView(R.layout.r7_security);
        EditText email = findViewById(R.id.email);
        EditText password = findViewById(R.id.password);
        TextView status = findViewById(R.id.status);

        findViewById(R.id.submit).setOnClickListener(view -> {
            FormKeyboard.dismiss(this);
            String address = email.getText().toString().trim();
            String secret = password.getText().toString();

            if (address.isEmpty() || secret.trim().isEmpty()) {
                status.setText(R.string.fill_fields);
            } else if (!Patterns.EMAIL_ADDRESS.matcher(address).matches()) {
                status.setText(R.string.invalid_email);
            } else if (secret.codePointCount(0, secret.length()) < 6) {
                status.setText(R.string.short_password);
            } else {
                status.setText(R.string.valid_form);
            }
        });
    }
}
