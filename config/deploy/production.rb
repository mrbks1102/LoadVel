server ENV["MYIP"], user: "jhin", roles: %w{app db web} 
set :ssh_options, keys: "~/.ssh/roadvel_git_rsa" 
