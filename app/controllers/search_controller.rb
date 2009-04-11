class SearchController < ApplicationController
  helper 'messages'
  layout 'messages'
  
  def index
    @search_message = Message.new(params[:message])
    
    if params[:message]
      message = params[:message]
      
      search_string = Hash.new
      search_string[:name]       = message[:name] if !message[:name].blank?
      search_string[:subject]    = message[:subject] if !message[:subject].blank?
      search_string[:host]       = message[:host] if !message[:host].blank?
      search_string[:message]    = message[:message] if !message[:message].blank?
      search_string = search_string.map{|k,v| "#{k} LIKE '%#{v}%'"}.join(" AND ")
      
      @messages = Message.find(:all, :conditions => search_string, :order => "created_at DESC")
    end
  end
  
end
