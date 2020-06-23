FactoryBot.define do
  sequence(:slack_username) { |n| "testusername#{n}" }
  sequence(:slack_user_id) { |n| "ID123#{n}" }


  factory :user do
    email { "test@example.com" }

    factory :admin do
      admin { true }
      email { "admin@example.com" }
    end
  end

  factory :employee do
    slack_username
    slack_user_id
    started_on  { Date.today }
    time_zone { "Eastern Time (US & Canada)" }
  end

  factory :sent_message do
    employee
    association :message, factory: :onboarding_message
    message_body { "Message body!" }
    sent_on { Date.today }
    sent_at { Time.parse("10:00:00 UTC") }
  end

  factory :onboarding_message do
    title { "Onboarding message 1" }
    body { "This is an awesome onboarding message!" }
    days_after_start { 3 }
    time_of_day { Time.parse("10:00:00 UTC") }
    tag_list { "test_tag, test_tag_two" }
  end

  factory :quarterly_message do
    title { "Quarterly message 1" }
    body { "This is an awesome quarterly message!" }
    tag_list { "test_tag, test_tag_two" }
  end

  factory :broadcast_message do
    title { "Message to everyone" }
    body { "Everyone needs to know this thing!" }
  end
end
