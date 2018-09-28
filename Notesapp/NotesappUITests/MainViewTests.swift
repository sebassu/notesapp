import Foundation

class MainViewTests: KIFTestCase {

    override func beforeEach() {
        TestUtilities.navigateToMainView()
    }

    func testNavigateToCreateView() {
        tester().tapView(withAccessibilityLabel: "Crear nota")
        tester().waitForTappableView(withAccessibilityLabel: "Crear-Editar nota")
    }

    func testNavigateToDetailView() {
        let notes = tester().waitForTappableView(withAccessibilityLabel: "Tabla notas") as! UITableView
        tester().tapRow(at: IndexPath(row: 1, section: 1), in: notes)
        tester().waitForTappableView(withAccessibilityLabel: "Detalle de nota")
    }
}
