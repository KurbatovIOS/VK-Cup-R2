//
//  DragVC.swift
//  VK Cup R2
//
//  Created by Kurbatov Artem on 15.01.2023.
//

import UIKit

class DragingVC: UIViewController {
    
    private let questionLabel = UILabel()
    private let answersCollectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.sectionInset = UIEdgeInsets(top: 300, left: 15, bottom: 0, right: 15)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return view
    }()
    
    private var initialCenter = CGPoint()
    
    private let mainModel = MainModel()
    
    private let answers = ["0", "1", "2", "3"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        answersCollectionView.delegate = self
        answersCollectionView.dataSource = self
        
        configureQuestion()
        configureAnswers()
    }
    
    private func configureQuestion() {
        
        view.addSubview(questionLabel)
        
        questionLabel.text = "Сначала идёт _____, а потом уже потомпотомпо ______ !"
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
            // adjust y range
            print(point)
            print(cell.center)
            comparePositions(of: cell.center, and: point)
        }
        else {
            cell.center = initialCenter
        }
    }
}

extension DragingVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return answers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = answersCollectionView.dequeueReusableCell(withReuseIdentifier: Helpers.dragVCIdentifier, for: indexPath) as! DragCollectionViewCell
        cell.backgroundColor = .purple
        cell.tag = indexPath.row
        cell.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector (handlePenGesture)))
        cell.configureCell(text: answers[indexPath.row])
        return cell
    }
}
