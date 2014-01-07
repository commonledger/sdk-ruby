module CommonLedger

  module Api

    # Manages data relating to the Chart of Accounts
    #
    # account_id - The account UUID
    class Accounts

      def initialize(account_id, client)
        @account_id = account_id
        @client = client
      end

      # Creates a new account in the chart of accounts
      # '/core.account/add' POST
      #
      # organisation_id - The organisation the account belongs to
      # account_number - The account code
      # name - The account name
      # classification - The account classification
      # type - The type of classification for the account
      # tax - The tax code that applies to the account
      # currency - The currency code that applies to the account
      def add(organisation_id, account_number, name, classification, type, tax, currency, options = {})
        body = options.has_key?(:body) ? options[:body] : {}
        body[:organisation_id] = organisation_id
        body[:account_number] = account_number
        body[:name] = name
        body[:classification] = classification
        body[:type] = type
        body[:tax] = tax
        body[:currency] = currency

        response = @client.post "/core.account/add", body, options

        return response
      end

      # 
      # '/core.account/view/:account_id' GET
      #
      def view(options = {})
        body = options.has_key?(:query) ? options[:query] : {}

        response = @client.get "/core.account/view/#{@account_id}", body, options

        return response
      end

      # Updates an existing account in the chart of accounts
      # '/core.account/update/:account_id' POST
      #
      # organisation_id - The organisation the account belongs to
      # account_number - The account code
      # name - The account name
      # classification - The account classification
      # type - The type of classification for the account
      # tax - The tax code that applies to the account
      # currency - The currency code that applies to the account
      def update(organisation_id, account_number, name, classification, type, tax, currency, options = {})
        body = options.has_key?(:body) ? options[:body] : {}
        body[:organisation_id] = organisation_id
        body[:account_number] = account_number
        body[:name] = name
        body[:classification] = classification
        body[:type] = type
        body[:tax] = tax
        body[:currency] = currency

        response = @client.post "/core.account/update/#{@account_id}", body, options

        return response
      end

      # Deletes an account from the chart of accounts
      # '/core.account/delete/:account_id' GET
      #
      def delete(options = {})
        body = options.has_key?(:query) ? options[:query] : {}

        response = @client.get "/core.account/delete/#{@account_id}", body, options

        return response
      end

    end

  end

end
