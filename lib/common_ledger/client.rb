require "faraday"
require "json"

require "common_ledger/api/accounts"

module CommonLedger

  class Client

    def initialize(auth = {}, options = {})
      @http_client = CommonLedger::HttpClient::HttpClient.new auth, options
    end

    # Manages data relating to the Chart of Accounts
    #
    # account_id - The account UUID
    def accounts(account_id)
      CommonLedger::Api::Accounts.new account_id, @http_client
    end

  end

end
