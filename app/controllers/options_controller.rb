class OptionsController < ApplicationController
  helper_method :cookies
  
  layout "messages"
  
  def index
    
  end
  
  def set_view
    cookies[:view] = {:value => params[:id], :expires => Time.now.next_month}
    redirect_to messages_path
  end
  
  def set_theme
    cookies[:theme] = {:value => params[:id], :expires => Time.now.next_month}
    redirect_to :action => 'index'
  end
  
  def iphone
    cookies[:iphone] = {:value => params[:id], :expires => Time.now.next_month}
    redirect_to messages_path
  end
  
end
