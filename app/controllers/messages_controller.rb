class MessagesController < ApplicationController
  require 'resolv'
  helper_method :cookies
  
  layout 'messages'
  
  # GET /messages
  # GET /messages.xml
  def index
    if cookies[:view] == 'thread'
      @messages = Message.paginate(:page => params[:page], :per_page => 20, :conditions => "parent_id = 0", :order => "created_at DESC")
    else
      @messages = Message.paginate(:page => params[:page], :per_page => 50, :order => 'created_at DESC')
    end

    respond_to do |format|
      format.html # index.html.erb
      format.iphone # index.iphone.erb
      format.xml  { render :xml => @messages }
    end
  end

  # GET /messages/1
  # GET /messages/1.xml
  def show
    @message = Message.find(params[:id])
    
    (flash[:message])? @reply_message = Message.new(flash[:message].attributes) : @reply_message = Message.new
    @reply_message.name ||= cookies[:name]
    @reply_message.subject ||= @message.re_subject
    @reply_message.parent_id = @message.id
    @reply_message.message ||= "\n\n\n<blockquote>" + @message.message + "</blockquote>"
    
    # mix errors into reply_message model
    flash[:message].errors.map{|k,v| @reply_message.errors.add(k, v)} if flash[:message]

    respond_to do |format|
      format.html # show.html.erb
      format.iphone { render } # show.iphone.erb
      format.xml  { render :xml => @message }
    end
  end

  # GET /messages/new
  # GET /messages/new.xml
  def new
    @message = Message.new
    
    @message[:name] ||= cookies[:name]

    respond_to do |format|
      format.html # new.html.erb
      format.iphone # new.iphone.erb
      format.xml  { render :xml => @message }
    end
  end

  # GET /messages/1/edit
  # def edit
  #   @message = Message.find(params[:id])
  # end

  # POST /messages
  # POST /messages.xml
  def create
    @message = Message.new(params[:message])
    begin
      @message.host = Resolv.getname(request.remote_ip)
    rescue
      @message.host = "unresolved (#{request.remote_ip})"
    end
    
    respond_to do |format|
      if params[:commit] != 'Preview' && @message.save
        cookies[:name] = {:value => @message.name, :expires => Time.now.next_month}
        
        flash[:notice] = 'Message was successfully created.'
        format.html { redirect_to(@message) }
        format.iphone { redirect_to(@message) }
        format.xml  { render :xml => @message, :status => :created, :location => @message }
      else
        format.html { 
          if @message.parent_id == 0
            render :action => "new"
          else
            flash[:message] = @message
            flash[:commit] = params[:commit]
            redirect_to(Message.find(@message.parent_id))
          end
        }
        format.iphone {
          if @message.parent_id == 0
            render :action => "new"
          else
            flash[:message] = @message
            redirect_to(Message.find(@message.parent_id))
          end
        }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /messages/1
  # PUT /messages/1.xml
  def update
    @message = Message.find(params[:id])

    respond_to do |format|
      if @message.update_attributes(params[:message])
        flash[:notice] = 'Message was successfully updated.'
        format.html { redirect_to(@message) }
        format.iphone { redirect_to(@message) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.iphone { render :action => "edit" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.xml
  def destroy
    @message = Message.find(params[:id])
    @message.destroy

    respond_to do |format|
      format.html { redirect_to(messages_url) }
      format.iphone { redirect_to(messages_url) }
      format.xml  { head :ok }
    end
  end
end
