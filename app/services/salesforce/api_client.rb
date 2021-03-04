# frozen_string_literal: true

module Salesforce
  class ApiClient
    def initialize
      @restforce_client = initialize_client
    end

    def query(query_string)
      restforce_client.query(query_string)
    end

    private

    attr_reader :restforce_client

    def initialize_client
      Restforce.new(
        host: salesforce_credentials[:host],
        username: salesforce_credentials[:username],
        password: salesforce_credentials[:password],
        client_id: salesforce_credentials[:client_id],
        client_secret: salesforce_credentials[:client_secret])
    end

    def salesforce_credentials
      @salesforce_credentials ||= Rails.application.credentials[Rails.env.to_sym][:salesforce]
    end
  end
end
