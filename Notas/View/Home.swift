//
//  Home.swift
//  Notas
//
//  Created by Paul Jaime Felix Flores on 19/04/23.
//

import Foundation
import SwiftUI

struct Home: View {
    /*
       Paso 2.0,mandamos a llamar el viewModel.
       le ponemos StateObject para que no se no
       resete, como es vista principal le ponemos el (=)
       si fuera otra vista le pondriamos (:) para que
       reciba parámetro.
    */
    @StateObject var model = ViewModel()
    // Paso 3.1, contexto para ponerlo en el botón
    @Environment(\.managedObjectContext) var context
    
    /*
      Paso 2.10
      Para que nos muestre los resultados usamos el
      @FetchRequest
      Nos pide la entidad que es Notas
      sortdescriptrion ->  es el ordenamiento
      Código para traer nuestros datos
      
    */
   
    @FetchRequest(entity:Notas.entity(),sortDescriptors: [],
                  
                  /*
                   - Esto para que nos ponga notas que
                   empiecen con eso
                   (format: "nota BEGINSWITH 'IMPORTANTE'")
                   
                   V-112,paso 5.0
                   
                   Los predicados son una condición
                   dentro de una consulta o
                   Fetchrequest.
                   
                   Ponemos el predicado ->
                   predicate:NSPredicate(format: "fecha >= %@",Date()as CVarArg)
                  */
                  predicate:NSPredicate(format: "fecha >= %@",Date()as CVarArg),animation: .spring()) var results : FetchedResults<Notas>
    
    
    var body: some View {
        //V-109, Paso 2.7
        NavigationView{
            List{
                // Paso 2.11,Para mostrar los datos usamos un ForEach
                ForEach(results){ item in
                    VStack(alignment: .leading){
                        // Paso 2.12 dato por defecto ??
                        Text(item.nota ?? "Sin nota")
                            .font(.title)
                            .bold()
                        Text(item.fecha ?? Date(), style: .date)
                    }//:V-STACK
                    // Paso 3.2, le ponemos esto para que salga un menú contextual , al dar un tap sostenido.
                    .contextMenu(ContextMenu(menuItems: {
                        
                        // Botón Editar
                        Button(action:{
                            // Paso 4.2 enviamos los datos para poder editar
                            model.sendData(item: item)
                            print("editar")
                        }){
                            //Paso 3.3
                            Label(title:{
                                Text("Editar")
                            }, icon:{
                                Image(systemName: "pencil")
                            })
                        }
                        
                        // Paso 3.4,Botón eliminar
                        Button(action:{
                            // Paso 3.5
                            model.deleteData(item: item, context: context)
                        }){
                            Label(title:{
                                Text("Eliminar")
                            }, icon:{
                                Image(systemName: "trash")
                            })
                        }//Button
                        
                    }))
                }//:ForEach
            }//:List
            // Paso 2.8
            .navigationBarTitle("Notas")
            .navigationBarItems(trailing:
                                    Button(action:{
                // Paso 2.3
                model.show.toggle()
            }){
                // Paso 2.9
                Image(systemName: "plus")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
            }
            )//:NavigationbarItems
            // Paso 2.1,traemos nuestro model
            .sheet(isPresented: $model.show, content: {
                //Paso 2.2
                addView(model: model)
            })
        }//:NavigationView
    }
}

#Preview{
    Home()
}
