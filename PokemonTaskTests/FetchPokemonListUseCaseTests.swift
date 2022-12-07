//
//  FetchPokemonsUseCaseTests.swift
//  PokemonTaskTests
//
//  Created by Hleb Tsahoika on 7.12.22.
//

import XCTest
@testable import PokemonTask

final class FetchPokemonListUseCaseTests: XCTestCase {
    
    var repository = MockFetchPokemonListRepository()
    lazy var fetchPokemonListUseCase = FetchPokemonListUseCase(repository: repository)

    func testSuccessCallBack() {
        
        let pokemon = [PokemonModel.newPokemon]
        let expectedResult: Result<[PokemonModel], Error> = .success(pokemon)
        repository.expectedResult = expectedResult
        let completionHandlerExpectation = expectation(description: "Fetch pokemon expectation")
        
        fetchPokemonListUseCase.fetchDataModel { (result) in
            switch result {
            case .success(let model):
                XCTAssertEqual(model, pokemon)
                completionHandlerExpectation.fulfill()
            case .failure: break
            }
        }
        waitForExpectations(timeout: 1, handler: nil)
    }


    func testFailCallBack() {
        
        let theError = MockFetchPokemonListRepositoryError.fail
        let expectedResult: Result<[PokemonModel], Error> = .failure(theError)
        repository.expectedResult = expectedResult
        let completionHandlerExpectation = expectation(description: "Fetch pokemon expectation")
        
        fetchPokemonListUseCase.fetchDataModel { (result) in
            switch result {
            case .success: break
            case .failure(let error):
                switch error {
                case MockFetchPokemonListRepositoryError.fail:
                    completionHandlerExpectation.fulfill()
                default: break
                }
            }
        }
        waitForExpectations(timeout: 1, handler: nil)
    }

}
