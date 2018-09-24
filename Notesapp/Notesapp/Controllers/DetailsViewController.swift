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
    var note : Note;
    
    required init?(coder aDecoder: NSCoder) {
        note = Note();
        super.init(coder: aDecoder)
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
    }
}
