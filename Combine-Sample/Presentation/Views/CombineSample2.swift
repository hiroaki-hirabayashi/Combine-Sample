//
//  CombineSample2.swift
//  Combine-Sample
//
//  Created by Hiroaki-Hirabayashi on 2022/03/18.
//

import SwiftUI

struct CombineSample2: View {
    
    @ObservedObject var viewModel: CombineViewModel = .init()
    var text = ""
    var body: some View {
        VStack {
            VStack(spacing: 20) {
                TextField.init("メールアドレス", text: self.$viewModel.mail)
                    .textContentType(.emailAddress)
                    .autocapitalization(.none)
                if !self.viewModel.invalidMail.isEmpty {
                    Text(self.viewModel.invalidMail)
                        .foregroundColor(.red)
                        .font(.footnote)
                        .fixedSize()
                }
                SecureField.init("パスワード", text: self.$viewModel.pass)
                    .textContentType(.newPassword)
                
                SecureField.init("パスワード確認", text: self.$viewModel.retype)
                    .textContentType(.newPassword)
                
                if !self.viewModel.invalidPass.isEmpty {
                    Text(self.viewModel.invalidPass)
                        .foregroundColor(.red)
                        .font(.footnote)
                }
                Button("登録") {
                    debugPrint("register")
                }
                .disabled(!self.viewModel.canSend)
                .foregroundColor(self.viewModel.canSend ? .gray : .blue)
                
                Spacer()
            }
            
            
        }
        .padding()
        .textFieldStyle(RoundedBorderTextFieldStyle())
    }
}

struct CombineSample2_Previews: PreviewProvider {
    static var previews: some View {
        CombineSample2(viewModel: .init())
    }
}

