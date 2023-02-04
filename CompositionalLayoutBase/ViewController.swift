//
//  ViewController.swift
//  CompositionalLayoutBase
//
//  Created by Алексей Попроцкий on 03.02.2023.
//

import UIKit

class ViewController: UIViewController {

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewLayout()
        let collectioView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectioView.translatesAutoresizingMaskIntoConstraints = false
        collectioView.backgroundColor = .none
        return collectioView
    }()
    
    
    private var orderButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1)
        button.setTitle("Make Order", for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica", size: 18)
        button.tintColor = .white
        button.layer.cornerRadius = 10        
        return button
    }()
    
    private let sections = MockData.shared.pageData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegate()
        registerCell()
        setupView()
        setupConstraints()
    }

    
    
    private func setupView() {
        view.backgroundColor = #colorLiteral(red: 0.9841352105, green: 0.9841352105, blue: 0.9841352105, alpha: 1)
        view.addSubview(orderButton)
        view.addSubview(collectionView)
        
        collectionView.collectionViewLayout = createLayout()
    }
    
    private func registerCell() {
        collectionView.register(SaleCollectionViewCell.self,
                                forCellWithReuseIdentifier: "SaleCollectionViewCell")
        collectionView.register(CategoryCollectionViewCell.self,
                                forCellWithReuseIdentifier: "CategoryCollectionViewCell")
        collectionView.register(ExampleCollectionViewCell.self,
                                forCellWithReuseIdentifier: "ExampleCollectionViewCell")
        collectionView.register(HeaderSupplementaryView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "HeaderSupplementaryView")
    }
    
    private func setDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}


// MARK: - Create Layout
extension ViewController {
    private func createLayout() -> UICollectionViewCompositionalLayout {
        UICollectionViewCompositionalLayout { [weak self] sectionIndex, _ in
            guard let self = self else { return nil}
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
    
    private func createLayoutSection(group: NSCollectionLayoutGroup,
                                     behavior: UICollectionLayoutSectionOrthogonalScrollingBehavior,
                                     interGroupSpacing: CGFloat,
                                     supplementaryItems: [NSCollectionLayoutBoundarySupplementaryItem],
                                     contentInsets: Bool) -> NSCollectionLayoutSection {
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = behavior
        section.interGroupSpacing = interGroupSpacing
        section.boundarySupplementaryItems = supplementaryItems
        section.supplementariesFollowContentInsets = contentInsets
        return section
    }
    
    
    private func createSaleSection() -> NSCollectionLayoutSection {
        // fractionalWidth(1) ширина item будет = ширине группы
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                            heightDimension: .fractionalHeight(1)))
        
        // У NSCollectionLayoutGroup был инит с repeat, узнать про него
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.9),
                                                                         heightDimension: .fractionalHeight(0.2)),
                                                       subitems: [item])
        let section = createLayoutSection(group: group,
                                          behavior: .groupPaging,
                                          interGroupSpacing: 5,
                                          supplementaryItems: [],
                                          contentInsets: false)
        section.contentInsets = .init(top: 0, leading: 5, bottom: 0, trailing: 0)
        return section
    }
    
    
    private func createCategorySection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(0.3),
                                                            heightDimension: .fractionalHeight(1)))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                                         heightDimension: .fractionalHeight(0.1)),
                                                       subitems: [item])
        group.interItemSpacing = .flexible(10)
        let section = createLayoutSection(group: group,
                                          behavior: .none,
                                          interGroupSpacing: 10,
                                          supplementaryItems: [supplementaryHeaderItems()],
                                          contentInsets: false)
        section.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 10)
        return section
    }
    
    
    private func createExampleSection() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                                            heightDimension: .fractionalHeight(1)))
        // .fractionalWidth(0.9) чтоб было видно что дальше еще идут элементы
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.9),
                                                                         heightDimension: .fractionalHeight(0.45)),
                                                       subitems: [item])
        let section = createLayoutSection(group: group,
                                          behavior: .continuous,
                                          interGroupSpacing: 10,
                                          supplementaryItems: [supplementaryHeaderItems()],
                                          contentInsets: false)
        section.contentInsets = .init(top: 0, leading: 10, bottom: 0, trailing: 0)
        return section
    }
    
    
    private func supplementaryHeaderItems() -> NSCollectionLayoutBoundarySupplementaryItem {
        .init(layoutSize: .init(widthDimension: .fractionalWidth(1),
                                heightDimension: .estimated(30)),
              elementKind: UICollectionView.elementKindSectionHeader,
              alignment: .top)
    }
}


// MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
    
}


// MARK: - UICollectionViewDelegate
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
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SaleCollectionViewCell",
                                                                for: indexPath) as? SaleCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            cell.configCell(imageName: sale[indexPath.row].image)
            return cell
            
            
        case .category(let category):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCollectionViewCell",
                                                                for: indexPath) as? CategoryCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            cell.configCell(categoryName: category[indexPath.row].title, imageName: category[indexPath.row].image)
            return cell
            
            
        case .example(let example):
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ExampleCollectionViewCell",
                                                                for: indexPath) as? ExampleCollectionViewCell
            else {
                return UICollectionViewCell()
            }
            cell.configCell(imageName: example[indexPath.row].image)
            return cell
        }
    }
    
    // Запрашивает отображеноие дополнительного объекта для вставки Хедера
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                         withReuseIdentifier: "HeaderSupplementaryView",
                                                                         for: indexPath) as! HeaderSupplementaryView
            header.configHeader(categoryName: sections[indexPath.section].title)
            return header
        default:
            return UICollectionReusableView()
        }
    }
}


// MARK: - Set Constraints
extension ViewController {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            orderButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            orderButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            orderButton.widthAnchor.constraint(equalToConstant: 300),
            orderButton.heightAnchor.constraint(equalToConstant: 60),
            
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: orderButton.topAnchor, constant: -10)
        ])
    }
}
