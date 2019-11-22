//
//  TaskTableViewController.swift
//  TaskList
//
//  Created by Mikhail Semerikov on 22.11.2019.
//  Copyright © 2019 Mikhail Semerikov. All rights reserved.
//

import UIKit

class TaskTableViewController: UITableViewController {
    
    var tasks = Task(name: "", childs: [])

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    @IBAction func addTaskButtonPressed(_ sender: UIBarButtonItem) {
        showCreateTaskAlert()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.childs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell") else { return UITableViewCell() }
        cell.textLabel?.text = tasks.childs[indexPath.row].name
        cell.detailTextLabel?.text = String(tasks.childs[indexPath.row].childs.count)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let childVC = storyboard?.instantiateViewController(withIdentifier: "TaskTableViewController") as? TaskTableViewController else { return }
        
        let child = tasks.childs[indexPath.row]
        childVC.title = child.name
        childVC.tasks = child
        navigationController?.pushViewController(childVC, animated: true)
    }

}

extension TaskTableViewController {
    
    private func showCreateTaskAlert() {
        let alert = UIAlertController(title: "Создание новой задачи", message: "Введите название для подзадачи", preferredStyle: .alert)
        alert.addTextField { (textField) in
            textField.placeholder = "Название задачи"
        }
        
        let actionSuccess = UIAlertAction(title: "Создать", style: .default, handler: { [weak self] (_) in
            guard let textField = alert.textFields?[0],
                let taskName = textField.text else { return }
            let newTask = Task(name: taskName, childs: [])
            self?.tasks.childs.append(newTask)
            self?.tableView.reloadData()
        })
        
        let actionCancel = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        
        alert.addAction(actionSuccess)
        alert.addAction(actionCancel)
        self.present(alert, animated: true, completion: nil)
    }
    
}

