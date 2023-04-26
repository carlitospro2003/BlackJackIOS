//
//  RecordViewController.swift
//  JuegoBlackJack
//
//  Created by imac on 10/04/23.
//

import UIKit
import AVFoundation

class RecordViewController: UIViewController
{
    
    let scrollView = UIScrollView()
    
    
    
    @IBAction func btnSalir(_ sender: Any)
    {
        efectoBotnes()
    }
    
    
    //var victorias: Int = 0
    var efectoBoton: AVAudioPlayer?
    
    var nombre = UserDefaults.standard.string(forKey: "nombre")
    var victorias = UserDefaults.standard.integer(forKey: "victorias")
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // Configurar el ScrollView
               scrollView.translatesAutoresizingMaskIntoConstraints = false
               
               view.addSubview(scrollView)
               
               NSLayoutConstraint.activate([
                   scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                   scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                   scrollView.topAnchor.constraint(equalTo: view.topAnchor),
                   scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
               ])
               
        let data = ["\(nombre): \(victorias) victorias", "Carlos: 9 victorias", "Guillermo: 7 victorias", "Veronica: 4 victorias", "Josue: 2 victorias", "David: 1 victoria"]

        var yPosition: CGFloat = 250

        for dato in data {
            let label = UILabel()
            label.text = dato
            label.textAlignment = .center
            label.backgroundColor = .secondarySystemBackground
            
            label.translatesAutoresizingMaskIntoConstraints = false
            
            scrollView.addSubview(label)
            
            NSLayoutConstraint.activate([
                label.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                label.centerYAnchor.constraint(equalTo: scrollView.topAnchor, constant: yPosition),
                label.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.8),
                label.heightAnchor.constraint(equalToConstant: 50)
            ])
            
            yPosition += 100
        }

        // Establecer el contenido del ScrollView
        scrollView.contentSize = CGSize(width: view.bounds.width, height: yPosition + 10)
    }
    
    func efectoBotnes() {
        let path = Bundle.main.path(forResource: "Boton", ofType: "mp3")!
        let url = URL(fileURLWithPath: path)

        do {
            efectoBoton = try AVAudioPlayer(contentsOf: url)
            //efecto?.numberOfLoops = -1 // -1 para reproducir en bucle
            efectoBoton?.prepareToPlay()
            efectoBoton?.play()
        } catch {
            // Si ocurre un error al cargar el archivo de música, puedes imprimir un mensaje en la consola o mostrar una alerta al usuario
            print("El efecto no se encuentra")
        }
    }
    
    
    

}
