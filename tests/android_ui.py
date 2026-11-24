"""Run the Android practices against an installed debug APK on a disposable AVD."""
import argparse
import re
import subprocess
from pathlib import Path
from xml.etree import ElementTree as ET

PACKAGE = "br.edu.labmobile"


def adb(*args):
    return subprocess.check_output(["adb", *args], timeout=45)


def shell(*args):
    return adb("shell", *args).decode().strip()


def view_tree():
    location = "/sdcard/window-labmobile.xml"
    shell("uiautomator", "dump", location)
    return ET.fromstring(adb("exec-out", "cat", location))


def node(view_id):
    element = view_tree().find(f".//node[@resource-id='{PACKAGE}:id/{view_id}']")
    if element is None:
        raise AssertionError(f"Componente ausente: {view_id}")
    return element


def click(view_id):
    x1, y1, x2, y2 = map(int, re.findall(r"\d+", node(view_id).get("bounds")))
    shell("input", "tap", str((x1 + x2) // 2), str((y1 + y2) // 2))


def expect(view_id, text):
    actual = node(view_id).get("text")
    if text != actual:
        raise AssertionError(f"{view_id}: esperado {text!r}, observado {actual!r}")


def type_into(view_id, text):
    click(view_id)
    shell("input", "text", text)


def launch():
    shell("am", "start", "-W", "-n", PACKAGE + "/.MainActivity")
    expect("title", "Projeto Android em execução")


def run(output):
    output.mkdir(parents=True, exist_ok=True)

    def capture(name):
        output.joinpath(name + ".png").write_bytes(adb("exec-out", "screencap", "-p"))

    # This test intentionally resets the demo app on the chosen test device.
    assert shell("pm", "clear", PACKAGE) == "Success"
    shell("input", "keyevent", "82")
    launch()
    capture("r1-android")
    print("R1 PASS | abrir aplicativo | título alterado exibido", flush=True)

    click("r2")
    expect("title", "Acesso ao laboratório")
    assert node("password").get("password") == "true"
    click("submit")
    expect("status", "Preencha e-mail e senha.")
    type_into("email", "aluna@example.test")
    type_into("password", "123456")
    click("submit")
    expect("status", "Formulário de login preenchido.")
    capture("r2-login")
    print("R2 PASS | vazio e preenchido | aviso, confirmação e senha mascarada", flush=True)
    shell("input", "keyevent", "4")

    click("r4")
    expect("title", "Menu de navegação")
    capture("r4-menu")
    for item, title in [("menu_cadastro", "Cadastro"), ("menu_consultar", "Consultar"),
                        ("menu_config", "Configurações")]:
        click(item)
        expect("page_title", title)
        click("back")
        expect("title", "Menu de navegação")
    click("menu_exit")
    expect("status", "Menu encerrado.")
    print("R4 PASS | três destinos, voltar e sair | navegação e encerramento", flush=True)

    click("r5")
    click("verify")
    expect("status", "Nenhuma tecnologia selecionada.")
    click("java")
    click("flutter")
    click("verify")
    expect("status", "Selecionadas: Java, Flutter")
    capture("r5-checkbox")
    click("java")
    click("verify")
    expect("status", "Selecionadas: Flutter")
    print("R5 PASS | zero opções, duas e desmarcação | lista corresponde ao estado", flush=True)
    shell("input", "keyevent", "4")

    click("r6")
    click("save")
    expect("status", "Informe o nome.")
    type_into("name", "Pessoa%sTeste")
    click("save")
    expect("status", "Nome salvo: Pessoa Teste")
    capture("r6-salvo")
    shell("am", "force-stop", PACKAGE)
    launch()
    click("r6")
    expect("name", "Pessoa Teste")
    expect("status", "Nome recuperado: Pessoa Teste")
    capture("r6-recuperado")
    print("R6 PASS | vazio, salvar, force-stop, reabrir | mesmo nome recuperado no campo", flush=True)
    shell("input", "keyevent", "4")

    click("r7")
    click("submit")
    expect("status", "Preencha e-mail e senha.")
    capture("r7-vazio")
    type_into("email", "aluna")
    type_into("password", "12345")
    click("submit")
    expect("status", "E-mail inválido.")
    capture("r7-email")
    type_into("email", "@example.test")
    click("submit")
    expect("status", "A senha deve ter no mínimo 6 caracteres.")
    capture("r7-senha")
    type_into("password", "6")
    click("submit")
    expect("status", "Dados válidos para esta prática.")
    print("R7 PASS | vazio, e-mail inválido, 5 e 6 caracteres | três avisos e confirmação", flush=True)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("output", type=Path)
    run(parser.parse_args().output)
