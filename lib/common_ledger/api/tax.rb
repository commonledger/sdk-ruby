module CommonLedger

  module Api

    # Collection of different tax rates and their codes
    #
    # tax_id - The tax UUID
    class Tax

      def initialize(tax_id, client)
        @tax_id = tax_id
        @client = client
      end

      # Add a new tax rate
      # '/core.tax/add' POST
      #
      # organisation_id - The UUID of the organisation this tax rate belongs to
      # name - The name of this tax rate
      # type - The tax type (tax code)
      # display_rate - The rate to display this tax at
      # effective_rate - The rate that gets applied for this tax
      def add(organisation_id, name, type, display_rate, effective_rate, options = {})
        body = options.has_key?(:body) ? options[:body] : {}
        body[:organisation_id] = organisation_id
        body[:name] = name
        body[:type] = type
        body[:display_rate] = display_rate
        body[:effective_rate] = effective_rate

        response = @client.post "/core.tax/add", body, options

        return response
      end

      # View a tax rate
      # '/core.tax/view/:tax_id' GET
      #
      def view(options = {})
        body = options.has_key?(:query) ? options[:query] : {}

        response = @client.get "/core.tax/view/#{@tax_id}", body, options

        return response
      end

      # Update an existing tax rate
      # '/core.tax/update/:tax_id' POST
      #
      # organisation_id - The UUID of the organisation this tax rate belongs to
      # name - The name of this tax rate
      # type - The tax type (tax code)
      # display_rate - The rate to display this tax at
      # effective_rate - The rate that gets applied for this tax
      def update(organisation_id, name, type, display_rate, effective_rate, options = {})
        body = options.has_key?(:body) ? options[:body] : {}
        body[:organisation_id] = organisation_id
        body[:name] = name
        body[:type] = type
        body[:display_rate] = display_rate
        body[:effective_rate] = effective_rate

        response = @client.post "/core.tax/update/#{@tax_id}", body, options

        return response
      end

    end

  end

end
