# Profile nginx_common
# ====================
#
# Class: profiles::nginx::common
# ==============================
#
class profiles::nginx::common {
  $nginx_version = lookup('nginx_version', String, 'first', '')
  if empty($nginx_version) {
    fail("Hiera data 'nginx_version' is empty!")
  }
  $invalid_vhost = '<!DOCTYPE html><html><body><h1>Invalid VirtualHost!</h1></body></html>'
  class { '::nginx':
    worker_processes         => $::processorcount,
    log_format               => {
      main => '$remote_addr\t$remote_user\t[$time_local]\t$msec\t$host\t$request\t$status\t$body_bytes_sent\t"$http_referer"\t"$http_user_agent"\t"$http_x_forwarded_for"\t$request_time\t"$upstream_cache_status"\t[$upstream_status]\t[$upstream_addr]\t[$upstream_response_time]\t$uid_set\t$uid_got\t"$http_cookie"\t$connection:$connection_requests\t$scheme',
      json_main => '{ "remote_addr": "$remote_addr","remote_user": "$remote_user","time_local": "$time_local","msec": "$msec","host": "$host","request": "$request","status": "$status","body_bytes_sent": "$body_bytes_sent","http_referer": "$http_referer","http_user_agent": "$http_user_agent","http_x_forwarded_for": "$http_x_forwarded_for","request_time": "$request_time","upstream_cache_status": "$upstream_cache_status","upstream_status": "$upstream_status","upstream_addr": "$upstream_addr","upstream_response_time": "$upstream_response_time","uid_set": "$uid_set","uid_got": "$uid_got","http_cookie": "$http_cookie","connection": "$connection","connection_requests": "$connection_requests","scheme": "$scheme" }',
    },
    proxy_set_header         => [
      'Host $host',
      'X-Real-IP $remote_addr',
      'X-Forwarded-For $proxy_add_x_forwarded_for',
      'Proxy ""',
    ],
    nginx_error_log          => '/var/log/nginx/error.log',
    nginx_error_log_severity => 'warn',
    proxy_http_version       => '1.1',
    proxy_buffers            => '8 64k',
    proxy_buffer_size        => '64k',
    proxy_connect_timeout    => '60',
    proxy_send_timeout       => '60',
    proxy_read_timeout       => '60',
    client_max_body_size     => '32m',
    server_tokens            => 'off',
    server_purge             => true,
    confd_purge              => true,
    gzip_buffers             => '32 8k',
    gzip_comp_level          => '7',
    gzip_min_length          => '1024',
    gzip_http_version        => '1.1',
    gzip_proxied             => 'any',
    gzip_types               => 'text/plain text/css application/json application/x-javascript text/xml application/xml application/rss+xml text/javascript image/tiff image/svg+xml application/psd application/x-font-woff application/x-font-ttf application/vnd.ms-fontobject',
    gzip_vary                => 'on',
    http_cfg_append          => {
      charset                   => 'utf-8',
      charset_types             => '*',
      proxy_ignore_client_abort => 'on',
    },
    manage_repo              => false,
    package_ensure           => $nginx_version,
    nginx_cfg_prepend        => {
      include => [
        "${::nginx::params::conf_dir}/modules-enabled/*.conf",
      ],
    }
  }
  ::nginx::resource::server { 'default':
    ensure              => present,
    server_name         => [ '_' ],
    listen_port         => 80,
    listen_options      => 'default_server',
    resolver            =>  $::dns_nameservers,
    access_log          => '/var/log/nginx/access.log',
    format_log          => 'main',
    error_log           => '/var/log/nginx/error.log warn',
    location_custom_cfg => {
      default_type => 'text/html',
      return       => "400 '${invalid_vhost}'",
    },
    index_files         => [],
  }
}

