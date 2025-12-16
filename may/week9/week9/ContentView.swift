//
//  ContentView.swift
//  week9
//
//  Created by 백지은 on 12/14/25.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    //PhotosUI
    @State private var selectedItems: [PhotosPickerItem] = []
    @State private var selectedImages: [UIImage] = []
    
    //ImagePicker
    @State private var showImagePicker = false
    @State private var selectedPickerImages: [UIImage] = []
    
    
    //CameraPicker
    @State private var showCamera = false
    @State private var capturedImage: UIImage?

    //PhotosUI
    var body: some View {
        VStack(spacing: 20) {
            PhotosPicker("📁 사진 선택하기", selection: $selectedItems, maxSelectionCount: 5, matching: .images)

            ScrollView(.horizontal) {
                HStack {
                    ForEach(selectedImages, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipped()
                    }
                }
            }
        }
        .padding()
        .onChange(of: selectedItems) { oldItems, newItems in
            selectedImages.removeAll()
            for item in newItems {
                Task {
                    if let data = try? await item.loadTransferable(type: Data.self),
                       let image = UIImage(data: data) {
                        selectedImages.append(image)
                    }
                }
            }
        }
        
        Divider()
        
        //ImagePicker
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    ForEach(selectedPickerImages, id: \.self) { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                    }
                }
            }

            Button("앨범에서 사진 선택") {
                showImagePicker = true
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(images: $selectedPickerImages, selectedLimit: 5)
            }
        }
        
        Divider()
        
        //CameraPicker
        VStack(spacing: 20) {
                    if let image = capturedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 300)
                    } else {
                        Text("사진을 찍어보세요!")
                    }

                    Button("📷 카메라 열기") {
                        showCamera = true
                    }
                    .padding()
                    .sheet(isPresented: $showCamera) {
                        CameraPicker { image in
                            self.capturedImage = image
                        }
                    }
                }
                .padding()
    }
}

#Preview {
    ContentView()
}
