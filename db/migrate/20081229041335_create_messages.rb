class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.integer    :parent, :default => 0
      t.string     :host, :name, :subject
      t.text       :message

      t.timestamps
    end
  end

  def self.down
    drop_table     :messages
  end
end
