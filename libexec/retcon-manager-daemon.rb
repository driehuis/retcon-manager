# Change this file to be a wrapper around your daemon code.

# Do your post daemonization configuration here
# At minimum you need just the first line (without the block), or a lot
# of strange things might start happening...
DaemonKit::Application.running! do |config|
  # Trap signals with blocks or procs
  config.trap( 'INT' ) do
    puts 'going down'
    exit
  end
  config.trap( 'TERM', Proc.new { puts 'Going down'; exit } )
end

# Sample loop to show process
EM.run do
  
  EventMachine::add_periodic_timer 600 do
   # Retcon::BackupServers.update_disk_space
  end
  
  EventMachine::add_periodic_timer 60 do
    Retcon::BackupServers.queue_backups
  end
  
  EventMachine::add_periodic_timer 60 do
    Retcon::BackupServers.start_queued
  end
  
  EventMachine::add_periodic_timer 1 do
    Retcon::BackupJobs.wakeup
  end
end
