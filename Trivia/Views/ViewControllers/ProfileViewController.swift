//
//  ProfileViewController.swift
//  Trivia
//
//  Created by Josh R on 7/4/21.
//

import UIKit

final class ProfileViewController: UIViewController {
    //questions answered correctly
    let totalCorrectAnswers: UILabel = {
        let label = UILabel()
        label.text = "# of correct answers: 123"
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let totalQuestionsAskedLabel: UILabel = {
        let label = UILabel()
        label.text = "Total questions asked: 1234"
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //Win %
    let winPercentageLabel: UILabel = {
        let label = UILabel()
        label.text = "Win percentage: 80%"
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //Title label
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Your Stats"
        label.textColor = .systemBlue
        label.font = UIFont.systemFont(ofSize: 40, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 15
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        stackView.addArrangedSubview(winPercentageLabel)
        stackView.addArrangedSubview(totalCorrectAnswers)
        stackView.addArrangedSubview(totalQuestionsAskedLabel)
        
        view.addSubview(titleLabel)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        ])
    }
}

import SwiftUI

@available(iOS 13, *)
struct ProfileViewController_Preview: PreviewProvider {
    
    static var previews: some View {
        ProfileViewController().toPreview().edgesIgnoringSafeArea(.all)
    }
}
