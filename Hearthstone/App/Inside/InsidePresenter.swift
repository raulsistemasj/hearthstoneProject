//
//  InsidePresenter.swift
//  Hearthstone
//
//  Created by Raul M Ferreira on 19/09/22.
//

import UIKit

protocol InsidePresentationLogic {
    func presentScreenValues(category: String, imageList: [String])
    func presentError()
}

final class InsidePresenter: InsidePresentationLogic {
    
    // MARK: - Archtecture Objects
    
    weak var viewController: InsideDisplayLogic?
    
    // MARK: - Presentation Logic
    
    func presentScreenValues(category: String, imageList: [String]) {
        let viewModel = Inside.Model.ViewModel(title: category.capitalized, imageList: imageList)
        DispatchQueue.main.async {
            self.viewController?.displayScreenValues(viewModel: viewModel)
        }
    }
    
    func presentError() {
        let viewModel = Inside.Model.ErrorViewModel(title: "Hearthstone",
                                                    message: "Ops, tivemos um problema inesperado.",
                                                    retryButton: "Tentar Novamente",
                                                    cancel: "Cancelar")
        viewController?.displayError(viewModel)
    }
}
