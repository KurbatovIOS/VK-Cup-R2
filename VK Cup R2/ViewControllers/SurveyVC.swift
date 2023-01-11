//
//  SurveyVC.swift
//  VK Cup R2
//
//  Created by Kurbatov Artem on 07.01.2023.
//

import UIKit

class SurveyVC: UIViewController {
        
    private var answerCollectionView: UICollectionView!
    
    private let questionCountLabel = UILabel()
    private let questionLabel = UILabel()
    
    private let surveyModel = SurveyModel()
    private var survey = [Question]()
    private var currentQuestionIndex = 0
    private var questionCount = 0
    
    private let mainModel = MainModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        answerCollectionView = mainModel.createCollectionView()
                
        answerCollectionView.delegate = self
        answerCollectionView.dataSource = self
        
        configuteQuestionCountLable()
        configuteQuestionLable()
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
            questionLabel.topAnchor.constraint(equalTo: questionCountLabel.bottomAnchor, constant: 30),
        ])
    }
    
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
        
        answerCollectionView.allowsSelection = true
        answerCollectionView.reloadData()
    }
}

extension SurveyVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return survey[currentQuestionIndex].answers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = answerCollectionView.dequeueReusableCell(withReuseIdentifier: Helpers.surveyVCIdentifier, for: indexPath) as! SurveyCollectionViewCell
        cell.configureCell(answer: survey[currentQuestionIndex].answers[indexPath.row], percent: survey[currentQuestionIndex].answerPercents[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = answerCollectionView.frame.width
        let heigh = view.frame.height * 0.08
        
        return CGSize(width: width, height: heigh)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        answerCollectionView.allowsSelection = false
        
        let cells = answerCollectionView.visibleCells as! [SurveyCollectionViewCell]
        
        var correctCell: UICollectionViewCell?
        var wrongCell: UICollectionViewCell?

        for cell in cells {
            cell.answerPercent.alpha = 1
            
            let index = answerCollectionView.indexPath(for: cell)
           
            if index?.row == survey[currentQuestionIndex].correctIndex {
                correctCell = cell
            }
            else if index?.row != survey[currentQuestionIndex].correctIndex && indexPath == index {
                wrongCell = answerCollectionView.cellForItem(at: indexPath)
            }
        }
                
        questionCount += 1
        currentQuestionIndex += 1
        
        if currentQuestionIndex == survey.count {
            currentQuestionIndex = 0
        }
        
        UIView.animate(withDuration: 0.5) {
            correctCell!.backgroundColor = .green
            if wrongCell != nil {
                wrongCell?.backgroundColor = .red
            }
        } completion: { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.displayQuestion()
            }
        }
    }
}

extension SurveyVC: SurveyModelDelegate {
    
    func getQuestions(_ questions: [Question]) {
        self.survey = questions
        displayQuestion()
    }
}
