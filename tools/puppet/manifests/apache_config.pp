class { 'apache':
    mpm_module => 'prefork'
}

class {'apache::mod::php': }

class apache_config {

    apache::vhost { 'dfs.dev':
        priority        => '1',
        vhost_name      => '*',
        port            => '80',
        docroot         => '/workspace/drupal',
        docroot_owner   => 'vagrant',
        docroot_group   => 'vagrant',
        logroot         => '/var/log',
        override        => 'All'
    }

    apache::mod { 'rewrite': }
}
