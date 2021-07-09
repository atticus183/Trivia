//
//  AnimatedCountingLabel.swift
//  Trivia
//
//  Created by Josh R on 7/8/21.
//

import UIKit

/// A subclass of `UILabel` that will animate the `.text` value using a `CADisplayLink`.
class AnimatedCountingLabel: UILabel {
    // MARK: Properties
    
    /// The duration of the animation in seconds.
    var animationDuration: Double
    
    /// A `Date` object used to assist with the animation duration calculation.
    private var animationStartDate = Date()
    
    /// A computed property that can be used to get the label's current value and animate to a new value.
    var currentValue: Int {
        endValue
    }
    
    /// A `CADisplayLink` used to animate the delta.
    private var displayLink: CADisplayLink?
    
    /// An `Int` that indicates the end value of this label.
    var endValue: Int = 0

    /// An `Int` that indicates the start value of this label.
    var startValue: Int = 0
    
    // MARK: Initialization
    
    /// Initializes a `AnimatedCountingLabel`.
    /// - Parameters:
    ///   - startValue: The start value of type `Int`.
    ///   - endValue: The end value of type `Int`.
    ///   - withDuration: The animation duration in seconds.
    init(startValue: Int = 0, endValue: Int = 0, withDuration: Double = 1.5) {
        self.startValue = startValue
        self.endValue = endValue
        self.animationDuration = withDuration
        super.init(frame: .zero)
        
        textColor = .white
        
        updateLabel(from: startValue, to: endValue)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    
    /// Method will update the label and animate the change.
    func updateLabel(from begValue: Int, to endValue: Int) {
        animationStartDate = Date()
        self.startValue = begValue
        self.endValue = endValue
        displayLink = CADisplayLink(target: self, selector: #selector(handleUpdate))
        displayLink?.add(to: .main, forMode: .default)
    }
    
    @objc func handleUpdate() {
        let now = Date()
        let elapsedTime = now.timeIntervalSince(animationStartDate)

        if elapsedTime > animationDuration {
            self.text = "\(Int(endValue))"
            displayLink?.invalidate()
            displayLink = nil
        } else {
            let amountToIncrementBy = elapsedTime / animationDuration
            let value = Double(startValue) + amountToIncrementBy * Double((endValue - startValue))
            self.text = "\(Int(value))"
        }
    }
}
