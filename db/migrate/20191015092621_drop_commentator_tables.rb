# frozen_string_literal: true

class DropCommentatorTables < ActiveRecord::Migration[6.0]
  def change
    drop_table :commontator_comments
    drop_table :commontator_subscriptions
    drop_table :commontator_threads
  end
end
