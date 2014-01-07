module CommonLedger

  module Api

    # Manages journal entries and journal lines
    #
    # journal_id - The journal entry UUID
    class Journals

      def initialize(journal_id, client)
        @journal_id = journal_id
        @client = client
      end

      # Add a new journal entry
      # '/core.journal/add' POST
      #
      # organisation_id - The UUID of the organisation this journal entry belongs to
      # journal_number - The journal number this journal entry belongs to
      # journal_type - The type of journal entry this is
      # datetime - The timestamp this journal entry was recorded
      # notes - Any notes this journal entry has
      # lines - An array of journal lines that make up this journal entry
      def add(organisation_id, journal_number, journal_type, datetime, notes, lines, options = {})
        body = options.has_key?(:body) ? options[:body] : {}
        body[:organisation_id] = organisation_id
        body[:journal_number] = journal_number
        body[:journal_type] = journal_type
        body[:datetime] = datetime
        body[:notes] = notes
        body[:lines] = lines

        response = @client.post "/core.journal/add", body, options

        return response
      end

      # View a journal entry
      # '/core.journal/view/:journal_id' GET
      #
      def view(options = {})
        body = options.has_key?(:query) ? options[:query] : {}

        response = @client.get "/core.journal/view/#{@journal_id}", body, options

        return response
      end

      # Add a new journal entry
      # '/core.journal/update/:journal_id' POST
      #
      # organisation_id - The UUID of the organisation this journal entry belongs to
      # journal_number - The journal number this journal entry belongs to
      # journal_type - The type of journal entry this is
      # datetime - The timestamp this journal entry was recorded
      # notes - Any notes this journal entry has
      # lines - An array of journal lines that make up this journal entry
      def update(organisation_id, journal_number, journal_type, datetime, notes, lines, options = {})
        body = options.has_key?(:body) ? options[:body] : {}
        body[:organisation_id] = organisation_id
        body[:journal_number] = journal_number
        body[:journal_type] = journal_type
        body[:datetime] = datetime
        body[:notes] = notes
        body[:lines] = lines

        response = @client.post "/core.journal/update/#{@journal_id}", body, options

        return response
      end

    end

  end

end
