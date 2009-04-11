module MessagesHelper
  
  def message_line(message, link = true)
    line = "<b>#{message.subject}</b> - #{message.name} - <i title='#{(message.created_at).to_s(:crud)}'>#{distance_of_time_in_words_to_now(message.created_at)} ago</i>"
    if link
      return link_to(line, message_path(message.id))
    else
      return line
    end
  end
  
  def message_thread(message)
    output = ""
    message.thread.each do |message|
      
      message.depth.times do
        output += "<ul class='thread'>"
      end
      
      if @message
        link = (@message.id != message.id)
      else
        link = true
      end
      output += "<li>" + message_line(message, link) + "</li>"
      
      message.depth.times do
        output += "</ul>"
      end
      
    end
    
    return output
  end
  
end
