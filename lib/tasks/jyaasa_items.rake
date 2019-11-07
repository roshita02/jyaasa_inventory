namespace :db do
  namespace :seed do
    Dir[Rails.root.join('preset_items', '*.rb')].each do |items_seed|
      task_name = File.basename(items_seed, '.rb')
      desc 'Seed ' + task_name
      task task_name.to_sym => :environment do
        load(items_seed) if File.exist?(items_seed)
      end
    end
  end
end
