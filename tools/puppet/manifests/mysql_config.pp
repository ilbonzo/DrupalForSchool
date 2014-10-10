class { '::mysql::server':
    root_password    => 'secret',
    override_options => { 'mysqld' => { 'max_connections' => '1024' } }
}
class mysql_config {

    mysql::db { 'dfs':
        user     => 'dfs',
        password => 'dfs',
        host     => 'localhost',
        grant    => ['all'],
        charset  => 'utf8'
    }

}
