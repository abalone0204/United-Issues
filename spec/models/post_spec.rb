require 'rails_helper'

RSpec.describe Post, :type => :model do
  subject { Fabricate(:post) } 
end
