//
//  ImagePickerButton.swift
//  Socialcademy
//
//  Created by Kenneth Oliver Rathbun on 11/10/23.
//

import Foundation
import SwiftUI

struct ImagePickerButton<Label : View>: View {
    @Binding var imageURL: URL?
    @ViewBuilder let label: () -> Label
    @State private var showImageSourceDialog = false
    @State private var sourceType: UIImagePickerController.SourceType?
    
    var body: some View {
        Button(action: {
            showImageSourceDialog = true
        }) {
            label()
        }
        .confirmationDialog("Choose Image", isPresented: $showImageSourceDialog) {
            Button("Choose from Library", action: {
                sourceType = .photoLibrary
            })
            
            Button("Take Photo", action: {
                sourceType = .camera
            })
            
            if imageURL != nil {
                Button("Remove Photo", role: .destructive, action: {
                    imageURL = nil
                })
            }
        }
    }
}

extension ImagePickerButton {
    struct ImagePickerView: UIViewControllerRepresentable {
        let sourceType: UIImagePickerController.SourceType
        let onSelect: (URL) -> Void
        
        @Environment(\.dismiss) var dismiss
        
        func makeCoordinator() -> ImagePickerCoordinator {
            return ImagePickerCoordinator(view: self)
        }
        
        func makeUIViewController(context: Context) -> UIImagePickerController {
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = true
            imagePicker.delegate = context.coordinator
            imagePicker.sourceType = sourceType
            return imagePicker
        }
        
        func updateUIViewController(_ imagePicker: UIImagePickerController, context: Context) {}
    }
    
    class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let view: ImagePickerView
        
        init(view: ImagePickerView) {
            self.view = view
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            guard let imageURL = info[.imageURL] as? URL else { return }
            view.onSelect(imageURL)
            view.dismiss()
        }
    }
}
