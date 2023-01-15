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
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.sectionInset = UIEdgeInsets(top: 300, left: 15, bottom: 0, right: 15)
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
        
        questionModel.delegate = self
        questionModel.loadData()
        
        answersCollectionView.delegate = self
        answersCollectionView.dataSource = self
        
        configureQuestion()
        configureAnswers()
        configureButton()
        
        displayQuestion()
    }
    
    private func configureQuestion() {
        
        view.addSubview(questionLabel)
        
        questionLabel.font = .preferredFont(forTextStyle: .title2)
        questionLabel.textAlignment = .left
        questionLabel.numberOfLines = 0
        
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
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
    
    private func displayQuestion() {
        
        questionLabel.text = questions[currentQuestionIndex].question
    }
    
    private func findCoordinates(of text: String) -> CGPoint {
        let range: NSRange = (questionLabel.text! as NSString).range(of: text)
        let prefix = (questionLabel.text! as NSString).substring(to: range.location)
        let size: CGSize = prefix.size(withAttributes: [NSAttributedString.Key.font: questionLabel.font!])
        var point = CGPoint(x: size.width + 15, y: 35)
        if point.x > view.frame.width {
            point.y += 30
            point.x -= view.frame.width
        }
        
        print("Text location \(point)")
        
        return point
    }
    
    private func comparePositions(of cellPosition: CGPoint, and gapPoint: CGPoint) {
        
        if gapPoint.y - 10 <= cellPosition.y  && cellPosition.y <= gapPoint.y + 10 {
            print("Ok")
        }
        
        
        
    }
    
    private func checkAnswer(answer: String, answerIndex: Int) -> Bool {
        
        // chech and then replace
        
        if let stratIndex = questionLabel.text!.firstIndex(of: "_") {
            
            let endIndex = questionLabel.text!.index(stratIndex, offsetBy: 5)
            
            let range = stratIndex..<endIndex
            
            questionLabel.text?.replaceSubrange(range, with: answer)

            //return answer == questions[currentQuestionIndex].correctAnswers[answerIndex]
            return true
        }
        else {
            return false
        }
    }
    
    @objc func buttonAction() {
        
        let cells = answersCollectionView.visibleCells
                
        for cell in cells {
            print(cell.center)
        }
        
        //questionLabel.text?.replaceSubrange(<#T##subrange: Range<String.Index>##Range<String.Index>#>, with: <#T##Collection#>)
        
//        let answer1Color: UIColor = checkAnswer(answer: String(answer[0].lowercased()), answerIndex: 0) ? .green : .red
//        let answer2Color: UIColor = checkAnswer(answer: String(answer[1].lowercased()), answerIndex: 1) ? .green : .red
//
//        let words = questionLabel.text?.split(separator: " ")
//
//        var stringForRange = makeStringForRange(words: words!, answerIndex: questions[currentQuestionIndex].answerIndexes[0])
//        let answer1Range = (stringForRange as NSString).range(of: String(answer[0].lowercased()))
//
//        stringForRange = makeStringForRange(words: words!, answerIndex: questions[currentQuestionIndex].answerIndexes[1])
//        let answer2Range = (stringForRange as NSString).range(of: String(answer[1].lowercased()))
//
//        let mutableAttributedString = NSMutableAttributedString.init(string: questionLabel.text!)
//        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: answer1Color, range: answer1Range)
//        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: answer2Color, range: answer2Range)
//
//        questionLabel.attributedText = mutableAttributedString
//
//        mainModel.clickAnimation(view: questionLabel)
//
//        currentQuestionIndex += 1
//
//        if currentQuestionIndex == questions.count {
//            currentQuestionIndex = 0
//        }
//
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
//            self.displayQuestion()
//        }
     
    }
    
    @objc private func handlePenGesture(gesture: UIPanGestureRecognizer) {
        
        let cell = gesture.view!
        let translation = gesture.translation(in: cell.superview)
        
        if gesture.state == .began {
           
            self.initialCenter = cell.center
        }
        else if gesture.state == .changed {
            var newCenter = CGPoint(x: initialCenter.x + translation.x, y: initialCenter.y + translation.y)
            if newCenter.y <= 25 {
                newCenter.y = 25
            }
            cell.center = newCenter
        }
        else if gesture.state == .ended {
            let point = findCoordinates(of: "_____")
            
            comparePositions(of: cell.center, and: point)
        }
        else {
            cell.center = initialCenter
        }
    }
}

extension DragingVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return questions[currentQuestionIndex].answers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = answersCollectionView.dequeueReusableCell(withReuseIdentifier: Helpers.dragVCIdentifier, for: indexPath) as! DragCollectionViewCell
        cell.backgroundColor = .purple
        cell.tag = indexPath.row
        cell.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector (handlePenGesture)))
        cell.configureCell(text: questions[currentQuestionIndex].answers[indexPath.row])
        return cell
    }
}

extension DragingVC: DragModelDelegate {
   
    func getData(_ data: [DragQuestion]) {
        self.questions = data
    }
}
