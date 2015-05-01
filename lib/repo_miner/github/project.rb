class RepoMiner::Github::Repo

  MAX_PAGES = 10

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def tag_bugfix_prs
    pull_requests.each do |pr|
      if pr.looks_like_a_bugfix?
        pr.tag_as_bugfix
      end
    end
  end

  def pull_requests
    puts "Fetching pull requests from github"

    @pull_requests ||= begin
      page = 1
      gh_prs = github.issues name, :per_page => 100, page: page
      pull_requests = RepoMiner::Github::PullRequest.from_github(self, gh_prs)
      page += 1
      puts "Fetched page #{page}"


      while page < MAX_PAGES do
        gh_prs = github.issues name, :per_page => 100, page: page
        pull_requests = pull_requests + RepoMiner::Github::PullRequest.from_github(self, gh_prs)
        page += 1
        puts "Fetched page #{page}. #{pull_requests.size} prs so far"
      end

      puts "Fetched #{pull_requests.size} pull requests"
      puts "Fetched #{pull_requests.collect(&:number).uniq.size} unique pull requests"
      puts pull_requests.collect(&:number).join(", ")

      pull_requests
    end
  end

  def github_repo
    @github_repo ||= github.repo(name)
  end

  def github
    RepoMiner::Github.client
  end
end
