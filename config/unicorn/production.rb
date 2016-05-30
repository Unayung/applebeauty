# # See http://unicorn.bogomips.org/Unicorn/Configurator.html for complete
# # documentation.
# app_dir = "/home/apps/applebeauty/current"


# # def notify_hipchat
# #   env      = ENV["RACK_ENV"]
# #   hostname = `hostname`.chomp
# #   message  = "Americana Exchange (#{env}): [#{hostname}] Unicorn restarted."

# #   `bundle exec rake hipchat:send MESSAGE=#{message}`
# # end

# # Use at least one worker per core if you're on a dedicated server,
# # more will usually help for _short_ waits on databases/caches.
# worker_processes ENV["RACK_ENV"] == "production" ? 4 : 1

# # Help ensure your application will always spawn in the symlinked
# # "current" directory that Capistrano sets up.
# working_directory app_dir

# # listen on a Unix domain socket
# # we use a shorter backlog for quicker failover when busy
# listen "/home/apps/applebeauty/shared/sockets/unicorn.sock", :backlog => 64

# # nuke workers after 600 seconds instead of 60 seconds (the default)
# timeout 600

# # feel free to point this anywhere accessible on the filesystem
# pid "#{app_dir}/tmp/pids/unicorn.pid"

# # By default, the Unicorn logger will write to stderr.
# # Additionally, ome applications/frameworks log to stderr or stdout,
# # so prevent them from going to /dev/null when daemonized here:
# stderr_path "#{app_dir}/log/unicorn.stderr.log"
# stdout_path "#{app_dir}/log/unicorn.stdout.log"

# # combine Ruby 2.0.0dev or REE with "preload_app true" for memory savings
# # http://rubyenterpriseedition.com/faq.html#adapt_apps_for_cow
# preload_app true
# GC.respond_to?(:copy_on_write_friendly=) and
#   GC.copy_on_write_friendly = true

# before_fork do |server, worker|
#   # the following is highly recomended for Rails + "preload_app true"
#   # as there's no need for the master process to hold a connection
#   defined?(ActiveRecord::Base) and
#     ActiveRecord::Base.connection.disconnect!

#   # This allows a new master process to incrementally
#   # phase out the old master process with SIGTTOU to avoid a
#   # thundering herd (especially in the "preload_app false" case)
#   # when doing a transparent upgrade.  The last worker spawned
#   # will then kill off the old master process with a SIGQUIT.
#   # old_pid = "#{server.config[:pid]}.oldbin"
#   # if old_pid != server.pid
#   #   begin
#   #     notify_hipchat
#   #   rescue
#   #   end
#   # end

#   # Throttle the master from forking too quickly by sleeping.  Due
#   # to the implementation of standard Unix signal handlers, this
#   # helps (but does not completely) prevent identical, repeated signals
#   # from being lost when the receiving process is busy.
#   # sleep 1
# end

# after_fork do |server, worker|
#   # per-process listener ports for debugging/admin/migrations
#   # addr = "127.0.0.1:#{9293 + worker.nr}"
#   # server.listen(addr, :tries => -1, :delay => 5, :tcp_nopush => true)

#   # the following is *required* for Rails + "preload_app true",
#   defined?(ActiveRecord::Base) and
#     ActiveRecord::Base.establish_connection

#   # if preload_app is true, then you may also want to check and
#   # restart any other shared sockets/descriptors such as Memcached,
#   # and Redis.  TokyoCabinet file handles are safe to reuse
#   # between any number of forked children (assuming your kernel
#   # correctly implements pread()/pwrite() system calls)
# end

# before_exec do |server|
#   # Sepecify the location of current Gemfile. Or unicorn will use the old one.
#   ENV["BUNDLE_GEMFILE"] = "#{app_dir}/Gemfile"
#   server.logger.info("Using Gemfile: #{ENV["BUNDLE_GEMFILE"]}")
# end
