//
//  FillTextVC.swift
//  VK Cup R2
//
//  Created by Kurbatov Artem on 13.01.2023.
//

import UIKit

class FillTextVC: UIViewController {
    
    private let questionLabel = UILabel()
    private let answerText = UITextView()
    private let button = UIButton()
    private var defaultTextFont: UIFont?
    
    private let mainModel = MainModel()
    private let questionModel = FillGapModel()
    
    private var questions = [QuestionWithGaps]()
    private var currentQuestionIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        answerText.delegate = self
        
        questionModel.delegate = self
        questionModel.loadData()
        
        configureQuestion()
        configureTextView()
        configureButton()
        
        displayQuestion()
    }
    
    private func configureQuestion() {
        
        view.addSubview(questionLabel)
        
        questionLabel.font = .preferredFont(forTextStyle: .title2)
        questionLabel.textAlignment = .center
        questionLabel.numberOfLines = 0
        
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            questionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            questionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
        ])
    }
    
    private func configureTextView() {
        
        view.addSubview(answerText)
        
        answerText.layer.cornerRadius = 5
        answerText.layer.borderWidth = 0.5
        answerText.layer.borderColor = traitCollection.userInterfaceStyle == .dark ? UIColor.white.cgColor : UIColor.black.cgColor
        
        defaultTextFont = answerText.font
        answerText.textColor = .lightGray
        
        answerText.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            answerText.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 50),
            answerText.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            answerText.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            answerText.heightAnchor.constraint(equalToConstant: 50)
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
    
    @objc func buttonAction() {
        
        if answerText.text != nil && answerText.text != "" {
            
            answerText.text = answerText.text.trimmingCharacters(in: .whitespaces)
            
            let answer = answerText.text.split(separator: " ")
            
            if answer.count == 2 {
                
                let answer1Color: UIColor = checkAnswer(answer: String(answer[0].lowercased()), answerIndex: 0) ? .green : .red
                let answer2Color: UIColor = checkAnswer(answer: String(answer[1].lowercased()), answerIndex: 1) ? .green : .red
            
                let words = questionLabel.text?.split(separator: " ")
                
                var stringForRange = makeStringForRange(words: words!, answerIndex: questions[currentQuestionIndex].answerIndexes[0])
                let answer1Range = (stringForRange as NSString).range(of: String(answer[0].lowercased()))
                
                stringForRange = makeStringForRange(words: words!, answerIndex: questions[currentQuestionIndex].answerIndexes[1])
                let answer2Range = (stringForRange as NSString).range(of: String(answer[1].lowercased()))
                
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
                let alert = mainModel.createAlert(message: "Ответ должен содержать 2 слова, разделенные пробелом")
                present(alert, animated: true)
            }
        }
        else {
            let alert = mainModel.createAlert(message: "Поле ответа должно быть заполнено")
            present(alert, animated: true)
        }
    }
    
    private func displayQuestion() {
        
        questionLabel.text = questions[currentQuestionIndex].question
        answerText.endEditing(true)
        setPlaceholderText()
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
    
    private func checkAnswer(answer: String, answerIndex: Int) -> Bool {
        
        if let stratIndex = questionLabel.text!.firstIndex(of: "_") {
            
            let endIndex = questionLabel.text!.index(stratIndex, offsetBy: 5)
            
            let range = stratIndex..<endIndex
            
            questionLabel.text?.replaceSubrange(range, with: answer)

            return answer == questions[currentQuestionIndex].correctAnswers[answerIndex]
        }
        else {
            return false
        }
    }
    
    private func setPlaceholderText() {
        answerText.font = defaultTextFont
        answerText.text = "Впишите два слова, разделенные пробелом"
        answerText.textColor = UIColor.lightGray
    }
}

extension FillTextVC: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if answerText.textColor == UIColor.lightGray {
            answerText.text = nil
            answerText.textColor = UIColor.black
            answerText.font = .preferredFont(forTextStyle: .body)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if answerText.text.isEmpty {
            setPlaceholderText()
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}

extension FillTextVC: FillGapModelDelegate {
   
    func getData(_ data: [QuestionWithGaps]) {
        self.questions = data
    }
}
