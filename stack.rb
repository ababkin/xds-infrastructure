#!/usr/bin/env ruby

require "net/http"
require "uri"

# uri = URI.parse("https://discovery.etcd.io/new")
# response = Net::HTTP.get_response(uri)
# discovery_url = response.body

# p "Using new discovery URL: #{discovery_url} ..."


template_file = "file://#{Dir.pwd}/infrastructure.json"
p "Using template: #{template_file} ..."

fail "Please provide AWS_ACCESS_KEY and AWS_SECRET_KEY environment variables" unless ENV['AWS_ACCESS_KEY'] && ENV['AWS_SECRET_KEY']
fail "Please provide DBUSERNAME and DBPASSWORD environment variables for postgres DB" unless ENV['DB_USERNAME'] && ENV['DB_PASSWORD']

awsCommand = (ARGV[0] || "create") + "-stack"

p `aws cloudformation #{awsCommand} --stack-name xdataset --capabilities CAPABILITY_IAM --template-body "#{template_file}" \
--parameters  \
ParameterKey=AwsAccessKey,\
ParameterValue=#{ENV['AWS_ACCESS_KEY']} \
ParameterKey=AwsSecretKey,\
ParameterValue=#{ENV['AWS_SECRET_KEY']} \
ParameterKey=DBUsername,\
ParameterValue=#{ENV['DB_USERNAME']} \
ParameterKey=DBPassword,\
ParameterValue=#{ENV['DB_PASSWORD']}`


# ParameterKey=DiscoveryURL,\
# ParameterValue=#{discovery_url} \
