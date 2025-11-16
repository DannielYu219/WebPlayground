//
//  Picker.swift
//  HTMLPG
//
//  Created by Daniel www on 2025/1/29.
//
import SwiftUI
import UniformTypeIdentifiers

struct DocumentPicker1: UIViewControllerRepresentable {
    @Binding var fileContent: String
    
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.html], asCopy: true)
        documentPicker.delegate = context.coordinator
        return documentPicker
    }

    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIDocumentPickerDelegate {
        var parent: DocumentPicker1

        init(_ parent: DocumentPicker1) {
            self.parent = parent
        }

        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            guard let url = urls.first else { return }
            do {
                let data = try Data(contentsOf: url)
                if let htmlString = String(data: data, encoding: .utf8) {
                    parent.fileContent = htmlString
                }
            } catch {
                print("Failed to read file: \(error)")
            }
        }

        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            print("Document picker was cancelled")
        }
    }
}


// 在文件选择后处理沙盒写入
