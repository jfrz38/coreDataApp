//
//  tableViewController.swift
//  coreDataApp
//
//  Created by Aula11 on 26/11/18.
//  Copyright © 2018 José Francisco Ruiz Zamora. All rights reserved.
//

import UIKit
import CoreData

class tableViewController: UITableViewController{

    var listTeams = [Team]() //Lista de equipos a tener
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: #selector(tableViewController.addItem))
    }
    
    func addItem(){
        let alertController = UIAlertController(title: "Añadir equipo", message: "Equipo", preferredStyle: .Alert)
        
        let confirmAction = UIAlertAction(title: "Confirmar", style: UIAlertActionStyle.Default, handler: ({
            (_) in
            
            let textFieldNombre = alertController.textFields![0].text! as String
            if( textFieldNombre == "" || textFieldNombre == " "){
                return
            }
            
            let img = UIImage(named: "team_image_default")
            self.saveItem(textFieldNombre, image: img!)
            self.tableView.reloadData()
            
        }))
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.Cancel, handler: nil)
        
        alertController.addTextFieldWithConfigurationHandler({
            (textField) in
            
            textField.placeholder = "Nombre equipo"
        })
        
        let imageView = UIImageView(frame: CGRectMake(220,10,40,40))
        imageView.image = UIImage(named: "team_image_default")
        alertController.view.addSubview(imageView)
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
    
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func saveItem(teamToSave : String, image: UIImage){

        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext

        let entity = NSEntityDescription.entityForName("ListTeams", inManagedObjectContext: managedContext)

        let team = coreDataApp.Team(entity:entity!, insertIntoManagedObjectContext: managedContext)
        team.teamName = teamToSave
        team.teamImage = image
        team.teamPlayers = [Player]()
        
        do{
            try managedContext.save()
            listTeams.append(team)
            
        }
        catch{
            
            print("error")
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        //Método para coger todos los datos del core data y mostrarlos en el table view
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext

        let fetchRequest = NSFetchRequest(entityName: "ListTeams")
        
        do{
            let results = try managedContext.executeFetchRequest(fetchRequest)
            listTeams = results as! [Team]
            
        }
        catch{
            print("error")
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //añadir tableViews
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listTeams.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! EquipoTableViewCell
        
        let team = listTeams[indexPath.row]
        //cell.textLabel?.text = team.teamName
        cell.lblEquipo?.text = team.teamName
        
        return cell

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier != "mostrarJugadores" {return}
        
        let celdaRef = sender as! UITableViewCell
        let destinoVC = segue.destinationViewController as! UINavigationController
        let childSourceVC = destinoVC.topViewController as! jugadoresTableViewController
        
        let filaSeleccionada = tableView.indexPathForCell(celdaRef)
        childSourceVC.team = listTeams[(filaSeleccionada)!.row]
    }

}

