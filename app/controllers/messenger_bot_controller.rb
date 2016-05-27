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
    elsif event['message']['text'] == "button"
      sender.reply({
        "attachment": {
              "type": "template",
              "payload": {
                "template_type": "generic",
                "elements": [{
                  "title": "First card",
                  "subtitle": "Element #1 of an hscroll",
                  "image_url": "http://messengerdemo.parseapp.com/img/rift.png",
                  "buttons": [{
                    "type": "web_url",
                    "url": "https://www.messenger.com/",
                    "title": "Web url"
                  }, {
                    "type": "postback",
                    "title": "Postback",
                    "payload": "Payload for first element in a generic bubble",
                  }],
                },{
                  "title": "Second card",
                  "subtitle": "Element #2 of an hscroll",
                  "image_url": "http://messengerdemo.parseapp.com/img/gearvr.png",
                  "buttons": [{
                    "type": "postback",
                    "title": "Postback",
                    "payload": "Payload for second element in a generic bubble",
                  }],
                }]
              }
            }
        })
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