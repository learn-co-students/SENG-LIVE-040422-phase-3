class Bank < ActiveRecord::Base
  has_many :accounts
  has_many :users, -> { distinct }, through: :accounts

  def open_account(user, label, account_type, opening_deposit)
    Account.create(
      user: user,
      bank: self,
      label: label,
      balance: opening_deposit,
      account_type: account_type
    )
  end

  def accounts_summary(user)
    self.accounts.where(user: user).map(&:summary)
  end

  def blacklist(user)
    Account.where(user_id: user.id, bank_id: self.id).destroy_all
  end
end