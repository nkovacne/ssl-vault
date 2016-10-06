# Creates cerificate file.
#
# Recipe:: chain_file
# Cookbook:: ssl-vault
# Author:: Nicolás Kovac <nkovacne@ull.edu.es>
# Copyright:: Copyright 2014 OnBeep, Inc.
# License:: The MIT License (MIT)
# Source:: https://github.com/onbeep-cookbooks/ssl-vault
#


include_recipe 'chef-vault'
include_recipe 'ssl-vault::certificate_directory'

node['ssl-vault']['certificates'].each do |cert_name, cert|
  clean_name = cert_name.gsub(
    node['ssl-vault']['data_bag_key_rex'],
    node['ssl-vault']['data_bag_key_replacement_str']
  )
  vault_item = chef_vault_item('ssl-vault', clean_name)

  chain_file = if node['ssl-vault']['chain_file']
    node['ssl-vault']['chain_file']
  else
    File.join(
      node['ssl-vault']['certificate_directory'],
      [cert_name, 'chain', 'cert'].join('.')
    )
  end
  
  template chain_file do
     source 'chain.cert.erb'
     owner 'root'
     group 'root'
     mode '0644'
     variables(
       :chain_certs => vault_item['chain_certificates']
     )
  end

  node.set['ssl-vault']['certificate'][cert_name]['chain_file'] = chain_file
end
