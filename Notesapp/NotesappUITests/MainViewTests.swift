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

    func testAllNotesAreShown() {
        let categoryIds = EntityManager.instance().categories.map { ($0.identifier) }
        for categoryId in categoryIds {
            validateAllNotesFromCategoryIdAreShown(categoryId)
        }
    }

    private func validateAllNotesFromCategoryIdAreShown(_ categoryId: Int) {
        let notesWithCategory = EntityManager.instance().getNotesForCategoryId(categoryId)!
        for index in 0...notesWithCategory.count - 1 {
            let expectedNote = notesWithCategory[index]
            validateNoteIsShown(expectedNote, index, categoryId)
        }
    }

    private func validateNoteIsShown(_ expectedNote: Note, _ index: Int, _ section: Int) {
        let notesTable = tester().waitForTappableView(withAccessibilityLabel: "Tabla notas") as! UITableView
        let noteCell = tester().waitForCell(at: IndexPath(row: index, section: section),
                                            in: notesTable) as! NoteTableCell
        assertCellHasExpectedData(expectedNote, noteCell)
    }

    private func assertCellHasExpectedData(_ expectedNote: Note, _ noteCell: NoteTableCell) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        XCTAssertEqual(expectedNote.title, noteCell.titleLabel?.text)
        XCTAssertEqual(dateFormatter.string(from: expectedNote.createdDate), noteCell.dateLabel?.text)
        XCTAssertEqual(expectedNote.content, noteCell.contentLabel?.text)
    }
}
