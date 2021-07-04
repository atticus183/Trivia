//
//  UIViewController+Extensions.swift
//  Trivia
//
//  Created by Josh R on 7/4/21.
//

import SwiftUI
import UIKit

extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
        // this variable is used for injecting the current view controller
        let viewController: UIViewController

        func makeUIViewController(context: Context) -> UIViewController {
            return viewController
        }

        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        }
    }

    func toPreview() -> some View {
        // inject self (the current view controller) for the preview
        Preview(viewController: self)
    }
}
