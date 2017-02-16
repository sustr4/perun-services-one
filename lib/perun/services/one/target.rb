require 'pry'

class Perun::Services::One::Target < Perun::Services::One::State

  def initialize( input )
    super()
    @full = JSON.parse(input)

    @full["users"].each do |user|
      @users << user["login"]

      # Simple list of all users
      if user["banned"] then
        @banned << user["login"]
      end

      # TODO: read banned users

      # Group membership
      user["groups"].each do | group, status |
        @groups << group
        @groupMembers << { "name" => user["login"], "group" => group } if status == "VALID"
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
