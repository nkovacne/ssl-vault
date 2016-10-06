ssl-vault
===
Manages SSL Keys, Certs and Chains using the 
[chef-vault](https://github.com/opscode-cookbooks/chef-vault) Cookbook, itself
a wrapper for the [chef-vault](https://github.com/Nordstrom/chef-vault) Gem.

SSL Keys, Certs and Chains are stored in Chef Encrypted Data Bags using Chef
Vault and are only accessible to clients using their existing public keys.

More information on the Chef Vault security model can be found on [Justin Timberman's Blog](http://jtimberman.housepub.org/blog/2013/09/10/managing-secrets-with-chef-vault/) or [Andrew Jaquith's Blog](http://www.markerbench.com/blog/2013/10/06/chef-3rd-course/).

This Cookbook is derived from [Maciej Pasternacki's](https://github.com/mpasternacki) [ssl-key-vault](https://github.com/3ofcoins/chef-cookbook-ssl-key-vault) Cookbook.


Requirements
---
1. [chef-vault](https://github.com/Nordstrom/chef-vault) plugin for Knife,
available as a Ruby Gem: `gem install chef-vault`
2. A SSL certificate and private key.


Attributes
---
- `node['ssl-vault']['certificates']` - List of certificates to install, as
  determined by the IDs of Encrypted Data Bag Items. 
  i.e. `['example.com', 'www.example.com']`
  Can be set per Node, so as to limit vectors.

The following Attributes are set or unset by default, and are available for 
customization by you, the user:
- `['ssl-vault']['certificate_directory']` - String name of directory into 
  which to deposit the certificate(s) [and chain file(s)].
- `['ssl-vault']['private_key_directory']` - String name of directory into 
  which to deposit the private key(s) [and PEM file(s)].
- `['ssl-vault']['private_key_file']` - String name of private key file.
- `['ssl-vault']['data_bag_key_rex']` - Regular Expression of Data Bag Key 
  ID(s).
- `['ssl-vault']['data_bag_key_replacement_str']` - String replacement 
  character for IDs that don't match `data_bag_key_rex`.
- `['ssl-vault']['private_key_file']` - String name of private key file.
- `['ssl-vault']['certificate_file']` - String name of certificate file.
- `['ssl-vault']['pem_file']` - String name of PEM file.
- `['ssl-vault']['chain_file']` - String name of simple chain file.
- `['ssl-vault']['combined_chain_file']` - String name of combined chain file.
- `['ssl-vault']['combined_chain_pem_file']` - String name of combined chain
  PEM file.

The following Attribute overrides `['chef-vault']['version']`'s Attribute:
- `['chef-vault']['version']` - String version of chef-vault Gem to install.


Data Bag Structure
---

- The encrypted data bag must be named `ssl-vault`.

- The item name should be the CN of the certificate with the configured
    replacements applied
  (default replacement: underscores for dots, `www_example_com`).

- The value should be a json hash with the following keys:
    - `certificate`: the certificate in pem format
    - `key`: the key in pem format
    - `chain_certificates`: array of intermediate ca certificates [optional]


Recipes
---
This Cookbook provides several Recipes:

- `default.rb` - **Use this Recipe**. Includes remaining Recipes and 
  `chef-vault` Cookbook.
- `certificate_directory.rb` - Creates certificate (and chain) directory.
- `certificate_file.rb` - Creates certificate file.
- `chain_file.rb` - Creates simple chain file.
- `combined_chain_file.rb` - Creates combined chain file.
- `combined_chain_pem_file.rb` - Creates combined chain PEM file.
- `pem_file.rb` - Creates PEM file.
- `private_key_directory.rb` - Creates private key (and PEM) directory.
- `private_key_file.rb` - Creates private key file.


Usage
===
Include this Cookbook in your Node's Run List, along with setting the Node
Attributes for the certificates and keys you wish to install, and encrypting
those certificates and keys.

Overview
---
1. Aquire an SSL certificate and private key file.
2. Store the SSL certificate and private key file in an Encrypted Data Bag.
3. Encrypt the SSL certificate and private key using Chef Vault.
4. Include the certificate's Common Name (CN) in a Node's Attributes.


Example
---
Given the SSL certificate and key file for `example.com`:

1. Create a Data Bag Item containing the SSL certificate and private key:

        ruby -rjson -e 'puts JSON[Hash[Hash[*ARGV].map { |k,v| [k, File.read(v)] }]]' -- \
            certificate example.com.cert \
            key example.com.key \
            > example.com.json

2. Encrypt the new Data Bag Item using the Client's public key:

        knife vault create ssl-vault example_com --mode client \
            --search 'QUERY' --admins '' \
            --json example.com.json

       Either add Chef server's admin API users to the `--admins`, or make
       the key otherwise accessible to yourself in future (e.g. with
       [knife-briefcase](https://github.com/3ofcoins/knife-briefcase/)).

3. Add `example.com` to a Node's `['ssl-vault']['certificates']` Attribute:

        node['ssl-vault']['certificates'] = ['example.com']

4. Add `recipe[ssl-vault]` to Node's Run List.
5. The key will be stored in `/etc/ssl/private/example.com.key`, and
certificate in `/etc/ssl/certs/example.com.cert`.


Author
===
- Author:: Maciej Pasternacki (<maciej@3ofcoins.net>) ([ssl-key-vault](https://github.com/3ofcoins/chef-cookbook-ssl-key-vault))
- Author:: Greg Albrecht (<gba@onbeep.com>) ([ssl-vault](https://github.com/onbeep-cookbooks/ssl-vault))

Copyright
===
Copyright 2014 OnBeep, Inc.
Portions Copyright (C) 2013 Maciej Pasternacki <maciej@3ofcoins.net>

License
===
The MIT License (MIT)

Source
===
https://github.com/onbeep-cookbooks/ssl-vault
