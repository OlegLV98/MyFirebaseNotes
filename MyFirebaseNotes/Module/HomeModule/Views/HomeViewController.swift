//
//  HomeViewController.swift
//  HW3Module3_LesnoyOleg
//
//  Created by Oleg Lesnoy on 13.06.2024.
//

import UIKit

protocol HomeViewControllerProtocol: AnyObject {
    func reloadData()
    func deleteRow(indexPath: IndexPath)
    func showAlert() 
}

class HomeViewController: UIViewController, HomeViewControllerProtocol {
    var presenter: HomePresenterProtocol!
        
    private lazy var tableView: UITableView = {
        $0.layer.cornerRadius = 20
        $0.dataSource = self
        $0.delegate = self
        $0.backgroundColor = AppColorSet.Home.table
        $0.separatorStyle = .singleLine
        $0.separatorColor = AppColorSet.Home.FolderCell.separator
        $0.register(CustomTableViewCell.self, forCellReuseIdentifier: "cell")
        return $0
    }(UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height), style: .plain))
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.getFolders()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Папки"
        presenter = HomePresenter(view: self)
        view.backgroundColor = AppColorSet.Home.bgMainView
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: .add, style: .plain, target: self, action: #selector(addFolder))
        navigationItem.rightBarButtonItem?.tintColor = AppColorSet.Home.addButton
        navigationItem.backBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "folder.fill"), style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = AppColorSet.Notes.backButton
        view.addSubview(tableView)
    }
    
    func showAlert() {
        let alert = UIAlertController(title: nil, message: "У папки должно быть название!", preferredStyle: .alert)
        let action = UIAlertAction(title: "ОК", style: .default) {_ in
            alert.dismiss(animated: true)
        }
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    @objc func addFolder() {
        let alert = UIAlertController(title: "Название папки", message: "Напишите название папки", preferredStyle: .alert)
        alert.addTextField()
        let action = UIAlertAction(title: "OK", style: .default) {[weak self]_ in
            guard let self else {return}
            if let name = alert.textFields?[0].text {
                presenter.addFolder(name: name)
                alert.dismiss(animated: true)
            }
        }
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    func deleteRow(indexPath: IndexPath) {
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    func reloadData() {
        tableView.reloadData()
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        cell.setupCell(item: presenter.tableData[indexPath.row])
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        61
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let folderName = presenter.tableData[indexPath.row].name
        let folderId = presenter.tableData[indexPath.row].id
        let notesVC = ModuleBuilder.createNotesModule(folderName: folderName, folderId: folderId)
        navigationController?.pushViewController(notesVC, animated: true)
        navigationItem.backButtonTitle = "Назад"
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.deleteFolder(indexPath: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
}
