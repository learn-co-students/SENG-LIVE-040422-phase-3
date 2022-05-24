class User < ActiveRecord::Base
  has_many :accounts
  has_many :banks, -> { distinct }, through: :accounts

  def total_balance
    self.accounts.sum(:balance)
  end

  def international_funds
    international_banks = Bank.where.not(country: country_of_residence)
    self.accounts.where(bank: international_banks).sum(:balance)
  end
end