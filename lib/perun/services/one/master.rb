
class Perun::Services::One::Master < ::Thor
  desc 'sync', 'Synchronize user base with OpenNebula'
  def sync

    # TODO: Move all this into options and conf. file
    file = File.new("/tmp/opennebula.json", "r")
    ignoreUsers = Array.new([ "oneadmin", "serveradmin", "rocci" ])
    options = { "authDriver" => "x509", "principalTypes" => [ "cert_dns", "principals", "ssh_keys" ] }

    logger = Logger.new(STDERR)
    logger.level = Logger::DEBUG

    target = Perun::Services::One::Target.new(file.read, options)
    reality = Perun::Services::One::Reality.new(ENV["ONE_XMLRPC"], options, logger)

    usersToAdd = target.users - reality.users
    usersToRemove = reality.users - target.users
    logger.debug("#{usersToAdd.count} users to add, #{usersToRemove.count} users to remove.")

    bansToAdd = target.banned - reality.banned
    bansToRemove = reality.banned - target.banned

    # TODO Implelement ignored users (method to remove them from all lists?)

    usersToAdd.each do | user |
      logger.info("Creating user #{user}.")
      reality.addUser(user)
    end

  end
  default_task :sync
end

