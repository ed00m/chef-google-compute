
# Copyright 2018 Google Inc.
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# ----------------------------------------------------------------------------
#
#     ***     AUTO GENERATED CODE    ***    AUTO GENERATED CODE     ***
#
# ----------------------------------------------------------------------------
#
#     This file is automatically generated by Magic Modules and manual
#     changes will be clobbered when the file is regenerated.
#
#     Please read more about how to change this file in README.md and
#     CONTRIBUTING.md located at the root of this package.
#
# ----------------------------------------------------------------------------

# The following example requires two environment variables to be set:
#   * CRED_PATH - the path to a JSON service_account file
#   * PROJECT - the name of your GCP project.
#
# For convenience you optionally can add these to your ~/.bash_profile (or the
# respective .profile settings) environment:
#
#   export CRED_PATH=/path/to/my/cred.json
#   export PROJECT=/path/to/my/cred.json
#
# The following command will run this example:
#   CRED_PATH=/path/to/my/cred.json \
#   PROJECT='my-test-project'
#     chef-client -z --runlist \
#       "recipe[gcompute::examples~delete_global_forwarding_rule]"
#
# ________________________

raise "Missing parameter 'CRED_PATH'. Please read docs at #{__FILE__}" \
  unless ENV.key?('CRED_PATH')
raise "Missing parameter 'PROJECT'. Please read docs at #{__FILE__}" \
  unless ENV.key?('PROJECT')

# For more information on the gauth_credential parameters and providers please
# refer to its detailed documentation at:
# https://github.com/GoogleCloudPlatform/chef-google-auth
gauth_credential 'mycred' do
  action :serviceaccount
  path ENV['CRED_PATH'] # e.g. '/path/to/my_account.json'
  scopes [
    'https://www.googleapis.com/auth/compute'
  ]
end

gcompute_global_address 'my-app-lb-address' do
  action :create
  project ENV['PROJECT'] # ex: 'my-test-project'
  credential 'mycred'
end

gcompute_zone 'us-central1-a' do
  project ENV['PROJECT'] # ex: 'my-test-project'
  credential 'mycred'
end

gcompute_instance_group 'my-chef-servers' do
  action :create
  zone 'us-central1-a'
  project ENV['PROJECT'] # ex: 'my-test-project'
  credential 'mycred'
end

gcompute_backend_service 'my-app-backend' do
  action :create
  backends [
    { group: 'my-chef-servers' }
  ]
  enable_cdn true
  health_checks [
    gcompute_health_check_ref('another-hc', ENV['PROJECT'] # ex: 'my-test-project')
  ]
  project ENV['PROJECT'] # ex: 'my-test-project'
  credential 'mycred'
end

gcompute_url_map 'my-url-map' do
  action :create
  default_service 'my-app-backend'
  project ENV['PROJECT'] # ex: 'my-test-project'
  credential 'mycred'
end

gcompute_target_http_proxy 'my-http-proxy' do
  action :create
  url_map 'my-url-map'
  project ENV['PROJECT'] # ex: 'my-test-project'
  credential 'mycred'
end

gcompute_global_forwarding_rule 'test1' do
  action :delete
  ip_address gcompute_global_address_ref(
    'my-app-lb-address',
    ENV['PROJECT'] # ex: 'my-test-project'
  )
  ip_protocol 'TCP'
  port_range '80'
  target gcompute_target_http_proxy_ref(
    'my-http-proxy',
    ENV['PROJECT'] # ex: 'my-test-project'
  )
  project ENV['PROJECT'] # ex: 'my-test-project'
  credential 'mycred'
end
