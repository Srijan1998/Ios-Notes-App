//
//  ViewController.swift
//  notes
//
//  Created by Srijan Bhatia on 21/11/20.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var titleArray = [Title]()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTitles()
    }
    
    @IBAction func addButtonClicked(_ sender: UIBarButtonItem) {
        let newItem = Title(context: context)
        newItem.title = "New Note"
        let description = Note(context: context)
        description.decript = "Enter your note here"
        newItem.descript = description
        description.title = newItem
        self.titleArray.append(newItem)
        saveTitles()
    }
    
    func loadTitles() {
        do {
            let request: NSFetchRequest<Title> = Title.fetchRequest()
            titleArray = try context.fetch(request)
        } catch {
            print("Error while loading \(error)")
        }
        tableView.reloadData()
    }
    func saveTitles() {
        do {
            try context.save()
        } catch {
            print("Error while saving \(error)")
        }
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TitlesToNote" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let selectedTitle = titleArray[indexPath.row]
                let destinationVC = segue.destination as! NoteViewController
                destinationVC.name = selectedTitle
                destinationVC.note = selectedTitle.descript
            }
        }
    }
    
}

//MARK:- UITableViewControllerDataSource
extension TableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titleArray.count;
    }
}

//MARK:- UITableViewDelegate
extension TableViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TitleCell", for:indexPath)
        cell.textLabel?.text = titleArray[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier:"TitlesToNote" , sender: self)
    }
}

