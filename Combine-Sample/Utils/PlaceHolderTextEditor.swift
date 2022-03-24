//
//  PlaceHolderTextEditor.swift
//  Combine-Sample
//
//  Created by Hiroaki-Hirabayashi on 2022/03/24.
//

import SwiftUI

struct PlaceHolderTextEditor: View {
    var placeholderText: String
    @Binding var text: String

    var body: some View {
        ZStack(alignment: .topLeading) {
            if text.isEmpty {
                Text(placeholderText)
                    .foregroundColor(.black)
                    .padding(.top, 24)
                    .padding(.leading, 16)
            }
            TextEditor(text: $text)
                .padding(.top)
                .frame(maxWidth: .infinity, maxHeight: 251)
        }
        .onAppear {
            UITextView.appearance().backgroundColor = .clear
        }
        .onDisappear {
            UITextView.appearance().backgroundColor = nil
        }
    }
}

