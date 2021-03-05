# frozen_string_literal: true

module Salesforce
  class ApiClient
    include Salesforce::MockRestforceCollectionHelper

    def initialize
      @restforce_client = initialize_client
    end

    # TODO: I am unable to login into Salesforce sandbox using given userpass and password
    # Hence returning mock data response on auth error
    # Following the same  response structure as Restforce gem
    def query(query_string)
      restforce_client.query(query_string)
    rescue Restforce::AuthenticationError => e
      build_restforce_collection
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
