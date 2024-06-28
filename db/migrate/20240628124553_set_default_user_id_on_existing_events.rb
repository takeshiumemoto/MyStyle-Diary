class SetDefaultUserIdOnExistingEvents < ActiveRecord::Migration[6.1]
  def up
    default_user = User.first
    Event.where(user_id: nil).update_all(user_id: default_user.id) if default_user
  end

  def down
    # ダウンマイグレーションのための処理（必要なら）
  end
end
