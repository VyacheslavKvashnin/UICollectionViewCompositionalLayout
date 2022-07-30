//
//  SelfConfiguringCell.swift
//  UICollectionViewCompositionalLayout
//
//  Created by Вячеслав Квашнин on 30.07.2022.
//

import Foundation

protocol SelfConfiguringCell {
    static var reuseId: String { get }
    func configure(with intValue: Int)
}
