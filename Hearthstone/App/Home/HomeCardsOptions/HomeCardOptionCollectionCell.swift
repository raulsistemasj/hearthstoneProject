//
//  CardOptionsCollectionCell.swift
//  Hearthstone
//
//  Created by Raul M Ferreira on 19/09/22.
//

import Foundation

import UIKit

final class HomeCardOptionCollectionCell: UICollectionViewCell {
    static let identifier = String(describing: HomeCardOptionCollectionCell.self)
    
    // MARK: - Properties
    
    private let titleLabelFontSize: CGFloat = 18
    private let setUpViewCornerRadius: CGFloat = 16
    
    private let tileLabelConstraintsLeadingAnchor: CGFloat = 23
    private let tileLabelConstraintsTrailingAnchor: CGFloat = -23
    private let tileLabelConstraintsBottomAnchor: CGFloat = -17
    
    // MARK: - Components
    
    private lazy var titleLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.textColor = .white
        element.textAlignment = .left
        element.numberOfLines = 0
        element.lineBreakMode = .byWordWrapping
        element.font = .systemFont(ofSize: titleLabelFontSize, weight: .medium)
        return element
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }
    
    // MARK: - Setup
    
    private func setUpView() {
        backgroundColor = .ramdomColor
        layer.cornerRadius = setUpViewCornerRadius
        addComponents()
        addTitleLabelConstraints()
    }
    
    // MARK: - Layout Functions
    
    private func addComponents() {
        addSubview(titleLabel)
    }
    
    private func addTitleLabelConstraints() {
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: tileLabelConstraintsLeadingAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: tileLabelConstraintsTrailingAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: tileLabelConstraintsBottomAnchor).isActive = true
    }
    
    // MARK: - Configure
    
    func configure(with title: String){
        titleLabel.text = title
    }
}
