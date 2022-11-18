//
//  ViewController.swift
//  PokemonTask
//
//  Created by Hleb Tsahoika on 14.11.22.
//

import UIKit

class PokemonDetailViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var heightLabel: UILabel!
    
    @IBOutlet weak var weightLabel: UILabel!
    
    @IBOutlet weak var typeLabel: UILabel!
    
    @IBOutlet weak var topImageView: UIImageView!
    
    @IBOutlet weak var bottomImageView: UIImageView!
    
    @IBOutlet weak var informationView: UIView!
    
    var presenter: PokemonDetailPresenterSpec!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = "pok1"
        informationView.layer.cornerRadius = 15
        informationView.layer.masksToBounds = true
        
        presenter.setup()
    }
    
}

// MARK: PokemonDetailViewEventReceiverable

extension PokemonDetailViewController: PokemonDetailViewEventReceiverable {
    
    func receivedEventOfSetupViews(with setupModel: PokemonDetailViewSetupModel) {
        nameLabel.text = setupModel.name.capitalized
        heightLabel.text = "\(setupModel.height)cm"
        weightLabel.text = "\(setupModel.weight)kg"
        typeLabel.text = String(setupModel.types.joined(separator: ", ").capitalized)
        topImageView.image = UIImage(data: setupModel.topImage)
        bottomImageView.image = UIImage(data: setupModel.botImage)
        
    }
}


