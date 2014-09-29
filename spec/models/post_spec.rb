require 'rails_helper'

RSpec.describe Post, :type => :model do
  subject { Fabricate(:post) } 
  let(:post) { Fabricate(:post) } 
  
  it "should belong to user" do
    expect(post).to belong_to(:user)
  end
end
