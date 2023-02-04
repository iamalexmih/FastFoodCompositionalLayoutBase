//
//  SaleCollectionViewCell.swift
//  CompositionalLayoutBase
//
//  Created by Алексей Попроцкий on 03.02.2023.
//

import UIKit

class SaleCollectionViewCell: UICollectionViewCell {
    
    private let saleImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setupConstraints()
    }
    
    
    private func setupView() {
        contentView.addSubview(saleImageView)
        backgroundColor = .white
        clipsToBounds = true
        layer.cornerRadius = 10
    }
    
    func configCell(imageName: String) {
        saleImageView.image = UIImage(named: imageName)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            saleImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            saleImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            saleImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            saleImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
        
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
