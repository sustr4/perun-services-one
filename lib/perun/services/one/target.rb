require 'pry'

class Perun::Services::One::Target < Perun::Services::One::State

  def initialize( input )
    super()
    @full = JSON.parse(input)

    @full["users"].each do |user|
      @users << user["login"]
      @fullNames << { "name" => user["login"], "fullName" => user["display_name"] }
      @emails << { "name" => user["login"], "email" => user["email"] }

      if user["banned"] == "true" then
        @banned << user["login"]
      end

      # Group membership
      user["groups"].each do | group, status |
        @groups << group
        @groupMembers << { "name" => user["login"], "group" => group } if status == "VALID"
      end
      user["privileged_in_groups"].each do | group |
        @groups << group
        @privilegedInGroups << { "name" => user["login"], "group" => group }
      end
      @groups = @groups.uniq

      # Principals
      user["credentials"]["cert_dns"].each do | dn |
        @dns << { "name" => user["login"], "dn" => dn }
      end
      user["credentials"]["principals"].each do | principal |
        @principals << { "name" => user["login"], "principal" => principal }
      end
      user["credentials"]["ssh_keys"].each do | sshKey |
        @sshKeys << { "name" => user["login"], "sshKey" => sshKey }
      end

    end
    
    return 0
  end 



end
