//
//  PokemonListViewController.swift
//  PokemonTask
//
//  Created by Hleb Tsahoika on 14.11.22.
//

import UIKit

class PokemonListViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var presenter: PokemonListPresenterSpec!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setup()
        setupTableView()
    }
    
    
    // MARK: private
    
    private enum TableViewOptions: Int {
        
        case numberOfSections = 2
        case cellsToUpdate = 10
        
        enum PokemonListCellOptions: Int {
            case pokemonCellHeight = 75
            case pokemonCellSectionId = 0
        }
        
        enum LoadingCellOptions: Int {
            case loadingCellHeight = 55
            case loadingCellSectionId = 1
        }
    }

    private enum State {
        case initial
        case showList
    }
    
    private var state: State = .initial {
        didSet {
            switch state {
            case .initial: break
            case .showList: tableView.reloadData()
            }
        }
    }
        
    private func setupTableView() {
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = UIColor.clear  
        tableView.register(UINib(nibName: K.pokemonListCellNibName, bundle: nil), forCellReuseIdentifier: K.pokemonListTableViewCellID)
        tableView.register(UINib(nibName: K.loadingCellNibName, bundle: nil), forCellReuseIdentifier: K.loadingTableViewCellID)
    }
    
}

extension PokemonListViewController: PokemonListViewEventReceiverable {
    func receivedEventOfRefreshList() {
        state = .showList
    }
    
    func receivedEventOfShowAlert(title: String, content: String) {
        let alert = UIAlertController(title: title, message: content, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
}

// MARK: - UITableViewDataSource & UITableViewDelegate

extension PokemonListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == TableViewOptions.PokemonListCellOptions.pokemonCellSectionId.rawValue {
            return presenter.rowOfList
        } else if section == TableViewOptions.LoadingCellOptions.loadingCellSectionId.rawValue {
            return 1
        } else {
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return TableViewOptions.numberOfSections.rawValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == TableViewOptions.PokemonListCellOptions.pokemonCellSectionId.rawValue {
            let cell = tableView.dequeueReusableCell(withIdentifier: K.pokemonListTableViewCellID, for: indexPath) as! PokemonListTableViewCell
            let viewModel = presenter.getCellModel(by: indexPath.row)
            cell.nameLabel.text = viewModel.name
            cell.pokemonImage.image = UIImage(data: viewModel.imageData)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: K.loadingTableViewCellID, for: indexPath) as! LoadingTableViewCell
            cell.activityIndicator.startAnimating()
            return cell
        }
    }
    
}

extension PokemonListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelect(at: indexPath.row)
        
        tableView.cellForRow(at: indexPath)?.isSelected = false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == TableViewOptions.PokemonListCellOptions.pokemonCellSectionId.rawValue {
            return CGFloat(TableViewOptions.PokemonListCellOptions.pokemonCellHeight.rawValue)
        } else {
            return CGFloat(TableViewOptions.LoadingCellOptions.loadingCellHeight.rawValue)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == presenter.rowOfList - TableViewOptions.cellsToUpdate.rawValue, !presenter.isNowLoading {
            presenter.updateList()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.tableView.reloadData()
            }
        }
    }
}
