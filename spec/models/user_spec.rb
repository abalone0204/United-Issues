require 'rails_helper'

RSpec.describe User, :type => :model do
  let(:user) { Fabricate(:user) } 

  it "should have many posts" do
    expect(user).to have_many(:posts)
  end
  
  
  

end
