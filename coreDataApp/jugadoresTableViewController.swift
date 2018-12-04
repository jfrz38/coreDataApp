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
    
    @IBOutlet weak var imgPlayer: UIView!
    @IBOutlet weak var lblPlayer: UILabel!
    
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
    
    //Volver a la lista de equipos
    func backTableTeam(){
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    //Añadir jugador a un equipo
    func addPlayer(){
        let alertController = UIAlertController(title: "Introduce jugador", message: "Jugador", preferredStyle: .Alert)
        
        let confirmAction = UIAlertAction(title: "Confirmar", style: UIAlertActionStyle.Default, handler: ({
            (_) in
            
            let txtField1 = alertController.textFields![0].text! as String
            let txtField2 = alertController.textFields![1].text! as String

            
            if( txtField1 == "" || txtField1 == " "){
                return
            }
            if( txtField2 == "" || txtField2 == " "){
                return
            }
            
            let img = UIImage(named: "player_image_default")
            self.saveItem(txtField1, surname: txtField2, image: img!)
            self.tableView.reloadData()
        }))
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: UIAlertActionStyle.Cancel, handler: nil)
        
        alertController.addTextFieldWithConfigurationHandler({
            (textField) in
            
            textField.placeholder = "Nombre jugador"
        })
        
        alertController.addTextFieldWithConfigurationHandler {
            (textFieldApellidos) in
            
            textFieldApellidos.placeholder="Apellidos jugador"
        }
        
        let imageView = UIImageView(frame: CGRectMake(220,10,40,40))
        imageView.image = UIImage(named: "player_image_default")
        alertController.view.addSubview(imageView)
        
        /*let x = alertController.textFields![1].frame.origin.x
        let y = alertController.textFields![1].frame.origin.y + alertController.textFields![1].frame.height
        let w = alertController.textFields![1].frame.width
        
        let imageView2 = UIImageView(frame: CGRectMake(x,y,200,w))
        imageView2.image = UIImage(named: "player_image_default")
        alertController.view.addSubview(imageView2)*/
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func saveItem(name : String, surname: String, image: UIImage){
        
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        let entity = NSEntityDescription.entityForName("ListPlayers", inManagedObjectContext: managedContext)

        
        let player = Player(entity:entity!, insertIntoManagedObjectContext: managedContext)
        player.playerName = name
        player.playerSurname = surname
        player.playerTeam = team.teamName
        player.playerImage = image
        
        do{
            try managedContext.save()
            listPlayers.append(player)
            
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
            for players in results{
                if(players.playerTeam! == self.team.teamName){
                    listPlayers.append(players as! Player)
                }
            }
            
        }
        catch{
            print("error")
        }
        
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return listPlayers.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("playerCell", forIndexPath: indexPath) as! JugadorTableViewCell
       
        let player = listPlayers[indexPath.row]
        cell.lblPlayer?.text = player.playerName + " " + player.playerSurname
        cell.imgPlayer.image = player.playerImage
        cell.imgPlayer.frame = CGRectMake(cell.imgPlayer.frame.origin.x, cell.imgPlayer.frame.origin.y, cell.imgPlayer.image!.size.width,cell.imgPlayer.image!.size.height / 2)
        return cell
        
    }

    
}
