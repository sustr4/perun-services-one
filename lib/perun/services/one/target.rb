require 'pry'

class Perun::Services::One::Target
  attr_reader :full

  def initialize( input )
    @full = JSON.parse(input)
  end 

  def users
    retval = Array.new
    @full["users"].each do |user|
      retval << user["login"]
    end
    retval
  end

end
