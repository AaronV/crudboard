class Message < ActiveRecord::Base
  acts_as_tree :order => 'created_at'
  
  auto_html_for :message do
    html_escape
    image
    youtube :width => 500, :height => 300
    vimeo :width => 500, :height => 300
    link :target => "_blank", :rel => "nofollow"
    simple_format
  end
  
  attr_accessor :depth
  
  # Validations
  validates_presence_of :name, :subject, :message
  
  # Methods
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
