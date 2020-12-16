class Transfer

  attr_accessor :status, :amount, :sender, :receiver

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
    if self.status != "complete" && sender.balance >= amount && sender.valid? && receiver.valid?
      sender.balance -= amount    
      receiver.balance += amount
      @status = "complete"
    else
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end 

  def reverse_transfer
    if self.status == "complete"
      self.receiver.balance -= self.amount
      self.sender.balance += self.amount
      self.status = "reversed"
    end
  end 

end
