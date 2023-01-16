//
//  DragVC.swift
//  VK Cup R2
//
//  Created by Kurbatov Artem on 15.01.2023.
//

import UIKit

class DragingVC: UIViewController {
    
    private let questionLabel = UILabel()
    private let button = UIButton()
    private let answersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    private var initialCenter = CGPoint()
    
    private let mainModel = MainModel()
    private let questionModel = DragModel()
    
    private var questions = [DragQuestion]()
    private var currentQuestionIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "info.circle"), style: .plain, target: self, action: #selector(infoAction))
        
        questionModel.delegate = self
        questionModel.loadData()
        
        answersCollectionView.delegate = self
        answersCollectionView.dataSource = self
        
        configureQuestion()
        configureAnswers()
        configureButton()
        
        displayQuestion()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let layout = answersCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            layout.minimumInteritemSpacing = 5
            layout.minimumLineSpacing = 10
            layout.sectionInset = UIEdgeInsets(top: 300, left: 15, bottom: 0, right: 15)
        }
    }
    
    // MARK: - Views configuration
    
    private func configureQuestion() {
        
        view.addSubview(questionLabel)
        
        questionLabel.font = .preferredFont(forTextStyle: .title2)
        questionLabel.textAlignment = .left
        questionLabel.numberOfLines = 0
        
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            questionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
        ])
    }
    
    private func configureAnswers() {
        
        view.addSubview(answersCollectionView)
        
        answersCollectionView.backgroundColor = .clear
        
        answersCollectionView.register(DragCollectionViewCell.self, forCellWithReuseIdentifier: Helpers.dragVCIdentifier)
        answersCollectionView.allowsSelection = false
        answersCollectionView.isScrollEnabled = false
        
        answersCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            answersCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            answersCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            answersCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            answersCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configureButton() {
        
        view.addSubview(button)
        
        button.configuration = .filled()
        button.configuration?.cornerStyle = .capsule
        button.configuration?.title = "Ответить"
        
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // MARK: - Display question
    
    private func displayQuestion() {
        
        questionLabel.text = questions[currentQuestionIndex].question
        answersCollectionView.reloadData()
    }
    
    // MARK: - Button action and cell dragging
    
    @objc func buttonAction() {
        
        answersCollectionView.isUserInteractionEnabled = false
        
        let cells = answersCollectionView.visibleCells
        
        let text = questionLabel.text
        
        let answer1 = findAnswerCell(cells: cells, answerIndex: 0)
        let answer2 = findAnswerCell(cells: cells, answerIndex: 1)
        
        if answer1.cell != nil && answer2.cell != nil {
            
            answer1.cell?.alpha = 0
            answer2.cell?.alpha = 0
            
            let answer1Color: UIColor = answer1.isCorrectAnseer! ? .green : .red
            let answer2Color: UIColor = answer2.isCorrectAnseer! ? .green : .red
            
            let words = questionLabel.text?.split(separator: " ")
            
            var stringForRange = makeStringForRange(words: words!, answerIndex: questions[currentQuestionIndex].answerIndexes[0])
            let answer1Range = (stringForRange as NSString).range(of: String(questions[currentQuestionIndex].answers[answer1.cell!.tag]))
            
            stringForRange = makeStringForRange(words: words!, answerIndex: questions[currentQuestionIndex].answerIndexes[1])
            let answer2Range = (stringForRange as NSString).range(of: String(questions[currentQuestionIndex].answers[answer2.cell!.tag]))
            
            let mutableAttributedString = NSMutableAttributedString.init(string: questionLabel.text!)
            mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: answer1Color, range: answer1Range)
            mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: answer2Color, range: answer2Range)
            
            questionLabel.attributedText = mutableAttributedString
            
            mainModel.clickAnimation(view: questionLabel)
            
            currentQuestionIndex += 1
            
            if currentQuestionIndex == questions.count {
                currentQuestionIndex = 0
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                self.displayQuestion()
            }
        }
        else {
            questionLabel.text = text
            let alert = mainModel.createAlert(message: "Оба пропуска должны быть заполнены")
            present(alert, animated: true)
        }
        
        answersCollectionView.isUserInteractionEnabled = true
    }
    
    @objc private func handlePenGesture(gesture: UIPanGestureRecognizer) {
        
        let cell = gesture.view!
        let translation = gesture.translation(in: cell.superview)
        
        if gesture.state == .began {
            self.initialCenter = cell.center
        }
        else if gesture.state != .cancelled {
            
            var newCenter = CGPoint(x: initialCenter.x + translation.x, y: initialCenter.y + translation.y)
            if newCenter.y <= 25 {
                newCenter.y = 25
            }
            cell.center = newCenter
        }
        else {
            cell.center = initialCenter
        }
    }
    
    @objc private func infoAction() {
        let alert = UIAlertController(title: "Подсказка", message: "Старайтесь разместить ответ по центру пропуска", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ОК", style: .cancel))
        present(alert, animated: true)
    }
    
    // MARK: - Helper functions
    
    private func findPoint() -> CGPoint {
                
        let range: NSRange = (questionLabel.text! as NSString).range(of: "_____")
        let prefix = (questionLabel.text! as NSString).substring(to: range.location)
        let size: CGSize = prefix.size(withAttributes: [NSAttributedString.Key.font: questionLabel.font!])
        var point = CGPoint(x: size.width + 20, y: 25)
        if point.x > view.frame.width {
            point.y += 30
            point.x -= (view.frame.width - 40)
        }
        
        return point
    }
    
    private func comparePositions(of cellPosition: CGPoint, and gapPoint: CGPoint) -> Bool {
        
        return (gapPoint.y - 10 <= cellPosition.y  && cellPosition.y <= gapPoint.y + 10) && (gapPoint.x < cellPosition.x && cellPosition.x < gapPoint.x + 60)
    }
    
    private func checkAnswer(cellTag: Int, answerIndex: Int) -> Bool {
        
        if let stratIndex = questionLabel.text!.firstIndex(of: "_") {
            
            let endIndex = questionLabel.text!.index(stratIndex, offsetBy: 5)
            
            let range = stratIndex..<endIndex
            
            let answer = questions[currentQuestionIndex].answers[cellTag]
            
            questionLabel.text?.replaceSubrange(range, with: answer)
            
            return cellTag == questions[currentQuestionIndex].correctAnswers[answerIndex]
        }
        else {
            return false
        }
    }
    
    private func findAnswerCell(cells: [UICollectionViewCell], answerIndex: Int) -> (cell: UICollectionViewCell?, isCorrectAnseer: Bool?) {
        
        let point = findPoint()
        
        for cell in cells {
            if comparePositions(of: cell.center, and: point) {
                return (cell, checkAnswer(cellTag: cell.tag, answerIndex: answerIndex))
            }
        }
        return (nil, nil)
    }
    
    private func makeStringForRange(words: [String.SubSequence], answerIndex: Int) -> String {
        
        var str = ""
        
        for i in 0..<words.count {
            
            if i != answerIndex {
                str += String(repeating: "#", count: words[i].count)
            }
            else {
                str += words[i]
            }
            
            str += " "
        }
        
        return String(str.dropLast(1))
    }
}

// MARK: - Extensions

extension DragingVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questions[currentQuestionIndex].answers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = answersCollectionView.dequeueReusableCell(withReuseIdentifier: Helpers.dragVCIdentifier, for: indexPath) as! DragCollectionViewCell
        cell.tag = indexPath.row
        cell.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector (handlePenGesture)))
        cell.configureCell(text: questions[currentQuestionIndex].answers[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = view.frame.width * 0.4
        return CGSize(width: width, height: 40)
    }
}

extension DragingVC: DragModelDelegate {
    
    func getData(_ data: [DragQuestion]) {
        self.questions = data
    }
}
