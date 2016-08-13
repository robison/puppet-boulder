define boulder::secretfiles (

  $isurl     = undef,
  $proto     = undef,
  $username  = undef,
  $password  = undef,
  $server    = undef,
  $port      = undef,
  $uri       = undef,
  $params    = undef,
  $mode,
  $cfgdir    = $boulder::cfgdir,
  $package   = $boulder::package,
  $svcgrp    = $boulder::svcgrp,
  $svcusr    = $boulder::svcusr,

  ) {

  if $proto {
    $_proto = "${proto}://"
  } else {
    $_proto = undef
  }

  if $password {
    $_password = ":${password}"
  } else {
    $_password = undef
  }

  if $port {
    $_port = ":${port}"
  } else {
    $_port = undef
  }

  if $uri {
    $_uri = "/${uri}"
  } else {
    $_uri = undef
  }

  if $params {
    $_params = "?${params}"
  } else {
    $_params = undef
  }

  if $username and $server {
    $_server = "@${server}"
  } else {
    $_server = $server
  }

  if $isurl {
    $content = "${_proto}${username}${_password}${_server}${_port}${_uri}${_params}\n"
  } else {
    $content = $password
  }

  file {

    "${cfgdir}/secrets/${name}":
      ensure  => file,
      content => $content,
      backup  => false,
      owner   => $svcusr,
      group   => $svcgrp,
      mode    => $mode;

    }

}