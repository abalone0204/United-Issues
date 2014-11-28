module DemocracyIssuesHelper
  def vote_proportion(candidate)
    p = candidate.votes.count.to_f / Vote.all.count.to_f
    result = p  * 100.0
    return result.round(2).to_s + " %"
  end
end
