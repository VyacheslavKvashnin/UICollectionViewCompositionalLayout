//
//  FoodCell.swift
//  UICollectionViewCompositionalLayout
//
//  Created by Вячеслав Квашнин on 30.07.2022.
//

import Foundation
import UIKit


class FoodCell: UICollectionViewCell, SelfConfiguringCell {
    
    static var reuseId: String = "FoodCell"
    
    let friendImageView = UIImageView()
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.purple
        setupConstraints()
        
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .systemBlue
        addSubview(label)
        friendImageView.frame = self.bounds
        backgroundColor = .green
    }
    
    func configure(with intValue: Int) {
        label.text = String(intValue)
    }
}
