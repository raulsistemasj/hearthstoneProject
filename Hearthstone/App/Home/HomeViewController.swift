//
//  HomeViewController.swift
//  Hearthstone
//
//  Created by Raul M Ferreira on 19/09/22.
//

import UIKit

protocol HomeDisplayLogic: AnyObject {
    func displayScreenValues(viewModel: Home.Model.ViewModel)
    func displayError(_ viewModel: Home.Model.ErrorViewModel)
}

final class HomeViewController: UIViewController, HomeDisplayLogic, HomeCardOptionsViewDelegate {
      
    // MARK: - Properties
    
    private let titleLabelCGRectX: CGFloat = 0
    private let titleLabelCGRectY: CGFloat = 0
    private let titleLabelCGRectWidth: CGFloat = 225
    private let titleLabelCGRectHeight: CGFloat = 55
    
    private let titleLabelFontSize: CGFloat = 40
    private let titleLabelFontOfSize: CGFloat = 40
    private let titleLabelNumberOfLines: Int = 0
    
    private let tileLabelConstraintsTopAnchor: CGFloat = 91
    private let tileLabelConstraintsLeadingAnchor: CGFloat = 37
    private let tileLabelConstraintsTrailingAnchor: CGFloat = -37
    
    private let lineViewConstraintsTopAnchor: CGFloat = 8
    private let lineViewConstraintsHeightAnchor: CGFloat = 2
    private let lineViewConstraintsLeadingAnchor: CGFloat = 39
    
    private let classConstraintsTopAnchor: CGFloat = 24.5
    private let classConstraintsLeadingAnchor: CGFloat = 24
    
    private let typeConstraintsTopAnchor: CGFloat = 24
    private let typeConstraintsLeadingAnchor: CGFloat = 24
    
    private let racesConstraintsTopAnchor: CGFloat = 24
    private let racesConstraintsLeadingAnchor: CGFloat = 24

    // MARK: - Components
    
    lazy var titleLabel: UILabel = {
        let element = UILabel(frame: CGRect(x: titleLabelCGRectX, y: titleLabelCGRectY, width: titleLabelCGRectWidth, height: titleLabelCGRectHeight))
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = UIFont.systemFont(ofSize: titleLabelFontOfSize, weight: .bold)
        element.numberOfLines = titleLabelNumberOfLines
        element.textAlignment = .left
        element.lineBreakMode = .byWordWrapping
        element.textColor = .homeTitleLabelColor
        return element
    }()
    
    private lazy var lineView: UIView = {
        let element = UIView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.backgroundColor = .homeLineViewColor
        element.isHidden = true
        return element
    }()
    
    private lazy var classOption: HomeCardOptionsView = {
        let element = HomeCardOptionsView()
        element.delegate = self
        return element
    }()
    
    private lazy var typeOption: HomeCardOptionsView = {
        let element = HomeCardOptionsView()
        element.delegate = self
        return element
    }()
    
    private lazy var racesOption: HomeCardOptionsView = {
        let element = HomeCardOptionsView()
        element.delegate = self
        return element
    }()
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let element = UIActivityIndicatorView()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.hidesWhenStopped = true
        element.style = .whiteLarge
        element.color = .red
        element.startAnimating()
        return element
    }()
    
    var alert: UIAlertController?
    
    // MARK: - Architecture Objects
    
    var interactor: HomeBusinessLogic?
    var router: (NSObjectProtocol & HomeRoutingLogic & HomeDataPassing)?
    
    // MARK: - ViewController Lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .WindowBackgroundColor
        addComponents()
        addComponentsConstraints()
        loadScreenValues()
    }
    
    // MARK: - Setup
    
    private func setup() {
        let viewController = self
        let interactor = HomeInteractor()
        let presenter = HomePresenter()
        let router = HomeRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: - Private Functions
    
    private func loadScreenValues() {
        interactor?.loadScreenValues()
    }
    
    // MARK: Layout func
    
    private func addComponents() {
        view.addSubview(titleLabel)
        view.addSubview(lineView)
        view.addSubview(classOption)
        view.addSubview(typeOption)
        view.addSubview(racesOption)
        view.addSubview(activityIndicatorView)
    }
    
    private func addComponentsConstraints() {
        addTitleLabelConstraints()
        addLineViewConstraints()
        addClassConstraints()
        addTypeConstraints()
        addRacesConstraints()
        addActivityIndicatorViewConstraints()
    }
    
    private func addTitleLabelConstraints() {
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: tileLabelConstraintsTopAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                            constant: tileLabelConstraintsLeadingAnchor).isActive  = true
        titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: tileLabelConstraintsTrailingAnchor).isActive = true
    }
    
    private func addLineViewConstraints() {
        lineView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: lineViewConstraintsTopAnchor).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: lineViewConstraintsHeightAnchor).isActive = true
        lineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: lineViewConstraintsLeadingAnchor).isActive = true
        lineView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func addClassConstraints() {
        classOption.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: classConstraintsTopAnchor).isActive = true
        classOption.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: classConstraintsLeadingAnchor).isActive = true
        classOption.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func addTypeConstraints() {
        typeOption.topAnchor.constraint(equalTo: classOption.bottomAnchor, constant: typeConstraintsTopAnchor).isActive = true
        typeOption.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: typeConstraintsLeadingAnchor).isActive = true
        typeOption.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func addRacesConstraints() {
        racesOption.topAnchor.constraint(equalTo: typeOption.bottomAnchor, constant: racesConstraintsTopAnchor).isActive = true
        racesOption.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: racesConstraintsLeadingAnchor).isActive = true
        racesOption.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }
    
    private func addActivityIndicatorViewConstraints() {
        activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    // MARK: - Display Logic
    
    func displayScreenValues(viewModel: Home.Model.ViewModel) {
        titleLabel.text = viewModel.title
        classOption.configure(with: viewModel.classeOptions)
        typeOption.configure(with: viewModel.typeOptions)
        racesOption.configure(with: viewModel.raceOptions)
        activityIndicatorView.stopAnimating()
        lineView.isHidden = false
    }
    
    func displayError(_ viewModel: Home.Model.ErrorViewModel) {
        alert = UIAlertController(title: viewModel.title,
                                  message: viewModel.message,
                                  preferredStyle: .alert)
        alert?.addAction(UIAlertAction(title: viewModel.retryButton, style: .default, handler: { [weak self] _ in
            self?.loadScreenValues()
        }))
        alert?.addAction(UIAlertAction(title: viewModel.cancel, style: .cancel, handler: { _ in
            Utils.closeApplication()
        }))
        router?.routeToError()
    }
    
    // MARK: - Cell Actions
    
    func didTaphomeViewCellItem(with category: String, and name: String) {
        interactor?.didSelect(category: category, name: name)
        router?.routeToInside()
    }
}
