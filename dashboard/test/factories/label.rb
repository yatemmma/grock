FactoryGirl.define do
  factory :label1, :class => Grock::Label do
    id 1
    key "label1"
    values ({name: 'name1', nick: 'nick1', site: 'site1', youtube: 'youtube1', recommend: 1}.to_json)
  end
  factory :label2, :class => Grock::Label do
    id 2
    key "label2"
    values ({xxx: 123}.to_json)
  end
end
