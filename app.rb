#!/usr/bin/env ruby

require 'pry'

class MagicDigits
  attr_reader :output_file
  attr_accessor :seed 
  
  def initialize
    @seed = 100000000
    @output_file_path = './dump.txt'

    perform
  end

  def calculate_sum 
  end

  def perform
    for i in seed...limit do 
     puts "Processing... #{i}"
     puts "Found! #{i}" if magic_number? i 
    end 
  end 

  def close_output_file
    out_file_handler.close
  end 

  private 

  def limit
    # @limit ||= @seed * 10
    @limit ||= @seed + 100
  end

  def magic_number?(n)
    reduced = reduced_to_three_digits_or_less(n)

    return true if reduced.to_s.split('').map { |e| e.to_i }.reduce(:+).odd? if has_base_magic_numbers? reduced
      
    false
  end 

  def base_magic_numbers
    @base_magic_numbers ||= [1, 3, 4, 6, 7, 9]
  end 

  def has_base_magic_numbers?(n)
    n.to_s.split('').map { |e| base_magic_numbers.include? e }.reduce(:|)
  end 

  def reduced_to_three_digits_or_less(n)
    return n if size_of_digit(n) <= 3

    reduced_to_three_digits_or_less(summ_of_digits(n))
  end

  def size_of_digit(n)
    n.to_s.size
  end  

  def summ_of_digits(n)
    n.to_s.split('').map { |e| e.to_i }.reduce(:+)
  end 

  def out_file_handler
    @out_file_handler ||= File.open(output_file_path, 'w')
  end 
end 

begin 
  instance = MagicDigits.new.perform
ensure 
  instance.close_output_file
end 