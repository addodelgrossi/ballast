# Ballast

Ballast é um app standalone para Apple Watch que guia o exercício de grounding
5-4-3-2-1 principalmente por haptics. Não possui conta, backend, analytics,
HealthKit nem armazenamento de histórico.

## Fluxo

```text
Start → SEE 5 → HEAR 4 → FEEL 3 → SMELL 2 → TASTE 1 → You’re here. → Done
```

- A complication inicia uma nova sessão imediatamente, usando `ballast://start`.
- Abrir pelo ícone mostra Start ou retoma a sessão que ainda estiver em memória.
- Um tique da Coroa Digital, em qualquer direção, conta um item.
- Um toque em qualquer ponto do ecrã ativo oferece o mesmo comportamento.
- Ao chegar a zero, o passo seguinte começa automaticamente.

## Linguagem tátil

Cada passo começa com `.start`, seguido por uma pausa de 220 ms e pulsos
`.click` separados por 160 ms. O número de pulsos comunica a contagem sem exigir
que a pessoa olhe para o ecrã.

| Passo | Pulsos |
| --- | ---: |
| SEE / VEJA | 5 |
| HEAR / OUÇA | 4 |
| FEEL / SINTA | 3 |
| SMELL / CHEIRE | 2 |
| TASTE / SABOREIE | 1 |
| Conclusão | `.success` |

O fallback por toque reproduz `.click`; a Coroa usa o feedback tátil nativo do
watchOS. Padrões de falha, retry e notificação não são usados.

## Complications

A extensão WidgetKit suporta `accessoryCircular`, `accessoryCorner`,
`accessoryInline` e `accessoryRectangular`. A marca é um círculo com a metade
inferior preenchida e todos os formatos iniciam o exercício com um toque.

## Requisitos e execução

- Xcode 26.5 ou posterior
- Componente da plataforma watchOS 26.5 instalado em **Xcode → Settings → Components**
- watchOS 11 ou posterior
- Apple Watch Series 7 45 mm suportado; layout responsivo para outros tamanhos

Abra `Ballast.xcodeproj`, escolha a sua Team em **Signing & Capabilities** para os
targets Ballast e BallastComplication e execute no relógio. Os bundle identifiers
são `com.addodelgrossi.ballast` e `com.addodelgrossi.ballast.complication`.

O projeto Xcode fica versionado e pode ser regenerado, opcionalmente, com:

```sh
xcodegen generate
```

Crie um Series 7 45 mm para validação local:

```sh
xcrun simctl create 'Ballast Series 7 (45mm)' \
  'com.apple.CoreSimulator.SimDeviceType.Apple-Watch-Series-7-45mm' \
  'com.apple.CoreSimulator.SimRuntime.watchOS-26-5'
```

Build sem assinatura:

```sh
xcodebuild -project Ballast.xcodeproj -scheme Ballast \
  -destination 'generic/platform=watchOS' CODE_SIGNING_ALLOWED=NO build
```

Valide que o archive de distribuição contém o app e a complication:

```sh
scripts/verify-release-archive.sh
```

Execute todos os testes, incluindo a interface e a Coroa Digital:

```sh
xcodebuild -project Ballast.xcodeproj -scheme Ballast \
  -destination 'platform=watchOS Simulator,name=Ballast Series 7 (45mm),OS=26.5' \
  test
```

## Testes e acessibilidade

O target BallastTests cobre transições, contagem, reinício, conclusão e os
padrões hápticos. BallastUITests percorre o fluxo completo por toque e valida a
Coroa nos dois sentidos em um simulador Apple Watch. Previews SwiftUI cobrem o
fluxo e as famílias principais de complication. A interface usa Dynamic Type,
alvos de toque grandes e labels e hints localizados para VoiceOver em inglês,
português brasileiro, espanhol e francês.

Os haptics reais, a sensação da Coroa e a complication devem ser validados no
Series 7 físico; o simulador não reproduz fielmente esses elementos.

## Privacidade e escopo

O MVP não solicita permissões sensíveis, não realiza chamadas de rede e não
persiste dados. Humor, streaks, técnicas alternativas e App Intents/Siri ficam
fora desta versão.

## Site e App Store

- Site do produto: [`docs/index.html`](docs/index.html)
- Política de privacidade: [`docs/privacy/index.html`](docs/privacy/index.html)
- Suporte: [`docs/support/index.html`](docs/support/index.html)
- Checklist e metadata da loja: [`AppStore/README.md`](AppStore/README.md)
- Plano de lançamento e aquisição: [`AppStore/LaunchPlan.md`](AppStore/LaunchPlan.md)

O conteúdo de `docs/` é publicado no GitHub Pages pelo workflow
`.github/workflows/pages.yml`. Depois de habilitar **Settings → Pages → Source:
GitHub Actions**, a URL será `https://addodelgrossi.github.io/ballast/`.
