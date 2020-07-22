# frozen_string_literal: true
module Api
  module V1
    class ApiController < ApplicationController
      include Authentication
    end
  end
end
