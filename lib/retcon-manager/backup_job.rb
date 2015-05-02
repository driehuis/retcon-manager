module Retcon
  class BackupJobs
    def self.wakeup
      BackupJob.running.each do | job |
        job.wakeup
      end
    end
  end
end