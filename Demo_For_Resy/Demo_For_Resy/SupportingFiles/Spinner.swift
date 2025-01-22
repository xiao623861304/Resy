//
//  Spinner.swift
//  Demo_For_Resy
//
//  Created by yan feng on 1/15/25.
//

import UIKit

protocol ActivityPresentable {
    func presentActivity()
    func dismissActivity()
}

extension ActivityPresentable where Self: UIViewController {
    func presentActivity() {
        DispatchQueue.main.async {
            let activityView = UIView(frame: UIScreen.main.bounds)
            activityView.accessibilityIdentifier = "ActivityView"
            self.view.addSubview(activityView)
            let overlayView = UIView()
            overlayView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.7)
            overlayView.layer.cornerRadius = 8
            activityView.addSubview(overlayView)
            let activityIndicator = UIActivityIndicatorView(style: .large)
            activityIndicator.color = .white
            activityIndicator.startAnimating()
            activityView.addSubview(activityIndicator)
            
            activityIndicator.translatesAutoresizingMaskIntoConstraints = false
            overlayView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                overlayView.centerXAnchor.constraint(equalTo: activityView.centerXAnchor),
                overlayView.centerYAnchor.constraint(equalTo: activityView.centerYAnchor, constant: -100),
                overlayView.widthAnchor.constraint(equalToConstant: 120),
                overlayView.heightAnchor.constraint(equalToConstant: 120),
                activityIndicator.centerXAnchor.constraint(equalTo: overlayView.centerXAnchor),
                activityIndicator.centerYAnchor.constraint(equalTo: overlayView.centerYAnchor)
            ])
        }
    }
    
    func dismissActivity() {
        DispatchQueue.main.async {
            self.view.subviews
                .filter { $0.accessibilityIdentifier == "ActivityView" }
                .first?.removeFromSuperview()
        }
    }
}
