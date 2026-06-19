import XCTest

@MainActor
final class BallastUITests: XCTestCase {
    func testTapFallbackCompletesTheFullExercise() {
        continueAfterFailure = false
        let app = launchApp()
        let startButton = app.buttons["Start"]
        XCTAssertTrue(startButton.waitForExistence(timeout: 5))
        XCTAssertTrue(app.staticTexts["Notice one thing. Turn the Crown. Repeat."].exists)
        startButton.tap()

        let labelsAfterEachTap = [
            "SEE, 4 items remaining.",
            "SEE, 3 items remaining.",
            "SEE, 2 items remaining.",
            "SEE, 1 item remaining.",
            "HEAR, 4 items remaining.",
            "HEAR, 3 items remaining.",
            "HEAR, 2 items remaining.",
            "HEAR, 1 item remaining.",
            "FEEL, 3 items remaining.",
            "FEEL, 2 items remaining.",
            "FEEL, 1 item remaining.",
            "SMELL, 2 items remaining.",
            "SMELL, 1 item remaining.",
            "TASTE, 1 item remaining."
        ]

        XCTAssertTrue(app.buttons["SEE, 5 items remaining."].waitForExistence(timeout: 2))
        captureScreenshot(named: "Ballast-SEE-5")

        for expectedLabel in labelsAfterEachTap {
            app.buttons.firstMatch.tap()
            XCTAssertTrue(app.buttons[expectedLabel].waitForExistence(timeout: 2), expectedLabel)

            switch expectedLabel {
            case "HEAR, 4 items remaining.":
                captureScreenshot(named: "Ballast-HEAR-4")
            case "FEEL, 3 items remaining.":
                captureScreenshot(named: "Ballast-FEEL-3")
            case "SMELL, 2 items remaining.":
                captureScreenshot(named: "Ballast-SMELL-2")
            case "TASTE, 1 item remaining.":
                captureScreenshot(named: "Ballast-TASTE-1")
            default:
                break
            }
        }

        app.buttons.firstMatch.tap()
        XCTAssertTrue(app.staticTexts["You’re here."].waitForExistence(timeout: 2))
        XCTAssertTrue(app.buttons["Done"].exists)
        captureScreenshot(named: "Ballast-Completion")
    }

    func testDigitalCrownCountsInBothDirections() {
        continueAfterFailure = false
        let app = launchApp()
        let startButton = app.buttons["Start"]
        XCTAssertTrue(startButton.waitForExistence(timeout: 5))
        startButton.tap()

        XCTAssertTrue(app.buttons["SEE, 5 items remaining."].waitForExistence(timeout: 2))

        let initialLabel = app.buttons.firstMatch.label
        XCUIDevice.shared.rotateDigitalCrown(delta: 0.05)
        XCTAssertTrue(waitForNewButton(in: app, excluding: initialLabel))

        let labelAfterPositiveRotation = app.buttons.firstMatch.label
        XCUIDevice.shared.rotateDigitalCrown(delta: -0.05)
        XCTAssertTrue(waitForNewButton(in: app, excluding: labelAfterPositiveRotation))
    }

    func testPortugueseLocalizationCompletesTheFullExercise() {
        continueAfterFailure = false
        let app = launchApp(language: "pt-BR", locale: "pt_BR")
        let startButton = app.buttons["Iniciar"]
        XCTAssertTrue(startButton.waitForExistence(timeout: 5))
        XCTAssertTrue(app.staticTexts["Perceba uma coisa. Gire a Coroa. Repita."].exists)
        startButton.tap()

        let labelsAfterEachTap = [
            "VEJA, faltam 4 itens.",
            "VEJA, faltam 3 itens.",
            "VEJA, faltam 2 itens.",
            "VEJA, falta 1 item.",
            "OUÇA, faltam 4 itens.",
            "OUÇA, faltam 3 itens.",
            "OUÇA, faltam 2 itens.",
            "OUÇA, falta 1 item.",
            "SINTA, faltam 3 itens.",
            "SINTA, faltam 2 itens.",
            "SINTA, falta 1 item.",
            "CHEIRE, faltam 2 itens.",
            "CHEIRE, falta 1 item.",
            "SABOREIE, falta 1 item."
        ]

        XCTAssertTrue(app.buttons["VEJA, faltam 5 itens."].waitForExistence(timeout: 2))
        captureScreenshot(named: "Ballast-PT-VEJA-5")

        for expectedLabel in labelsAfterEachTap {
            app.buttons.firstMatch.tap()
            XCTAssertTrue(app.buttons[expectedLabel].waitForExistence(timeout: 2), expectedLabel)

            switch expectedLabel {
            case "OUÇA, faltam 4 itens.":
                captureScreenshot(named: "Ballast-PT-OUCA-4")
            case "SINTA, faltam 3 itens.":
                captureScreenshot(named: "Ballast-PT-SINTA-3")
            case "CHEIRE, faltam 2 itens.":
                captureScreenshot(named: "Ballast-PT-CHEIRE-2")
            case "SABOREIE, falta 1 item.":
                captureScreenshot(named: "Ballast-PT-SABOREIE-1")
            default:
                break
            }
        }

        app.buttons.firstMatch.tap()
        XCTAssertTrue(app.staticTexts["Você está aqui."].waitForExistence(timeout: 2))
        XCTAssertTrue(app.buttons["Concluir"].exists)
        captureScreenshot(named: "Ballast-PT-Completion")
    }

    private func launchApp(language: String? = nil, locale: String? = nil) -> XCUIApplication {
        let application = XCUIApplication()
        if let language, let locale {
            application.launchArguments += [
                "-AppleLanguages", "(\(language))",
                "-AppleLocale", locale
            ]
        }
        application.launch()
        return application
    }

    private func waitForNewButton(in application: XCUIApplication, excluding label: String) -> Bool {
        let predicate = NSPredicate(format: "label != %@", label)
        return application.buttons.matching(predicate).firstMatch.waitForExistence(timeout: 3)
    }

    private func captureScreenshot(named name: String) {
        let attachment = XCTAttachment(screenshot: XCUIScreen.main.screenshot())
        attachment.name = name
        attachment.lifetime = .keepAlways
        add(attachment)
    }
}
