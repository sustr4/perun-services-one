
class Perun::Services::One::Master < ::Thor
  desc 'sync', 'Synchronize user base with OpenNebula'
  def sync

    file = File.new("/tmp/opennebula.json", "r")
    ignoreUsers = Array.new([ "oneadmin", "serveradmin", "rocci" ])

    target = Perun::Services::One::Target.new(file.read)
    reality = Perun::Services::One::Reality.new()

    usersToAdd = target.users - reality.users
    usersToRemove = reality.users - target.users

    bansToAdd = target.banned - reality.banned
    bansToRemove = reality.banned - target.banned

    # TODO Implelement ignored users (method to remove them from all lists?)

    usersToAdd.each do | user |
      reality.addUser(user)
    end

  end
  default_task :sync
end

