class TweetsController < ApplicationController

  def index
    @tweets = Tweet.all.order(created_at: :desc)
  end

  def new
    @tweet = TweetTag.new
  end

  def create
    @tweet = TweetTag.new(tweet_params)
    if @tweet.valid?
      @tweet.save
      return redirect_to root_path
    else
      render "new"
    end
  end

  def search
    return nil if params[:input] == ""
    tag = Tag.where(['name LIKE ?', "%#{params[:input]}%"])
    render json:{ keyword: tag }
  end

  private  

  def tweet_params
    params.require(:tweet_tag).permit(:message, :name)
  end

end
