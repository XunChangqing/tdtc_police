class WelcomeController < ApplicationController
  #before_filter CASClient::Frameworks::Rails::Filter, except: [:index, :total, :node]
  before_filter CASClient::Frameworks::Rails::Filter
  def index
  end
  def profile
  end
  def useradmin
  end
end
