class UpdateParentToParentId < ActiveRecord::Migration
  def self.up
    change_table :messages do |t|
      t.rename :parent, :parent_id
      t.change :parent_id, :int, :default => 0
    end
  end

  def self.down
    change_table :messages do |t|
      t.rename :parent_id, :parent
      t.change :parent, :int, :default => 0
    end
  end
end
