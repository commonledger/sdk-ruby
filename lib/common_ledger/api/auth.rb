module CommonLedger

  module Api

    # Using OAuth 2.0 to connect to Common Ledger
    #
    class Auth

      def initialize(client)
        @client = client
      end

      # After redirecting to /auth/authorise this endpoint will return an access token
      # '/auth/token' POST
      #
      # client_id - The application client_id
      # client_secret - The application client_secret
      # code - The code from the authorise request
      # redirect_url - The redirect_uri used to set up the application
      # grant_type - Either 'authorization_code' when requesting an access token, or 'refresh_token' when refreshing an old access token
      def token(client_id, client_secret, code, redirect_url, grant_type, options = {})
        body = options.has_key?(:body) ? options[:body] : {}
        body[:client_id] = client_id
        body[:client_secret] = client_secret
        body[:code] = code
        body[:redirect_url] = redirect_url
        body[:grant_type] = grant_type

        response = @client.post "/auth/token", body, options

        return response
      end

    end

  end

end
