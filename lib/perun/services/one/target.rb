require 'pry'

class Perun::Services::One::Target < Perun::Services::One::State

  def initialize( input, options )
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
      options["principalTypes"].each do | type |
        user["credentials"]["#{type}"].each do | principal |
          @principals << { "name" => user["login"], "principal" => principal }
        end
      end

    end
    
    return 0
  end 



end
