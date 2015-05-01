require "repo_miner/version"

require "dotenv"

Dotenv.load

require_relative "repo_miner/github"
require_relative "repo_miner/github/project"
require_relative "repo_miner/github/pull_request"

module RepoMiner
  # Your code goes here...
end
