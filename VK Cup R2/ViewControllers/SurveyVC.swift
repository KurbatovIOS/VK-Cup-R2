//
//  SurveyVC.swift
//  VK Cup R2
//
//  Created by Kurbatov Artem on 07.01.2023.
//

import UIKit

class SurveyVC: UIViewController {
    
    private let anserTableView = UITableView()
    
    private let answerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    private let questionCountLabel = UILabel()
    private let questionLabel = UILabel()
    
    private let surveyModel = SurveyModel()
    private var survey = [Question]()
    private var currentQuestionIndex = 0
    private var questionCount = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        anserTableView.delegate = self
//        anserTableView.dataSource = self
        
        answerCollectionView.delegate = self
        answerCollectionView.dataSource = self
        
        view.backgroundColor = .systemBackground
        
        configuteQuestionCountLable()
        configuteQuestionLable()
        //configureAnserTableView()
        configureAnswerCollectionView()
        
        surveyModel.delegate = self
        surveyModel.loadQuestions()
    }
    
    
    // MARK: - views configuration
    
    private func configuteQuestionCountLable() {
        
        view.addSubview(questionCountLabel)
                
        questionCountLabel.textColor = .systemGray
        
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
        
        questionLabel.font = UIFont.boldSystemFont(ofSize: 22)
        questionLabel.numberOfLines = 0
        
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            questionLabel.leadingAnchor.constraint(equalTo: questionCountLabel.leadingAnchor),
            questionLabel.trailingAnchor.constraint(equalTo: questionCountLabel.trailingAnchor),
            questionLabel.topAnchor.constraint(equalTo: questionCountLabel.bottomAnchor, constant: 10),
        ])
    }
    
//    private func configureAnserTableView() {
//
//        view.addSubview(anserTableView)
//
//        anserTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: Helpers.surveyVCIdentifier)
//
//        anserTableView.separatorStyle = .none
//        anserTableView.isScrollEnabled = false
//
//        anserTableView.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            anserTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
//            anserTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
//            anserTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
//            anserTableView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 30)
//        ])
//    }
    
    private func configureAnswerCollectionView() {
        
        view.addSubview(answerCollectionView)
        
        answerCollectionView.register(SurveyCollectionViewCell.self, forCellWithReuseIdentifier: Helpers.surveyVCIdentifier)
        
        answerCollectionView.translatesAutoresizingMaskIntoConstraints = false
        answerCollectionView.isScrollEnabled = false
        
        NSLayoutConstraint.activate([
            answerCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            answerCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            answerCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
            answerCollectionView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 30)
        ])
    }

    
    // MARK: -
    
    private func displayQuestion() {
        
        questionCountLabel.text = "Вопрос \(questionCount+1)"
        questionLabel.text = survey[currentQuestionIndex].question
        
        //anserTableView.reloadData()
    }
    
    private func checkAnswer(indexPathForSelectedCell indexPath: IndexPath) {
        
        let cell = anserTableView.cellForRow(at: indexPath)
        
        if indexPath.row == survey[currentQuestionIndex].correctIndex {
            cell?.backgroundView?.backgroundColor = .green
        }
        else {
            cell?.backgroundView?.backgroundColor = .red
        }
        
    }
    
}

extension SurveyVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return survey[currentQuestionIndex].answers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = answerCollectionView.dequeueReusableCell(withReuseIdentifier: Helpers.surveyVCIdentifier, for: indexPath) as! SurveyCollectionViewCell
        cell.configureCell(answer: survey[currentQuestionIndex].answers[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = answerCollectionView.frame.width
        let heigh = view.frame.height * 0.07
        
        return CGSize(width: width, height: heigh)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
    
    
    
    
}

//extension SurveyVC: UITableViewDelegate, UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return survey[currentQuestionIndex].answers.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = anserTableView.dequeueReusableCell(withIdentifier: Helpers.surveyVCIdentifier, for: indexPath) as! CustomTableViewCell
//        cell.configureCell(text: survey[currentQuestionIndex].answers[indexPath.row], bgColor: .systemGray3, cornerRadius: 5, alignment: .left)
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return view.frame.height * 0.07
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        checkAnswer(indexPathForSelectedCell: indexPath)
//
////        questionCount += 1
////
////        currentQuestionIndex += 1
////
////        if currentQuestionIndex == survey.count {
////            currentQuestionIndex = 0
////        }
////        displayQuestion()
//    }
//
//}

extension SurveyVC: SurveyModelDelegate {
    
    func getQuestions(_ questions: [Question]) {
        self.survey = questions
        displayQuestion()
    }
}
