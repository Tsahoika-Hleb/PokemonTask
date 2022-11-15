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
        
        // Do any additional setup after loading the view.
    }
}

