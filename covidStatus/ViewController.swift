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
        //let ciudadBuscada = ciudadTextField.text
        let urlAPI = URL(string:"https://corona.lmao.ninja/v3/covid-19/countries/\(self.ciudadTextField.text ?? "")")
        
        let peticion = URLRequest(url: urlAPI!)
        let tarea = URLSession.shared.dataTask(with: peticion) {datos,respuesta,error in
            if error != nil{
                print(error?.localizedDescription ?? "not")
            }else{
                do{
                    let json = try JSONSerialization.jsonObject(with: datos!, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:Any];             print(json)
                    //Sacar los Datos de JSON
                    let ciudad = json["country"] as! String?
                    let totalCasosConfirmados = json["cases"] as! Int?
                    let totalDeMuertes = json["deaths"] as! Int?
                    let totaldeRecuperados = json["recovered"] as! Int?
                    let ciudadInformacion = json["countryInfo"] as! [String : Any]
                    let banderalink = ciudadInformacion["flag"] as! String
                    
                //Sacar Imagen de la Bandera
                    DispatchQueue.main.sync(execute: {
                        print(banderalink)
                        let url = NSURL(string: banderalink)
                        print(url!)
                        if let data = NSData(contentsOf: url! as URL) {
                            self.imageViewBandera.image = UIImage(data: data as Data)
                        }
                        self.ciudadLabel.text = ciudad
                        self.casosConfirmadosLabel.text = String(totalCasosConfirmados!)
                        self.casosRecuperadosLabel.text = String(totaldeRecuperados!)
                        self.muertesLabel.text = String(totalDeMuertes!)
                    })
                    
                } catch {
                    print("Error al procesar Json")
                }
            }
        }
        tarea.resume()
    }
}

