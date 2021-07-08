//
//  ProfileViewController.swift
//  Trivia
//
//  Created by Josh R on 7/4/21.
//

import Combine
import UIKit

final class ProfileViewController: UIViewController {
    let viewModel: ProfileViewModel
    
    private var cancellables: Set<AnyCancellable> = []
    
    //questions answered correctly
    let totalCorrectAnswersLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let totalQuestionsAskedLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //Win %
    let winPercentageLabel: UILabel = {
        let label = UILabel()
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
    
    // MARK: Initialization
    
    init(viewModel: ProfileViewModel = ProfileViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        stackView.addArrangedSubview(winPercentageLabel)
        stackView.addArrangedSubview(totalCorrectAnswersLabel)
        stackView.addArrangedSubview(totalQuestionsAskedLabel)
        
        view.addSubview(titleLabel)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            stackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
        ])
        
        bindViewModelValues()
    }
    
    private func bindViewModelValues() {
        viewModel.$winPercentage.sink { [weak self] wintPerct in
            self?.winPercentageLabel.text = "Win percentage: \(wintPerct ?? "0.0%")"
        }.store(in: &cancellables)
        
        viewModel.$numberOfCorrectAnswers.sink { [weak self] correctAnswers in
            self?.totalCorrectAnswersLabel.text = "Correct Answers: \(correctAnswers ?? 0)"
        }.store(in: &cancellables)
        
        viewModel.$numberOfQuestionsAsked.sink { [weak self] totalQuestions in
            self?.totalQuestionsAskedLabel.text = "Total questions asked: \(totalQuestions ?? 0)"
        }.store(in: &cancellables)
    }
}

import SwiftUI

@available(iOS 13, *)
struct ProfileViewController_Preview: PreviewProvider {
    
    static var previews: some View {
        ProfileViewController().toPreview().edgesIgnoringSafeArea(.all)
    }
}
