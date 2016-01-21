require './test/test_helper'
require './config/initialize'
require './models/model'


module Grock
  class LabelTest < Minitest::Test
    include FactoryGirl::Syntax::Methods
    FactoryGirl.reload
    
    def setup
      DatabaseCleaner.start
    end
    
    def teardown
      DatabaseCleaner.clean
    end
    
    def test_load
      create(:label1)
      create(:label2)
      
      labels = Label.load
      assert { labels.size == 2 }
      
      label = labels.first
      assert { label.id == 1 }
      assert { label.key == 'label1' }
      assert { label.name == 'name1' }
      assert { label.nick == 'nick1' }
      assert { label.site == 'site1' }
      assert { label.youtube == 'youtube1' }
      assert { label.recommend == 1 }
    end
    
    def test_all_columns
      columns = %w(id key name nick site youtube recommend)
      assert { Label.all_columns == columns}
    end
    
    def test_find_by_id
      create(:label1)
      label = Label.find_by_id(1)
      assert { label.id == 1 }
      assert { label.key == 'label1' }
      assert { label.name == 'name1' }
      assert { label.nick == 'nick1' }
      assert { label.site == 'site1' }
      assert { label.youtube == 'youtube1' }
      assert { label.recommend == 1 }
    end
    
    def test_save_values
      label = Label.new
      saved = label.save_values({key: 'key1', name: 'name1'})
      assert { saved == true }
      assert { label.id == 1 }
      assert { label.key == 'key1' }
      assert { label.name == 'name1' }
    end
    
    def test_undefined_column
      create(:label1)
      label = Label.find_by_id(1)
      assert_raises(NoMethodError) { label.undefinedcolumn }
    end
  end
end
