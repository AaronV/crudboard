# Regular Expression console testing method
def show_regexp(a, re)
  if a =~ re
    "#{$`}<<#{$&}>>#{$'}"
  else
    "no match"
  end
end

class ApplicationController < ActionController::Base
  # Disable sessions for robots, only do this if testing is worked out (p.472 The Rails Way)
  # session :off, :if => lambda {|req| req.user_agent =~ /(Google|Slurp)/i}
  
  before_filter :adjust_format_for_iphone
  
  helper_method :iphone_user_agent?
  
  protected
  
  def adjust_format_for_iphone
    # Detect from iPhone user-agent
    request.format = :iphone if iphone_user_agent?
  end
  
  # Request from an iPhone or iPod touch?
  # (Mobile Safari user agent)
  def iphone_user_agent?
    (cookies[:iphone] == 'true') || 
    (request.env["HTTP_USER_AGENT"] && request.env["HTTP_USER_AGENT"][/(Mobile\/.+Safari)/] && cookies[:iphone] != 'false')
  end
  
end
