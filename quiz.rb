require 'slack-ruby-client'
require 'active_record'
require 'yaml'

Dir[File.expand_path('../../app/models', __FILE__) << '/*.rb'].each do |file|
  require file
end
config = YAML.load_file('./config/database.yml')
ActiveRecord::Base.establish_connection(config['development'])

Slack.configure do |conf|
  conf.token = 'xoxb-122337496247-IR5Gox1VwwPH1UHr9tIx61Is'
end

client = Slack::RealTime::Client.new

client.on :hello do
  puts 'connected!'
end

client.on :message do |data|
  case data['text']
  when 'test'
    class Engineer < ActiveRecord::Base
      p @e = Engineer.first.last_name
    end
  end
end

client.start!
