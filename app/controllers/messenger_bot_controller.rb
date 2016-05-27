class MessengerBotController < ActionController::Base
  def message(event, sender)
    # profile = sender.get_profile(field) # default field [:locale, :timezone, :gender, :first_name, :last_name, :profile_pic]
    if event['message']['text'] == "123"
      sender.reply({ text: "Reply: #{event['message']['text']}" })
    elsif event['message']['text'] == "456"
      sender.reply({ text: "從三小" })
    elsif event['message']['text'] == "link"
      link = Link.last
      sender.reply({ text: link.title + " / " + link.url })
    end
  end

  def delivery(event, sender)
  end

  def postback(event, sender)
    payload = event["postback"]["payload"]
    case payload
    when :something
      #ex) process sender.reply({text: "button click event!"})
    end
  end
end