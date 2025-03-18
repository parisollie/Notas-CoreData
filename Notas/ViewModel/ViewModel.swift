//
//  ViewModel.swift
//  Notas
//
//  Created by Paul Jaime Felix Flores on 19/04/23.
//


import Foundation
import CoreData
import SwiftUI

class ViewModel: ObservableObject {
    //V-106,paso 1.0
    @Published var nota = ""
    @Published var fecha = Date()
    //Para poder cerrar una ventana modal
    @Published var show = false
    
    //V-111,paso 1.30
    @Published var updateItem : Notas!
    //@Published var tipo = ""
    
    //--------------------------------------Mis funciones ------------------------------------------
    
    // V-108,Paso 1.16,CoreData, Función Para salvar nota.
    func saveData(context: NSManagedObjectContext){
        //Código para guardar
        let newNota = Notas(context: context)
        //Accedemos los atributos de nuestra entidad,es igual a la nota que estamos usando en la vista
        newNota.nota = nota
        newNota.fecha = fecha
        
        //Para guardar se usa un Do-Catch es obligatorio.
        do {
            try context.save()
            print("guardo")
            //Para que haga false o true y nos regrese la ventana modal
            show.toggle()
        } catch let error as NSError {
            // alerta al usario,print para programadores-localizedDescription
            print("No guardo", error.localizedDescription)
        }
    }
    
  
    
    //V-110,paso 1.25 Función para Eliminar datos( es la cpsa mas sencilla en un CRUD)
    func deleteData(item:Notas,context: NSManagedObjectContext){
        //Eliminamos el contexto
        context.delete(item)
        //Do-catch en una sola linea ,pero no es correcto hacerlo
        //try! context.save()
        do {
            try context.save()
            print("Elimino")
        } catch let error as NSError {
            // alerta al usario
            print("No elimino", error.localizedDescription)
        }
    }
    
    //Paso 1.31, función para enviar los datos
    func sendData(item: Notas){
        updateItem = item
        //Igualamos los datos que tienen en la base de datos
        nota = item.nota ?? ""
        fecha = item.fecha ?? Date()
        //Abrimos la ventana modal
        show.toggle()
    }
    
    //Paso 1.33,actualizamos nuestra nota
    func editData(context: NSManagedObjectContext){
        updateItem.fecha = fecha
        updateItem.nota = nota
        do {
            try context.save()
            print("edito")
            show.toggle()
        } catch let error as NSError {
            print("No edito", error.localizedDescription)
        }
    }
}//Fin observable.


//para el preview de addView
extension ViewModel {
    static var preview: ViewModel {
        let model = ViewModel()
        model.nota = "Nota de ejemplo"
        model.fecha = Date()
        return model
    }
}
