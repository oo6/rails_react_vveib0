module Mentionable
  extend ActiveSupport::Concern

  def mention_users
    names = self.content.scan(/@([a-z0-9][a-z0-9-]*)/i).flatten.uniq
    @menton_users = User.where(name: names)
  end

  def create_mention_notification
    users = mention_users - [user]
    users.each do |user|
      Notification.create(user: user, subject: self, name: 'mention')
    end
  end
end
