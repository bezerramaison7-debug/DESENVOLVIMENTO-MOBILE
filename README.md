# Laboratório Mobile

Oito práticas da disciplina Desenvolvimento Mobile. O projeto Android reúne R1, R2, R4, R5, R6 e R7. Os roteiros R3 e R8 têm pontos de entrada Flutter independentes.

| Roteiro | Arquivo ou tela principal |
|---|---|
| R1 · Projeto Android | `MainActivity.java` e `r1_android_studio.xml` |
| R2 · Login XML | `LoginActivity.java` e `r2_login.xml` |
| R3 · Login Flutter | [roteiro3_login.dart](flutter/lib/roteiro3_login.dart) |
| R4 · Menu | `MenuActivity.java`, `MenuPageActivity.java` e `r4_menu.xml` |
| R5 · Seleção de tecnologias | `CheckboxActivity.java` e `r5_checkbox.xml` |
| R6 · Armazenamento de nome | `PreferencesActivity.java` e `r6_preferences.xml` |
| R7 · Validação | `SecureActivity.java` e `r7_security.xml` |
| R8 · Classificação da senha | [roteiro8_senha.dart](flutter/lib/roteiro8_senha.dart) |

## Android Studio

Abra a pasta `android/` no Android Studio. Use AGP 8.8.2, Gradle 8.10.2,
JDK 17 ou 21, SDK 35 e Build Tools 35.0.0. Em **Device Manager**, inicialize
um emulador com API 23 ou superior. Selecione o módulo `app` e clique em
**Run**. A primeira tela mostra o R1 e os atalhos dos demais roteiros nativos.
O módulo declara atividades no Manifest, lógica em `src/main/java`, layouts
em `src/main/res/layout` e rótulos/estilos em `src/main/res/values`.

Com Gradle e ADB no PATH, a partir da raiz:

```bash
gradle -p android assembleDebug
adb install -r android/app/build/outputs/apk/debug/app-debug.apk
python3 tests/android_ui.py evidencias/execucao-android
```

Use um AVD descartável. O script limpa os dados do aplicativo de demonstração
antes dos testes, usa a árvore de acessibilidade do Android para localizar os
componentes e grava capturas do próprio emulador. Se houver mais de um dispositivo,
selecione o alvo com `ANDROID_SERIAL`.

## Flutter e DartPad

Cada arquivo em `flutter/lib/` contém seu próprio `main()` e usa apenas Flutter.
Em [DartPad](https://dartpad.dev/), crie um pad Flutter, cole um dos arquivos por
vez e pressione **Run**. Com Flutter SDK 3.35.7 e Chrome/Chromium:

```bash
cd flutter
flutter pub get
flutter analyze
flutter test --reporter expanded
flutter run -d chrome -t lib/roteiro3_login.dart
flutter run -d chrome -t lib/roteiro8_senha.dart
```

O R3 dá boas-vindas com dados de demonstração. O R8 classifica pelo número de
pontos de código Unicode: de 1 a 5, fraca; de 6 a 9, média; a partir de 10,
forte. A classificação serve à prática de condicionais e atualização de
estado. No R6, o armazenamento privado guarda somente um nome de exibição.
Os formulários ilustram validação local, sem contas ou servidor.

As execuções do GitHub Actions ficam na aba [Actions](../../actions). As
capturas e logs disponíveis também são listados em [evidencias](evidencias).
