import Checkout

protocol PaymentViewModel {
  var checkoutAPIService: CheckoutAPIProtocol { get set }
  var billingFormData: BillingForm? { get set }
  var paymentFormStyle: PaymentFormStyle? { get set }
  var billingFormStyle: BillingFormStyle? { get set }
  var supportedSchemes: [Card.Scheme] { get set}
  var cardValidator: CardValidator { get set }
  var logger: FramesEventLogging { get }
  var updateEditBillingSummaryView: (() -> Void)? { get set }
  var updateAddBillingDetailsView: (() -> Void)? { get set }
  var updateExpiryDateView: (() -> Void)? { get set }
  var updateCardNumberView: (() -> Void)? { get set }
  var updateSecurityCodeViewScheme: ((Card.Scheme) -> Void)? { get set }
  var updateSecurityCodeViewStyle: (() -> Void)? { get set }
  var updatePayButtonView: (() -> Void)? { get set }
  var updateHeaderView: (() -> Void)? { get set }
  var shouldEnablePayButton: ((Bool) -> Void)? { get set }
  var cardTokenRequested: ((Result<TokenDetails, TokenisationError.TokenRequest>) -> Void)? { get set }
  func updateAll()
  func viewControllerWillAppear()
}
