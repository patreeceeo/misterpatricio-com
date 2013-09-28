class IntroController < ApplicationController
  before_filter :set_headers

  def index
  end

  def personal
  end

  def hobbies
  end

  def garage
  end

  def javascript
  end

  def ruby
  end

  def python
  end

  def general
  end

  private

    def set_headers
      response.headers['Cache-Control'] = 'public, max-age=31536000'
    end

end
