//
//  ViewController.swift
//  App для домашних дел
//
//  Created by Анна on 27.09.18.
//  Copyright © 2018 Анна. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var generalTableView: UITableView! {
        didSet {
            self.generalTableView.delegate = self
            self.generalTableView.dataSource = self
        }
    }
    @IBAction func addAction(_ sender: UIButton) {
    }
    @IBAction func saveButton(_ sender: UIButton) {
        self.repository.save()
    }
    
    var repository: ToDoListRepository!
    
    func reloadData() {
        generalTableView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        repository = ToDoListRepository()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: AddNew function
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddNew" {
            if let addNevController = segue.destination as? AddNewViewController {
                addNevController.onNewItemAdded = { text in
                    self.repository.addNewTask(text)
                    self.reloadData()
                }
            }
        }
    }
    
    func addAlert(title: String, message: String, style:  UIAlertControllerStyle = .alert, indexPath: IndexPath ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        let action = UIAlertAction(title: "OK", style: .default) { action in
            guard let text = alertController.textFields?.first?.text else {return}
            if text.isEmpty {
                return
            } else {
                self.repository.editTask(index: indexPath.row, text)
                self.reloadData()
            }
        }
        alertController.addAction(action)
        alertController.addTextField(configurationHandler: nil)
        alertController.textFields?.first?.text = repository.getTaskPlansArray(index: indexPath.row)
        self.present(alertController, animated: true)
    }
    
    //MARK: Other opportunity function
    @IBAction func otherOpportunity(_ sender: UIButton) {
        let opAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let deleteDoneTasksAction = UIAlertAction(title: "Delete all done tasks", style: .default) { action in
            self.repository.removeMadeArray()
            self.reloadData()
        }
        let returnDoneTasksAction = UIAlertAction(title: "Return all done tasks", style: .default) { action in
           self.repository.returnDoneTasks()
           self.reloadData()
        }
        let deleteAllAction = UIAlertAction(title: "Delete All", style: .default) { action in
            self.repository.removeMadeArray()
            self.repository.removePlansArray()
            self.reloadData()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        opAlertController.addAction(deleteDoneTasksAction)
        opAlertController.addAction(returnDoneTasksAction)
        opAlertController.addAction(deleteAllAction)
        opAlertController.addAction(cancelAction)
        
        if repository.madeArrayIsEmpty() && !repository.plansArrayIsEmpty() {
            deleteDoneTasksAction.isEnabled = false
            returnDoneTasksAction.isEnabled = false
        } else {
            if repository.madeArrayIsEmpty() && repository.plansArrayIsEmpty() {
                deleteDoneTasksAction.isEnabled = false
                returnDoneTasksAction.isEnabled = false
                deleteAllAction.isEnabled = false
            }
        }
        self.present(opAlertController, animated: true, completion: nil)
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return repository.plansCount()
        case 1:
            return repository.madeCount()
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "SecondCell") as? SecondCell {
                cell.setText(" -  " + repository.getTaskPlansArray(index: indexPath.row), isDone: false)
                return cell
            }
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "SecondCell") as? SecondCell {
                cell.setText(" -  " + repository.getTaskMadeArray(index: indexPath.row), isDone: true )
                return cell
            }
        }
        return UITableViewCell()
    }
    
    //MARK: Mark as done function
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        repository.markDoneFunction(section: indexPath.section, index: indexPath.row)
        self.reloadData()
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        // MARK: Delete funktion
        let deletAction = UITableViewRowAction(style: .default, title: "Delete", handler: { (action, indexPath) in
            self.repository.deleteFunction(section: indexPath.section, index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        })
        deletAction.backgroundColor = .darkGray
        
        // MARK: Edit function
        guard indexPath.section == 0 else {return [deletAction]}
        let editAction = UITableViewRowAction(style: .default, title: "Edit", handler: { (action, indexPath) in
            self.addAlert(title: "Editing", message: "Make Editing", indexPath: indexPath)
        })
        editAction.backgroundColor = .lightGray
        return [deletAction, editAction]
    }
}
