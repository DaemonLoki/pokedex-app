//
//  PokemonDetailVC.swift
//  pokedex
//
//  Created by Stefan Blos on 27.01.16.
//  Copyright © 2016 Stefan Blos. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var pokedexIdLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var healthLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var evoLbl: UILabel!
    @IBOutlet weak var currentEvoImg: UIImageView!
    @IBOutlet weak var nextEvoImg: UIImageView!
    
    
    var pokemon: Pokemon!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLbl.text = pokemon.name.capitalizedString
        mainImg.image = UIImage(named: "\(pokemon.pokedexId)")
        currentEvoImg.image = mainImg.image
        pokedexIdLbl.text = "\(pokemon.pokedexId)"
        
        pokemon.downloadPokemonDetails { () -> () in
            // called after download is done:
            self.descriptionLbl.text = self.pokemon.pokeDescription
            self.attackLbl.text = self.pokemon.attack
            self.defenseLbl.text = self.pokemon.defense
            self.heightLbl.text = self.pokemon.height
            self.healthLbl.text = self.pokemon.health
            self.weightLbl.text = self.pokemon.weight
            self.evoLbl.text = self.pokemon.evoText
            if self.pokemon.nextEvo != 0 {
                self.nextEvoImg.image = UIImage(named: "\(self.pokemon.nextEvo)")
            } else {
                self.nextEvoImg.hidden = true
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onBackBtnPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
