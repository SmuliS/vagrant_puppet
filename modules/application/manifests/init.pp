class application {
  file {
    ["/var/$application_name",
    "/var/$application_name/shared",
    "/var/$application_name/shared/config"]:
      ensure => directory,
      owner => $user_name,
      group => $user_name,
      mode => 775
  }
  file {
    "/var/$application_name/shared/config/database.yml":
      ensure => present,
      owner => $user_name,
      group => $user_name,
      mode => 600,
      source => "puppet:///modules/application/database.yml"
  }
  package {
    "bundler":
      provider => gem
  }

}
