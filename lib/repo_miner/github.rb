require "octokit"

module RepoMiner
  module Github
    extend self

    def client
      @client ||= begin
        client = Octokit::Client.new(access_token: ENV["GITHUB_TOKEN"])
        client.auto_paginate = true
        client
      end
    end
  end
end
