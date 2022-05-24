class Bank < ActiveRecord::Base
  has_many :accounts
  has_many :users, -> { distinct }, through: :accounts

  def accounts_summary(user)
    self.accounts.where(user: user).map(&:summary)
  end
end