class QuizController
require 'slack-ruby-client'
require 'active_record'
require 'yaml'

Dir[File.expand_path('../../app/models', __FILE__) << '/*.rb'].each do |file|
  require file
end
config = YAML.load_file('./config/database.yml')
ActiveRecord::Base.establish_connection(config['development'])

Slack.configure do |conf|
  conf.token = ''
end

client = Slack::RealTime::Client.new

client.on :hello do
  puts 'connected!'
  client.message channel: 'C3JUFFWD7',
  text: 'Welcome to engineer quiz channel!!
  このchannelでは少しでも早く、多くのFiNCエンジニアの名前を覚えてもらうために
  ランダムで社員、インターン生の写真から名前を当ててもらうクイズが出題されます！
  苗字または呼び名をアルファベットで答えてください。
  それでは *start* で始めましょう!!'
end

client.on :message do |data|
  if data['text'] === 'start'
    class Engineer < ActiveRecord::Base
    end
    @answer = Engineer.order("RAND()").first
    client.message channel: data['channel'], text: "#{@answer.image}"

    client.on :message do |data2|
      if data2['text'] === "#{@answer.nickname}" || data2['text'] === "#{@answer.last_name}"
        client.message channel: data2['channel'], text: "#{@answer.image}""{ 正解！！！！！)""\n""#{@answer.department}""として主に働いています。""\n""#{@answer.last_name}""さんについてもっと知りたい人はこちら:point_right:""#{@answer.fincchans}""\n"":octopus: *start* でもう一回クイズにチャレンジ！:octopus:"
        break
      end
      if data2['text'] != "#{@answer.nickname}" && data2['text'] != "#{@answer.last_name}" && data2['text'] != data['text'] && data2['subtype'] != 'bot_message' && data2['text'] != nil
        client.message channel: data2['channel'], text: "#{@answer.image}""{ 違うよ！)""\n""これを見てもっと勉強しましょう:point_right:""#{@answer.fincchans}"
        break
      end
    end
  end
end

client.start!
end
