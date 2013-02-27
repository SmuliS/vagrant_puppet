class capistrano {
  exec {
    "/usr/local/bin/gem install capistrano -v=2.14.2":
      user => root,
      group => root,
      alias => "install_capistrano",
      unless => "ls /usr/local/lib/ruby/gems/1.9.1/gems/capistrano-2.14.2/"
  }
}
