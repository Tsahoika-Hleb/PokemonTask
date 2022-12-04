//
//  PokemonListPresenter.swift
//  PokemonTask
//
//  Created by Hleb Tsahoika on 14.11.22.
//

import Foundation

protocol PokemonListPresenterSpec {
    
    var eventReceiver: PokemonListViewEventReceiverable? { get set }
    var rowOfList: Int { get }
    var isNowLoading: Bool { get set }
    
    func setup()
    func updateList()
    func didSelect(at row: Int)
    func getCellModel(by row: Int) -> PokemonListCellModel
}

protocol PokemonListViewEventReceiverable: AnyObject {
    func receivedEventOfRefreshList()
    func receivedEventOfShowAlert(errorType: Error)
}

/// Presenter to PokemonListViewController
class PokemonListPresenter<AnyFetchShoesUseCase>: PokemonListPresenterSpec where AnyFetchShoesUseCase: FetchDataUseCaseSpec, AnyFetchShoesUseCase.DataModel == [PokemonModel] {
    
    init(fetchPokemonUseCase: AnyFetchShoesUseCase,
         fetchLocalPokemonUseCaseSpec: AnyFetchShoesUseCase,
         router: PokemonListRouter) {
        self.fetchPokemonUseCase = fetchPokemonUseCase
        self.fetchLocalPokemonUseCaseSpec = fetchLocalPokemonUseCaseSpec
        self.router = router
        
    }
    
    weak var eventReceiver: PokemonListViewEventReceiverable?
    var rowOfList: Int {return pokemons.count}
    var isNowLoading = false
    
    func setup() {
        fetchLocalPokemonList()
    }
    
    func updateList() {
        isNowLoading = true
        fetchPokemon()
    }
    
    func getCellModel(by row: Int) -> PokemonListCellModel {
        let thePokemon = pokemons[row]
        return PokemonListCellModel(imageData: thePokemon.frontDefault!, name: "\(thePokemon.id)) \(thePokemon.name)")
    }
    
    func didSelect(at row: Int) {
        let thePokemon = pokemons[row]
        router.pushDetailView(with: thePokemon)
    }
    
    
    // MARK: Private
    
    private var pokemons: [PokemonModel] = []
    private let router: PokemonListRouter
    private let fetchPokemonUseCase: AnyFetchShoesUseCase
    private let fetchLocalPokemonUseCaseSpec: AnyFetchShoesUseCase
    
    // Receives [PokemonModel] and Error from LocalRepository
    private func fetchLocalPokemonList() {
        fetchLocalPokemonUseCaseSpec.fetchDataModel { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let pokemons):
                self.pokemons = pokemons
                self.eventReceiver?.receivedEventOfRefreshList()
            case .failure:
                self.updateList()
                break
            }
            K.currentOffset = self.pokemons.count
            
        }
    }
    
    // Receives [PokemonModel] and Error from CacheRepository
    private func fetchPokemon() {
        fetchPokemonUseCase.fetchDataModel { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let pokemons):
                self.pokemons += pokemons
                self.eventReceiver?.receivedEventOfRefreshList()
                self.isNowLoading = false
            case .failure(let error):
                if (error as! NetworkError == NetworkError.connection) {
                    self.eventReceiver?.receivedEventOfShowAlert(errorType: error)
                }
            }
        }
    }
    
}
