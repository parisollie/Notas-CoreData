//
//  addView.swift
//  Notas
//
//  Created by Paul Jaime Felix Flores on 19/04/23.
//

import SwiftUI

struct addView: View {
    // Paso 1.3 mandamos a llamar el ViewModel,con dos puntos decimos que el parámetro es viewmodel
    @ObservedObject var model : ViewModel

    // Paso 2.5
    @Environment(\.managedObjectContext) var context
    
    //V-107,paso 1.1
    var body: some View {
        VStack{
            // Paso 1.2, ponemos agregar Nota
            // Paso 4.5 ,operador ternario
            Text(model.updateItem != nil ? "Editar nota" : "Agregar nota")
                            .font(.largeTitle)
                            .bold()
            Spacer()
            /*
               Paso 1.4, vamosa guardar en TextEditor
               esta variable todo lo que guardemos de
               nuestra nota ,$model.nota
             
               TextEditor , abarca toda la pantalla
               $model.nota, es la variable donde
               guardaremos nuestra nota
             
             */
            TextEditor(text: $model.nota)
            
            Divider()
            
            // Paso 1.5,Nos da la hora y la fecha.
            DatePicker("Seleccionar fecha", selection: $model.fecha)
            
            Spacer()
            
            // Paso 1.6
            Button(action:{
               
                // Paso 4.4 si tiene contenido ,podemos editar la nota
                if model.updateItem != nil {
                    model.editData(context: context)
                }else{
                    // Paso 2.6, le mandamos el context del environment
                    model.saveData(context: context)
                }
            }){
                // Paso 1.7, para el botón guardar de la nota
                Label(
                    title: { Text("Guardar").foregroundColor(.white).bold() },
                    icon: { Image(systemName: "plus").foregroundColor(.white) }
                )
            }
            .padding()
            // Paso 1.8 nos estira el espacio del botón guardar
            .frame(width: UIScreen.main.bounds.width - 30)
            
            /*
              Paso 1.9
             .background(Color.blue)
              Paso 4.7,sino escribimos nada se desactiva el botón ponemos ternario
             */
            .background(model.nota == "" ? Color.gray : Color.blue)
            .cornerRadius(8)
            
            //Paso 4.6,deshabilitar el botón,si esta vacío nos desactiva el true
            .disabled(model.nota == "" ? true : false)
        }
        .padding()
    }
}

#Preview {
    addView(model: .preview)
}


