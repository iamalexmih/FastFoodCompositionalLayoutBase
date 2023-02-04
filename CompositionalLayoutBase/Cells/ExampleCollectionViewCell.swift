//
//  ExampleCollectionViewCell.swift
//  CompositionalLayoutBase
//
//  Created by Алексей Попроцкий on 03.02.2023.
//

import UIKit

class ExampleCollectionViewCell: UICollectionViewCell {
    
    private let burgerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "burger1")
        return imageView
    }()
    
    private let backgroundTitleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.alpha = 0.6
        return view
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Egg Top Burger"
        label.textAlignment = .center
        label.font = UIFont(name: "Arial", size: 16)
        label.textColor = .black
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "$7.42"
        label.textAlignment = .center
        label.font = UIFont(name: "Arial Bold", size: 24)
        label.textColor = .black
        return label
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        translatesAutoresizingMaskIntoConstraints = false
        
        setupView()
        setupConstraints()
    }
    
    
    private func setupView() {
        addSubview(burgerImageView)
        addSubview(backgroundTitleView)
        addSubview(priceLabel)
        addSubview(nameLabel)
        
        clipsToBounds = true
        layer.cornerRadius = 10
    }
    
    func configCell(imageName: String) {
        burgerImageView.image = UIImage(named: imageName)
    }
    
    private func setupConstraints() {
        // проверить работает ли frame = bounds
//        saleImageView.frame = bounds
        NSLayoutConstraint.activate([
            burgerImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            burgerImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            burgerImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            burgerImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            
            backgroundTitleView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            backgroundTitleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            backgroundTitleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            backgroundTitleView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1),
            
            nameLabel.centerYAnchor.constraint(equalTo: backgroundTitleView.centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: backgroundTitleView.leadingAnchor, constant: 10),
            
            priceLabel.centerYAnchor.constraint(equalTo: backgroundTitleView.centerYAnchor),
            priceLabel.trailingAnchor.constraint(equalTo: backgroundTitleView.trailingAnchor, constant: -10)
        ])
        
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
