require 'capistrano'

Capistrano::Configuration.instance(:must_exist).load do
  
  desc 'Start a SSH connection to remote server'
  task :ssh do
    servers = find_servers_for_task(current_task)
    case servers.count
      when 0
        logger.debug "no servers found"
      when 1
        ssh_connect servers.first
      else
        HighLine.new.choose do |menu|
          menu.prompt = "Please choose your server: "
          menu.choices(*servers.map(&:host)) {|choice| ssh_connect servers.select { |s| s.host == choice }.first }
        end
    end
  end
  
  def ssh_connect(server)
    Capistrano::SSH.connection_strategy(server, self) do |host, user, options|
      params =  "#{user}@#{host}"
      params += " -p #{options[:port]}" unless options[:port].nil?
      logger.debug "connecting to #{host}"
      logger.info "password: #{password}" if self.variables[:password].kind_of?(String)
      params += %{ -t "cd #{fetch(:sushi_default_dir)} && bash"} if self[:sushi_default_dir]
      exec "ssh #{params}"
    end
  end
  
end