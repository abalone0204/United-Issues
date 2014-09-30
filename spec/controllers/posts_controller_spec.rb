require 'rails_helper'

RSpec.describe PostsController, :type => :controller do

  describe "GET #index" do

    let(:post) { Fabricate(:post) } 

    it "should assigns all posts to @posts" do
      get :index
      expect(assigns(:posts)).to eq [post]
    end

  end

  describe "GET #show" do
    
    let(:post) { Fabricate(:post) } 

    it "should assigns post to @post" do
      get :show, id: post
      expect(assigns(:post)).to eq post
    end
  end

  describe "GET #edit" do
    let(:post) { Fabricate(:post) }
    let(:user) { Fabricate(:user) } 
    before { sign_in user } 

    

    it "should assigns post to @post" do
      get :edit, id: post
      expect(assigns(:post)).to eq post
    end

  end

  describe "GET #new" do
    let(:user) { Fabricate(:user) } 
    before { sign_in user } 
    it "should assigns a new post to @post" do
      get :new
      expect(assigns(:post)).to be_a_new(Post)
    end
  end

  describe "POST #create" do

    let(:user) { Fabricate(:user) } 
    before { sign_in user }

    context "with valid params" do
      
      let(:valid_post_params) { Fabricate.attributes_for(:post) } 
      
      it "should create a post" do
        expect {
          post :create, post: valid_post_params
        }.to change(Post, :count).by(1)
      end

      it "should redirect to post" do
        post :create, post: valid_post_params
        expect(response).to redirect_to Post.last
      end
    end

    context "with invalid params" do

      let(:invalid_post_params) { Fabricate.attributes_for(:invalid_post) } 
      it "should not create a post" do
        expect {
          post :create, post: invalid_post_params
        }.not_to change(Post, :count)
      end
      it "should render edit template" do
        post :create, post: invalid_post_params
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PUT #update" do
    let(:post) { Fabricate(:post) }
    let(:user) { Fabricate(:user) } 
    
    before { sign_in user }

    context "with valid params" do
      it "should update post's attributes" do
        valid_post_params = {title: "Changed title" }
        put :update, id: post, post: valid_post_params
        post.reload
        expect(post.title).to eq valid_post_params[:title]
      end

      it "should redirect to show page" do
        valid_post_params = {title: "Changed title" }
        put :update, id: post, post: valid_post_params
        expect(response).to redirect_to(post)
      end
    end

    context "with invalid params" do

      it "should not update post's attributes" do
        invalid_post_params = {title: "", content: "doesn't matter"}
        put :update, id: post, post: invalid_post_params
        post.reload
        expect(post.content).not_to eq invalid_post_params[:content]
      end

      it "should render edit template" do
        invalid_post_params = {title: "", content: "doesn't matter"}
        put :update, id: post, post: invalid_post_params
        expect(response).to render_template(:edit)
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:post) { Fabricate(:post) } 
    let(:user) { Fabricate(:user) }
    before { sign_in user } 

    it "should delete a post" do
       expect {
        delete :destroy, id: post
       }.to change(Post, :count).by(-1)
    end

    it "should redirect to index page" do
      delete :destroy, id: post
      expect(response).to redirect_to(posts_url)
    end
  end

end
