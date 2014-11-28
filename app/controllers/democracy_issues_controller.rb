class DemocracyIssuesController < ApplicationController
  before_action :authenticate_user!, only: [:vote]
  def index
    @candidates = Candidate.all
  end

  def vote
    @vote = Vote.create(user_id: current_user.id, candidate_id: params[:candidate_id].to_i)  
    redirect_to results_democracy_issues_path 
  end

  def results
    @candidates = Candidate.all.order('created_at DESC')
    respond_to do |format|
      format.html
      format.json
    end
  end
end
