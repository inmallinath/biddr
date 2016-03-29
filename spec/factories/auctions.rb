FactoryGirl.define do
  factory :auction do
    title "MyString"
    description "MyString"
    ends_on "2016-03-29 10:12:55"
    reserve_price "9.99"
    aasm_state "MyString"
    user nil
  end
end
