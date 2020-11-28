class Public::ReviewsController < ApplicationController

    def create
        @review = Review.new(review_params)
        @review.save
        redirect_to request.referer
    end

  private
    def review_params
      params.require(:review).permit(:name, :body, :rate, :item_id, :customer_id)
    end
end
