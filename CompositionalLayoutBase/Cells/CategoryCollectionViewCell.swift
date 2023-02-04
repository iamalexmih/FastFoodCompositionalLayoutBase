//
//  CategoryCollectionViewCell.swift
//  CompositionalLayoutBase
//
//  Created by Алексей Попроцкий on 03.02.2023.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {
    
    private let categoryImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "categoryBurger")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    private let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Category"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                layer.borderColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
                layer.borderWidth = 2
            } else {
                layer.borderWidth = 0
            }
        }
    }
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
    
    
    private func setupView() {
        addSubview(categoryImageView)
        addSubview(categoryLabel)
        backgroundColor = .white
        layer.cornerRadius = 10
    }
    
    func configCell(categoryName: String, imageName: String) {
        categoryImageView.image = UIImage(named: imageName)
        categoryLabel.text = categoryName
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            categoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            categoryLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            categoryLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            categoryLabel.heightAnchor.constraint(equalToConstant: 16),
            
            categoryImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            categoryImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            categoryImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            categoryImageView.bottomAnchor.constraint(equalTo: categoryLabel.topAnchor, constant: 0)
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
