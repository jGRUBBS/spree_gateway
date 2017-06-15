module Spree
  class Gateway::SquareConnectGateway < Gateway

    preference :application_id, :string
    preference :access_token, :string
    preference :location_id, :string

    def provider_class
      ActiveMerchant::Billing::SquareConnectGateway
    end

    def payment_profiles_supported?
      # true
      false
    end

    def purchase(money, creditcard, gateway_options)
      provider.purchase(*options_for_purchase_or_auth(money, creditcard, gateway_options))
    end

    def authorize(money, creditcard, gateway_options)
      provider.authorize(*options_for_purchase_or_auth(money, creditcard, gateway_options))
    end

    def capture(money, response_code, gateway_options)
      provider.capture(money, response_code, gateway_options)
    end

    def credit(money, creditcard, response_code, gateway_options)
      provider.refund(money, response_code, {})
    end

    def void(response_code, creditcard, gateway_options)
      provider.void(response_code, {})
    end

    def cancel(response_code)
      provider.void(response_code, {})
    end

    # def create_profile(payment)
    # end

    private

    def options_for_purchase_or_auth(money, creditcard, gateway_options)
      options = gateway_options.merge(
        idempotency_key: SecureRandom.uuid,
        reference_id:    gateway_options[:order_id]
      )
      creditcard = creditcard.encrypted_data
      return money, creditcard, options
    end

  end
end
