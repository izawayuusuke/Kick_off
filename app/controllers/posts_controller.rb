class PostsController < ApplicationController
  before_action :post_find, only: [:show, :destroy]
  def index
    @posts = Post.all.order(created_at: "DESC").page(params[:page]).without_count.per(1)
    @post = Post.new
    @user = current_user
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.order(created_at: "DESC")
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:success] = "投稿しました"
      redirect_to posts_path
    else
      @posts = Post.all.order(created_at: "DESC")
      render :index
    end
  end

  def destroy
    @post.destroy
    @post_id = @post.id
    # 詳細ページで投稿を削除すると、ajaxでidが取得できないため、リダイレクトを用意する
    path = Rails.application.routes.recognize_path(request.referrer)
    if path == { :controller=>"posts", :action=>"show", :id=>"#{@post.id}" }
      flash[:danger] = "投稿を削除しました"
      redirect_to posts_path
    end
  end

  private
    def post_find
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:content, :image)
    end
end
