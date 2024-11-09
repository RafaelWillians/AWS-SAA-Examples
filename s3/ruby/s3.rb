require 'aws-sdk-s3'
require 'pry'
require 'securerandom'

bucket_name = ENV['BUCKET_NAME']
puts bucket_name

bucket.create({bucket = bucket_name})