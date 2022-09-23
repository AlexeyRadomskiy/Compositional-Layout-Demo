//
//  ViewController.swift
//  Compositional Layout
//
//  Created by Alexey Radomskiy on 22.09.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private let collectionView: UICollectionView = {
        let collectionViewLayout = UICollectionViewLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .none
        collectionView.bounces = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    private let sections = MockData.shared.pageData

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setDelegates()
        setConstraints()
    }

}

// MARK: Private Methods

private extension ViewController {
    
    func setupViews() {
        view.backgroundColor = .white
        title = "FoodShop"
        
        view.addSubview(collectionView)
        collectionView.register(
            SaleCollectionViewCell.self,
            forCellWithReuseIdentifier: "StoriesCollectionViewCell"
        )
        collectionView.register(
            CategoryCollectionViewCell.self,
            forCellWithReuseIdentifier: "PopularCollectionViewCell"
        )
        collectionView.register(
            SaleCollectionViewCell.self,
            forCellWithReuseIdentifier: "ComingCollectionViewCell"
        )
        collectionView.register(
            HeaderSupplementaryView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "HeaderSupplementaryView"
        )
        collectionView.collectionViewLayout = createLayout()
    }
    
    func setDelegates() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
}

// MARK: Create Layout

private extension ViewController {
    
    func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self = self else { return nil }
            let section = self.sections[sectionIndex]
            switch section {
            case .sales(_):
                return self.createSaleSection()
            case .category(_):
                return self.createCategorySection()
            case .example(_):
                return self.createExampleSection()
            }
        }
    }
    
    func createLayoutSection(
        group: NSCollectionLayoutGroup,
        behavior: UICollectionLayoutSectionOrthogonalScrollingBehavior,
        interGroupSpacing: CGFloat,
        supplementaryItems: [NSCollectionLayoutBoundarySupplementaryItem],
        contentInsets: Bool
    ) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = behavior
        section.interGroupSpacing = interGroupSpacing
        section.boundarySupplementaryItems = supplementaryItems
        section.supplementariesFollowContentInsets = contentInsets
        
        return section
    }
    
    func createSaleSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        ))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(0.9),
                heightDimension: .fractionalHeight(0.2)
            ),
            subitems: [item]
        )
        let section = createLayoutSection(
            group: group,
            behavior: .groupPaging,
            interGroupSpacing: 6,
            supplementaryItems: [],
            contentInsets: false
        )
        section.contentInsets = .init(top: 0, leading: 12, bottom: 0, trailing: 12)
        
        return section
    }
    
    func createCategorySection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(
            widthDimension: .fractionalWidth(0.3),
            heightDimension: .fractionalHeight(1)
        ))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(0.1)
            ),
            subitems: [item]
        )
        group.interItemSpacing = .flexible(12)
        let section = createLayoutSection(
            group: group,
            behavior: .none,
            interGroupSpacing: 12,
            supplementaryItems: [supplementaryHeaderItem()],
            contentInsets: false
        )
        section.contentInsets = .init(top: 0, leading: 12, bottom: 0, trailing: 12)
        
        return section
    }
    
    func createExampleSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        ))
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(0.9),
                heightDimension: .fractionalHeight(0.45)
            ),
            subitems: [item]
        )
        let section = createLayoutSection(
            group: group,
            behavior: .continuous,
            interGroupSpacing: 12,
            supplementaryItems: [supplementaryHeaderItem()],
            contentInsets: true
        )
        section.contentInsets = .init(top: 0, leading: 12, bottom: 0, trailing: 12)
        
        return section
    }
    
    func supplementaryHeaderItem() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(30)
            ),
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
    }
    
}

// MARK: UICollectionViewDelegate

extension ViewController: UICollectionViewDelegate {}

// MARK: UICollectionViewDataSource

extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sections[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch sections[indexPath.section] {
        case .sales(let sale):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "StoriesCollectionViewCell",
                for: indexPath
            ) as? SaleCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configureCell(imageName: sale[indexPath.row].image)
            
            return cell
        case .category(let category):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "PopularCollectionViewCell",
                for: indexPath
            ) as? CategoryCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configureCell(
                categoryName: category[indexPath.row].title,
                imageName: category[indexPath.row].image
            )
            
            return cell
        case .example(let example):
            guard let cell = collectionView.dequeueReusableCell(
                withReuseIdentifier: "ComingCollectionViewCell",
                for: indexPath
            ) as? SaleCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configureCell(imageName: example[indexPath.row].image)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "HeaderSupplementaryView",
                for: indexPath
            ) as! HeaderSupplementaryView
            header.configureHeader(categoryName: sections[indexPath.section].title)
            
            return header
        default:
            return UICollectionReusableView()
        }
    }
    
}

// MARK: Set Constraints

extension ViewController {
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}

