namespace :salesforce do
  desc 'A rake task to synchronise local dealers with remote dealers data'
  task sync_dealers: :environment do
    puts "Sync process started. Before count of dealers: #{Dealer.count}"
    Salesforce::SyncDealers.new.call
    puts "Sync process finished. After count of dealers: #{Dealer.count}"
  end
end
