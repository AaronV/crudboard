class Message < ActiveRecord::Base
  acts_as_tree :order => 'created_at'
  
  attr_accessor :depth
  
  # Validations
  validates_presence_of :name, :subject, :message
  
  # Methods
  def formatted_message
    m = self.message
    
    # link_regex = /(http[:\/\w\.\?\=\&-^\t]+)/
    
    # temp_message = self.message
    # while temp_message =~ link_regex
    #   found = $&
    #   if FileExt.images.include?(found.split('.').last)
    #     logger.warn("IMAGE FOUND")
    #     m.gsub!(found, "<img src='#{found}' />")
    #   # else
    #   #   logger.warn("URL FOUND")
    #   #   m.gsub!(found, "<a href='#{found}' target='new'>#{found}</a>")
    #   end
    #   temp_message = $'
    # end
    
    # add returns
    m.gsub!(/\r\n/, ' <br/> ')
    
    return m
  end
  
  def re_subject
    re = self.subject.match(/^Re:\s/).to_a
    if re.size == 0
      return "Re: " + self.subject
    else
      return self.subject
    end
  end
  
  def thread(thread=[])
    # assume thread.empty? means the first call to this method
    if thread.empty?
      message = self.root
      thread << message
    else
      message = self
    end
    thread.concat(message.children)
    message.children.map{|child| child.thread(thread)}
    return thread
  end
  
  def depth
    self.ancestors.size
  end
  
end
