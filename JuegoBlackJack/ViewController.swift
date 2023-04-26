//
//  ViewController.swift
//  JuegoBlackJack
//
//  Created by imac on 03/04/23.
//

import UIKit
import AVFoundation


class ViewController: UIViewController
{
    
    
    
    @IBOutlet weak var imvSplash: UIImageView!
    
    var musica: AVAudioPlayer?
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imvSplash.frame = CGRect(x: (view.frame.width - imvSplash.frame.width)/2.0, y: -imvSplash.frame.height, width: imvSplash.frame.width, height: imvSplash.frame.height)
        imvSplash.alpha = 0.0
        reproducirMusica()
        print("La musica se esta Reproduciendo")
        
        
    }
    
    func reproducirMusica() {
        let path = Bundle.main.path(forResource: "Electro Shock Sport Dance", ofType: "mp3")!
        let url = URL(fileURLWithPath: path)

        do {
            musica = try AVAudioPlayer(contentsOf: url)
            musica?.numberOfLoops = -1 // -1 para reproducir en bucle
            musica?.prepareToPlay()
            musica?.play()
        } catch {
            // Si ocurre un error al cargar el archivo de música, puedes imprimir un mensaje en la consola o mostrar una alerta al usuario
            print("La musica no se encuentra")
        }
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        UIView.animate(withDuration: 2.5) {
            self.imvSplash.frame.origin.y = (self.view.frame.height - self.imvSplash.frame.height)/2.0
            self.imvSplash.alpha = 1.0
        } completion: { res in
            self.performSegue(withIdentifier: "sgSplash", sender: nil)
        }
    }
    
}

