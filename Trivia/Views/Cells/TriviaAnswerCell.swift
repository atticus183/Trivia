//
//  TriviaAnswerCell.swift
//  Trivia
//
//  Created by Josh R on 7/4/21.
//

import UIKit

class TriviaAnswerCell: UICollectionViewCell {
    
    var answer: String? {
        didSet { answerLabel.text = answer }
    }
    
    static var identifier: String {
        String(describing: Self.self)
    }
    
    var question: TriviaItem?

    // MARK: UI Components
    
    let answerLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textColor = .white
        label.numberOfLines = 2
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let resultImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .systemGreen
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    // MARK: Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(answerLabel)
        contentView.addSubview(resultImageView)
        
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.white.cgColor
        contentView.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            answerLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            answerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            answerLabel.trailingAnchor.constraint(equalTo: resultImageView.leadingAnchor, constant: 8),
            answerLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            
            resultImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            resultImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            resultImageView.heightAnchor.constraint(equalToConstant: 25),
            resultImageView.widthAnchor.constraint(equalToConstant: 25),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resultImageView.image = nil
        contentView.layer.borderColor = UIColor.white.cgColor
    }
    
    /// Either indicates to the user that they answered the question correctly or incorrectly.
    func updateSelectedAnswer() {
        let isCorrectAnswer = question?.correctAnswer == answer
        let image = isCorrectAnswer ? UIImage(systemName: "checkmark.circle") : UIImage(systemName: "multiply.circle")
        let color = isCorrectAnswer ? UIColor.systemGreen : UIColor.systemRed
        
        resultImageView.image = image
        resultImageView.tintColor = color
        contentView.layer.borderColor = color.cgColor
    }
    
    /// Updates the cell with the correct answer.
    func updateCellWithCorrectAnswer() {
        resultImageView.image = UIImage(systemName: "checkmark.circle")
        resultImageView.tintColor = .systemGreen
    }
    
}
