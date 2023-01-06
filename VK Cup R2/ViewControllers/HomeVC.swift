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
        
        elementsTableView.register(ElementTableViewCell.self, forCellReuseIdentifier: Identifiers.homeVCIdentifier)
        
        elementsTableView.separatorStyle = .none
        
        elementsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            elementsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            elementsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            elementsTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            elementsTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = elementsTableView.dequeueReusableCell(withIdentifier: Identifiers.homeVCIdentifier, for: indexPath) as! ElementTableViewCell
        cell.configureCell(text: "AAAA")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height * 0.1
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//    }
    
}

