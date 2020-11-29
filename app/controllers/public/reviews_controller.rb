class Public::ReviewsController < ApplicationController

  def create
    @review = Review.new(review_params)
    @review.save
    redirect_to request.referer
  end

  def edit
    @review = Review.find(params[:id])
  end

  def update
    @review = Review.find(params[:id])
    if @review.update(review_params)
      flash[notice] = '編集に成功しました'
      redirect_to request.referer
    else
      flash[notice] = "編集ができませんでした"
      redirect_to request.referer
    end
  end


# @average_reviewのインスタンス変数を設定



  private
    def review_params
      params.require(:review).permit(:title, :body, :rate, :item_id, :customer_id)
    end
end
