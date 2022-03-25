//
//  CombineViewModel.swift
//  Combine-Sample
//
//  Created by Hiroaki-Hirabayashi on 2022/03/18.
//

import Foundation
import Combine

class CombineViewModel: ObservableObject {
    // 入力メールアドレス
    @Published var mail = ""
    // 入力パスワード
    @Published var pass = ""
    // 入力確認パスワード
    @Published var retype = ""
    //
    @Published var canSend = false
    // 無効メールアドレス時のエラーメッセージ
    @Published var invalidMail = ""
    // 無効パスワード時のエラーメッセージ
    @Published var invalidPass = ""
    
    private var subscriptions: Set<AnyCancellable> = .init()
    
    init() {
        // メールアドレス入力判定
        let mailValidation = $mail.map({ !$0.isEmpty && $0.isValidMailStyle }).eraseToAnyPublisher()
        // パスワード入力判定
        let passValidation = $pass.map({ !$0.isEmpty }).eraseToAnyPublisher()
        // 確認用パスワード入力判定
        let retypeValidation = $retype.map({ !$0.isEmpty }).eraseToAnyPublisher()
        // パスワードと確認用パスワードの整合判定
        let matchValidation = $pass.combineLatest($retype).map({ $0 == $1 }).eraseToAnyPublisher()
        
        Publishers.CombineLatest4(mailValidation, passValidation, retypeValidation, matchValidation)
            .map({ [$0.0, $0.1, $0.2, $0.3] })
            .map({ $0.allSatisfy { $0 } })
            .assign(to: &$canSend)
        // メールアドレス入力判定
        $mail.map({ $0.isEmpty || $0.isValidMailStyle ? "" : "有効なメールアドレスを入力してください" }).assign(to: &$invalidMail)
        
        $pass.combineLatest($retype)
            .filter({ !$0.1.isEmpty && !$0.1.isEmpty })
            .map({ $0.0 == $0.1 ? "" : "パスワードが違います" })
            .assign(to: &$invalidPass)
        
    }
    
}

extension String {
    
    var isValidMailStyle: Bool {
        let emailRegEx = "[A-Z0-9a-z._+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
     }
    
}
