//
//  Teams+CoreDataProperties.h
//  coreDataApp
//
//  Created by Aula11 on 27/11/18.
//  Copyright © 2018 José Francisco Ruiz Zamora. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Teams.h"

NS_ASSUME_NONNULL_BEGIN

@interface Teams (CoreDataProperties)

@property (nullable, nonatomic, retain) id team;

@property (nonatomic,retain) Teams* teamName;
@property (nonatomic,retain) Teams* teamPlayers;

@end

NS_ASSUME_NONNULL_END
