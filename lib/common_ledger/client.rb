require "faraday"
require "json"

require "common_ledger/api/accounts"
require "common_ledger/api/tax"
require "common_ledger/api/journals"

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

    # Collection of different tax rates and their codes
    #
    # tax_id - The tax UUID
    def tax(tax_id)
      CommonLedger::Api::Tax.new tax_id, @http_client
    end

    # Manages journal entries and journal lines
    #
    # journal_id - The journal entry UUID
    def journals(journal_id)
      CommonLedger::Api::Journals.new journal_id, @http_client
    end

  end

end
