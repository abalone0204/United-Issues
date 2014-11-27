class DemocracyIssuesController < ApplicationController
  def index
    @candidates = Candidate.all
  end
end
