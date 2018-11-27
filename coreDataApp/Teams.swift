//
//  teams.swift
//  coreDataApp
//
//  Created by Aula11 on 26/11/18.
//  Copyright © 2018 José Francisco Ruiz Zamora. All rights reserved.
//

import UIKit
import CoreData

/*public class Teams: NSObject, NSCoding {
    
    var teamName: String
    var teamPlayers = [String]()
    
    init (teamName: String, teamPlayers: [String]){

        self.teamName = teamName
        self.teamPlayers = teamPlayers

    }
    
    public func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(teamName, forKey: "teamName")
        aCoder.encodeObject(teamPlayers, forKey: "teamPlayers")
    }
    
    required convenience public init?(coder aDecoder: NSCoder){
        let teamName = aDecoder.decodeObjectForKey("teamName") as! String
        let teamPlayers = aDecoder.decodeObjectForKey("teamPlayers") as! [String]
        self.init(teamName: teamName, teamPlayers: teamPlayers)
    }

}*/


@objc(Teams)
public class Teams: NSManagedObject {
    
    @NSManaged var teamName: String
    @NSManaged var teamPlayers: [String]
 
}

