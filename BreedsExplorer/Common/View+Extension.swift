//
//  View+Extension.swift
//  BreedsExplorer
//
//  Created by Antonio Rodrigues on 01/01/2023.
//

import SwiftUI

extension View {

    func setupErrorAlert(with isBeingPresented: Binding<Bool>,
                         error: BreedsRequestError,
                         retryAction: @escaping () -> Void) -> some View {

        @ViewBuilder
        var buttons: some View {
            Button(role: .cancel) {
            } label: {
                Text(String.dismiss)
            }
            Button(String.retry) {
                retryAction()
            }
        }

        return self.alert(String.title,
                          isPresented: isBeingPresented,
                          presenting: error,
                          actions: { _ in buttons},
                          message: { error in Text(error.message) })
    }
}

private extension String {

    static let title = "Oops, something went wrong"
    static let dismiss = "Dismiss"
    static let retry = "Retry"
}
