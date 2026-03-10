###########################
#	Improved version of "Build your own blockchain from scratch in 20 lines of Ruby!"	
#		from https://github.com/openblockchains/awesome-blockchains/tree/master/blockchain.rb
#  
#   and inspired by
#     Let's Build the Tiniest Blockchain In Less Than 50 Lines of Python by Gerald Nash
#     see https://medium.com/crypto-currently/lets-build-the-tiniest-blockchain-e70965a248b
#
#	Now, Blockchain with prompt transactions, transactions counter for each block, 
#											 ledger, proof of work and dynamic variable name. 
#
#	This Blockchain can be set as a loop for infinite using of the Blockchain.
#
#
#  to run use:
#    $ ruby ./blockchain.rb
#
#
#
require 'digest'
require 'pp'
require 'json'
require_relative 'block'
require_relative 'transaction'

LEDGER = []

def create_first_block
  i = 0
  instance_variable_set( "@b#{i}", 
                         Block.first( 
                           { from: "Alberto", to: "Salvador", what: "Peniques", qty: 10 },
                           { from: "Keukenhof", to: "Anne", what: "Tulip Semper Augustus", qty: 7 } )
                       )
  LEDGER << @b0
  pp @b0
  p "============================"
  add_block
end

def add_block
  i = 1
  loop do
    instance_variable_set("@b#{i}", Block.next( (instance_variable_get("@b#{i-1}")), get_transactions_data))
    LEDGER << instance_variable_get("@b#{i}")
    p "============================"
    pp instance_variable_get("@b#{i}")
    p "============================"
    save_ledger_to_json  # ← nuevo
    i += 1
  end
end

def save_ledger_to_json
  data = LEDGER.map do |block|
    {
      index:              block.index,
      block_id:           block.block_id,
      timestamp:          block.timestamp.to_s,
      previous_hash:      block.previous_hash,
      hash:               block.hash,
      nonce:              block.nonce,
      transactions:       block.transactions,
      transactions_count: block.transactions_count
    }
  end
  File.write('ledger.json', JSON.pretty_generate(data))
  puts ""
  puts "[ Blockchain guardada en ledger.json ]"
end

def launcher
  puts "==========================="
  puts ""
  puts "Welcome to Simple Blockchain In Ruby !"
  puts ""
  sleep 1.5
  puts "This program was created by Anthony Amar for and educationnal purpose"
  puts ""
  sleep 1.5
  puts "Wait for the genesis (the first block of the blockchain)"
  puts ""
  for i in 1..10
    print "."
    sleep 0.5
    break if i == 10
  end
  puts "" 
  puts "" 
  puts "==========================="
  create_first_block
end

launcher