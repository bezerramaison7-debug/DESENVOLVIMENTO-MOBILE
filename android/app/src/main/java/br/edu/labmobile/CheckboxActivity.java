package br.edu.labmobile;

import android.app.Activity;
import android.os.Bundle;
import android.widget.CheckBox;
import android.widget.TextView;

import java.util.ArrayList;
import java.util.List;

public class CheckboxActivity extends Activity {
    @Override
    public void onCreate(Bundle state) {
        super.onCreate(state);
        setContentView(R.layout.r5_checkbox);
        TextView status = findViewById(R.id.status);

        findViewById(R.id.verify).setOnClickListener(view -> {
            List<String> selected = new ArrayList<>();
            for (int id : new int[]{R.id.java, R.id.kotlin, R.id.flutter, R.id.python}) {
                CheckBox option = findViewById(id);
                if (option.isChecked()) {
                    selected.add(option.getText().toString());
                }
            }
            if (selected.isEmpty()) {
                status.setText(R.string.none_selected);
                return;
            }
            status.setText(getString(R.string.selected, android.text.TextUtils.join(", ", selected)));
        });
    }
}
