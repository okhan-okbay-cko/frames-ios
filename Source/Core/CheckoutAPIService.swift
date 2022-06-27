//
//  CheckoutAPIService.swift
//  
//
//  Created by Harry Brown on 03/02/2022.
//

import Foundation
import Checkout
import CheckoutEventLoggerKit

protocol CheckoutAPIProtocol {
    var cardValidator: CardValidating { get }
    var logger: FramesEventLogging { get }
    func createToken(_ paymentSource: PaymentSource, completion: @escaping (Result<TokenDetails, TokenisationError.TokenRequest>) -> Void)
}

public class CheckoutAPIService: CheckoutAPIProtocol {

    let cardValidator: CardValidating
    let logger: FramesEventLogging
    private let checkoutAPIService: Checkout.CheckoutAPIProtocol

    public convenience init(publicKey: String, environment: Environment) {
        let checkoutAPIService = Checkout.CheckoutAPIService(publicKey: publicKey, environment: environment.checkoutEnvironment)
        let cardValidator = CardValidator(environment: environment.checkoutEnvironment)
        let logger = FramesEventLogger(environment: environment, getCorrelationID: { checkoutAPIService.correlationID })

        self.init(checkoutAPIService: checkoutAPIService, cardValidator: cardValidator, logger: logger)
    }

    init(checkoutAPIService: Checkout.CheckoutAPIProtocol, cardValidator: CardValidating, logger: FramesEventLogger) {
        self.checkoutAPIService = checkoutAPIService
        self.cardValidator = cardValidator
        self.logger = logger
    }

    public func createToken(_ paymentSource: PaymentSource, completion: @escaping (Result<TokenDetails, TokenisationError.TokenRequest>) -> Void) {
        checkoutAPIService.createToken(paymentSource, completion: completion)
    }
}