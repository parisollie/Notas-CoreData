//
//  Home.swift
//  Notas
//
//  Created by Paul Jaime Felix Flores on 19/04/23.
//

import Foundation
import SwiftUI

struct Home: View {
    //Paso 1.11,mandamos a llamar el viewModel.
    @StateObject var model = ViewModel()
    //PASO 1.18
    @Environment(\.managedObjectContext) var context
    
    /*
      Paso 1.22
      sortdescriptrion es el ordenamiento
      Código para traer nuestros datos
      
     @FetchRequest(entity: Notas.entity(), sortDescriptors: [NSSortDescriptor(key: "fecha", ascending: true)], animation: .spring()) var results : FetchedResults<Notas>*/
    
    
    //V-112,paso 2.0 ponemos el predicado
    @FetchRequest(entity:Notas.entity(),sortDescriptors: [],
                  //(format: "nota BEGINSWITH 'IMPORTANTE'")
                  predicate:NSPredicate(format: "fecha >= %@",Date()as CVarArg),animation: .spring()) var results : FetchedResults<Notas>
    
    
    var body: some View {
        //Paso 1.19
        NavigationView{
    
            List{
                //Paso 1.23,Para mostrar los datos usamos un for each
                ForEach(results){ item in
                    VStack(alignment: .leading){
                        //paso 1.24 dato por defecto ??
                        Text(item.nota ?? "Sin nota")
                            .font(.title)
                            .bold()
                        Text(item.fecha ?? Date(), style: .date)
                        //V-110
                    }
                    //Paso 1.27
                    .contextMenu(ContextMenu(menuItems: {
                        Button(action:{
                            //V-111,Paso 1.32 enviamos los datos para poder editar
                            model.sendData(item: item)
                            //V-112
                            print("editar")
                        }){
                            //Paso 1.28
                            Label(title:{
                                Text("Editar")
                            }, icon:{
                                Image(systemName: "pencil")
                            })
                        }
                        //Paso 1.29,Boton eliminar
                        Button(action:{
                            model.deleteData(item: item, context: context)
                        }){
                            Label(title:{
                                Text("Eliminar")
                            }, icon:{
                                Image(systemName: "trash")
                            })
                        }
                    }))
                }
                
            }
            //Paso 1.20
            .navigationBarTitle("Notas")
            .navigationBarItems(trailing:
                                    Button(action:{
                //Paso 1.14
                model.show.toggle()
            }){
                //Paso 1.21
                Image(systemName: "plus")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            }
            //Paso 1.12,traemos nuestro model
            ).sheet(isPresented: $model.show, content: {
                //Paso 1.13
                addView(model: model)
            })
        }
    }
}

#Preview{
    Home()
}
