//
//  NoteViewController.swift
//  notes
//
//  Created by Srijan Bhatia on 21/11/20.
//

import UIKit
import CoreData

class NoteViewController: UIViewController {
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var noteField: UITextView!
    var name: Title?
    var note: Note?
    var id: NSManagedObjectID {
        name!.objectID
    }
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        titleField.text = name?.title
        noteField.text = note?.decript
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let titleObj = context.object(with: id) as! Title
        titleObj.title = titleField.text
        titleObj.descript?.decript = noteField.text
        do {
            try context.save()
        } catch {
            print("error \(error)")
        }
    }
    

}
