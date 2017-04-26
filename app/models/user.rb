class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_secure_password
  after_destroy :ensure_an_admin_remains
  class Error < StandardError
  end

  private

  def ensure_an_admin_remains
    if User.count.zero?
      error = Error.new
      raise error, "Can't delete last user"
    end
  end
end
