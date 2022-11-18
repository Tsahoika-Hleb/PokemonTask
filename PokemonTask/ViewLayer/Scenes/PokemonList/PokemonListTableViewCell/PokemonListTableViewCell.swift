//
//  PokemonListTableViewCell.swift
//  PokemonTask
//
//  Created by Hleb Tsahoika on 15.11.22.
//

import UIKit

struct PokemonListCellModel {
    let imageData: Data
    let name: String
}

class PokemonListTableViewCell: UITableViewCell {

    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cellView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = cellView.frame.height / 2
        self.backgroundColor = UIColor.clear
        self.selectionStyle = .none
        cellView.layer.cornerRadius = cellView.frame.height / 2
        pokemonImage.layer.cornerRadius = pokemonImage.frame.size.width / 2
        pokemonImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            customSelected()
        }
    }
    
    func customSelected() {
        cellView.backgroundColor = .systemGray2
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.cellView.backgroundColor = .systemGray6
        }
    }
    
}
