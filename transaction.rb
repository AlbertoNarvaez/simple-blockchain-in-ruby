def get_transactions_data

  transactions_block ||= []
  blank_transaction = Hash[from: "", to: "",
                           what: "", qty: ""]
  max_transactions = 3

  loop do
    puts "" 
    puts "Enter your name for the new transaction"
    from = gets.chomp
    puts "" 
    puts "What do you want to send ?"
    what = gets.chomp
    puts "" 
    puts "How much quantity ?"
    qty  = gets.chomp
    puts "" 
    puts "Who do you want to send it to ?"
    to   = gets.chomp

    transaction = Hash[from: "#{from}", to: "#{to}", 
                       what: "#{what}", qty: "#{qty}"]
    transactions_block << transaction

    if transactions_block.size >= max_transactions
      puts ""
      puts "[ Límite de #{max_transactions} transacciones por bloque alcanzado. Minando bloque... ]"
      return transactions_block
    end

    puts "" 
    puts "Do you want to make another transaction for this block ? (Y/n)"
    new_transaction = gets.chomp.downcase

    if new_transaction == "y"
      self
    else
      return transactions_block
      break
    end
  end
end