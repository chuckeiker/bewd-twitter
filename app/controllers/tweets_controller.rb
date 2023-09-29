class TweetsController < ApplicationController
  before_action :authenticate_user, only: [:create, :destroy]
  before_action :find_tweet, only: :destroy

  def create
    tweet = current_user.tweets.build(tweet_params)

    if tweet.save
      render json: tweet, status: :created
    else
      render json: { errors: tweet.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(:message)
  end

  def destroy
    if current_user == @tweet.user
      @tweet.destroy
      render json: { message: 'Tweet deleted successfully' }
    else
      render json: { error: 'You are not authorized to delete this tweet' }, status: :unauthorized
    end
  end

  private

  def find_tweet
    @tweet = Tweet.find_by(id: params[:id])
    render json: { error: 'Tweet not found' }, status: :not_found unless @tweet
  end

  def index
    tweets = Tweet.all
    render json: tweets
  end

  def index_by_user
    user = User.find_by(username: params[:username])
    if user
      tweets = user.tweets
      render json: tweets
    else
      render json: { error: 'User not found' }, status: :not_found
    end
  end

end
