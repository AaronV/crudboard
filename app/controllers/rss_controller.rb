class RssController < ApplicationController
  
  def messages
    @messages = Message.find(:all, :order => 'created_at DESC', :limit => 50)
  end
  
end
