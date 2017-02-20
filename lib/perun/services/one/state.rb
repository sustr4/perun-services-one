require 'pry'

# Parent for state description classes
class Perun::Services::One::State
  attr_reader :users
  attr_reader :banned
  attr_reader :groups
  attr_reader :group_members
  attr_reader :privileged_in_groups
  attr_reader :dns
  attr_reader :principals
  attr_reader :ssh_keys
  attr_reader :emails
  attr_reader :full_names

  def initialize
    @users = []
    @banned = []
    @groups = []
    @group_members = []
    @privileged_in_groups = []
    @dns = []
    @principals = []
    @ssh_keys = []
    @emails = []
    @full_names = []
  end
end
