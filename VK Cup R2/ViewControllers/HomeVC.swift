//
//  ViewController.swift
//  VK Cup R2
//
//  Created by Kurbatov Artem on 05.01.2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let elementsTableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        elementsTableView.delegate = self
        elementsTableView.dataSource = self
        
        view.backgroundColor = .systemBackground
        
        title = "Выбор"
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        configureTableView()
    }
    
    private func configureTableView() {
        
        view.addSubview(elementsTableView)
        
        elementsTableView.register(UITableViewCell.self, forCellReuseIdentifier: Helpers.homeVCIdentifier)
    
        elementsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            elementsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            elementsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            elementsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            elementsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = elementsTableView.dequeueReusableCell(withIdentifier: Helpers.homeVCIdentifier, for: indexPath)
        return cell
    }
}

