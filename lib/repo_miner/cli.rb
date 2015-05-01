require "thor"

class RepoMiner::CLI < Thor

  desc "tag pull requests", "Tag as bugfix all the PR that look like a bugfix"
  def tag(project)
    RepoMiner::Github::Repo.new(project).tag_bugfix_prs
  end
end
