//
//  CategoryCollactionViewCell.swift
//  Compositional Layout
//
//  Created by Alexey Radomskiy on 22.09.2022.
//

import UIKit

final class CategoryCollectionViewCell: UICollectionViewCell {
    
    private let categoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Category"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                layer.borderWidth = 2
                layer.borderColor = UIColor.systemRed.cgColor
            } else {
                layer.borderWidth = 0
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Config Method
    
    func configureCell(categoryName: String, imageName: String) {
        backgroundColor = .systemGreen
        categoryLabel.text = categoryName
    }
    
}

// MARK: Private Methods

private extension CategoryCollectionViewCell {
    
    func setupView() {
        backgroundColor = .white
        layer.cornerRadius = 10
        
        addSubview(categoryImageView)
        addSubview(categoryLabel)
    }
    
}

// MARK: Set Constraints

extension CategoryCollectionViewCell {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            categoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6),
            categoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6),
            categoryLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -6),
            categoryLabel.heightAnchor.constraint(equalToConstant: 16),
            
            categoryImageView.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            categoryImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6),
            categoryImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -6),
            categoryImageView.bottomAnchor.constraint(equalTo: categoryLabel.topAnchor)
        ])
    }
    
}
