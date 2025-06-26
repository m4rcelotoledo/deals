# frozen_string_literal: true

class DealsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_deal, only: %i[destroy edit lost update won]

  SUCCESS_MSG = I18n.t('deal_success')
  WARNING_MSG = I18n.t('deal_warning')

  def index
    @deal = Deal.new

    Deal.where(user: current_user).then do |deals|
      @last_deal = deals.last

      if search_params.present?
        deals = deals.merge(search_deals)
        flash[:warning] = I18n.t('deal_not_found') if deals.empty?
      end

      @deals = deals.order(created_at: :desc)
    end
  end

  def edit; end

  def create
    Deal.create(deal_params).then do |deal|
      deal.closing_date_probability = DealsService.set_default_time
      deal.user_id = current_user.id
      deal.save ? flash[:success] = SUCCESS_MSG : flash[:warning] = WARNING_MSG

      redirect_to root_path
    end
  end

  def lost
    deal.lost!
    flash[:success] = I18n.t('deal_lost')

    redirect_to root_path
  end

  def update
    if deal.update(deal_params)
      flash[:success] = I18n.t('deal_updated')
      redirect_to root_path
    else
      @deal = deal
      flash[:warning] = I18n.t('deal_missing_fields')

      render :edit
    end
  end

  def destroy
    flash[:success] = I18n.t('deal_destroyed') if deal.destroy

    redirect_to root_path
  end

  def won
    deal.won!
    flash[:success] = I18n.t('deal_won')

    redirect_to root_path
  end

  private

  attr_accessor :deal

  def deal_params
    params.expect(deal: %i[customer description value status closing_date_probability user_id])
  end

  def search_params
    params[:q]&.downcase
  end

  def set_deal
    @deal = current_user.deals.find(params[:id])
  end

  def search_deals
    current_user.deals.where(
      'LOWER(customer) LIKE LOWER(?) OR LOWER(description) LIKE LOWER(?)',
      "%#{search_params}%", "%#{search_params}%"
    )
  end
end
