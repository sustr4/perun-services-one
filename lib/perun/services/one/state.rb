require 'pry'

class Perun::Services::One::State
  attr_reader :users
  attr_reader :banned
  attr_reader :groups
  attr_reader :groupMembers
  attr_reader :dns
  attr_reader :principals
  attr_reader :sshKeys

  def initialize()
    @users = Array.new
    @banned = Array.new
    @groups = Array.new
    @groupMembers = Array.new
    @dns = Array.new
    @principals = Array.new
    @sshKeys = Array.new

  end

end
