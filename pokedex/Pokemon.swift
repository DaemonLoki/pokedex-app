//
//  Pokemon.swift
//  pokedex
//
//  Created by Stefan Blos on 25.01.16.
//  Copyright © 2016 Stefan Blos. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name: String!
    private var _pokedexId: Int!
    private var _description: String!
    private var _attack: String!
    private var _defense: String!
    private var _height: String!
    private var _health: String!
    private var _weight: String!
    private var _evoText: String!
    private var _type: String!
    private var _pokemonUrl: String!
    private var _nextEvo: Int!
    
    var name: String {
        return _name
    }
    
    var pokedexId: Int {
        return _pokedexId
    }
    
    var pokeDescription: String {
        return _description
    }
    
    var attack: String {
        return _attack
    }
    
    var defense: String {
        return _defense
    }
    
    var height: String {
        return _height
    }
    
    var health: String {
        return _health
    }
    
    var weight: String {
        return _weight
    }
    
    var evoText: String {
        return _evoText
    }
    
    var type: String {
        return _type
    }
    
    var pokemonUrl: String {
        return _pokemonUrl
    }
    
    var nextEvo: Int {
        return _nextEvo
    }
    
    init(name: String, pokedexId: Int) {
        self._name = name
        self._pokedexId = pokedexId
        
        self._pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexId)/"
    }
    
    func downloadPokemonDetails(completed: DownloadComplete) {
        let url = NSURL(string: _pokemonUrl)!
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                if let height = dict ["height"] as? String {
                    self._height = height
                }
        
                if let health = dict["hp"] as? Int {
                    self._health = "\(health)"
                }
                
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                print("attack is: " + self._attack)
                print("defense is: " + self._defense)
                print("height is: " + self._height)
                print("health is: " + self._health)
                print("weight is: " + self._weight)
                
                if let evoDict = dict["evolutions"] as? [Dictionary<String, AnyObject>] {
                    if evoDict.count != 0 {
                        if let level = evoDict[0]["level"] as? Int {
                            if let evo = evoDict[0]["to"] as? String {
                                if evo.rangeOfString("mega") != nil {
                                    self._evoText = "This pokemon has no evolutions"
                                    self._nextEvo = 0
                                } else {
                                    self._evoText = "This pokemon evolves on lvl \(level) to \(evo)"
                                    if let uri = evoDict[0]["resource_uri"] as? String {
                                        let noLink = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon", withString: "")
                                        self._nextEvo = Int(noLink.stringByReplacingOccurrencesOfString("/", withString: ""))
                                    }
                                }
                            }
                        } else {
                            self._evoText = "This pokemon has no evolutions"
                            self._nextEvo = 0
                        }
                        
                    } else {
                        self._evoText = "This pokemon has no evolutions"
                        self._nextEvo = 0
                    }
                }
                
                
                if let types = dict["types"] as? [Dictionary<String, String>] {
                    self._type = ""
                    for var i = 0; i < types.count; i++ {
                        let thisDict = types[i]
                        if let curType = thisDict["name"] {
                            self._type.appendContentsOf(curType.capitalizedString)
                        }
                        if i < types.count - 1 {
                            self._type.appendContentsOf("/")
                        }
                    }
                }
                
                print("Types: " + self._type)
                
                if let descriptions = dict["descriptions"] as? [Dictionary<String, String>] {
                    if let uri = descriptions[0]["resource_uri"] {
                        let urlDesc = NSURL(string: "\(URL_BASE)\(uri)")!
                        
                        Alamofire.request(.GET, urlDesc).responseJSON { response in
                            let desResult = response.result
                            
                            if let descDict = desResult.value as? Dictionary<String, AnyObject> {
                                if let descripString = descDict["description"] as? String {
                                    self._description = descripString.stringByReplacingOccurrencesOfString("POKMON", withString: "pokemon")
                                    print("Description of pokemon is: " + self._description)
                                }
                            }
                            
                            completed()
                        }
                    }
                } else {
                    self._description = ""
                }
                
            }
            
        }
        
        
        
    }
    
}