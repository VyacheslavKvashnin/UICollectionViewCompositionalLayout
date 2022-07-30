//
//  AdvancedViewController.swift
//  UICollectionViewCompositionalLayout
//
//  Created by Вячеслав Квашнин on 30.07.2022.
//

import UIKit

class AdvancedViewController: UIViewController {
    
    enum SectionKind: Int, CaseIterable {
        case list, grid
        var columnCount: Int {
            switch self {
            case .list:
                 return 2
            case .grid:
                return 3
            }
        }
    }

    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<SectionKind, Int>!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupCollectionView()
     }
    
    private func setupCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .cyan
        
        view.addSubview(collectionView)
        
        collectionView.register(UserCell.self, forCellWithReuseIdentifier: UserCell.reuseId)
        collectionView.register(FoodCell.self, forCellWithReuseIdentifier: FoodCell.reuseId)
        setupDataSource()
        reloadData()
    }
    
    func configure<T: SelfConfiguringCell>(cellType: T.Type, with intValue: Int, for indexPath: IndexPath) -> T {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseId, for: indexPath) as? T else {
         fatalError("Error: \(cellType)")
        }
        return cell
    }
    
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<SectionKind, Int>(collectionView: collectionView, cellProvider: { collectionView, indexPath, intValue in
            let section = SectionKind(rawValue: indexPath.section)!
            switch section {
            case .list:
                return self.configure(cellType: UserCell.self, with: intValue, for: indexPath)
            case .grid:
                return self.configure(cellType: FoodCell.self, with: intValue, for: indexPath)
            }
        })
    }
    
    private func reloadData() {
        var snapShot = NSDiffableDataSourceSnapshot<SectionKind, Int>()
        let itemPerSection = 10
        
        SectionKind.allCases.forEach { sectionKind in
            let itemOfSet = sectionKind.columnCount * itemPerSection
            let itemUpperbound = itemOfSet + itemPerSection
            snapShot.appendSections([sectionKind])
            snapShot.appendItems(Array(itemOfSet ..< itemUpperbound))
        }
        dataSource.apply(snapShot, animatingDifferences: true)
    }
    private func createListSection() -> NSCollectionLayoutSection {
        // sections -> groups -> items -> size
        let spacing = CGFloat(10)
        let sizeItem = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: sizeItem)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(0.1)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: 2
        )
        group.interItemSpacing = .fixed(spacing)
        let section = NSCollectionLayoutSection(group: group)
        section.interGroupSpacing = spacing
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 0, leading: spacing, bottom: 0, trailing: spacing
        )
        return section
    }
    
    private func createGridSection() -> NSCollectionLayoutSection {
        // sections -> groups -> items -> size
        
        let sizeItem = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: sizeItem)
        item.contentInsets = NSDirectionalEdgeInsets.init(
            top: 0, leading: 8, bottom: 0, trailing: 8
        )
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .estimated(104),
            heightDimension: .estimated(88)
        )
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuous
        section.contentInsets = NSDirectionalEdgeInsets.init(
            top: 16, leading: 12, bottom: 0, trailing: 12
        )
        return section
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            let section = SectionKind(rawValue: sectionIndex)!
            switch section {
            case .list:
                return self.createListSection()
            case .grid:
                return self.createGridSection()
            }
        }
        
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 20
        layout.configuration = config
        return layout
    }
}
