//
//  ViewController.swift
//  Trivia
//
//  Created by Josh R on 7/4/21.
//

import Combine
import UIKit

final class TriviaViewController: UIViewController {
    
    /// A collection of Combine's tokens.
    private var cancellables: Set<AnyCancellable> = []
    
    /// A `TriviaViewModel` for this view.
    private let viewModel: TriviaViewModel
    
    // MARK: UICollectionView
    
    /// A `UICollectionView` for this view.  Holds the questions for the retrieve question.
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.translatesAutoresizingMaskIntoConstraints = false
        return cv
    }()
    
    /// A `UICollectionViewFlowLayout` for this view's `UICollectionView`.
    private let layout: UICollectionViewFlowLayout = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .vertical
        return flow
    }()
    
    // MARK: UI Components

    /// A `UIButton` that presents a `ProfileViewController` when tapped.
    let profileButton: UIButton = {
        let button = UIButton()
        let image = UIImage(systemName: "person")
        button.setBackgroundImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(profileButtonTapped), for: .touchUpInside)
        return button
    }()
    
    /// A `UILabel` show the retrieved question.
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
    
    /// A `UILabel` showing the user's current score.
    let scoreLabel: UILabel = {
        let label = UILabel()
        label.text = "+200"
        label.font = UIFont.systemFont(ofSize: 28, weight: .semibold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// A `UIStackView` holding the question and possible answers.
    let stackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 30
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    // MARK: Initialization
    
    /// The initializer for a `TriviaViewController`.
    /// - Parameter viewModel: The view model for this view controller.
    init(viewModel: TriviaViewModel = TriviaViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: View Controller Lifecycle
    
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
        
        bindViewModelValues()
    }
    
    // MARK: Methods
    
    /// A method that binds this view's properties to the view model generated values.
    private func bindViewModelValues() {
        viewModel.$triviaItem.sink { [weak self] triviaItem in
            self?.questionLabel.text = triviaItem?.question ?? ""
            self?.collectionView.reloadData()
        }.store(in: &cancellables)
        
        viewModel.$totalPointsEarned.sink { [weak self] points in
            self?.scoreLabel.text = String(points ?? 0)
        }.store(in: &cancellables)
    }
    
    /// The selector method called when the user taps the profile button in the top left corner of the view.
    @objc func profileButtonTapped() {
        let viewController = ProfileViewController()
        present(viewController, animated: true)
    }
}

// MARK: UICollectionViewDelegate and UICollectionViewDataSource conformance

extension TriviaViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.triviaItem?.allPossibleAnswers.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TriviaAnswerCell.identifier, for: indexPath) as! TriviaAnswerCell
        let possibleAnswer  = viewModel.triviaItem?.allPossibleAnswers[indexPath.row] ?? ""
        cell.answer = possibleAnswer
        cell.question = viewModel.triviaItem
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! TriviaAnswerCell
        cell.updateSelectedAnswer()
        
        let selectedAnswer = viewModel.triviaItem!.allPossibleAnswers[indexPath.row]
        viewModel.selected(answer: selectedAnswer)
        
        //Updates cell regardless if user got the correct answer.
        if let cell = collectionView.cellForItem(at: IndexPath(row: viewModel.triviaItem?.indexOfCorrectAnswer ?? 0, section: 0)) as? TriviaAnswerCell {
            cell.updateCellWithCorrectAnswer()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.viewModel.fetchNewQuestion()
        }
    }
}

// MARK: UICollectionViewDelegateFlowLayout conformance

extension TriviaViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: 50)
    }
}

// MARK: SwiftUI like preview for UIKit

import SwiftUI

@available(iOS 13, *)
struct TriviaViewController_Preview: PreviewProvider {
    
    static var previews: some View {
        TriviaViewController().toPreview().edgesIgnoringSafeArea(.all)
    }
}
