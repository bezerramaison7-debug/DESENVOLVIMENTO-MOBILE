import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:laboratorio_mobile/roteiro3_login.dart';
import 'package:laboratorio_mobile/roteiro8_senha.dart';

void main() {
  testWidgets('R3 apresenta campos e dá boas-vindas com entrada válida', (
    tester,
  ) async {
    await tester.pumpWidget(const LoginApp());
    final fields = find.byType(TextField);
    expect(fields, findsNWidgets(2));
    expect(tester.widget<TextField>(fields.last).obscureText, isTrue);
    await tester.enterText(fields.first, 'aluna@example.test');
    await tester.enterText(fields.last, '123456');
    await tester.tap(find.text('Login'));
    await tester.pump();
    expect(find.text('Boas-vindas, aluna@example.test!'), findsOneWidget);
    expect(tester.widget<TextField>(fields.last).controller!.text, isEmpty);
  });

  testWidgets('R3 solicita e-mail válido e senha quando faltam dados', (
    tester,
  ) async {
    await tester.pumpWidget(const LoginApp());
    await tester.tap(find.text('Login'));
    await tester.pump();
    expect(find.text('Informe um e-mail válido e a senha.'), findsOneWidget);
    final fields = find.byType(TextField);
    await tester.enterText(fields.first, 'invalido');
    await tester.enterText(fields.last, '123456');
    await tester.tap(find.text('Login'));
    await tester.pump();
    expect(find.text('Informe um e-mail válido e a senha.'), findsOneWidget);
  });

  test('R8 classifica vazio e fronteiras de comprimento', () {
    expect(classify(''), Strength.empty);
    expect(classify('1'), Strength.weak);
    expect(classify('12345'), Strength.weak);
    expect(classify('123456'), Strength.medium);
    expect(classify('123456789'), Strength.medium);
    expect(classify('1234567890'), Strength.strong);
    expect(classify('🙂🙂🙂🙂🙂'), Strength.weak);
  });

  testWidgets('R8 atualiza a indicação ao editar e limpar', (tester) async {
    await tester.pumpWidget(const PasswordApp());
    final field = find.byType(TextField);
    expect(tester.widget<TextField>(field).obscureText, isTrue);
    expect(find.text('Digite uma senha'), findsOneWidget);
    for (final entry in {
      '12345': 'Senha Fraca',
      '123456': 'Senha Média',
      '1234567890': 'Senha Forte',
      '': 'Digite uma senha',
    }.entries) {
      await tester.enterText(field, entry.key);
      await tester.pump();
      expect(find.text(entry.value), findsOneWidget);
    }
  });
}
