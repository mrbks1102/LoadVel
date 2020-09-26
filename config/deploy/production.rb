# EC2サーバーのIP、EC2サーバーにログインするユーザー名、サーバーのロールを記述
server ENV["MYIP"], user: "jhin", roles: %w{app db web} 

#デプロイするサーバーにsshログインする鍵の情報を記述
set :ssh_options, keys: "~/.ssh/roadvel_git_rsa" 
