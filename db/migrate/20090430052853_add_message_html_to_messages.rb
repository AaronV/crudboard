class AddMessageHtmlToMessages < ActiveRecord::Migration
  def self.up
    add_column :messages, :message_html, :text
  end

  def self.down
    remove_column :messages, :message_html
  end
end
