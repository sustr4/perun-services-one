require 'securerandom'
include OpenNebula

class Perun::Services::One::Reality < Perun::Services::One::State
  attr_writer :authDriver

  def initialize()
    super()

    # FIXME: Replace this with config file/option read
    @client = Client.new(nil, ENV["ONE_XMLRPC"])
    @userPool = UserPool.new(@client)
    @userPool.info
    @groupPool = GroupPool.new(@client)
    @groupPool.info

    @groupIndex = makeGroupIndex

    @userPool.each do |user|
      @users << user.name
      @emails << { "name" => user.name, "email" => user['TEMPLATE/EMAIL'] }
      @banned << user.name if user['TEMPLATE/BANNED'] == "true"

      # Group membership
      user.groups.each do | groupid |
        @groups << @groupIndex[groupid]
        @groupMembers << { "name" => user.name, "group" => @groupIndex[groupid] }
      end
      @groups = @groups.uniq



    end

    return 0
  end

  def addUser(user)
    userObj = User.new(User.build_xml,@client)
    #TODO: catch
    userObj.allocate(user, self.class.randomPassword, @authDriver)
  end

  private

  def makeGroupIndex
    # Fill in a group index for simle lookup by GID
    groupIndex = Array.new
    @groupPool.each do |group|
      groupIndex[group['ID'].to_i] = group['NAME']
    end
    return groupIndex
  end

  def self.randomPassword
    SecureRandom.uuid
  end

end
