# frozen_string_literal: true

class User < ApplicationRecord
  validates :username, uniqueness: true, presence: true
  validates :email, uniqueness: true, presence: true
  validates_presence_of :password, :password_confirmation
  has_secure_password
end
