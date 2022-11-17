//
//  PokemonListViewController.swift
//  PokemonTask
//
//  Created by Hleb Tsahoika on 14.11.22.
//

import UIKit
import SDWebImage

class PokemonListViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var presenter: PokemonListPresenterSpec!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.updateList()
        setupTableView()
    }
    
    // MARK: private
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
        tableView.register(UINib(nibName: "PokemonListTableViewCell", bundle: nil), forCellReuseIdentifier: K.pokemonListTableViewCellID)
        tableView.register(UINib(nibName: "LoadingTableViewCell", bundle: nil), forCellReuseIdentifier: K.loadingTableViewCellID)
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
        if section == 0 {
            return presenter.rowOfList
        } else if section == 1 {
            return 1
        } else {
            return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: K.pokemonListTableViewCellID, for: indexPath) as! PokemonListTableViewCell
            let viewModel = presenter.getCellModel(by: indexPath.row)
            cell.nameLabel.text = viewModel.name
            //cell.pokemonImage = UIImageView(image: UIImage(named: "pikachu"))
            //cell.pokemonImage.sd_setImage(with: URL(string: viewModel.image)) // TODO: CHANGE
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
        if indexPath.section == 0 {
            return 75
        } else {
            return 55
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == presenter.rowOfList - 10, !presenter.isNowLoading {
            presenter.updateList()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                print("reload")
                self.tableView.reloadData()
            }
        }
    }
}
