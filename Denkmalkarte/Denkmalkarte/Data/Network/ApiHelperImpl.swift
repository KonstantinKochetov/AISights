//
//  ApiHelper.swift
//  Denkmalkarte
//
//  Created by Konstantin Kochetov on 13.10.18.
//  Copyright © 2018 htw.berlin. All rights reserved.
//


class ApiHelperImpl: ApiHelper {
    
    func getMapData(success: @escaping (String)->(),
                    failure: @escaping (Error)->()) {
        // mocking
        success("map data from api")
    }
    
}
