# Default Attributes for ssl-vault.
#
# Attribute:: default
# Cookbook:: ssl-vault
# Author:: Greg Albrecht <gba@onbeep.com>
# Copyright:: Copyright 2014 OnBeep, Inc.
# License:: The MIT License (MIT)
# Source:: https://github.com/onbeep-cookbooks/ssl-vault
#


default['ssl-vault']['certificates'] = []

# These are currently Ubuntu-centric:
default['ssl-vault']['certificate_directory'] = '/etc/ssl/certs'
default['ssl-vault']['private_key_directory'] = '/etc/ssl/private'
default['ssl-vault']['cert_group'] = 'root'

# There's limits on Data Bag Key names:
default['ssl-vault']['data_bag_key_rex'] = /[^[:alnum:]_-]+/
default['ssl-vault']['data_bag_key_replacement_str'] = '_'

# You can override the auto-generated file names here:
default['ssl-vault']['private_key_file'] = nil
default['ssl-vault']['certificate_file'] = nil
default['ssl-vault']['pem_file'] = nil
default['ssl-vault']['chain_file'] = nil
default['ssl-vault']['combined_chain_file'] = nil
default['ssl-vault']['combined_chain_pem_file'] = nil
