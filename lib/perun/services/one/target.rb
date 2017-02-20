require 'pry'

# Representation of the target state of the userbase
class Perun::Services::One::Target < Perun::Services::One::State
  def initialize(input, options)
    super()
    @full = JSON.parse(input)

    @full['users'].each do |user|
      @users << user['login']
      @full_names << { 'name' => user['login'], 'fullName' => user['display_name'] }
      @emails << { 'name' => user['login'], 'email' => user['email'] }

      @banned << user['login'] if user['banned'] == 'true'

      # Group membership
      user['groups'].each do |group, status|
        @groups << group
        @group_members << { 'name' => user['login'], 'group' => group } if status == 'VALID'
      end
      user['privileged_in_groups'].each do |group|
        @groups << group
        @privileged_in_groups << { 'name' => user['login'], 'group' => group }
      end
      @groups = @groups.uniq

      # Principals
      options['principalTypes'].each do |type|
        user['credentials'][type].each do |principal|
          @principals << { 'name' => user['login'], 'principal' => principal }
        end
      end

      # ssh Keys
      user['credentials']['ssh_keys'].each do |key|
        @ssh_keys << { 'name' => user['login'], 'ssh_key' => key }
      end
    end
  end
end
