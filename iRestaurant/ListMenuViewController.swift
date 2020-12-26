//
//  ViewController.swift
//  iRestaurant
//
//  Created by Tifo Audi Alif Putra on 26/12/20.
//

import UIKit

class ListMenuViewController: UITableViewController {
    
    private let service: RestoService
    
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
    }
}

