//
//  SurveyVC.swift
//  VK Cup R2
//
//  Created by Kurbatov Artem on 07.01.2023.
//

import UIKit

class SurveyVC: UIViewController {
    
    private let anserTableView = UITableView()
    
    private let questionCountLabel = UILabel()
    private let questionLabel = UILabel()
    
    private var count = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()

        anserTableView.delegate = self
        anserTableView.dataSource = self
        
        view.backgroundColor = .white
        
        configuteQuestionCountLable()
        configuteQuestionLable()
        configureAnserTableView()
        
        displayQuestion()
    }
    
    // MARK: - views configuration
    
    private func configuteQuestionCountLable() {
        
        view.addSubview(questionCountLabel)
                
        questionCountLabel.textColor = .systemGray2
        
        questionCountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            questionCountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            questionCountLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            questionCountLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            questionCountLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
    }
    
    private func configuteQuestionLable() {
        
        view.addSubview(questionLabel)
        
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        questionLabel.font = UIFont.boldSystemFont(ofSize: 23)
        
        NSLayoutConstraint.activate([
            questionLabel.leadingAnchor.constraint(equalTo: questionCountLabel.leadingAnchor),
            questionLabel.trailingAnchor.constraint(equalTo: questionCountLabel.trailingAnchor),
            questionLabel.topAnchor.constraint(equalTo: questionCountLabel.bottomAnchor, constant: 10),
        ])
    }
    
    private func configureAnserTableView() {
        
        view.addSubview(anserTableView)
        
        anserTableView.register(SurveyTableViewCell.self, forCellReuseIdentifier: Identifiers.surveyVCIdentifier)
        
        anserTableView.separatorStyle = .none
        
        anserTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            anserTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            anserTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            anserTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            anserTableView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 50)
        ])
    }
    
    // MARK: -
    
    private func displayQuestion() {
        
        count += 1
        questionCountLabel.text = "Вопрос \(count)"
        
        questionLabel.text = "Вот он первый вопрос"
        
        // get question label
        // set answer cells
        // reload teble view
        
    }
}

extension SurveyVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = anserTableView.dequeueReusableCell(withIdentifier: Identifiers.surveyVCIdentifier, for: indexPath) as! SurveyTableViewCell
        cell.configureCell(text: "AAAA \(indexPath.row)")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height * 0.07
    }
}
