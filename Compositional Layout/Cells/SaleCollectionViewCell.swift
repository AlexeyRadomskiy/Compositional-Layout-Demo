//
//  SaleCollectionViewCell.swift
//  Compositional Layout
//
//  Created by Alexey Radomskiy on 22.09.2022.
//

import UIKit

final class SaleCollectionViewCell: UICollectionViewCell {
    
    private let saleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
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
    
    func configureCell(imageName: String) {
        backgroundColor = .systemBlue
    }
    
}

// MARK: Private Methods

private extension SaleCollectionViewCell {
    
    func setupView() {
        backgroundColor = .white
        addSubview(saleImageView)
    }
    
}

// MARK: Set Constraints

extension SaleCollectionViewCell {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            saleImageView.topAnchor.constraint(equalTo: topAnchor),
            saleImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            saleImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            saleImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
}
