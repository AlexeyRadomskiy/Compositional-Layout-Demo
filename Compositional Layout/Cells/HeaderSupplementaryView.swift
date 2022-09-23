//
//  HeaderSupplementaryView.swift
//  Compositional Layout
//
//  Created by Alexey Radomskiy on 22.09.2022.
//

import UIKit

final class HeaderSupplementaryView: UICollectionReusableView {
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Header"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Config Method
    
    func configureHeader(categoryName: String) {
        headerLabel.text = categoryName
    }
    
}

// MARK: Private Methods

private extension HeaderSupplementaryView {
    
    func setupView() {
        backgroundColor = .white
        addSubview(headerLabel)
    }
    
}

// MARK: Set Constraints

extension HeaderSupplementaryView {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
        ])
    }
    
}
