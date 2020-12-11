require "pry"
class Transfer

  attr_accessor :status, :amount, :sender, :receiver, :transfer_completed

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @status = "pending"
    @amount = amount
  end 

  def valid?
    sender.valid? && receiver.valid?
  end

  def execute_transaction
    if @transfer_completed != self && sender.balance >= amount
      sender.balance -= amount    
      receiver.balance += amount
      @status = "complete"
      @transfer_completed = self
    end 
    if sender.balance < amount || sender.status == "closed" || receiver.status == "closed"
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
    
  end 

  def reverse_transfer
    if self.status == "complete"
      @transfer_completed.receiver.balance -= @transfer_completed.amount
      @transfer_completed.sender.balance += @transfer_completed.amount
      self.status = "reversed"
    end
  end 

end
