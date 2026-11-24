package br.edu.labmobile;

import android.app.Activity;
import android.os.Bundle;
import android.widget.EditText;
import android.widget.TextView;

public class LoginActivity extends Activity {
    @Override
    public void onCreate(Bundle state) {
        super.onCreate(state);
        setContentView(R.layout.r2_login);
        EditText email = findViewById(R.id.email);
        EditText password = findViewById(R.id.password);
        TextView status = findViewById(R.id.status);

        findViewById(R.id.submit).setOnClickListener(view -> {
            FormKeyboard.dismiss(this);
            boolean missing = email.getText().toString().trim().isEmpty()
                || password.getText().toString().isEmpty();
            status.setText(missing ? R.string.fill_fields : R.string.login_success);
        });
    }
}
