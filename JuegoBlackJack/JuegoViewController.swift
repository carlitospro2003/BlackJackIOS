//
//  JuegoViewController.swift
//  JuegoBlackJack
//
//  Created by imac on 04/04/23.
//

import UIKit
import AVFoundation

class JuegoViewController: UIViewController
{
    
    var miCarta: [String] = []
    var conteoReparto = 0
    //var contadorJugador = 0
    var manoJugador:   [Int] = []
    //var manoJugadorDos: [Int] = []
    var totalJugadorUno = 0
    var voltear = true
    var limitePuntos = 21
     
    var tiempoTranscurrido = 0
    var timer: Timer?
    
    var victorias = UserDefaults.standard.integer(forKey: "victorias")
    
    var efectoUno: AVAudioPlayer?
    var efectoDos: AVAudioPlayer?
    var efectoBoton: AVAudioPlayer?
    
    
    @IBOutlet weak var lblJugadorUnoValor: UILabel!
    @IBOutlet weak var lblTiempo: UILabel!
    
    
    @IBOutlet weak var lblNombre: UILabel!
    var nombre: String?
    
    
    
    
    
    @IBAction func btnDeal(_ sender: Any)
    {
        acumularTarjeta()
        efectoBotnes()
        
    }
    
    @IBAction func btnSalir(_ sender: Any)
    {
        efectoBotnes()
    }
    
    
    
    
    func cartaRandom(carta: [String]) -> String
        {
            let rangoMaximo = carta.count - 1
            let numeroRandom = Int.random(in: 0...rangoMaximo)
            
            return carta[numeroRandom]
        }
        
        
        
        func crearCarta()-> [String]
        {
            let simbolos = ["Hearts", "Diamonds", "Clubs", "Spades"]
            
            var cartaTrasera: [String] = []
            
            for simbolo in simbolos
            {
                for rango in 1...13
                {
                    if rango < 10
                    {
                        let nuevaCarta = simbolo + "0" + String(rango)
                        cartaTrasera.append(nuevaCarta)
                    } else
                    {
                        let nuevaCarta = simbolo + String(rango)
                        cartaTrasera.append(nuevaCarta)
                    }
                }
            }
            return cartaTrasera
        }
    
    
    func acumularTarjeta()
    {
        if conteoReparto < 5 && totalJugadorUno < limitePuntos {
                    // Obtener la imagen de la carta
                    let mostrarTarjeta = UIImageView()
                    mostrarTarjeta.frame = CGRect(x:50 + (conteoReparto * 50), y:150, width: 83, height: 121)
                    let carta = miCarta.removeLast()
                    mostrarTarjeta.image = UIImage(named: carta)
                    view.addSubview(mostrarTarjeta)

                    // Actualizar la mano del jugador y el total de puntos
                    let valorCarta = Int(carta.suffix(2))!
                    manoJugador.append(valorCarta)
                    totalJugadorUno += valorCarta
                    lblJugadorUnoValor.text = String(totalJugadorUno)

                    conteoReparto += 1

                    // Si el jugador alcanza el límite de puntos, mostrar la alerta
                    if totalJugadorUno == limitePuntos {
                        mostrarAlerta(titulo: "Ganaste!", mensaje: "Obtuviste \(totalJugadorUno) puntos", botonJugarDeNuevo: true)
                        victorias += 1
                        //print("Has ganado \(victorias) veces.")
                        print("El efecto victoria se reprodujo")
                        
                        // Imprimir los datos guardados en UserDefaults
                        print("Nombre: \(UserDefaults.standard.string(forKey: "NombreGuardado") ?? "")")
                        UserDefaults.standard.set(victorias, forKey: "victorias")
                        
                        UserDefaults.standard.synchronize()
                        print("Victorias: \(UserDefaults.standard.string(forKey: "victorias") ?? "")")
                        

                        
                        efectoVictoria()
                       
                        
                    } else if totalJugadorUno > limitePuntos {
                        mostrarAlerta(titulo: "Perdiste!", mensaje: "Obtuviste \(totalJugadorUno) puntos", botonJugarDeNuevo: true)
                        print("El efecto derrota se reprodujo")
                        efectoDerrota()
                    }
                } else {
                    print("No más cartas para repartir o ya se alcanzó el límite de puntos")
                    mostrarAlerta(titulo: "Lo sentimos, se han agotado las cartas", mensaje: "Obtuviste \(totalJugadorUno) puntos", botonJugarDeNuevo: true)
                }

    }
    
    func mostrarAlerta(titulo: String, mensaje: String, botonJugarDeNuevo: Bool) {
        
        detenerTiempo()
        
        
            let alerta = UIAlertController(title: titulo, message: mensaje, preferredStyle: .alert)
            if botonJugarDeNuevo {
                let jugarDeNuevo = UIAlertAction(title: "Jugar de nuevo", style: .default) { _ in
                    self.reiniciarJuego()
                    self.tiempoTranscurrido = 0
                    
                }
                alerta.addAction(jugarDeNuevo)
            }
            let cerrar = UIAlertAction(title: "Cerrar", style: .cancel)
            alerta.addAction(cerrar)
            present(alerta, animated: true)
        }
    
    func efectoVictoria() {
        let path = Bundle.main.path(forResource: "victoria", ofType: "mp3")!
        let url = URL(fileURLWithPath: path)

        do {
            efectoUno = try AVAudioPlayer(contentsOf: url)
            //efecto?.numberOfLoops = -1 // -1 para reproducir en bucle
            efectoUno?.prepareToPlay()
            efectoUno?.play()
        } catch {
            // Si ocurre un error al cargar el archivo de música, puedes imprimir un mensaje en la consola o mostrar una alerta al usuario
            print("La musica no se encuentra")
        }
        
    }
    
    func efectoDerrota() {
        let path = Bundle.main.path(forResource: "perder", ofType: "mp3")!
        let url = URL(fileURLWithPath: path)

        do {
            efectoDos = try AVAudioPlayer(contentsOf: url)
            //efecto?.numberOfLoops = -1 // -1 para reproducir en bucle
            efectoDos?.prepareToPlay()
            efectoDos?.play()
        } catch {
            // Si ocurre un error al cargar el archivo de música, puedes imprimir un mensaje en la consola o mostrar una alerta al usuario
            print("La musica no se encuentra")
        }
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
    
    func reiniciarJuego() {
        miCarta = crearCarta()
        miCarta.shuffle()
        conteoReparto = 0
        manoJugador = []
        totalJugadorUno = 0
        lblJugadorUnoValor.text = "0"
        // Actualizar la interfaz gráfica para eliminar las cartas de la partida anterior
        for subview in view.subviews {
            if subview is UIImageView {
                subview.removeFromSuperview()
            }
        }
        self.tiempoTranscurrido = 0
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(actualizarTiempo), userInfo: nil, repeats: true)
    }
    
    @objc func actualizarTiempo() {
        tiempoTranscurrido += 1
        let minutos = tiempoTranscurrido / 60
        let segundos = tiempoTranscurrido % 60
        lblTiempo.text = String(format: "%02d:%02d", minutos, segundos)
    }
    
    func detenerTiempo() {
        tiempoTranscurrido = 0
        // Detener el temporizador
        if var timer = timer {
            timer.invalidate()
            

        }
    }
    

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        miCarta = crearCarta()
        miCarta.shuffle()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(actualizarTiempo), userInfo: nil, repeats: true)
        //victorias = UserDefaults.standard.integer(forKey: "victorias")
        
        if let nombreGuardado = UserDefaults.standard.string(forKey: "NombreGuardado") {
                    // Mostrar el nombre en el label
                    lblNombre.text = "Hola, \(nombreGuardado)!"
                }
        
        
    }

}
