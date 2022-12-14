//
//  UserCell.swift
//  UICollectionViewCompositionalLayout
//
//  Created by Вячеслав Квашнин on 30.07.2022.
//

import Foundation
import UIKit

class UserCell: UICollectionViewCell, SelfConfiguringCell {
    
    static var reuseId: String = "UserCell"
    
    let friendImageView = UIImageView()
    
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
        friendImageView.translatesAutoresizingMaskIntoConstraints = false
        friendImageView.backgroundColor = .systemBlue
        addSubview(friendImageView)
        friendImageView.frame = self.bounds
        backgroundColor = .green
    }
    
    func configure(with intValue: Int) {
        print("123")
    }
}
