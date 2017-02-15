
class Perun::Services::One::Master < ::Thor
  desc 'sync', 'Synchronize user base with OpenNebula'
  def sync

    file = File.new("/tmp/opennebula.json", "r")

    target = Perun::Services::One::Target.new(file.read)
    reality = Perun::Services::One::Reality.new()

    puts target.users.inspect
    puts reality.users.inspect
    

  end
  default_task :sync
end

