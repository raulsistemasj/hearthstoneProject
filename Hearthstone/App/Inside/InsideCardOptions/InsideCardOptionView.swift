//
//  OptionsCardView.swift
//  Hearthstone
//
//  Created by Raul M Ferreira on 20/09/22.
//

import Foundation

import UIKit

protocol InsideCardOptionsViewDelegate: AnyObject {
    func refreshRequest()
}


final class InsideCardOptionsView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Properties
    
    weak var delegate: InsideCardOptionsViewDelegate?
    private var viewModel: Inside.Model.ViewModel?
    
    private let collectionLayoutTop: CGFloat = 2
    private let collectionLayoutLeft: CGFloat = 2
    private let collectionLayoutBottom: CGFloat = 0
    private let collectionLayoutRight: CGFloat = 0
    
    private let collectionViewConstraintsTopAnchor: CGFloat = 10
    private let collectionViewConstraintsHeightAnchor: CGFloat = 223
    
    private let collectionViewWidth: Int = 147
    private let collectionViewHeight: Int = 223
    
    // MARK: - Components
    
    private lazy var collectionLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: collectionLayoutTop, left: collectionLayoutLeft, bottom: collectionLayoutBottom, right: collectionLayoutRight)
        return layout
    }()
   
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(InsideCardOptionCollectionCell.self, forCellWithReuseIdentifier: InsideCardOptionCollectionCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.addSubview(refrashControl)
        return collectionView
    }()
    
    private lazy var refrashControl: UIRefreshControl = {
        let element = UIRefreshControl()
        element.addTarget(self, action: #selector(refrashAction), for: .valueChanged)
        
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
        translatesAutoresizingMaskIntoConstraints = false
        addComponents()
        addComponentsConstraints()
    }
    
    // MARK: Layout func
    
    private func addComponents() {
        addSubview(collectionView)
    }
    
    private func addComponentsConstraints() {
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    // MARK: - Configure
    
    public func configure(with viewModel: Inside.Model.ViewModel) {
        self.viewModel = viewModel
        refrashControl.endRefreshing()
        collectionView.reloadData()
    }
    
    // MARK: - Collection Delegate / Datasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.imageList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: InsideCardOptionCollectionCell.identifier, for: indexPath) as? InsideCardOptionCollectionCell, let urlString = viewModel?.imageList[indexPath.row] else { return UICollectionViewCell() }
        
        cell.configure(with: urlString)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionViewWidth, height: collectionViewHeight)
    }
    
    // MARK: - Action
    
    @objc private func refrashAction() {
        delegate?.refreshRequest()
    }

    
}
