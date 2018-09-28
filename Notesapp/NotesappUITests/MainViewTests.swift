import Foundation

class MainViewTests : KIFTestCase {
    func testNavigateToNoteCreateView() {
        tester().tapView(withAccessibilityLabel: "Crear nota")
        tester().waitForTappableView(withAccessibilityLabel: "Crear-Editar nota")
    }
}
