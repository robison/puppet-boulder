# boulder::config.pp
class boulder::config {

  $boulder_reqs               = $boulder::boulder_reqs
  $package                    = $boulder::package
  $version                    = $boulder::version
  $release                    = $boulder::release
  $bindir                     = $boulder::bindir
  $cfgdir                     = $boulder::cfgdir
  $datadir                    = $boulder::datadir
  $logdir                     = $boulder::logdir
  $svcdir                     = $boulder::svcdir
  $svcusr                     = $boulder::svcusr
  $svcgrp                     = $boulder::svcgrp
  $db_server                  = $boulder::db_server
  $db_port                    = $boulder::db_port
  $db_name                    = $boulder::db_name
  $pkcs11                     = $boulder::pkcs11
  $pkcs11module               = $boulder::pkcs11module
  $pkcs11pin                  = $boulder::pkcs11pin
  $pkcs11cardlabel            = $boulder::pkcs11cardlabel
  $pkcs11tokenlabel           = $boulder::pkcs11tokenlabel
  $pkcs11privkeylabel         = $boulder::pkcs11privkeylabel
  $services                   = $boulder::services
  $secrets                    = $boulder::secrets
  $certs                      = $boulder::certs
  $certs_source               = $boulder::certs_source
  $issuercert                 = $boulder::issuercert
  $issuerprivkey              = $boulder::issuerprivkey
  $intermediate_ca_bundle     = $boulder::intermediate_ca_bundle
  $smtp_server                = $boulder::smtp_server
  $smtp_username              = $boulder::smtp_username
  $smtp_password              = $boulder::smtp_password
  $smtp_from_address          = $boulder::smtp_from_address
  $cname                      = $boulder::cname
  $ct_server                  = $boulder::ct_server
  $ct_server_port             = $boulder::ct_server_port
  $ct_server_pkey             = $boulder::ct_server_pkey
  $dns_resolver               = $boulder::dns_resolver
  $user_notice                = $boulder::user_notice

  file {

    "${datadir}":
      ensure  => directory,
      backup  => false,
      owner   => $svcusr,
      group   => $svcgrp,
      mode    => '0770';

    "${cfgdir}":
      ensure  => directory,
      recurse => true,
      purge   => true,
      backup  => false,
      owner   => $svcusr,
      group   => $svcgrp,
      mode    => '0770';

    "${cfgdir}/certs":
      ensure  => directory,
      require => File[$cfgdir],
      recurse => true,
      purge   => true,
      backup  => false,
      owner   => $svcusr,
      group   => $svcgrp,
      mode    => '0770';

    "${cfgdir}/config":
      ensure  => directory,
      require => File[$cfgdir],
      recurse => true,
      purge   => true,
      backup  => false,
      owner   => $svcusr,
      group   => $svcgrp,
      mode    => '0770';

    "${cfgdir}/policy":
      ensure  => directory,
      require => File[$cfgdir],
      recurse => true,
      purge   => true,
      backup  => false,
      owner   => $svcusr,
      group   => $svcgrp,
      mode    => '0770';

    "${cfgdir}/secrets":
      ensure  => directory,
      require => File[$cfgdir],
      recurse => true,
      purge   => true,
      backup  => false,
      owner   => $svcusr,
      group   => $svcgrp,
      mode    => '0440';

    "${cfgdir}/mail_templates":
      ensure  => directory,
      require => File[$cfgdir],
      recurse => true,
      purge   => true,
      backup  => false,
      owner   => $svcusr,
      group   => $svcgrp,
      mode    => '0770';

  } ->

  boulder::configfiles { $services: } ->

  file {

    "${cfgdir}/policy/hostname-policy.json":
      ensure  => file,
      require => File["${cfgdir}/policy"],
      backup  => false,
      content => template("${package}/policy/hostname-policy.json.erb"),
      owner   => $svcusr,
      group   => $svcgrp,
      mode    => '0660';

    "${cfgdir}/policy/rate-limit-policies.yml":
      ensure  => file,
      require => File["${cfgdir}/policy"],
      backup  => false,
      content => template("${package}/policy/rate-limit-policies.yml.erb"),
      owner   => $svcusr,
      group   => $svcgrp,
      mode    => '0660';

    "${cfgdir}/mail_templates/expiration_mail_template.txt":
      ensure  => file,
      require => File["${cfgdir}/mail_templates"],
      backup  => false,
      content => template("${package}/mail_templates/expiration_mail_template.txt.erb"),
      owner   => $svcusr,
      group   => $svcgrp,
      mode    => '0660';

  }

  if $pkcs11 {

    file {

      "${cfgdir}/secrets/${::fqdn}-pkcs11-config.json":
        ensure  => file,
        require => File["${cfgdir}/secrets"],
        backup  => false,
        content => inline_template("{\"module\":\"${pkcs11module}\",\"tokenLabel\":\"${pkcs11tokenlabel}\",\"pin\":\"${pkcs11pin}\",\"privateKeyLabel\": \"${pkcs11privkeylabel}\"}\n"),
        owner   => $svcusr,
        group   => $svcgrp,
        mode    => '0440';

      '/usr/share/polkit-1/rules.d/48-pcscd-polkit.rules':
        ensure  => file,
        backup  => false,
        content => template("${package}/system/48-pcscd-polkit.rules.erb"),
        owner   => root,
        group   => root,
        mode    => '0644';

    }

  } else {

    file {

      "${cfgdir}/secrets/${::fqdn}.pkey.pem":
        ensure  => file,
        require => File["${cfgdir}/secrets"],
        backup  => false,
        source  => $issuerprivkey,
        owner   => $svcusr,
        group   => $svcgrp,
        mode    => '0440';
    }

  }

  if $certs {

    boulder::certfiles { $certs: }

  }

  if $secrets {

    $secrets_defaults = {
      proto    => 'mysql+tcp',
      server   => $db_server,
      port     => $db_port,
      uri      => $db_name,
      mode     => '0440'
    }

    create_resources('boulder::secretfiles', $secrets, $secrets_defaults)

  }


}
