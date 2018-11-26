//
//  tableViewController.swift
//  coreDataApp
//
//  Created by Aula11 on 26/11/18.
//  Copyright © 2018 José Francisco Ruiz Zamora. All rights reserved.
//

import UIKit
import CoreData

class tableViewController: UITableViewController {

    var listTeams = [NSManagedObject]() //Lista de equipos a tener
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: #selector(tableViewController.addItem))
    }
    
    func addItem(){
        let alertController = UIAlertController(title: "Añadir equipo", message: "Equipo", preferredStyle: .Alert)
        
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
            
            textField.placeholder = "Nombre equipo"
        })
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
    
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func saveItem(itemToSave : String){
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("ListTeams", inManagedObjectContext: managedContext)
        
        let item = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        /*
        let emptyTeamPlayers = [String]()
        let team = teams(teamName: itemToSave,teamPlayers: emptyTeamPlayers)
        
        item.setValue(team, forKey: "team")
        
        do{
          
            try managedContext.save()
            
            listTeams.append(item)
        
        }
        catch{
            
            print("error")
        }*/
        item.setValue(itemToSave, forKey: "item")
        
        do{
            
            try managedContext.save()
            
            listTeams.append(item)
            
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
            listTeams = results as! [NSManagedObject]
            
        }
        catch{
            print("error")
        }
        
    }
    
    /*override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Right)  //Añadir animación al hacer click
        
        managedContext.deleteObject(listTeams[indexPath.row]) //Eliminar el objeto de la fila indicada visaulmente
        listItems.removeAtIndex(indexPath.row)  //Eliminar el valor del objeto listItems
        self.tableView.reloadData()
 
    }*/

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //añadir tableViews
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listTeams.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")! as UITableViewCell
        
        let item = listTeams[indexPath.row] //Valor del item correspondiente a cada celda
        
        cell.textLabel?.text = item.valueForKey("team") as! String //Label de la celda será el texto de item de CoreData ; as! para obligar a que sea String
        
        return cell
    }


}

