class BoggleController < ApplicationController
  before_filter :set_headers

  private

    def set_headers
      response.headers['Cache-Control'] = 'public, max-age=31536000'
    end
end
