//
//  ContentView.swift
//  PhotosPickerSandbox
//
//  Created by Zaid Neurothrone on 2022-12-16.
//

import PhotosUI
import SwiftUI

struct ContentView: View {
  @State private var selectedItem: PhotosPickerItem? = nil
  @State private var selectedImageData: Data? = nil
  
  var body: some View {
    VStack {
      PhotosPicker(
        selection: $selectedItem,
        matching: .images,
        photoLibrary: .shared()
      ) {
        Text("Select a photo")
      }
      .onChange(of: selectedItem) { newItem in
        Task {
          // Retrive selected asset in the form of Data
          if let data = try? await newItem?.loadTransferable(type: Data.self) {
            selectedImageData = data
          }
        }
      }
      
      if let selectedImageData,
         let uiImage = UIImage(data: selectedImageData) {
        Image(uiImage: uiImage)
          .resizable()
          .scaledToFit()
          .frame(width: 250, height: 250)
      }
      
      Spacer()
    }
    .padding()
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}

