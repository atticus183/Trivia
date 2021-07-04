//
//  ViewController.swift
//  Trivia
//
//  Created by Josh R on 7/4/21.
//

import UIKit

class TriviaViewController: UIViewController {
    
    private let layout: UICollectionViewFlowLayout = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .vertical
        return flow
    }()
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    let profileButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "person")
        button.setBackgroundImage(image, for: .normal)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        return button
    }()
    
    let questionLabel: UILabel = {
        let label = UILabel()
        label.text = "Who is the CEO of Apple?"
        label.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 4
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "+200"
        label.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 30
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        
        collectionView.register(TriviaAnswerCell.self, forCellWithReuseIdentifier: TriviaAnswerCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        stackView.addArrangedSubview(questionLabel)
        stackView.addArrangedSubview(collectionView)
        
        view.addSubview(profileButton)
        view.addSubview(scoreLabel)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            profileButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            profileButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            profileButton.heightAnchor.constraint(equalToConstant: 35),
            profileButton.widthAnchor.constraint(equalToConstant: 35),
            
            scoreLabel.centerYAnchor.constraint(equalTo: profileButton.centerYAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            collectionView.heightAnchor.constraint(equalToConstant: 230),

            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 12),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -12),
        ])
        
        collectionView.reloadData()
    }
    
    @objc func profileButtonTapped() {
        //TODO: Present profile vc
    }

}

extension TriviaViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TriviaAnswerCell.identifier, for: indexPath) as! TriviaAnswerCell
        cell.answerLabel.text = "Answer \(indexPath.row)"
        return cell
    }
}

extension TriviaViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 50)
    }
}

import SwiftUI

@available(iOS 13, *)
struct TriviaViewController_Preview: PreviewProvider {
    
    static var previews: some View {
        TriviaViewController().toPreview().edgesIgnoringSafeArea(.all)
    }
}
