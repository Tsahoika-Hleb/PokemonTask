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
    
    func updateList()
    func didSelect(at row: Int)
    func getCellModel(by row: Int) -> PokemonListCellModel
}

protocol PokemonListViewEventReceiverable: AnyObject {
    func receivedEventOfRefreshList()
    func receivedEventOfShowAlert(title: String, content: String)
}


class PokemonListPresenter<AnyFetchShoesUseCase>: PokemonListPresenterSpec where AnyFetchShoesUseCase: FetchDataUseCaseSpec, AnyFetchShoesUseCase.DataModel == [PokemonModel] {
    
    init(fetchPokemonUseCase: AnyFetchShoesUseCase,
         router: PokemonListRouter) {
        self.fetchPokemonUseCase = fetchPokemonUseCase
        self.router = router
        
    }
    
    weak var eventReceiver: PokemonListViewEventReceiverable?
    var rowOfList: Int {return pokemons.count}
    var isNowLoading = false
    
    func updateList() {
        isNowLoading = false
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
    
    private func fetchPokemon() {
        print("try to fetch")
        fetchPokemonUseCase.fetchDataModel { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let pokemons):
                print("success")
                self.pokemons += pokemons
                self.eventReceiver?.receivedEventOfRefreshList()
            case .failure:
                print("fail---------------")
                
                self.eventReceiver?.receivedEventOfShowAlert(title: "Fail", content: "An error occurred, please try again later.")
                
            }
        }
    }
}
