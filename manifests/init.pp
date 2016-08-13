# boulder init.pp
class boulder (

  $boulder_reqs                      = $boulder::params::boulder_reqs,
  $package                           = $boulder::params::package,
  $version                           = $boulder::params::version,
  $release                           = $boulder::params::release,

  $bindir                            = $boulder::params::bindir,
  $cfgdir                            = $boulder::params::cfgdir,
  $datadir                           = $boulder::params::datadir,
  $logdir                            = $boulder::params::logdir,
  $svcdir                            = $boulder::params::svcdir,

  $svcusr                            = $boulder::params::svcusr,
  $svcgrp                            = $boulder::params::svcgrp,

  $rabbitmq_username                 = $boulder::params::rabbitmq_username,
  $rabbitmq_password                 = $boulder::params::rabbitmq_password,
  $rabbitmq_server                   = $boulder::params::rabbitmq_server,
  $rabbitmq_port                     = $boulder::params::rabbitmq_port,
  $rabbitmq_vhost                    = $boulder::params::rabbitmq_vhost,

  $db_server                         = $boulder::params::db_server,
  $db_port                           = $boulder::params::db_port,
  $db_name                           = $boulder::params::db_name,
  $db_username                       = $boulder::params::db_username,
  $db_password                       = $boulder::params::db_password,

  $pkcs11                            = $boulder::params::pkcs11,
  $pkcs11module                      = $boulder::params::pkcs11module,
  $pkcs11pin                         = $boulder::params::pkcs11pin,
  $pkcs11cardlabel                   = $boulder::params::pkcs11cardlabel,
  $pkcs11tokenlabel                  = $boulder::params::pkcs11tokenlabel,
  $pkcs11privkeylabel                = $boulder::params::pkcs11privkeylabel,

  $services                          = $boulder::services,
  $secrets                           = $boulder::secrets,
  $certs                             = $boulder::certs,
  $certs_source                      = $boulder::certs_source,
  $issuercert                        = $boulder::issuercert,
  $issuerprivkey                     = $boulder::issuerprivkey,
  $intermediate_ca_bundle            = $boulder::intermediate_ca_bundle,

  $boulder_sa_db_password            = $boulder::params::boulder_sa_db_password,
  $cert_checker_db_password          = $boulder::params::cert_checker_db_password,
  $importer_db_password              = $boulder::params::importer_db_password,
  $mailer_db_password                = $boulder::params::mailer_db_password,
  $ocsp_updater_db_password          = $boulder::params::ocsp_updater_db_password,
  $ocsp_responder_db_password        = $boulder::params::ocsp_responder_db_password,
  $policy_db_password                = $boulder::params::policy_db_password,
  $purger_db_password                = $boulder::params::purger_db_password,
  $revoker_db_password               = $boulder::params::revoker_db_password,

  $boulder_sa_dburl                  = $boulder::params::boulder_sa_dburl,
  $ocsp_updater_dburl                = $boulder::params::ocsp_updater_dburl,
  $ocsp_responder_dburl              = $boulder::params::ocsp_responder_dburl,
  $cert_checker_dburl                = $boulder::params::cert_checker_dburl,
  $revoker_dburl                     = $boulder::params::revoker_dburl,
  $purger_dburl                      = $boulder::params::purger_dburl,
  $mailer_dburl                      = $boulder::params::mailer_dburl,

  $amqp_url                          = $boulder::params::amqp_url,
  $smtp_server                       = $boulder::params::smtp_server,
  $smtp_username                     = $boulder::params::smtp_username,
  $smtp_password                     = $boulder::params::smtp_password,
  $smtp_from_address                 = $boulder::params::smtp_from_address,

  $dns_resolver                      = $boulder::params::dns_resolver,

  $cname                             = $boulder::params::cname,
  $ct_server                         = $boulder::params::ct_server,
  $ct_server_port                    = $boulder::params::ct_server_port,
  $ct_server_pkey                    = $boulder::params::ct_server_pkey,

  $user_notice                       = $boulder::params::user_notice

  ) inherits boulder::params {

  anchor { '::boulder::start': } ->
    class { '::boulder::install': } ->
    class { '::boulder::config': } ->
    class { '::boulder::service': } ->
  anchor { '::boulder::end': }

}