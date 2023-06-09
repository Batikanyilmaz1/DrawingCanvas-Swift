//
//  ContentView.swift
//  draw3
//
//  Created by Batıkan Yılmaz on 17.12.2022.
//

import SwiftUI
import PencilKit

struct ContentView: View {
    var body: some View {
        Home()
    }
}

struct Home : View {
    @State var canvas = PKCanvasView()
    @State var isDraw = true
    
    var body: some View{
        
        NavigationView{
            //Drawing item
            DrawingView(canvas: $canvas, isDraw: $isDraw)
                .navigationTitle("Drawing")
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarItems(leading: Button(action: {
                    //saving image
                    SaveImage()
                    
                }, label: {
                    Image(systemName: "square.and.arrow.down.fill")
                        .font(.title)
                }),trailing: HStack(spacing: 15){
                   
                    Button(action: {
                        //erase tool...
                        
                        isDraw.toggle()
                        
                    }){
                        Image(systemName: "pencil.slash")
                            .font(.title)
                    }
                })
        }
    }
    func SaveImage(){
        //getting image from canvas
        let image = canvas.drawing.image(from: canvas.drawing.bounds, scale: 1)
  
        //saving to albums...
        
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
}

struct DrawingView : UIViewRepresentable {
    
    @Binding var canvas : PKCanvasView
    @Binding var isDraw : Bool
    
    let ink = PKInkingTool(.pencil, color: .black)
    let eraser = PKEraserTool(.bitmap)
    
    func makeUIView(context: Context) -> PKCanvasView {
        
        canvas.drawingPolicy = .anyInput
        
        canvas.tool = isDraw ? ink : eraser
        
        return canvas
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context){
        
        //updating tool whenever main view updates...
        
        uiView.tool = isDraw ? ink : eraser
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
