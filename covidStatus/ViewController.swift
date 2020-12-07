//
//  ViewController.swift
//  covidStatus
//
//  Created by Catalina on 05/12/20.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ciudadLabel: UILabel!
    @IBOutlet weak var imageViewBandera: UIImageView!
    @IBOutlet weak var ciudadTextField: UITextField!
    @IBOutlet weak var casosConfirmadosLabel: UILabel!
    @IBOutlet weak var casosRecuperadosLabel: UILabel!
    @IBOutlet weak var muertesLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func buscarCiudadButton(_ sender: UIButton) {
        let urlAPI = URL(string:"https://corona.lmao.ninja/v3/covid-19/countries/mexico")
        
        let peticion = URLRequest(url: urlAPI!)
        let tarea = URLSession.shared.dataTask(with: peticion) {datos,respuesta,error in
            if error != nil{
                print(error?.localizedDescription ?? "not")
            }else{
                do{
                    let json = try JSONSerialization.jsonObject(with: datos!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:Any];             print(json)
                   // let querySubJson = json["query"] as! [String : Any]
                    if let codigo =  json["cases"] {
                        print("Casos")
                        print(codigo)
                       }
                    
                } catch {
                    print("Error al procesar Json")
                }
            }
        }
        tarea.resume()
    }
}

