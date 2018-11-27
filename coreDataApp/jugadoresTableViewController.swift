//
//  deleteTableViewController.swift
//  coreDataApp
//
//  Created by Aula11 on 26/11/18.
//  Copyright © 2018 José Francisco Ruiz Zamora. All rights reserved.
//

import UIKit
import CoreData

class jugadoresTableViewController: UITableViewController, UINavigationControllerDelegate {

    var listPlayers = [Player]() //Lista de jugadores en un equipo
    var team: Team!
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        
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

        
        let player = Player(entity:entity!, insertIntoManagedObjectContext: managedContext)
        player.playerName = itemToSave
        player.playerTeam = team.teamName
        
        do{
            try managedContext.save()
            listPlayers.append(player)
            print("Guardado jugador ",player.playerName," en el equipo ",team.teamName)
            
        }
        catch{
            
            print("error")
        }

    }
    
    override func viewWillAppear(animated: Bool) {
        //Método para coger todos los datos del core data y mostrarlos en el table view
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "ListPlayers")
        
        do{
            let results = try managedContext.executeFetchRequest(fetchRequest)
            listPlayers = results as! [Player]
            
        }
        catch{
            print("error")
        }
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listPlayers.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        
        /*let item = listTeams[indexPath.row] //Valor del item correspondiente a cada celda
         
         let team = item.valueForKey("team") as! teams*/
        
        
        let player = listPlayers[indexPath.row]
        cell.textLabel?.text = player.playerName
        
        return cell
        
    }

    
}
