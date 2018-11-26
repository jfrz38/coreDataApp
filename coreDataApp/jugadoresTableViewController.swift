//
//  deleteTableViewController.swift
//  coreDataApp
//
//  Created by Aula11 on 26/11/18.
//  Copyright © 2018 José Francisco Ruiz Zamora. All rights reserved.
//

import UIKit
import CoreData

class jugadoresTableViewController: UITableViewController {

    var listPlayers = [NSManagedObject]() //Lista de jugadores en un equipo
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Reply, target: self, action: #selector(jugadoresTableViewController.backTableTeam))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: #selector(jugadoresTableViewController.addPlayer))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
    
    //Volver a la lista de equipos
    func backTableTeam(){
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    //Añadir jugador a un equipo
    func addPlayer(){
        let alertController = UIAlertController(title: "Introduce jugador", message: "Jugador", preferredStyle: .Alert)
        
        let confirmAction = UIAlertAction(title: "Confirmar", style: UIAlertActionStyle.Default, handler: ({
            (_) in
            
            if let field = alertController.textFields![0] as? UITextField{
                
                self.saveItem(field.text!)
                self.tableView.reloadData()
            }
        }))
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.Cancel, handler: nil)
        
        alertController.addTextFieldWithConfigurationHandler({
            (textField) in
            
            textField.placeholder = "Nombre jugador"
        })
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func saveItem(itemToSave : String){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("ListPlayers", inManagedObjectContext: managedContext)
        
        let item = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        item.setValue(itemToSave, forKey: "item")
        
        do{
            
            try managedContext.save()
            
            listPlayers.append(item)
            
        }
        catch{
            
            print("error")
        }
        
    }

}
