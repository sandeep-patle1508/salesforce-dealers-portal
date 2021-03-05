namespace :salesforce do
  desc 'A rake task to synchronise local dealers with remote dealers data'
  task :sync_dealers do
    Salesforce::SyncDealers.new.call
  end
end
