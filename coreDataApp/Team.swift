//
//  Team.swift
//  coreDataApp
//
//  Created by Aula11 on 26/11/18.
//  Copyright © 2018 José Francisco Ruiz Zamora. All rights reserved.
//

import UIKit
import CoreData

public class Team: NSManagedObject {
    
    @NSManaged var teamName: String
    @NSManaged var teamPlayers: [Player]
    

}

