//
//  InsideViewController.swift
//  Hearthstone
//
//  Created by Raul M Ferreira on 19/09/22.
//

import UIKit

protocol InsideDisplayLogic: AnyObject {
    func displayScreenValues(viewModel: Inside.Model.ViewModel)
    func displayError(_ viewModel: Inside.Model.ErrorViewModel)
}

final class InsideViewController: UIViewController, InsideDisplayLogic, InsideCardOptionsViewDelegate {
       
    // MARK: - Properties
    
    private let nameTypeLabelCGRectX: CGFloat = 0
    private let nameTypeLabelCGRectY: CGFloat = 0
    private let nameTypeLabelCGRectWidth: CGFloat = 55
    private let nameTypeLabelCGRectHeight: CGFloat = 30
    
    private let nameTypeLabelFontSize: CGFloat = 22
    private let nameTypeLabelFontOfSize: CGFloat = 22
    private let nameTypeLabelNumberOfLines: Int = 0
    
    private let nameTypeLabelConstraintsTopAnchor: CGFloat = 109
    private let nameTypeLabelConstraintsLeadingAnchor: CGFloat = 31
    private let nameTypeLabelConstraintsTrailingAnchor: CGFloat = -31
    
    private let buttonConstraintsTopAnchor: CGFloat = 91
    private let buttonConstraintsLeadingAnchor: CGFloat = 24
    private let buttonConstraintsWidthAnchor: CGFloat = 64
    private let buttonConstraintsheightAnchor: CGFloat = 64
    private let buttonRadius: CGFloat = 32
    
    private let cardConstraintsTopAnchor: CGFloat = 50
    private let cardConstraintsLeadingAnchor: CGFloat = 24
    private let cardConstraintsTrailingAnchor: CGFloat = -24
    
    // MARK: - Components
    
    var alert: UIAlertController?
    
    private lazy var buttonReturn: UIButton = {
        let element = UIButton()
        element.translatesAutoresizingMaskIntoConstraints = false
        element.setImage(UIImage(named: "bottonReturn"), for: .normal)
        element.layer.cornerRadius = buttonRadius
        element.isHidden = true
        element.addTarget(self, action: #selector(didTapButtonReturn), for: .touchUpInside)
        return element
    }()
    
    lazy var nameTypeLabel: UILabel = {
        let element = UILabel(frame: CGRect(x: nameTypeLabelCGRectX, y: nameTypeLabelCGRectY, width: nameTypeLabelCGRectWidth, height: nameTypeLabelCGRectHeight))
        element.translatesAutoresizingMaskIntoConstraints = false
        element.font = UIFont.systemFont(ofSize: nameTypeLabelFontSize, weight: .bold)
        element.font = UIFont.systemFont(ofSize: nameTypeLabelFontOfSize, weight: .bold)
        element.numberOfLines = nameTypeLabelNumberOfLines
        element.textAlignment = .right
        element.lineBreakMode = .byWordWrapping
        element.textColor = .homeTitleLabelColor
        return element
    }()
    
    private lazy var cardOption: InsideCardOptionsView = {
        let element = InsideCardOptionsView()
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
    
    // MARK: - Archtecture Objects
    
    var interactor: InsideBusinessLogic?
    var router: (NSObjectProtocol & InsideRoutingLogic & InsideDataPassing)?
    
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
        let interactor = InsideInteractor()
        let presenter = InsidePresenter()
        let router = InsideRouter()
        
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
    
    // MARK: - Layout Functions
    
    private func addComponents() {
        view.addSubview(nameTypeLabel)
        view.addSubview(buttonReturn)
        view.addSubview(cardOption)
        view.addSubview(activityIndicatorView)
    }
    
    private func addComponentsConstraints() {
        addNameTypeLabelConstraints()
        addButtonReturnConstraint()
        addCarConstraints()
        addActivityIndicatorViewConstraints()
    }
    
    private func addButtonReturnConstraint() {
        buttonReturn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: buttonConstraintsTopAnchor).isActive = true
        buttonReturn.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                            constant: buttonConstraintsLeadingAnchor).isActive  = true
        buttonReturn.widthAnchor.constraint(equalToConstant: buttonConstraintsWidthAnchor).isActive = true
        buttonReturn.heightAnchor.constraint(equalToConstant: buttonConstraintsheightAnchor).isActive = true
    }
    
    private func addNameTypeLabelConstraints() {
        nameTypeLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: nameTypeLabelConstraintsTopAnchor).isActive = true
        nameTypeLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: nameTypeLabelConstraintsTrailingAnchor).isActive = true
    }
    
    private func addCarConstraints() {
        cardOption.topAnchor.constraint(equalTo: nameTypeLabel.bottomAnchor, constant: cardConstraintsTopAnchor).isActive = true
        cardOption.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: cardConstraintsLeadingAnchor).isActive = true
        cardOption.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: cardConstraintsTrailingAnchor).isActive = true
        cardOption.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    private func addActivityIndicatorViewConstraints() {
        activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    // MARK: - Display Logic
    
    func displayScreenValues(viewModel: Inside.Model.ViewModel) {
        nameTypeLabel.text = viewModel.title
        cardOption.configure(with: viewModel)
        activityIndicatorView.stopAnimating()
        buttonReturn.isHidden = false
    }
    
    func displayError(_ viewModel: Inside.Model.ErrorViewModel) {
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
    
    // MARK: - Delegate
    
    func refreshRequest() {
        loadScreenValues()
    }
    
    // MARK: - Action
    
    @objc private func didTapButtonReturn() {
        router?.routeToDismiss()
    }
}
