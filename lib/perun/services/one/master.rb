
class Perun::Services::One::Master < ::Thor
  desc 'sync', 'Synchronize user base with OpenNebula'
  def sync

    file = File.new("/tmp/opennebula.json", "r")
    ignoreUsers = Array.new([ "oneadmin", "serveradmin", "rocci" ])

    target = Perun::Services::One::Target.new(file.read)
    reality = Perun::Services::One::Reality.new()

    puts target.dns
    puts target.principals
    puts target.sshKeys
    

  end
  default_task :sync
end

