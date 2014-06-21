# Ruby bank program that allows basic banking functionality.  
 
class Bank
  attr_accessor :withdrawal, :deposit, :users, :balance, :bname
  @@accounts = {}
  def initialize(bname)
    @bname = bname
    @users = Hash.new           #Hash to hold users as keys and balances as values
    @@accounts[bname] = users   #Hash to hold bank names as keys and users as values
    puts "#{@bname} bank was just created."
  end

  def open_account(person, balance = 0)
    @users[person] = balance
    @@accounts.store(@bname, users)
    @balance = balance
    person.cash -= @users[person]
    puts "#{person.name}, thanks for opening an account at #{@bname} with $#{@users[person]}!"
  end
  
  def withdrawal(person, amount)
    if @users[person] < amount
      puts "#{person.name} does not have enough money in the account to withdraw #{amount}."
    else
      @users[person] -= amount
      person.cash += amount
      puts "#{person.name} withdrew $#{amount} from #{@bname}.  #{person.name} has #{person.cash} cash.  #{person.name}'s account has $#{@users[person]}."
    end  
  end
  
  def deposit(person, amount)
    if person.cash < amount
      puts "#{person.name} does not have enough cash to deposit $#{amount}."
    else
      @users[person] += amount
      person.cash -= amount
      puts "#{person.name} deposited $#{amount} to #{@bname}.  #{person.name} has $#{person.cash} cash remaining.  #{person.name}'s account has $#{@users[person]}." 
    end
  end
  
  def transfer(person, account2, amount)
    if @users[person] < amount
      puts "#{person.name} does not have enough money in the account to make the transfer."
    else
      @users[person] -= amount
      account2.users[person] += amount
      puts "#{person.name} transfered $#{amount} from #{@bname} account to #{account2.bname} account.  The #{@bname} account has $#{@users[person]} and the #{account2.bname} account has $#{account2.users[person]}."
    end
  end
end
 
class Person
  attr_accessor :name, :cash
  def initialize(name, cash = 100)
    @name = name
    @cash = cash
    puts "Hi, #{name}.  You have $#{cash} on hand!"
  end
end
 
chase = Bank.new("JP Morgan Chase")
wells_fargo = Bank.new("Wells Fargo")
puts "=========="
randy = Person.new("Randy", 600)
kristen = Person.new("Kristen", 1000)
puts "=========="
chase.open_account(randy, 200)
chase.open_account(kristen, 300)
wells_fargo.open_account(randy, 200)
wells_fargo.open_account(kristen, 300)
puts "=========="
chase.deposit(randy, 100)
chase.deposit(kristen, 350)
puts "=========="
chase.withdrawal(randy, 10000)
chase.withdrawal(kristen, 200)
puts "=========="
chase.transfer(randy, wells_fargo, 70)
puts "=========="
chase.deposit(randy, 150)
chase.withdrawal(randy, 100)
