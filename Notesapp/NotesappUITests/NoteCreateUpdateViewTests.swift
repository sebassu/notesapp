import Foundation

class NoteCreateUpdateViewTests: KIFTestCase {

    override func beforeEach() {
        TestUtilities.navigateToMainView()
    }

    func testCreateNote() {
        let titleToSet = "Algún tipo de título"
        let titleOfCategoryToSet = "University"
        let contentToSet = "El contenido de la nota, que debiera ser un poco más "
            + "largo que el título, como podrá apreciarse."
        tester().tapView(withAccessibilityLabel: "Crear nota")
        executeNoteModificationTest(titleToSet, titleOfCategoryToSet, contentToSet)
    }

    func testEditExistingNote() {
        let titleToSet = "Otro título"
        let titleOfCategoryToSet = "Work"
        let contentToSet = "Me pregunto para que tipo de contenido una aplicación "
            + "similar a esta sería utilizada."
        let notes = tester().waitForTappableView(withAccessibilityLabel: "Tabla notas") as! UITableView
        tester().tapRow(at: IndexPath(row: 1, section: 0), in: notes)
        tester().tapView(withAccessibilityLabel: "Editar nota")
        executeNoteModificationTest(titleToSet, titleOfCategoryToSet, contentToSet)
    }

    private func executeNoteModificationTest(_ titleToSet: String, _ titleOfCategoryToSet: String, _ contentToSet: String) {
        tester().clearText(fromAndThenEnterText: titleToSet, intoViewWithAccessibilityLabel: "Campo título")
        tester().tapView(withAccessibilityLabel: "Campo categoría")
        tester().waitForView(withAccessibilityLabel: "Selección de categoría")
        tester().selectPickerViewRow(withTitle: titleOfCategoryToSet)
        tester().clearText(fromAndThenEnterText: contentToSet, intoViewWithAccessibilityLabel: "Campo contenido")
        tester().tapView(withAccessibilityLabel: "Botón aceptar");
        XCTAssertTrue(noteExists(withTitle: titleToSet, withCategoryTitle: titleOfCategoryToSet, withContent: contentToSet))
    }

    private func noteExists(withTitle titleToSet: String,
                            withCategoryTitle titleOfCategoryToSet: String, withContent contentToSet: String) -> Bool {
        let notes = EntityManager.instance().notes;
        for note in notes {
            let hasExpectedData = note.title == titleToSet &&
                note.category.title == titleOfCategoryToSet && note.content == contentToSet
            if hasExpectedData && Calendar.current.isDateInToday(note.createdDate) {
                return true
            }
        }
        return false
    }
}
