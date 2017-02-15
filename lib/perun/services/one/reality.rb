include OpenNebula

class Perun::Services::One::Reality

  def initialize()
    # FIXME: Replace this with config file/option read
    @client = Client.new(nil, ENV["ONE_XMLRPC"])
    @userPool = UserPool.new(@client)
    @userPool.info
  end 

  def users
    retval = Array.new
    @userPool.each do |user|
      retval << user.name
    end
    retval
  end

end
