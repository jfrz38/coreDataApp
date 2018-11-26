//
//  teams.swift
//  coreDataApp
//
//  Created by Aula11 on 26/11/18.
//  Copyright © 2018 José Francisco Ruiz Zamora. All rights reserved.
//

import UIKit

public class teams: NSObject {
    
    var teamName: String
    var teamPlayers = [String]()
    
    init (teamName: String, teamPlayers: [String]){

        self.teamName = teamName
        self.teamPlayers = teamPlayers


    }

}
