class RepoMiner::Github::PullRequest

  attr_reader :attributes, :project

  BUGFIX_REGEXP     = /\b(fix(es|ed)?|close(s|d)?|FA-?(\d+))\b/mi
  NOT_BUGFIX_REGEXP = /\b(typo(s)?|style(s)?|merge(s)?|fix test)\b/mi

  def self.from_github(project, prs)
    prs.collect do |pr|
      RepoMiner::Github::PullRequest.new(project, pr.to_attrs)
    end
  end

  def initialize(project, attributes)
    @project = project
    @attributes = attributes
  end

  def title
    attributes[:title]
  end

  def number
    attributes[:number]
  end

  def body
    attributes[:body]
  end

  def description
    [title, body].join("\n")
  end

  def looks_like_a_bugfix?
    description =~ BUGFIX_REGEXP && (!description =~ NOT_BUGFIX_REGEXP)
  end

  def tag_as_bugfix
    puts "======================================================="
    puts "TAGGING PR ##{number}'#{title}' as it looks like a bugfix'"
    puts "======================================================="

    # github.add_labels_to_an_issue(project.name, number, ['bugfix'])
  end

  def github
    RepoMiner::Github.client
  end
end
