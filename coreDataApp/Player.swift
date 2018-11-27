//
//  Player.swift
//  coreDataApp
//
//  Created by Aula11 on 27/11/18.
//  Copyright © 2018 José Francisco Ruiz Zamora. All rights reserved.
//

import UIKit
import CoreData

public class Player: NSManagedObject {

    @NSManaged var playerName: String
    @NSManaged var playerSurname: String
    @NSManaged var playerImage: UIImage?
    @NSManaged var playerTeam: String
}
