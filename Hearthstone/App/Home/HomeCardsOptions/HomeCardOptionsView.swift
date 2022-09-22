//
//  CardOptionsView.swift
//  Hearthstone
//
//  Created by Raul M Ferreira on 19/09/22.
//

import Foundation

import UIKit

protocol HomeCardOptionsViewDelegate: AnyObject {
    func didTaphomeViewCellItem(with category: String, and name: String)
}

final class HomeCardOptionsView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Properties
    
    private var viewModel: Home.Model.HomeCardOptionsViewModel?
    weak var delegate: HomeCardOptionsViewDelegate?
    
    private let titleLabelFontSize: CGFloat = 16
    private let titleNumberOfLines: Int = 0
    
    private let collectionLayoutTop: CGFloat = 2
    private let collectionLayoutLeft: CGFloat = 2
    private let collectionLayoutBottom: CGFloat = 2
    private let collectionLayoutRight: CGFloat = 2
    
    private let titleLabelConstraintLeadingAnchor: CGFloat = 15
    
    private let collectionViewConstraintsTopAnchor: CGFloat = 10
    private let collectionViewConstraintsHeightAnchor: CGFloat = 105
    
    private let collectionViewWidth: Int = 144
    private let collectionViewHeight: Int = 104
    
    // MARK: - Components
    
    private lazy var titleLabel: UILabel = {
        let element = UILabel()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.textAlignment = .left
        element.textColor = .cardOptionTitleLabelColor
        element.font = .systemFont(ofSize: titleLabelFontSize)
        element.numberOfLines = titleNumberOfLines
        element.lineBreakMode = .byWordWrapping
        return element
    }()
    
    private lazy var collectionLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: collectionLayoutTop, left: collectionLayoutLeft, bottom: collectionLayoutBottom, right: collectionLayoutRight)
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(HomeCardOptionCollectionCell.self, forCellWithReuseIdentifier: HomeCardOptionCollectionCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
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
        translatesAutoresizingMaskIntoConstraints = false
        addComponents()
        addComponentsConstraints()
    }
    
    // MARK: - Layout func
    
    private func addComponents() {
        addSubview(titleLabel)
        addSubview(collectionView)
    }
    
    private func addComponentsConstraints() {
        addTitleLabelConstraint()
        addCollectionViewConstraints()
    }
    
    private func addTitleLabelConstraint() {
        titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: titleLabelConstraintLeadingAnchor).isActive  = true
        titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
    }
    
    private func addCollectionViewConstraints() {
        collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: collectionViewConstraintsTopAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalToConstant: collectionViewConstraintsHeightAnchor).isActive = true
    }
    
    // MARK: - Configure
    
    public func configure(with viewModel: Home.Model.HomeCardOptionsViewModel) {
        self.viewModel = viewModel
        titleLabel.text = viewModel.title
        collectionView.reloadData()
    }
    
    // MARK: - Collection Delegate / Datasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.cards.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCardOptionCollectionCell.identifier, for: indexPath) as? HomeCardOptionCollectionCell, let cardTitle = viewModel?.cards[indexPath.row] else { return UICollectionViewCell() }

        cell.configure(with: cardTitle)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionViewWidth, height: collectionViewHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let name = viewModel?.cards[indexPath.row] , let category = viewModel?.title else { return }
        delegate?.didTaphomeViewCellItem(with: category, and: name)
    }
}
