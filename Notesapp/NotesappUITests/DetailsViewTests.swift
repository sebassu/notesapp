import Foundation

class DetailsViewTests: KIFTestCase {

    override func beforeEach() {
        TestUtilities.navigateToMainView()
    }

    func testDetailViewContainsAppropriateData() {
        let indexPathToTap = IndexPath(row: 1, section: 0)
        let notes = tester().waitForTappableView(withAccessibilityLabel: "Tabla notas") as! UITableView
        let tappedNote = (notes.cellForRow(at: indexPathToTap) as! NoteTableCell).note!
        tester().tapRow(at: indexPathToTap, in: notes)
        tester().waitForTappableView(withAccessibilityLabel: "Detalle de nota")
        verifyCorrectNoteDataIsLoaded(tappedNote)
    }

    private func verifyCorrectNoteDataIsLoaded(_ tappedNote: Note) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        let titleText = (tester().waitForView(withAccessibilityLabel: "Título nota") as! UILabel).text!
        let dateText = (tester().waitForView(withAccessibilityLabel: "Fecha nota") as! UILabel).text!
        let contentsText = (tester().waitForView(withAccessibilityLabel: "Contenido nota") as! UILabel).text!
        XCTAssertEqual(tappedNote.title, titleText)
        XCTAssertEqual(tappedNote.createdDate, dateFormatter.date(from: dateText))
        XCTAssertEqual(tappedNote.content, contentsText)
    }

    func testNavigateToEditNote() {
        let notes = tester().waitForTappableView(withAccessibilityLabel: "Tabla notas") as! UITableView
        tester().tapRow(at: IndexPath(row: 0, section: 2), in: notes)
        tester().tapView(withAccessibilityLabel: "Editar nota")
        tester().waitForView(withAccessibilityLabel: "Crear-Editar nota")
    }
}
