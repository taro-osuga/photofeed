class FavoritesController < ApplicationController
    def create
        favorite = current_user.favorites.create(feed_id: params[:feed_id])
        redirect_to feeds_url, notice: "#{favorite.feed.user.name}さんの投稿をお気に入り登録しました"
      end
      def destroy
        favorite = current_user.favorites.find_by(id: params[:id]).destroy
        redirect_to feeds_url, notice: "#{favorite.feed.user.name}さんの投稿をお気に入り解除しました"
      end

      def index
        @user = current_user
        @favorites = Favorite.where(user_id: @user.id).all
        
      end
end
