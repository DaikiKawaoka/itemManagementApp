class Api::V1::ItemsController < ApplicationController
  include Api::V1::SessionsHelper
  before_action :logged_in_user, only: [:create, :destroy,:edit]

  def index

  end

  def show

  end

  def create

  end

  def update

  end

  def destroy
    
  end
end
