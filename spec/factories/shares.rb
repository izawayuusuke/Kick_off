FactoryBot.define do
  factory :share do
    association :post
    user { post.user }
  end
end
