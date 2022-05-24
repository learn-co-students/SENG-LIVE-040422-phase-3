# This will delete any existing rows from the User and Bank tables
# so you can run the seed file multiple times without having duplicate entries in your database
puts "Deleting User/Bank data..."
Account.destroy_all
User.destroy_all
Bank.destroy_all

puts "Creating users..."
joe_shmoe = User.create(name: "Joe Schmoe", country_of_residence: "UK")
jane_doe = User.create(name: "Jane Doe", country_of_residence: "USA")

puts "Creating banks..."

bank_of_america = Bank.create(name: "Bank of America", market_capitalization: 338610000000, country: "USA")
citigroup = Bank.create(name: "Citigroup", market_capitalization: 142110000000, country: "USA")
jp_morgan_chase = Bank.create(name: "JPMorgan Chase", market_capitalization: 461340000000, country: "USA")
royal_bank_of_canada = Bank.create(name: "Royal Bank of Canada", market_capitalization: 145180000000, country: "Canada")
china_construction_bank = Bank.create(name: "China Construction Bank", market_capitalization: 184590000000, country: "China")
icbc = Bank.create(name: "ICBC", market_capitalization: 241370000000, country: "China")
cm_bank = Bank.create(name: "CM Bank", market_capitalization: 204110000000, country: "China")
morgan_stanley = Bank.create(name: "Morgan Stanley", market_capitalization: 181280000000, country: "USA")
agricultural_bank_of_china = Bank.create(name: "Agricultural Bank of China", market_capitalization: 155140000000, country: "China")
wells_fargo = Bank.create(name: "Wells Fargo", market_capitalization: 194600000000, country: "USA")


puts "Creating Accounts..."
# ***********************************************************
# * TODO: create accounts! Remember, an account belongs to a user *
# * and an account belongs to a bank.                         *
# ***********************************************************
joe_personal = Account.create(label: "Joe Personal", balance: 1000.0, account_type: "Checking", user_id: joe_shmoe.id, bank_id: bank_of_america.id)
joe_savings = Account.create(label: "Joe Savings", balance: 4000.0, account_type: "Savings", user_id: joe_shmoe.id, bank_id: bank_of_america.id)
joe_money_market = Account.create(label: "Joe Savings", balance: 14000.0, account_type: "Money Market", user_id: joe_shmoe.id, bank_id: wells_fargo.id)
jane_personal = Account.create(label: "Jane Personal", balance: 5000.0, account_type: "Checking", user_id: jane_doe.id, bank_id: jp_morgan_chase.id)
jane_international = Account.create(label: "Jane overseas", balance: 2000.0, account_type: "Checking", user_id: jane_doe.id, bank_id: royal_bank_of_canada.id)
# binding.pry
# Create accounts Here

# ***********************************************************

puts "Seeding done!"