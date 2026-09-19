//
//  TheNewsAPIApp.swift
//  TheNewsAPI
//
//  Created by Manyuchi, Carrington C on 2026/09/19.
//

import SwiftUI

@main
struct TheNewsAPIApp: App {
    var body: some Scene {
        DocumentGroup(newDocument: TheNewsAPIDocument()) { file in
            ContentView(document: file.$document)
        }
    }
}
