//
//  ViewController.swift
//  iRestaurant
//
//  Created by Tifo Audi Alif Putra on 26/12/20.
//

import UIKit

class ListMenuViewController: UITableViewController {
    
    private let service: RestoService
    
    private static let cellIdentifier = "ListMenuRestoCellIdentifier"
    
    private var menu: [Menu] = []
    
    init(service: RestoService) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        configureTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetchMenu()
    }
    
    private func configureTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: ListMenuViewController.cellIdentifier)
        tableView.tableFooterView = UIView()
    }
    
    private func configureNavBar() {
        self.navigationItem.title = "iRestaurants"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addResto))
    }
    
    private func fetchMenu() {
        service.fetchMenu { [weak self] (menu: [Menu]) in
            self?.menu = menu
            self?.tableView.reloadData()
        }
    }
    
    @objc private func addResto() {
        let alertController = UIAlertController(title: "iRestaurant", message: "Add Menu", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Fill the menu name"
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Fill the menu description"
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "Fill the menu price"
        }
        
        let alertAction = UIAlertAction(title: "Add", style: .default) { [weak self] (_) in
            guard
                let nameTextField = alertController.textFields?.first,
                let menuName = nameTextField.text,
                let descTextField = alertController.textFields?[1],
                let menuDesc = descTextField.text,
                let priceTextField = alertController.textFields?.last,
                let menuPrice = priceTextField.text,
                let price = Double(menuPrice) else { return }
            
            self?.service.addMenu(
                name: menuName,
                desc: menuDesc,
                price: price
            )
            
            self?.fetchMenu()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(alertAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    private func updateMenu(menu: Menu) {
        let alertController = UIAlertController(title: "iRestaurant", message: "Update Menu", preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.text = menu.name
        }
        
        alertController.addTextField { (textField) in
            textField.text = menu.desc
        }
        
        alertController.addTextField { (textField) in
            textField.text = String(menu.price)
        }
        
        let alertAction = UIAlertAction(title: "Add", style: .default) { [weak self] (_) in
            guard
                let nameTextField = alertController.textFields?.first,
                let menuName = nameTextField.text,
                let descTextField = alertController.textFields?[1],
                let menuDesc = descTextField.text,
                let priceTextField = alertController.textFields?.last,
                let menuPrice = priceTextField.text,
                let price = Double(menuPrice) else { return }
            
            menu.name = menuName
            menu.desc = menuDesc
            menu.price = price
            
            self?.service.updateMenu(menu: menu)
            self?.fetchMenu()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(alertAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}

extension ListMenuViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ListMenuViewController.cellIdentifier, for: indexPath)
        cell.textLabel?.text = menu[indexPath.row].name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        updateMenu(menu: menu[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {
            return
        }
        
        service.deleteMenu(menu: menu[indexPath.row])
        fetchMenu()
    }
}

