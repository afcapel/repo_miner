require 'minitest_helper'

class RepoMiner::Github::RepoTest < Minitest::Test

  def test_it_can_fetch_project_pull_requests
    pull_requests = repo.pull_requests

    refute_empty pull_requests
    pull_requests.each { |pr| assert_kind_of RepoMiner::Github::PullRequest, pr }
  end

  def repo
    @repo ||= RepoMiner::Github::Repo.new("rails/rails")
  end
end
