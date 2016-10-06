# Default Include Recipe Requisites for ssl-vault.
#
# Recipe:: default
# Cookbook:: ssl-vault
# Author:: Greg Albrecht <gba@onbeep.com>
# Copyright:: Copyright 2014 OnBeep, Inc.
# License:: The MIT License (MIT)
# Source:: https://github.com/onbeep-cookbooks/ssl-vault
#


include_recipe 'chef-vault'
include_recipe 'ssl-vault::certificate_directory'
include_recipe 'ssl-vault::private_key_directory'
include_recipe 'ssl-vault::certificate_file'
include_recipe 'ssl-vault::private_key_file'
include_recipe 'ssl-vault::pem_file'
include_recipe 'ssl-vault::chain_file'
include_recipe 'ssl-vault::combined_chain_file'
include_recipe 'ssl-vault::combined_chain_pem_file'
