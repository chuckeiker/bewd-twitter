class Session < ApplicationRecord
  before_validation :generate_session_token

  belongs_to :user

  private

  def generate_session_token
    self.token = SecureRandom.urlsafe_base64
  end
end
