//
//  FillTextVC.swift
//  VK Cup R2
//
//  Created by Kurbatov Artem on 13.01.2023.
//

import UIKit

class FillTextVC: UIViewController {
    
    private let textLabel = UILabel()
    private let answerText = UITextView()
    
    private let button = UIButton()
    
    private let model = MainModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        answerText.delegate = self
        
        configureText()
        configureTextView()
        configureButton()
    }
    
    private func configureText() {
        
        view.addSubview(textLabel)
        
        textLabel.text = "Заполни _____ пропуски как _____ скорее"
        textLabel.font = .preferredFont(forTextStyle: .title2)
        textLabel.textAlignment = .center
        textLabel.numberOfLines = 0
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            textLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            textLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
        ])
    }
    
    private func configureTextView() {
        
        view.addSubview(answerText)
        
        answerText.layer.cornerRadius = 5
        answerText.layer.borderWidth = 0.5
        answerText.layer.borderColor = traitCollection.userInterfaceStyle == .dark ? UIColor.white.cgColor : UIColor.black.cgColor
        
        answerText.text = "Впишите два слова, разделенные пробелом"
        answerText.textColor = .lightGray
        
        answerText.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            answerText.topAnchor.constraint(equalTo: textLabel.bottomAnchor, constant: 50),
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
            
            answerText.text = answerText.text.lowercased()
            answerText.text = answerText.text.trimmingCharacters(in: .whitespaces)
            
            let answer = answerText.text.split(separator: " ")
            
            if answer.count == 2 {
                checkAnswer(answer: String(answer[0]))
                checkAnswer(answer: String(answer[1]))
                
                let stringRange = (textLabel.text! as NSString).range(of: String(answer[0]))
                let string2Range = (textLabel.text! as NSString).range(of: String(answer[1]))

                let mutableAttributedString = NSMutableAttributedString.init(string: textLabel.text!)
                mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.green, range: stringRange)
                mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.green, range: string2Range)
    
                textLabel.attributedText = mutableAttributedString
            }
            else {
                let alert = model.createAlert(message: "Ответ должен содержать 2 слова, разделенные пробелом")
                present(alert, animated: true)
            }
        }
        else {
            let alert = model.createAlert(message: "Поле ответа должно быть заполнено")
            present(alert, animated: true)
        }
    }
    
    private func checkAnswer(answer: String) {
        
        if let stratIndex = textLabel.text!.firstIndex(of: "_") {
            
            let endIndex = textLabel.text!.index(stratIndex, offsetBy: 5)
            
            let range = stratIndex..<endIndex
            
            textLabel.text?.replaceSubrange(range, with: answer)
            
            model.clickAnimation(view: textLabel)
            
            // check if it's correct
            
           
        }
    }
}

extension FillTextVC: UITextFieldDelegate, UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if answerText.textColor == UIColor.lightGray {
            answerText.text = nil
            answerText.textColor = UIColor.black
            answerText.font = .preferredFont(forTextStyle: .body)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if answerText.text.isEmpty {
            answerText.text = "Впишите два слова, разделенные пробелом"
            answerText.textColor = UIColor.lightGray
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


