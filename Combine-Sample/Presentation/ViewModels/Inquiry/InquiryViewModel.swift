//
//  NoCombineViewModel.swift
//  Combine-Sample
//
//  Created by Hiroaki-Hirabayashi on 2022/03/25.
//

import SwiftUI

final class InquiryViewModel: ObservableObject {
    static var maxCharacterLength: Int = 3000

    @Published var text = ""
    @Published var confirm = false
    @Published var send = false
    @Published var toTextCountValidation = false

    /// 問い合わせ送信
    /// - Returns: エラー有無: true, false, エラー文字列 (エラーなしはnil)
    func sendInquiry() -> (Bool, String?) {
        var err = false
        var result: String?
        // UseCase呼び出し

        return (err, result)
    }

    /// 電話をかける
    func callToInquiry() {
        let phoneNumber = "0120333310"
        guard let url = URL(string: "tel://" + phoneNumber) else { return }
        UIApplication.shared.open(url)
    }
}
