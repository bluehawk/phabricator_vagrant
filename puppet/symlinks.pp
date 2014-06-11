 # Fix links in case your host is windows (THIS WILL FAIL BADLY IF YOU ARE USING SHARED FOLDERS)
file {"$path/bin/accountadmin": ensure=>link, target=>'../scripts/user/account_admin.php'}
file {"$path/bin/aphlict": ensure=>link, target=>'../support/aphlict/server/aphlict_launcher.php'}
file {"$path/bin/audit": ensure=>link, target=>'../scripts/setup/manage_audit.php'}
file {"$path/bin/auth": ensure=>link, target=>'../scripts/setup/manage_auth.php'}
file {"$path/bin/cache": ensure=>link, target=>'../scripts/cache/manage_cache.php'}
file {"$path/bin/celerity": ensure=>link, target=>'../scripts/setup/manage_celerity.php'}
file {"$path/bin/commit-hook": ensure=>link, target=>'../scripts/repository/commit_hook.php'}
file {"$path/bin/config": ensure=>link, target=>'../scripts/setup/manage_config.php'}
file {"$path/bin/diviner": ensure=>link, target=>'../scripts/diviner/diviner.php'}
file {"$path/bin/drydock": ensure=>link, target=>'../scripts/drydock/drydock_control.php'}
file {"$path/bin/fact": ensure=>link, target=>'../scripts/fact/manage_facts.php'}
file {"$path/bin/feed": ensure=>link, target=>'../scripts/setup/manage_feed.php'}
file {"$path/bin/files": ensure=>link, target=>'../scripts/files/manage_files.php'}
file {"$path/bin/harbormaster": ensure=>link, target=>'../scripts/setup/manage_harbormaster.php'}
file {"$path/bin/i18n": ensure=>link, target=>'../scripts/setup/manage_i18n.php'}
file {"$path/bin/lipsum": ensure=>link, target=>'../scripts/lipsum/manage_lipsum.php'}
file {"$path/bin/mail": ensure=>link, target=>'../scripts/mail/manage_mail.php'}
file {"$path/bin/phd": ensure=>link, target=>'../scripts/daemon/manage_daemons.php'}
file {"$path/bin/policy": ensure=>link, target=>'../scripts/setup/manage_policy.php'}
file {"$path/bin/repository": ensure=>link, target=>'../scripts/repository/manage_repositories.php'}
file {"$path/bin/search": ensure=>link, target=>'../scripts/search/manage_search.php'}
file {"$path/bin/ssh-auth": ensure=>link, target=>'../scripts/ssh/ssh-auth.php'}
file {"$path/bin/ssh-auth-key": ensure=>link, target=>'../scripts/ssh/ssh-auth-key.php'}
file {"$path/bin/ssh-connect": ensure=>link, target=>'../scripts/ssh/ssh-connect.php'}
file {"$path/bin/ssh-exec": ensure=>link, target=>'../scripts/ssh/ssh-exec.php'}
file {"$path/bin/storage": ensure=>link, target=>'../scripts/sql/manage_storage.php'}
file {"$path/scripts/daemon/phd-daemon" : ensure=>link, target=>'launch_daemon.php'}