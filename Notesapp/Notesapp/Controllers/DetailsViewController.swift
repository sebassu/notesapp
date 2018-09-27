//
//  DetailsViewController.swift
//  Notesapp
//
//  Created by Sebastián Uriarte Güimil on 9/24/18.
//  Copyright © 2018 OrangeLoops. All rights reserved.
//

import UIKit

internal class DetailsViewController: UIViewController {

    @objc(note)
    internal var note: Note!

    private static var editSegueIdentifier = "EditarNota"

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var contentLabel: UILabel!

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override open func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = note.title
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm:ss"
        dateLabel.text = dateFormatter.string(from: note.createdDate)
        contentLabel.text = note.content
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == DetailsViewController.editSegueIdentifier,
            let destination = segue.destination as? NoteActionViewController {
            destination.noteToEdit = note
        }
    }
}
