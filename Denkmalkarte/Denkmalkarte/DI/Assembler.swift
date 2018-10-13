//
//  AppAsembler.swift
//  Denkmalkarte
//
//  Created by Konstantin Kochetov on 13.10.18.
//  Copyright © 2018 htw.berlin. All rights reserved.
//

import Foundation

protocol Assembler {
    func resolve() -> MapUseCases
}

class AppAssembler: Assembler {
    
    func resolve() -> MapUseCases {
        return MapInteractor(dbHelper: DbHelperImpl(), apiHelper: ApiHelperImpl())
    }
    
}
