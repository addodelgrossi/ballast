import SwiftUI

@main
struct BallastApp: App {
    @State private var session = ExerciseSession()

    var body: some Scene {
        WindowGroup {
            BallastRootView(session: session)
                .onOpenURL(perform: handleDeepLink)
        }
    }

    private func handleDeepLink(_ url: URL) {
        guard url.scheme == "ballast", url.host == "start" else { return }
        session.start()
    }
}
