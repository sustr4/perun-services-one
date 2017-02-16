require 'pry'

class Perun::Services::One::State
  attr_reader :users
  attr_reader :banned
  attr_reader :groups
  attr_reader :groupMembers
  attr_reader :privilegedInGroups
  attr_reader :dns
  attr_reader :principals
  attr_reader :sshKeys
  attr_reader :emails
  attr_reader :fullNames

  def initialize()
    @users = Array.new
    @banned = Array.new
    @groups = Array.new
    @groupMembers = Array.new
    @privilegedInGroups = Array.new
    @dns = Array.new
    @principals = Array.new
    @sshKeys = Array.new
    @emails = Array.new
    @fullNames = Array.new

  end

end
