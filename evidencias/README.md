# Evidências de execução

- [Revisão do código validado](https://github.com/bezerramaison7-debug/DESENVOLVIMENTO-MOBILE/commit/bf63ecc0bc40eb2e702b65a2540dc32301f15d9c)
- [Pipeline de validação](https://github.com/bezerramaison7-debug/DESENVOLVIMENTO-MOBILE/actions/runs/45449536301)
- [Capturas](capturas) · [Log Android](android.log) · [Log Flutter](flutter.log)

O job Android compilou o projeto e executou R1, R2, R4, R5, R6 e R7 em AVD API 29. O artefato do job contém o APK e os resultados da automação. O job Flutter executou quatro testes, análise estática e as duas compilações para Web.

As capturas Flutter foram produzidas em teste de widgets com o SDK 3.35.7. R3 e R8 também foram percorridos no DartPad com Flutter 3.50.1. Foram observados o aviso e as boas-vindas no R3 e as três faixas no R8.

Os trajetos simulados usaram dados fictícios:

| Perfil | Fluxo |
|---|---|
| Primeiro acesso | Abriu a tela inicial e testou os dois formulários de login. |
| Exploração | Visitou os destinos do menu e atualizou uma seleção de tecnologias. |
| Retorno e correção | Recuperou um nome salvo após encerrar o processo, corrigiu o formulário e percorreu as faixas de senha. |

Consulte o [README do projeto](../README.md) para reproduzir os testes.