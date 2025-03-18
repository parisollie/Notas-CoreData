//
//  addView.swift
//  Notas
//
//  Created by Paul Jaime Felix Flores on 19/04/23.
//

import SwiftUI

struct addView: View {
    //Paso 1.3 mandamos a llamar el ViewModel,con dos puntos decimos que el parámetro es viewmodel
    @ObservedObject var model : ViewModel

    //Paso 1.26
    @Environment(\.managedObjectContext) var context
    
    //V-107,paso 1.1
    var body: some View {
        VStack{
            /*
             //Paso 1.2
             Text("Agregar nota")
                .font(.largeTitle)
                .bold()*/
            
            //Paso 1.35,operador ternario
            Text(model.updateItem != nil ? "Editar nota" : "Agregar nota")
                            .font(.largeTitle)
                            .bold()
            Spacer()
            /*Paso 1.4, vamosa guardar en TextEditor esta variable todo lo que guardemos de nuestra nota ,$model.nota
             
             TextEditor , abarca toda la pantalla
             $model.nota, es la variable donde guardaremos nuestra nota
             
             */
            TextEditor(text: $model.nota)
            
            Divider()
            
            //Paso 1.5,Nos da la hora y la fecha.
            DatePicker("Seleccionar fecha", selection: $model.fecha)
            
            Spacer()
            
            //Paso 1.6
            Button(action:{
               
                //V-111,Paso 1.34 si tiene contenido ,podemos editar la nota
                if model.updateItem != nil {
                    model.editData(context: context)
                }else{
                    //V-108,paso 1.17
                    model.saveData(context: context)
                }
            }){
                //Paso 1.7, para el boton guardar de la nota
                Label(
                    title: { Text("Guardar").foregroundColor(.white).bold() },
                    icon: { Image(systemName: "plus").foregroundColor(.white) }
                )
            }
            .padding()
            //Paso 1.8 nos estira el espacio del boton guardar
            .frame(width: UIScreen.main.bounds.width - 30)
            
            /*
              Paso 1.9
             .background(Color.blue)
              Paso 1.37,sino escribimos nada se desactiva el botón*/
            .background(model.nota == "" ? Color.gray : Color.blue)
            .cornerRadius(8)
            
            //Paso 1.36,deshabilitar el boton,si esta vacio nos desactiva el true
            .disabled(model.nota == "" ? true : false)
            /*
            Text(model.updateItem != nil ? "Editar nota" : "Agregar nota")
            */
        }
        .padding()
    }
}

#Preview {
    addView(model: .preview)
}


