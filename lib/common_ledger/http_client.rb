require "common_ledger/http_client/auth_handler"
require "common_ledger/http_client/error_handler"
require "common_ledger/http_client/request_handler"
require "common_ledger/http_client/response"
require "common_ledger/http_client/response_handler"

module CommonLedger

  module HttpClient

    # Main HttpClient which is used by Api classes
    class HttpClient

      attr_accessor :options, :headers

      @headers = {}

      def initialize(auth = {}, options = {})

        if auth.is_a? String
          auth = { :access_token => auth }
        end

        @options = {
          :base => "http://sandbox.api.commonledger.com",
          :api_version => "v1",
          :user_agent => "alpaca/0.1.0 (https://github.com/pksunkara/alpaca)"
        }

        @options.update options

        @headers = {
          "user-agent" => @options[:user_agent]
        }

        if @options.has_key? :headers
          @headers.update Hash[@options[:headers].map { |k, v| [k.downcase, v] }]
          @options.delete :headers
        end

        @client = Faraday.new @options[:base] do |conn|
          conn.use CommonLedger::HttpClient::AuthHandler, auth
          conn.use CommonLedger::HttpClient::ErrorHandler

          conn.adapter Faraday.default_adapter
        end
      end

      def get(path, params = {}, options = {})
        request path, nil, "get", options.merge({ :query => params })
      end

      def post(path, body = {}, options = {})
        request path, body, "post", options
      end

      def patch(path, body = {}, options = {})
        request path, body, "patch", options
      end

      def delete(path, body = {}, options = {})
        request path, body, "delete", options
      end

      def put(path, body = {}, options = {})
        request path, body, "put", options
      end

      # Intermediate function which does three main things
      #
      # - Transforms the body of request into correct format
      # - Creates the requests with give parameters
      # - Returns response body after parsing it into correct format
      def request(path, body, method, options)
        options = @options.merge options

        options[:headers] = options[:headers] || {}
        options[:headers] = @headers.merge Hash[options[:headers].map { |k, v| [k.downcase, v] }]

        options[:body] = body

        if method != "get"
          options[:body] = options[:body] || {}
          options = set_body options
        end

        response = create_request method, path, options

        body = get_body response

        CommonLedger::HttpClient::Response.new body, response.status, response.headers
      end

      # Creating a request with the given arguments
      #
      # If api_version is set, appends it immediately after host
      def create_request(method, path, options)
        version = options.has_key?(:api_version) ? "/#{options[:api_version]}" : ""

        path = "#{version}#{path}"

        instance_eval <<-RUBY, __FILE__, __LINE__ + 1
          @client.#{method} path do |req|
            req.body = options[:body]
            req.headers.update(options[:headers])
            req.params.update(options[:query]) if options[:query]
          end
        RUBY
      end

      # Get response body in correct format
      def get_body(response)
        CommonLedger::HttpClient::ResponseHandler.get_body response
      end

      # Set request body in correct format
      def set_body(options)
        CommonLedger::HttpClient::RequestHandler.set_body options
      end

    end

  end

end
