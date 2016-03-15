require File.expand_path('../load_config', __FILE__)

daemonize


pidfile '/var/run/diaspora/diaspora.pid'
bind 'unix:///var/run/diaspora/diaspora.sock'
#bind 'tcp://0.0.0.0:3000'

worker_timeout AppConfig.server.unicorn_timeout.to_i

#stdout_redirect AppConfig.server.stdout_log.present? ? AppConfig.server.stdout_log.get : '/dev/null',
#                AppConfig.server.stderr_log.present? ? AppConfig.server.stderr_log.get : '/dev/null'

stdout_redirect '/var/log/diaspora/puma_stdout.log', '/var/log/diaspora/puma_stderr.log', true

environment AppConfig.server.rails_environment

workers 1
preload_app!

