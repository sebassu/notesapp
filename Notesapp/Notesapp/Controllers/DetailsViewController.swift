//
//  DetailsViewController.swift
//  Notesapp
//
//  Created by Sebastián Uriarte Güimil on 9/24/18.
//  Copyright © 2018 OrangeLoops. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @objc(note)
    var note : Note
    
    @IBOutlet weak var titleLabel:UILabel!
    @IBOutlet weak var dateLabel:UILabel!
    @IBOutlet weak var contentLabel:UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        note = Note()
        super.init(coder: aDecoder)
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = note.title
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
        dateLabel.text = dateFormatter.string(from:note.createdDate)
        contentLabel.text = note.content
    }
}
