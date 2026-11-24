package br.edu.labmobile;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;

public class MenuActivity extends Activity {
    @Override
    public void onCreate(Bundle state) {
        super.onCreate(state);
        setContentView(R.layout.r4_menu);
        openPage(R.id.menu_cadastro, R.string.menu_cadastro, R.string.cadastro_info);
        openPage(R.id.menu_consultar, R.string.menu_consultar, R.string.consultar_info);
        openPage(R.id.menu_config, R.string.menu_config, R.string.config_info);
        findViewById(R.id.menu_exit).setOnClickListener(view -> {
            setResult(RESULT_OK);
            finish();
        });
    }

    private void openPage(int button, int title, int description) {
        findViewById(button).setOnClickListener(view ->
            startActivity(new Intent(this, MenuPageActivity.class)
                .putExtra("title", title)
                .putExtra("description", description)));
    }
}
