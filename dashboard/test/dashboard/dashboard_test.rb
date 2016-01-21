require './test/test_helper'
require 'rack/test'
require './config/initialize'
require './dashboard'

module Grock
  class DashboardTest < Minitest::Test
    include Rack::Test::Methods
    include FactoryGirl::Syntax::Methods
    FactoryGirl.reload
    
    def setup
      DatabaseCleaner.start
      create(:label1)
    end
    
    def teardown
      DatabaseCleaner.clean
    end

    def app
      Dashboard
    end

    def test_get_top_page
      get '/'
      assert { true == last_response.ok? }
    end

    def test_get_item_list
      get '/list/label'
      assert { true == last_response.ok? }
    end

    def test_get_item_detail
      get '/detail/label/1'
      assert { true == last_response.ok? }
    end

    def test_put_item_detail
      put '/detail/label/', "name": "name1"
      assert { true == last_response.ok? }
    end

    def test_post_item_detail
      post '/detail/label/1', "name": "name1"
      assert { true == last_response.ok? }
    end

    def test_delete_item_detail
      delete '/detail/label/1'
      assert { true == last_response.ok? }
    end
  end
end
