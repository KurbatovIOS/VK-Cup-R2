//
//  SurveyVC.swift
//  VK Cup R2
//
//  Created by Kurbatov Artem on 07.01.2023.
//

import UIKit

class SurveyVC: UIViewController {
    
    private let anserTableView = UITableView()
    private let questionLabel = UILabel()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        anserTableView.delegate = self
        anserTableView.dataSource = self
        
        view.backgroundColor = .cyan
    }
    
    
    private func configureAnserTableView() {
        
        view.addSubview(anserTableView)
        
        anserTableView.register(UITableViewCell.self, forCellReuseIdentifier: Identifiers.surveyVCIdentifier)
        
        anserTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            anserTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            anserTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            anserTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
    }
}

extension SurveyVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = anserTableView.dequeueReusableCell(withIdentifier: Identifiers.surveyVCIdentifier, for: indexPath)
        return UITableViewCell()
    }  
}
