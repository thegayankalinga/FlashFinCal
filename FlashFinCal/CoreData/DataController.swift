//
//  DataController.swift
//  FlashFinCal
//
//  Created by Gayan Kalinga on 2023-07-30.
//
import CoreData
import Foundation

class DataController: ObservableObject{
    
    //Data Models
    let container = NSPersistentContainer(name: "FlashFinCal")
    
    
    //Load Data
    init(){
        container.loadPersistentStores{ description, error in
            
            if let error = error{
                print("Core data failed to load: \(error.localizedDescription)")
            }
            
        }
    }
    
    
}
