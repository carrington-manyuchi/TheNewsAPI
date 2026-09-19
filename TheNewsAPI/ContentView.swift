//
//  ContentView.swift
//  TheNewsAPI
//
//  Created by Manyuchi, Carrington C on 2026/09/19.
//

import SwiftUI

struct ContentView: View {
    @Binding var document: TheNewsAPIDocument

    var body: some View {
        TextEditor(text: $document.text)
    }
}

#Preview {
    ContentView(document: .constant(TheNewsAPIDocument()))
}
