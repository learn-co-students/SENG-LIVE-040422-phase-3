class Account < ActiveRecord::Base
  belongs_to :user
  belongs_to :bank

  def summary
    "#{label} #{account_type} account balance: #{balance}"
  end
end