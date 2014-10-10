import 'apache_config.pp'
import 'mysql_config.pp'

Exec { path => '/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin' }

#Message of the day file
file { '/etc/motd':
    content => "Welcome to DrupalForSchool Vagrant-built virtual machine Managed by Puppet.\n"
}

class apt {
    exec { 'apt-get update':
        timeout => 0
    }
}

class git {
    package { 'git-core':
        ensure => latest,
        require => Class['apt']
    }
}

class php-dev {
    package { ['php-pear', 'php5-curl', 'php5-gd', 'php5-xdebug', 'php5-cli'] :
        ensure => 'latest'
    }

    package { 'curl':
        require => Class['apt']
    }

    package { 'vim':
        require => Class['apt']
    }

    package { 'make':
        require => Class['apt']
    }

    package { 'phpmyadmin':
        ensure => 'latest'
    }

    file_line { 'Append a line to /etc/apache2/apache2.conf':
      path => '/etc/apache2/apache2.conf',
      line => 'include /etc/phpmyadmin/apache.conf',
      require => Package['phpmyadmin']
    }

    exec { 'install-composer':
        command => 'curl -s https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer',
        creates => '/usr/local/bin/composer',
        require => Package['curl', 'php5-cli']
    }
}

class drupal {
    exec { 'download-drupal':
        command => 'drush dl drupal-7 --destination=/workspace --drupal-project-rename=drupal -y',
        cwd => '/workspace',
        require => Class['drush']
    }

    exec { 'install-drupal':
        command => 'drush site-install --db-url=mysql://dfs:dfs@localhost:3306/dfs --db-su=root --db-su-pw=secret --site-name="Drupal For School" --account-pass=password -y',
        cwd => '/workspace/drupal',
        require => Exec['download-drupal']
    }
}

include apt
include apache_config
include mysql_config
include git
include php-dev
include drush
include drupal
