# Representation of the current state of user accounts and controlled
# properties thereof on OpenNebula
class Perun::Services::One::Reality < Perun::Services::One::State
  def initialize(options, _logger)
    super()

    @options = options
    @client = OpenNebula::Client.new(nil, @options['rpc_endpoint'])
    user_pool = OpenNebula::UserPool.new(@client)
    user_pool.info
    @group_pool = OpenNebula::GroupPool.new(@client)
    @group_pool.info

    @group_index = make_group_index

    user_pool.each do |user|
      @users << user.name
      @emails << { 'name' => user.name, 'email' => user['TEMPLATE/EMAIL'] }
      @banned << user.name if user['TEMPLATE/BANNED'] == 'true'

      # Group membership
      user.groups.each do |groupid|
        @groups << @group_index[groupid]
        @group_members << { 'name' => user.name, 'group' => @group_index[groupid] }
      end
      @groups = @groups.uniq
    end
  end

  def add_user(user)
    user_obj = OpenNebula::User.new(User.build_xml, @client)
    # TODO: catch
    user_obj.allocate(user, random_password, @options['authDriver'])
  end

  private def make_group_index
    # Fill in a group index for simple lookup by GID
    group_index = []
    @group_pool.each do |group|
      group_index[group['ID'].to_i] = group['NAME']
    end
    group_index
  end

  private def random_password
    SecureRandom.uuid
  end
end
