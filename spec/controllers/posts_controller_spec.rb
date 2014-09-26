require 'rails_helper'

RSpec.describe PostsController, :type => :controller do
  describe "GET #index" do
    it "should assigns all posts to @posts" do
      post = Post.create(title:"Testing post", content:"lorem ipsm")
      get :index
      expect(assigns(:posts)).to eq [post]
    end
  end

  describe "GET #show" do
    it "should assigns post to @post" do
      post = Post.create(title:"Testing post", content:"lorem ipsm")
      get :show, id: post
      expect(assigns(:post)).to eq post
    end
  end

  describe "GET #edit" do
    it "should assigns post to @post" do
      post = Post.create(title:"Testing post", content:"lorem ipsm")
      get :edit, id: post
      expect(assigns(:post)).to eq post
    end
  end

  describe "GET #new" do
    it "should assigns a new post to @post" do
      get :new
      expect(assigns(:post)).to be_a_new(Post)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "should create a post" do
        valid_post_params = {title: "Valid title", content: "Valid content"}
        expect {
          post :create, post: valid_post_params
        }.to change(Post, :count).by(1)
      end
      it "should redirect to post" do
        valid_post_params = {title: "Valid title", content: "Valid content"}
        post :create, post: valid_post_params
        expect(response).to redirect_to Post.last
      end
    end

    context "with invalid params" do
      it "should not create a post" do
        invalid_post_params = {title: "", content: "doesn't matter"}
        expect {
          post :create, post: invalid_post_params
        }.not_to change(Post, :count)
      end
      it "should render edit template" do
        invalid_post_params = {title: "", content: "doesn't matter"}
        post :create, post: invalid_post_params
        expect(response).to render_template(:new)
      end
    end
  end

  describe "PUT #update" do

    let(:post) { Post.create(title: "For test", content: "lalala") }

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
    let!(:post) { Post.create(title: "OK bye", content: "doesn't matter") } 

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
