//
//  EmptyStateView.swift
//  Simple Contacts List
//
//  Created by Usef on 16/09/2025.
//

import UIKit

class EmptyStateView: UIView {
    private let imageView: UIImageView = {
        let config = UIImage.SymbolConfiguration(pointSize: 80, weight: .medium)
        let uiimage = UIImage(systemName: "person.crop.circle.badge.plus", withConfiguration: config)
        let imageView = UIImageView(image: uiimage)
        imageView.tintColor = .secondaryLabel
        return imageView
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.text = "Add your first contact!"
        label.textAlignment = .center
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }

    private func setup() {
        let stack = UIStackView(arrangedSubviews: [imageView, messageLabel])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stack)
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
