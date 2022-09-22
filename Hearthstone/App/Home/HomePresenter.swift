//
//  HomePresenter.swift
//  Hearthstone
//
//  Created by Raul M Ferreira on 19/09/22.
//

import UIKit

protocol HomePresentationLogic {
    func presentScreenValues(with response: Home.Model.Response)
    func presentError()
}

final class HomePresenter: HomePresentationLogic {
    
    // MARK: - Archtecture Objects
    
    weak var viewController: HomeDisplayLogic?
    
    // MARK: - Presentation Logic
    
    func presentScreenValues(with response: Home.Model.Response) {
        let viewModel = Home.Model.ViewModel(title: "Hearthstone",
                                             classeOptions: getClassesOptions(with: response.classes),
                                             typeOptions: getTypeOptions(with: response.types),
                                             raceOptions: getRacesOptions(with: response.races))
        DispatchQueue.main.async {
            self.viewController?.displayScreenValues(viewModel: viewModel)
        }
    }
    
    func presentError() {
        let viewModel = Home.Model.ErrorViewModel(title: "Hearthstone", message: "Ops, tivemos um problema inesperado.", retryButton: "Tentar Novamente", cancel: "Cancelar")
        viewController?.displayError(viewModel)
    }
    
    // MARK: - private func
    
    private func getClassesOptions(with options: [String]) -> Home.Model.HomeCardOptionsViewModel{
        .init(title: "Classes", cards: options)
    }
    
    private func getTypeOptions(with options: [String]) -> Home.Model.HomeCardOptionsViewModel{
        .init(title: "Types", cards: options)
    }
    
    private func getRacesOptions(with options: [String]) -> Home.Model.HomeCardOptionsViewModel{
        .init(title: "Races", cards: options)
    }
}
