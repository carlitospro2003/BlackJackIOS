//
//  MusicaViewController.swift
//  JuegoBlackJack
//
//  Created by imac on 05/04/23.
//

import UIKit
import AVFoundation


class MusicaViewController: UIViewController
{
    
    
    @IBOutlet weak var btnJugar: UIButton!
    
    
    @IBAction func btnMostrarAlerta(_ sender: Any)
    {
        
        let alert = UIAlertController(title: "Ingresa tu nombre", message: nil, preferredStyle: .alert)
                
                alert.addTextField { (textField) in
                    textField.placeholder = "Nombre"
                }
                
                let guardarAction = UIAlertAction(title: "Guardar", style: .default) { (_) in
                    guard let nombre = alert.textFields?.first?.text else { return }
                    if nombre.isEmpty {
                        // Si el campo de texto está vacío, mostramos otra alerta
                        let alert2 = UIAlertController(title: "Error", message: "Por favor ingresa un nombre.", preferredStyle: .alert)
                        let okAction2 = UIAlertAction(title: "OK", style: .default, handler: nil)
                        alert2.addAction(okAction2)
                        self.present(alert2, animated: true, completion: nil)
                    } else {
                        // Si se ingresó un nombre, lo asignamos a la propiedad nombre de la siguiente vista
                        //let siguienteVC = JuegoViewController()
                        //siguienteVC.nombre = nombre
                        
                        // Guardar el nombre en UserDefaults
                        UserDefaults.standard.set(nombre, forKey: "NombreGuardado")
                        
                        // Luego navegamos a la siguiente vista
                        //self.navigationController?.pushViewController(siguienteVC, animated: true)
                        self.performSegue(withIdentifier: "sgJugar", sender: sender)
                        print(nombre)
                    }
                }
                
                let cancelarAction = UIAlertAction(title: "Cancelar", style: .cancel)
                
                alert.addAction(guardarAction)
                alert.addAction(cancelarAction)
                
                present(alert, animated: true, completion: nil)
        
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        reproducirMusica()
    }
    
    func reproducirMusica()
    {
            guard let url = Bundle.main.url(forResource: "Musica", withExtension: "mp3") else
        {
            return
                
        }
            
            do {
                try AVAudioSession.sharedInstance().setCategory(.ambient, mode: .default)
                try AVAudioSession.sharedInstance().setActive(true)
                
                let player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)
                
                player.numberOfLoops = -1
                player.play()
            } catch let error {
                print(error.localizedDescription)
            }
        
    }
    


}
