package br.edu.labmobile;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.widget.TextView;

public class MenuPageActivity extends Activity {
    @Override
    public void onCreate(Bundle state) {
        super.onCreate(state);
        setContentView(R.layout.r4_menu_page);
        Intent page = getIntent();
        ((TextView) findViewById(R.id.page_title)).setText(page.getIntExtra("title", R.string.menu_title));
        ((TextView) findViewById(R.id.page_info)).setText(page.getIntExtra("description", R.string.menu_title));
        findViewById(R.id.back).setOnClickListener(view -> finish());
    }
}
