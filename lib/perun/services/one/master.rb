
class Perun::Services::One::Master < ::Thor
  desc 'sync', 'Synchronize user base with OpenNebula'
  def sync

    file = File.new("/tmp/opennebula.json", "r")
    ignoreUsers = Array.new([ "oneadmin", "serveradmin", "rocci" ])

    target = Perun::Services::One::Target.new(file.read)
    reality = Perun::Services::One::Reality.new()

    usersToAdd = target.users - reality.users
    usersToRemove = reality.users - target.users

    bansToAdd = target.bans - reality.bans
    bansToRemove = reality.bans - target.bans

    # TODO Implelement ignored users (method to remove them from all lists?)

    puts usersToRemove
    

  end
  default_task :sync
end

