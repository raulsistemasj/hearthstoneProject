//
//  CardOptionCell.swift
//  Hearthstone
//
//  Created by Raul M Ferreira on 20/09/22.
//

import Foundation
import UIKit

final class InsideCardOptionCollectionCell: UICollectionViewCell {
    
    static let identifier = String(describing: InsideCardOptionCollectionCell.self)
    
    // MARK: - Components
    
    private lazy var imageView: APIImageView = {
        let element = APIImageView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.clipsToBounds = true
        element.contentMode = .scaleToFill
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
    
    // MARK: - Func Prepar
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        imageView.backgroundColor = .clear
    }
    
    // MARK: - Setup
    
    private func setUpView() {
        addComponents()
        addImageViewConstraints()
    }
    
    // MARK: - Layout Functions
    
    private func addComponents() {
        addSubview(imageView)
    }
    
    private func addImageViewConstraints() {
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    // MARK: - Configure
    
    func configure(with urlString: String) {
        imageView.downloadFrom(stringURL: urlString)
    }
    
}
