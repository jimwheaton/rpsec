FactoryGirl.define do
  factory :task do
    sequence(:title) { |n| "Task #{n}"}

    factory :big_task do
      size 5
    end

    factory :small_task do
      size 1
    end

    trait :small do
      size 1
    end

    trait :large do
      size 5
    end
  end
end