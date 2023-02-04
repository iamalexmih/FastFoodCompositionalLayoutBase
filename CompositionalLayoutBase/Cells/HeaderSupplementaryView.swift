//
//  HeaderSupplementaryView.swift
//  CompositionalLayoutBase
//
//  Created by Алексей Попроцкий on 03.02.2023.
//

import UIKit


class HeaderSupplementaryView: UICollectionReusableView {
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "header"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .gray
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    func configHeader(categoryName: String) {
        headerLabel.text = categoryName
    }
    
    
    private func setupView() {
        backgroundColor = .white
        addSubview(headerLabel)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            headerLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
        ])   
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
