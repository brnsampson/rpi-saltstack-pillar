salt:
  # Set this to true to clean any non-salt-formula managed files out of
  # /etc/salt/{master,minion}.d ... You really don't want to do this on 2015.2
  # and up as it'll wipe out important files that Salt relies on.
  clean_config_d_dir: False

  # This state will remove "/etc/salt/minion" when you set this to true.
  minion_remove_config: True

  # This state will remove "/etc/salt/master" when you set this to true.
  master_remove_config: True

  # Set this to False to not have the formula install packages (in the case you
  # install Salt via git/pip/etc.)
  install_packages: True

  # to overwrite map.jinja salt packages
  lookup:
    salt-master: 'salt-master'
    salt-minion: 'salt-minion'
    salt-syndic: 'salt-syndic'
    salt-cloud: 'salt-cloud'
    salt-ssh: 'salt-ssh'

  # salt master config
  master:
    fileserver_backend:
      - git
      - roots
    gitfs_provider: pygit2
    gitfs_remotes:
      - git://github.com/saltstack-formulas/salt-formula.git
      - git://github.com/brnsampson/rpi-saltstack.git
      - git://github.com/brnsampson/rpi-saltstack-base.git
      - git://github.com/brnsampson/iptables-formula.git:
        - saltenv:
          - dev:
            - ref: develop
    gitfs_whitelist:
      - base
      - prod
      - develop
    file_roots:
      base:
        - /srv/salt
    pillar_roots:
      base:
        - /srv/pillar
      prod:
        - /srv/pillar/prod
      dev:
        - /srv/pillar/dev
    # for salt-api with tornado rest interface
    rest_tornado:
      port: 8000
      ssl_crt: /etc/pki/api/certs/server.crt
      ssl_key: /etc/pki/api/certs/server.key
      debug: False
      disable_ssl: False
    # for profile configuration as https://docs.saltstack.com/en/latest/topics/tutorials/lxc.html#tutorial-lxc-profiles

  # salt minion config:
  minion:

    # single master setup
    master: salt.whobe.us

    # multi master setup
    #master:
      #- salt_master_1
      #- salt_master_2

    fileserver_backend:
      - git
      - roots
    gitfs_remotes:
      - git://github.com/saltstack-formulas/salt-formula.git
    file_roots:
      base:
        - /srv/salt
    pillar_roots:
      base:
        - /srv/pillar

salt_formulas:
  git_opts:
    # The Git options can be customized differently for each
    # environment, if an option is missing in a given environment, the
    # value from "default" is used instead.
    default:
      # URL where the formulas git repositories are downloaded from
      # it will be suffixed with <formula-name>.git
      baseurl: https://github.com/saltstack-formulas
      # Directory where Git repositories are downloaded
      basedir: /srv/formulas
      # Update the git repository to the latest version (False by default)
      update: False
      # Options passed directly to the git.latest state
      options:
        rev: master
 #   develop:
 #     basedir: /srv/formulas/dev
 #     update: True
 #     options:
 #       rev: develop
  # Options of the file.directory state that creates the directory where
  # the git repositories of the formulas are stored
  basedir_opts:
    makedirs: True
    user: root
    group: root
    mode: 755
  # List of formulas to enable in each environment
  list:
    base:
      - salt-formula
      - consul-formula
      - jenkins-formula
      - dhcpd-formula
      - bind-formula
      - network-debian-formula
