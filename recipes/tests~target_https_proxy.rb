
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
#       "recipe[gcompute::tests~target_https_proxy]"
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

gcompute_zone 'us-central1-a' do
  project ENV['PROJECT'] # ex: 'my-test-project'
  credential 'mycred'
end

gcompute_instance_group 'chef-e2e-my-chef-servers' do
  action :create
  zone 'us-central1-a'
  project ENV['PROJECT'] # ex: 'my-test-project'
  credential 'mycred'
end

# Google::Functions must be included at runtime to ensure that the
# gcompute_health_check_ref function can be used in health_check blocks.
::Chef::Resource.send(:include, Google::Functions)

gcompute_backend_service 'chef-e2e-my-app-backend' do
  action :create
  backends [
    { group: 'chef-e2e-my-chef-servers' }
  ]
  enable_cdn true
  health_checks [
    gcompute_health_check_ref('another-hc', ENV['PROJECT'] # ex: 'my-test-project')
  ]
  project ENV['PROJECT'] # ex: 'my-test-project'
  credential 'mycred'
end

gcompute_url_map 'chef-e2e-my-url-map' do
  action :create
  default_service 'chef-e2e-my-app-backend'
  project ENV['PROJECT'] # ex: 'my-test-project'
  credential 'mycred'
end

# *******
# WARNING: This manifest is for example purposes only. It is *not* advisable to
# have the key embedded like this because if you check this file into source
# control you are publishing the private key to whomever can access the source
# code. Instead you should protect the key, and for example, use the file()
# function to read it from disk without writing it verbatim to the manifest:
#
# gcompute_ssl_certificate '...' do
#   ...
#   private_key File.read('/path/to/my/private/key.pem')
#   ...
# end
# *******

gcompute_ssl_certificate 'chef-e2e-sample-certificate' do
  action :create
  description 'A certificate for test purposes only.'
  project ENV['PROJECT'] # ex: 'my-test-project'
  credential 'mycred'
  certificate '-----BEGIN CERTIFICATE-----
MIICqjCCAk+gAwIBAgIJAIuJ+0352Kq4MAoGCCqGSM49BAMCMIGwMQswCQYDVQQG
EwJVUzETMBEGA1UECAwKV2FzaGluZ3RvbjERMA8GA1UEBwwIS2lya2xhbmQxFTAT
BgNVBAoMDEdvb2dsZSwgSW5jLjEeMBwGA1UECwwVR29vZ2xlIENsb3VkIFBsYXRm
b3JtMR8wHQYDVQQDDBZ3d3cubXktc2VjdXJlLXNpdGUuY29tMSEwHwYJKoZIhvcN
AQkBFhJuZWxzb25hQGdvb2dsZS5jb20wHhcNMTcwNjI4MDQ1NjI2WhcNMjcwNjI2
MDQ1NjI2WjCBsDELMAkGA1UEBhMCVVMxEzARBgNVBAgMCldhc2hpbmd0b24xETAP
BgNVBAcMCEtpcmtsYW5kMRUwEwYDVQQKDAxHb29nbGUsIEluYy4xHjAcBgNVBAsM
FUdvb2dsZSBDbG91ZCBQbGF0Zm9ybTEfMB0GA1UEAwwWd3d3Lm15LXNlY3VyZS1z
aXRlLmNvbTEhMB8GCSqGSIb3DQEJARYSbmVsc29uYUBnb29nbGUuY29tMFkwEwYH
KoZIzj0CAQYIKoZIzj0DAQcDQgAEHGzpcRJ4XzfBJCCPMQeXQpTXwlblimODQCuQ
4mzkzTv0dXyB750fOGN02HtkpBOZzzvUARTR10JQoSe2/5PIwaNQME4wHQYDVR0O
BBYEFKIQC3A2SDpxcdfn0YLKineDNq/BMB8GA1UdIwQYMBaAFKIQC3A2SDpxcdfn
0YLKineDNq/BMAwGA1UdEwQFMAMBAf8wCgYIKoZIzj0EAwIDSQAwRgIhALs4vy+O
M3jcqgA4fSW/oKw6UJxp+M6a+nGMX+UJR3YgAiEAvvl39QRVAiv84hdoCuyON0lJ
zqGNhIPGq2ULqXKK8BY=
-----END CERTIFICATE-----'
  private_key '-----BEGIN EC PRIVATE KEY-----
MHcCAQEEIObtRo8tkUqoMjeHhsOh2ouPpXCgBcP+EDxZCB/tws15oAoGCCqGSM49
AwEHoUQDQgAEHGzpcRJ4XzfBJCCPMQeXQpTXwlblimODQCuQ4mzkzTv0dXyB750f
OGN02HtkpBOZzzvUARTR10JQoSe2/5PIwQ==
-----END EC PRIVATE KEY-----'
end

gcompute_target_https_proxy 'chef-e2e-my-https-proxy' do
  action :create
  ssl_certificates [
    'chef-e2e-sample-certificate'
  ]
  url_map 'chef-e2e-my-url-map'
  project ENV['PROJECT'] # ex: 'my-test-project'
  credential 'mycred'
end
