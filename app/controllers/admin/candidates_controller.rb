class Admin::CandidatesController < AdminController
  before_action :find_candidate, only: [:edit, :update, :destroy]
  def index
    @candidates = Admin::Candidate.all
  end

  def new
    @candidate = Admin::Candidate.new
  end
  
  def create
    @candidate = Admin::Candidate.new(candidate_params)
    if @candidate.save
     redirect_to admin_candidates_path  
   else
    render :new
    end
  end

  def edit
    
  end

  def update
    if @candidate.update(candidate_params)
      redirect_to admin_candidates_path
    else
      render :edit
    end
  end

  def destroy
    @candidate.destroy
    redirect_to admin_candidates_path
  end

  private 
  def find_candidate
    @candidate = Admin::Candidate.find(params[:id])
  end
  def candidate_params
    params.require(:admin_candidate).permit(:name, :politics, :profile, :avatar)
  end
end