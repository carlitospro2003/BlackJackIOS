//
//  singleton.swift
//  JuegoBlackJack
//
//  Created by imac on 22/04/23.
//

import Foundation

class contadorVictorias:
    _instance = None
    
    def __init__(self):
        self.victories = 0
    
    @classmethod
    def get_instance(cls):
        if cls._instance is None:
            cls._instance = VictoryCounter()
        return cls._instance
