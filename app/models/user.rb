class User < ApplicationRecord
  has_many :user_videos
  has_many :videos, through: :user_videos

  validates :email, uniqueness: true, presence: true
  validates_presence_of :first_name
  enum role: [:default, :admin]
  has_secure_password

  def self.from_omniauth(auth_info, current_user)
    current_user.update(uid: auth_info.uid,
                        handle: auth_info.extra.raw_info.login,
                        access_token: auth_info.credentials.token)
  end

  def self.bookmarks(current_user)
    Video.joins([:tutorial, user_videos: :user])
         .where("users.id = #{current_user.id}")
         .order('tutorials.id ASC, videos.position ASC')
  end

end
