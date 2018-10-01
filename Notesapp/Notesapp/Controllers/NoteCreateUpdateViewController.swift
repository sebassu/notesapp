import UIKit

internal class NoteCreateUpdateViewController: UIViewController {

    private static var exitSegueIdentifier = "ReturnToNotes"

    private var downPicker: DownPicker!
    private var categoriesData: [String: Notesapp.Category] = [:]

    internal var noteToEdit: Note!

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var titleField: UITextField!
    @IBOutlet private weak var categoryField: UITextField!
    @IBOutlet private weak var contentView: UITextView!
    @IBOutlet private weak var acceptButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setTitleAndNoteData()
        loadCategoryDataToDisplay()
        self.downPicker = DownPicker(textField: self.categoryField, withData: Array(categoriesData.keys))
        self.downPicker.showArrowImage(true)
        self.downPicker.setPlaceholder("Elija una categoría...")
    }

    private func setTitleAndNoteData() {
        if noteToEdit != nil {
            titleLabel.text = "Editar nota"
            titleField.text = noteToEdit.title
            contentView.text = noteToEdit.content
            categoryField.text = noteToEdit.category.title
        }
    }

    private func loadCategoryDataToDisplay() {
        let categories = EntityManager.instance().categories
        for category in categories {
            categoriesData[category.title] = category
        }
    }

    @IBAction internal func textFieldDidEndEditing(textField: UITextField) {
        if textFieldIsEmpty(textField) {
            textField.layer.borderWidth = 1
            textField.layer.borderColor = UIColor.red.cgColor
        } else {
            textField.layer.borderWidth = 0
        }
    }

    private func textFieldIsEmpty(_ textField: UITextField) -> Bool {
        return textField.text?.count == 0
    }

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let wasExpectedIdentifier = identifier == NoteCreateUpdateViewController.exitSegueIdentifier
        if wasExpectedIdentifier {
            if textFieldIsEmpty(titleField) {
                printRequiredFieldsErrorMessage()
                return false
            } else {
                return performNoteAction()
            }
        }
        return true
    }

    private func performNoteAction() -> Bool {
        guard let title = titleField.text, let content = contentView.text,
            let category = categoriesData[categoryField.text!] else {
                printRequiredFieldsErrorMessage()
                return false
        }
        let date = Date()
        performCreationOrEditingOfNote(title: title, content: content, createdDate: date, category: category)
        return true
    }

    private func performCreationOrEditingOfNote(title: String, content: String,
                                                createdDate: Date, category: Notesapp.Category) {
        if noteToEdit == nil {
            let identifier = UUID()
            let toAdd = Note(id: identifier, title: title, content: content,
                             createdDate: createdDate, category: category)
            EntityManager.instance().addNote(toAdd)
        } else {
            noteToEdit.title = title
            noteToEdit.content = content
            noteToEdit.createdDate = createdDate
            noteToEdit.category = category
        }
    }

    private func printRequiredFieldsErrorMessage() {
        let alert = UIAlertController(title: "Error",
                                      message: "Complete los campos requeridos para continuar.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }

    @IBAction func setAccessibilityLabelToPickerView() {
        let aux = self.downPicker.getView()
        aux?.accessibilityLabel = "Selección de categoría"
    }
}
