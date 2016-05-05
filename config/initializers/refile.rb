require "refile/s3"

aws = {
  access_key_id: ENV['AWS-ACCESS-KEY'],
  secret_access_key: ENV['AWS-SECRET-KEY'],
  region: ENV['AWS-REGION'],
  bucket: ENV['AWS-BUCKET'],
}
Refile.cache = Refile::S3.new(prefix: "cache", **aws)
Refile.store = Refile::S3.new(prefix: "store", **aws)
